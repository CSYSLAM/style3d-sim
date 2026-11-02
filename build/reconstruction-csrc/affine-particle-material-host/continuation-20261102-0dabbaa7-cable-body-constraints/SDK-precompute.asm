
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

0000000000104370 <synreal::SolverNewton::precompute_matrices()>:
  104370:	f3 0f 1e fa          	endbr64 
  104374:	41 57                	push   %r15
  104376:	4c 8d 05 0f 68 0e 00 	lea    0xe680f(%rip),%r8        # 1eab8c <_fini+0x5448>
  10437d:	41 56                	push   %r14
  10437f:	41 55                	push   %r13
  104381:	41 54                	push   %r12
  104383:	55                   	push   %rbp
  104384:	53                   	push   %rbx
  104385:	48 81 ec f8 07 00 00 	sub    $0x7f8,%rsp
  10438c:	8b 9f a8 00 00 00    	mov    0xa8(%rdi),%ebx
  104392:	48 89 7c 24 40       	mov    %rdi,0x40(%rsp)
  104397:	48 89 d9             	mov    %rbx,%rcx
  10439a:	4c 8d 3c 9d 00 00 00 	lea    0x0(,%rbx,4),%r15
  1043a1:	00 
  1043a2:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  1043a9:	00 00 
  1043ab:	48 89 84 24 e8 07 00 	mov    %rax,0x7e8(%rsp)
  1043b2:	00 
  1043b3:	48 89 f8             	mov    %rdi,%rax
  1043b6:	48 8d bc 24 e0 03 00 	lea    0x3e0(%rsp),%rdi
  1043bd:	00 
  1043be:	48 8b b0 c0 00 00 00 	mov    0xc0(%rax),%rsi
  1043c5:	48 8b 90 c8 00 00 00 	mov    0xc8(%rax),%rdx
  1043cc:	e8 ef 98 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  1043d1:	4c 89 7c 24 68       	mov    %r15,0x68(%rsp)
  1043d6:	48 85 db             	test   %rbx,%rbx
  1043d9:	0f 84 f8 0d 00 00    	je     1051d7 <synreal::SolverNewton::precompute_matrices()+0xe67>
  1043df:	4c 89 ff             	mov    %r15,%rdi
  1043e2:	e8 69 8d f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  1043e7:	48 89 c5             	mov    %rax,%rbp
  1043ea:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  1043f1:	00 
  1043f2:	4c 01 fd             	add    %r15,%rbp
  1043f5:	48 89 84 24 00 04 00 	mov    %rax,0x400(%rsp)
  1043fc:	00 
  1043fd:	48 89 ac 24 10 04 00 	mov    %rbp,0x410(%rsp)
  104404:	00 
  104405:	48 39 c5             	cmp    %rax,%rbp
  104408:	74 0d                	je     104417 <synreal::SolverNewton::precompute_matrices()+0xa7>
  10440a:	4c 89 fa             	mov    %r15,%rdx
  10440d:	31 f6                	xor    %esi,%esi
  10440f:	48 89 c7             	mov    %rax,%rdi
  104412:	e8 09 7d f6 ff       	call   6c120 <memset@plt>
  104417:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
  10441c:	48 89 ac 24 08 04 00 	mov    %rbp,0x408(%rsp)
  104423:	00 
  104424:	4c 89 ff             	mov    %r15,%rdi
  104427:	e8 24 8d f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  10442c:	48 89 c1             	mov    %rax,%rcx
  10442f:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  104436:	00 
  104437:	4c 01 f9             	add    %r15,%rcx
  10443a:	48 89 8c 24 60 01 00 	mov    %rcx,0x160(%rsp)
  104441:	00 
  104442:	48 39 c1             	cmp    %rax,%rcx
  104445:	74 0f                	je     104456 <synreal::SolverNewton::precompute_matrices()+0xe6>
  104447:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
  10444c:	48 89 c7             	mov    %rax,%rdi
  10444f:	31 f6                	xor    %esi,%esi
  104451:	e8 ca 7c f6 ff       	call   6c120 <memset@plt>
  104456:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
  10445b:	4c 89 ff             	mov    %r15,%rdi
  10445e:	e8 ed 8c f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104463:	48 89 c1             	mov    %rax,%rcx
  104466:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  10446d:	00 
  10446e:	4c 01 f9             	add    %r15,%rcx
  104471:	48 89 8c 24 68 01 00 	mov    %rcx,0x168(%rsp)
  104478:	00 
  104479:	48 39 c1             	cmp    %rax,%rcx
  10447c:	74 0f                	je     10448d <synreal::SolverNewton::precompute_matrices()+0x11d>
  10447e:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
  104483:	48 89 c7             	mov    %rax,%rdi
  104486:	31 f6                	xor    %esi,%esi
  104488:	e8 93 7c f6 ff       	call   6c120 <memset@plt>
  10448d:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
  104492:	4c 89 ff             	mov    %r15,%rdi
  104495:	e8 b6 8c f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  10449a:	48 89 c5             	mov    %rax,%rbp
  10449d:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
  1044a4:	00 
  1044a5:	4c 01 fd             	add    %r15,%rbp
  1044a8:	48 89 84 24 20 04 00 	mov    %rax,0x420(%rsp)
  1044af:	00 
  1044b0:	48 89 ac 24 30 04 00 	mov    %rbp,0x430(%rsp)
  1044b7:	00 
  1044b8:	48 39 c5             	cmp    %rax,%rbp
  1044bb:	74 0f                	je     1044cc <synreal::SolverNewton::precompute_matrices()+0x15c>
  1044bd:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
  1044c2:	48 89 c7             	mov    %rax,%rdi
  1044c5:	31 f6                	xor    %esi,%esi
  1044c7:	e8 54 7c f6 ff       	call   6c120 <memset@plt>
  1044cc:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
  1044d1:	48 89 ac 24 28 04 00 	mov    %rbp,0x428(%rsp)
  1044d8:	00 
  1044d9:	4c 89 ff             	mov    %r15,%rdi
  1044dc:	e8 6f 8c f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  1044e1:	48 89 c5             	mov    %rax,%rbp
  1044e4:	48 89 84 24 f8 00 00 	mov    %rax,0xf8(%rsp)
  1044eb:	00 
  1044ec:	4c 01 fd             	add    %r15,%rbp
  1044ef:	48 89 84 24 40 04 00 	mov    %rax,0x440(%rsp)
  1044f6:	00 
  1044f7:	48 89 ac 24 50 04 00 	mov    %rbp,0x450(%rsp)
  1044fe:	00 
  1044ff:	48 39 c5             	cmp    %rax,%rbp
  104502:	74 0f                	je     104513 <synreal::SolverNewton::precompute_matrices()+0x1a3>
  104504:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
  104509:	48 89 c7             	mov    %rax,%rdi
  10450c:	31 f6                	xor    %esi,%esi
  10450e:	e8 0d 7c f6 ff       	call   6c120 <memset@plt>
  104513:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
  104518:	48 89 ac 24 48 04 00 	mov    %rbp,0x448(%rsp)
  10451f:	00 
  104520:	4c 89 ff             	mov    %r15,%rdi
  104523:	e8 28 8c f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104528:	48 89 c7             	mov    %rax,%rdi
  10452b:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
  104530:	4c 01 ff             	add    %r15,%rdi
  104533:	48 89 bc 24 b8 01 00 	mov    %rdi,0x1b8(%rsp)
  10453a:	00 
  10453b:	48 39 c7             	cmp    %rax,%rdi
  10453e:	74 0f                	je     10454f <synreal::SolverNewton::precompute_matrices()+0x1df>
  104540:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
  104545:	48 89 c7             	mov    %rax,%rdi
  104548:	31 f6                	xor    %esi,%esi
  10454a:	e8 d1 7b f6 ff       	call   6c120 <memset@plt>
  10454f:	48 8d 04 5b          	lea    (%rbx,%rbx,2),%rax
  104553:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104557:	48 c1 e0 04          	shl    $0x4,%rax
  10455b:	0f 11 84 24 68 04 00 	movups %xmm0,0x468(%rsp)
  104562:	00 
  104563:	48 89 c7             	mov    %rax,%rdi
  104566:	49 89 c4             	mov    %rax,%r12
  104569:	e8 e2 8b f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  10456e:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  104572:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  104577:	48 89 84 24 60 04 00 	mov    %rax,0x460(%rsp)
  10457e:	00 
  10457f:	48 89 8c 24 70 04 00 	mov    %rcx,0x470(%rsp)
  104586:	00 
  104587:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10458e:	00 00 
  104590:	48 8d 50 08          	lea    0x8(%rax),%rdx
  104594:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  10459b:	48 83 c0 30          	add    $0x30,%rax
  10459f:	48 c7 40 e0 00 00 00 	movq   $0x0,-0x20(%rax)
  1045a6:	00 
  1045a7:	48 89 50 e8          	mov    %rdx,-0x18(%rax)
  1045ab:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
  1045af:	48 c7 40 f8 00 00 00 	movq   $0x0,-0x8(%rax)
  1045b6:	00 
  1045b7:	48 39 c8             	cmp    %rcx,%rax
  1045ba:	75 d4                	jne    104590 <synreal::SolverNewton::precompute_matrices()+0x220>
  1045bc:	66 0f ef c0          	pxor   %xmm0,%xmm0
  1045c0:	4c 89 e7             	mov    %r12,%rdi
  1045c3:	48 89 84 24 68 04 00 	mov    %rax,0x468(%rsp)
  1045ca:	00 
  1045cb:	0f 11 84 24 88 04 00 	movups %xmm0,0x488(%rsp)
  1045d2:	00 
  1045d3:	e8 78 8b f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  1045d8:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  1045dc:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  1045e3:	00 
  1045e4:	48 89 84 24 80 04 00 	mov    %rax,0x480(%rsp)
  1045eb:	00 
  1045ec:	48 89 8c 24 90 04 00 	mov    %rcx,0x490(%rsp)
  1045f3:	00 
  1045f4:	0f 1f 40 00          	nopl   0x0(%rax)
  1045f8:	48 8d 50 08          	lea    0x8(%rax),%rdx
  1045fc:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  104603:	48 83 c0 30          	add    $0x30,%rax
  104607:	48 c7 40 e0 00 00 00 	movq   $0x0,-0x20(%rax)
  10460e:	00 
  10460f:	48 89 50 e8          	mov    %rdx,-0x18(%rax)
  104613:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
  104617:	48 c7 40 f8 00 00 00 	movq   $0x0,-0x8(%rax)
  10461e:	00 
  10461f:	48 39 c8             	cmp    %rcx,%rax
  104622:	75 d4                	jne    1045f8 <synreal::SolverNewton::precompute_matrices()+0x288>
  104624:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104628:	4c 89 e7             	mov    %r12,%rdi
  10462b:	48 89 84 24 88 04 00 	mov    %rax,0x488(%rsp)
  104632:	00 
  104633:	0f 11 84 24 a8 04 00 	movups %xmm0,0x4a8(%rsp)
  10463a:	00 
  10463b:	e8 10 8b f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104640:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  104644:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  104649:	48 89 84 24 a0 04 00 	mov    %rax,0x4a0(%rsp)
  104650:	00 
  104651:	48 89 8c 24 b0 04 00 	mov    %rcx,0x4b0(%rsp)
  104658:	00 
  104659:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  104660:	48 8d 50 08          	lea    0x8(%rax),%rdx
  104664:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  10466b:	48 83 c0 30          	add    $0x30,%rax
  10466f:	48 c7 40 e0 00 00 00 	movq   $0x0,-0x20(%rax)
  104676:	00 
  104677:	48 89 50 e8          	mov    %rdx,-0x18(%rax)
  10467b:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
  10467f:	48 c7 40 f8 00 00 00 	movq   $0x0,-0x8(%rax)
  104686:	00 
  104687:	48 39 c8             	cmp    %rcx,%rax
  10468a:	75 d4                	jne    104660 <synreal::SolverNewton::precompute_matrices()+0x2f0>
  10468c:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104690:	4c 89 e7             	mov    %r12,%rdi
  104693:	48 89 84 24 a8 04 00 	mov    %rax,0x4a8(%rsp)
  10469a:	00 
  10469b:	0f 11 84 24 c8 04 00 	movups %xmm0,0x4c8(%rsp)
  1046a2:	00 
  1046a3:	e8 a8 8a f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  1046a8:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  1046ac:	48 89 84 24 c8 00 00 	mov    %rax,0xc8(%rsp)
  1046b3:	00 
  1046b4:	48 89 84 24 c0 04 00 	mov    %rax,0x4c0(%rsp)
  1046bb:	00 
  1046bc:	48 89 8c 24 d0 04 00 	mov    %rcx,0x4d0(%rsp)
  1046c3:	00 
  1046c4:	0f 1f 40 00          	nopl   0x0(%rax)
  1046c8:	48 8d 50 08          	lea    0x8(%rax),%rdx
  1046cc:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  1046d3:	48 83 c0 30          	add    $0x30,%rax
  1046d7:	48 c7 40 e0 00 00 00 	movq   $0x0,-0x20(%rax)
  1046de:	00 
  1046df:	48 89 50 e8          	mov    %rdx,-0x18(%rax)
  1046e3:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
  1046e7:	48 c7 40 f8 00 00 00 	movq   $0x0,-0x8(%rax)
  1046ee:	00 
  1046ef:	48 39 c8             	cmp    %rcx,%rax
  1046f2:	75 d4                	jne    1046c8 <synreal::SolverNewton::precompute_matrices()+0x358>
  1046f4:	66 0f ef c0          	pxor   %xmm0,%xmm0
  1046f8:	4c 89 e7             	mov    %r12,%rdi
  1046fb:	48 89 84 24 c8 04 00 	mov    %rax,0x4c8(%rsp)
  104702:	00 
  104703:	0f 11 84 24 e8 04 00 	movups %xmm0,0x4e8(%rsp)
  10470a:	00 
  10470b:	e8 40 8a f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104710:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  104714:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  10471b:	00 
  10471c:	48 89 84 24 e0 04 00 	mov    %rax,0x4e0(%rsp)
  104723:	00 
  104724:	48 89 8c 24 f0 04 00 	mov    %rcx,0x4f0(%rsp)
  10472b:	00 
  10472c:	0f 1f 40 00          	nopl   0x0(%rax)
  104730:	48 8d 50 08          	lea    0x8(%rax),%rdx
  104734:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  10473b:	48 83 c0 30          	add    $0x30,%rax
  10473f:	48 c7 40 e0 00 00 00 	movq   $0x0,-0x20(%rax)
  104746:	00 
  104747:	48 89 50 e8          	mov    %rdx,-0x18(%rax)
  10474b:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
  10474f:	48 c7 40 f8 00 00 00 	movq   $0x0,-0x8(%rax)
  104756:	00 
  104757:	48 39 c8             	cmp    %rcx,%rax
  10475a:	75 d4                	jne    104730 <synreal::SolverNewton::precompute_matrices()+0x3c0>
  10475c:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104760:	4c 89 e7             	mov    %r12,%rdi
  104763:	48 89 84 24 e8 04 00 	mov    %rax,0x4e8(%rsp)
  10476a:	00 
  10476b:	0f 11 84 24 08 05 00 	movups %xmm0,0x508(%rsp)
  104772:	00 
  104773:	e8 d8 89 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104778:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  10477c:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  104781:	48 89 84 24 00 05 00 	mov    %rax,0x500(%rsp)
  104788:	00 
  104789:	48 89 8c 24 10 05 00 	mov    %rcx,0x510(%rsp)
  104790:	00 
  104791:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  104798:	48 8d 50 08          	lea    0x8(%rax),%rdx
  10479c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  1047a3:	48 83 c0 30          	add    $0x30,%rax
  1047a7:	48 c7 40 e0 00 00 00 	movq   $0x0,-0x20(%rax)
  1047ae:	00 
  1047af:	48 89 50 e8          	mov    %rdx,-0x18(%rax)
  1047b3:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
  1047b7:	48 c7 40 f8 00 00 00 	movq   $0x0,-0x8(%rax)
  1047be:	00 
  1047bf:	48 39 c8             	cmp    %rcx,%rax
  1047c2:	75 d4                	jne    104798 <synreal::SolverNewton::precompute_matrices()+0x428>
  1047c4:	48 8d 2c 5b          	lea    (%rbx,%rbx,2),%rbp
  1047c8:	66 0f ef c0          	pxor   %xmm0,%xmm0
  1047cc:	48 89 84 24 08 05 00 	mov    %rax,0x508(%rsp)
  1047d3:	00 
  1047d4:	48 c1 e5 03          	shl    $0x3,%rbp
  1047d8:	0f 11 84 24 28 05 00 	movups %xmm0,0x528(%rsp)
  1047df:	00 
  1047e0:	48 89 ef             	mov    %rbp,%rdi
  1047e3:	e8 68 89 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  1047e8:	66 48 0f 6e c0       	movq   %rax,%xmm0
  1047ed:	48 01 c5             	add    %rax,%rbp
  1047f0:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  1047f5:	48 8d 43 ff          	lea    -0x1(%rbx),%rax
  1047f9:	66 0f 6c c0          	punpcklqdq %xmm0,%xmm0
  1047fd:	48 89 ac 24 30 05 00 	mov    %rbp,0x530(%rsp)
  104804:	00 
  104805:	0f 29 84 24 20 05 00 	movaps %xmm0,0x520(%rsp)
  10480c:	00 
  10480d:	48 83 f8 01          	cmp    $0x1,%rax
  104811:	0f 86 c9 7c 00 00    	jbe    10c4e0 <synreal::SolverNewton::precompute_matrices()+0x8170>
  104817:	48 89 da             	mov    %rbx,%rdx
  10481a:	48 8b 4c 24 58       	mov    0x58(%rsp),%rcx
  10481f:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104823:	48 d1 ea             	shr    %rdx
  104826:	48 8d 14 52          	lea    (%rdx,%rdx,2),%rdx
  10482a:	48 89 c8             	mov    %rcx,%rax
  10482d:	48 c1 e2 04          	shl    $0x4,%rdx
  104831:	48 01 ca             	add    %rcx,%rdx
  104834:	0f 11 00             	movups %xmm0,(%rax)
  104837:	48 83 c0 30          	add    $0x30,%rax
  10483b:	0f 11 40 e0          	movups %xmm0,-0x20(%rax)
  10483f:	0f 11 40 f0          	movups %xmm0,-0x10(%rax)
  104843:	48 39 c2             	cmp    %rax,%rdx
  104846:	75 ec                	jne    104834 <synreal::SolverNewton::precompute_matrices()+0x4c4>
  104848:	48 89 da             	mov    %rbx,%rdx
  10484b:	48 8b 4c 24 58       	mov    0x58(%rsp),%rcx
  104850:	48 83 e2 fe          	and    $0xfffffffffffffffe,%rdx
  104854:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
  104858:	48 8d 04 c1          	lea    (%rcx,%rax,8),%rax
  10485c:	48 89 d9             	mov    %rbx,%rcx
  10485f:	48 29 d1             	sub    %rdx,%rcx
  104862:	48 39 d3             	cmp    %rdx,%rbx
  104865:	74 21                	je     104888 <synreal::SolverNewton::precompute_matrices()+0x518>
  104867:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10486b:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  104872:	00 
  104873:	0f 11 00             	movups %xmm0,(%rax)
  104876:	48 83 f9 01          	cmp    $0x1,%rcx
  10487a:	74 0c                	je     104888 <synreal::SolverNewton::precompute_matrices()+0x518>
  10487c:	48 c7 40 28 00 00 00 	movq   $0x0,0x28(%rax)
  104883:	00 
  104884:	0f 11 40 18          	movups %xmm0,0x18(%rax)
  104888:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10488c:	4c 89 e7             	mov    %r12,%rdi
  10488f:	48 89 ac 24 28 05 00 	mov    %rbp,0x528(%rsp)
  104896:	00 
  104897:	0f 11 84 24 48 05 00 	movups %xmm0,0x548(%rsp)
  10489e:	00 
  10489f:	e8 ac 88 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  1048a4:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  1048a8:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  1048ad:	48 89 84 24 40 05 00 	mov    %rax,0x540(%rsp)
  1048b4:	00 
  1048b5:	48 89 8c 24 50 05 00 	mov    %rcx,0x550(%rsp)
  1048bc:	00 
  1048bd:	0f 1f 00             	nopl   (%rax)
  1048c0:	48 8d 50 08          	lea    0x8(%rax),%rdx
  1048c4:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  1048cb:	48 83 c0 30          	add    $0x30,%rax
  1048cf:	48 c7 40 e0 00 00 00 	movq   $0x0,-0x20(%rax)
  1048d6:	00 
  1048d7:	48 89 50 e8          	mov    %rdx,-0x18(%rax)
  1048db:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
  1048df:	48 c7 40 f8 00 00 00 	movq   $0x0,-0x8(%rax)
  1048e6:	00 
  1048e7:	48 39 c8             	cmp    %rcx,%rax
  1048ea:	75 d4                	jne    1048c0 <synreal::SolverNewton::precompute_matrices()+0x550>
  1048ec:	66 0f ef c0          	pxor   %xmm0,%xmm0
  1048f0:	4c 89 e7             	mov    %r12,%rdi
  1048f3:	48 89 84 24 48 05 00 	mov    %rax,0x548(%rsp)
  1048fa:	00 
  1048fb:	0f 11 84 24 68 05 00 	movups %xmm0,0x568(%rsp)
  104902:	00 
  104903:	e8 48 88 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104908:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  10490c:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
  104911:	48 89 84 24 60 05 00 	mov    %rax,0x560(%rsp)
  104918:	00 
  104919:	48 89 8c 24 70 05 00 	mov    %rcx,0x570(%rsp)
  104920:	00 
  104921:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  104928:	48 8d 50 08          	lea    0x8(%rax),%rdx
  10492c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  104933:	48 83 c0 30          	add    $0x30,%rax
  104937:	48 c7 40 e0 00 00 00 	movq   $0x0,-0x20(%rax)
  10493e:	00 
  10493f:	48 89 50 e8          	mov    %rdx,-0x18(%rax)
  104943:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
  104947:	48 c7 40 f8 00 00 00 	movq   $0x0,-0x8(%rax)
  10494e:	00 
  10494f:	48 39 c8             	cmp    %rcx,%rax
  104952:	75 d4                	jne    104928 <synreal::SolverNewton::precompute_matrices()+0x5b8>
  104954:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104958:	4c 89 e7             	mov    %r12,%rdi
  10495b:	48 89 84 24 68 05 00 	mov    %rax,0x568(%rsp)
  104962:	00 
  104963:	0f 11 84 24 88 05 00 	movups %xmm0,0x588(%rsp)
  10496a:	00 
  10496b:	e8 e0 87 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104970:	49 01 c4             	add    %rax,%r12
  104973:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  104978:	48 89 84 24 80 05 00 	mov    %rax,0x580(%rsp)
  10497f:	00 
  104980:	4c 89 a4 24 90 05 00 	mov    %r12,0x590(%rsp)
  104987:	00 
  104988:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10498f:	00 
  104990:	48 8d 50 08          	lea    0x8(%rax),%rdx
  104994:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  10499b:	48 83 c0 30          	add    $0x30,%rax
  10499f:	48 c7 40 e0 00 00 00 	movq   $0x0,-0x20(%rax)
  1049a6:	00 
  1049a7:	48 89 50 e8          	mov    %rdx,-0x18(%rax)
  1049ab:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
  1049af:	48 c7 40 f8 00 00 00 	movq   $0x0,-0x8(%rax)
  1049b6:	00 
  1049b7:	4c 39 e0             	cmp    %r12,%rax
  1049ba:	75 d4                	jne    104990 <synreal::SolverNewton::precompute_matrices()+0x620>
  1049bc:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  1049c1:	4c 89 a4 24 88 05 00 	mov    %r12,0x588(%rsp)
  1049c8:	00 
  1049c9:	8b a8 98 04 00 00    	mov    0x498(%rax),%ebp
  1049cf:	48 85 ed             	test   %rbp,%rbp
  1049d2:	0f 84 21 29 00 00    	je     1072f9 <synreal::SolverNewton::precompute_matrices()+0x2f89>
  1049d8:	49 89 ec             	mov    %rbp,%r12
  1049db:	49 c1 e4 04          	shl    $0x4,%r12
  1049df:	4c 89 e7             	mov    %r12,%rdi
  1049e2:	e8 69 87 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  1049e7:	48 89 c1             	mov    %rax,%rcx
  1049ea:	48 89 84 24 38 01 00 	mov    %rax,0x138(%rsp)
  1049f1:	00 
  1049f2:	66 0f ef c0          	pxor   %xmm0,%xmm0
  1049f6:	4a 8d 04 20          	lea    (%rax,%r12,1),%rax
  1049fa:	48 8d 71 10          	lea    0x10(%rcx),%rsi
  1049fe:	48 89 84 24 90 02 00 	mov    %rax,0x290(%rsp)
  104a05:	00 
  104a06:	48 89 c2             	mov    %rax,%rdx
  104a09:	48 89 b4 24 48 02 00 	mov    %rsi,0x248(%rsp)
  104a10:	00 
  104a11:	0f 11 01             	movups %xmm0,(%rcx)
  104a14:	48 83 fd 01          	cmp    $0x1,%rbp
  104a18:	74 21                	je     104a3b <synreal::SolverNewton::precompute_matrices()+0x6cb>
  104a1a:	48 89 f0             	mov    %rsi,%rax
  104a1d:	48 39 f2             	cmp    %rsi,%rdx
  104a20:	74 19                	je     104a3b <synreal::SolverNewton::precompute_matrices()+0x6cb>
  104a22:	f3 0f 6f 29          	movdqu (%rcx),%xmm5
  104a26:	48 83 c0 10          	add    $0x10,%rax
  104a2a:	0f 11 68 f0          	movups %xmm5,-0x10(%rax)
  104a2e:	48 39 c2             	cmp    %rax,%rdx
  104a31:	75 ef                	jne    104a22 <synreal::SolverNewton::precompute_matrices()+0x6b2>
  104a33:	48 89 84 24 48 02 00 	mov    %rax,0x248(%rsp)
  104a3a:	00 
  104a3b:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104a40:	4c 89 a4 24 a8 02 00 	mov    %r12,0x2a8(%rsp)
  104a47:	00 
  104a48:	44 8b a8 98 04 00 00 	mov    0x498(%rax),%r13d
  104a4f:	4d 85 ed             	test   %r13,%r13
  104a52:	0f 84 d1 28 00 00    	je     107329 <synreal::SolverNewton::precompute_matrices()+0x2fb9>
  104a58:	4c 89 ed             	mov    %r13,%rbp
  104a5b:	48 c1 e5 04          	shl    $0x4,%rbp
  104a5f:	48 89 ef             	mov    %rbp,%rdi
  104a62:	e8 e9 86 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104a67:	48 8d 3c 28          	lea    (%rax,%rbp,1),%rdi
  104a6b:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104a6f:	48 89 c2             	mov    %rax,%rdx
  104a72:	48 89 84 24 e0 00 00 	mov    %rax,0xe0(%rsp)
  104a79:	00 
  104a7a:	0f 11 00             	movups %xmm0,(%rax)
  104a7d:	48 8d 40 10          	lea    0x10(%rax),%rax
  104a81:	48 89 bc 24 50 02 00 	mov    %rdi,0x250(%rsp)
  104a88:	00 
  104a89:	48 89 ac 24 40 02 00 	mov    %rbp,0x240(%rsp)
  104a90:	00 
  104a91:	49 83 fd 01          	cmp    $0x1,%r13
  104a95:	0f 84 1c 09 00 00    	je     1053b7 <synreal::SolverNewton::precompute_matrices()+0x1047>
  104a9b:	48 39 c7             	cmp    %rax,%rdi
  104a9e:	74 14                	je     104ab4 <synreal::SolverNewton::precompute_matrices()+0x744>
  104aa0:	48 89 f9             	mov    %rdi,%rcx
  104aa3:	f3 0f 6f 32          	movdqu (%rdx),%xmm6
  104aa7:	48 83 c0 10          	add    $0x10,%rax
  104aab:	0f 11 70 f0          	movups %xmm6,-0x10(%rax)
  104aaf:	48 39 c1             	cmp    %rax,%rcx
  104ab2:	75 ef                	jne    104aa3 <synreal::SolverNewton::precompute_matrices()+0x733>
  104ab4:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104ab9:	8b a8 f0 04 00 00    	mov    0x4f0(%rax),%ebp
  104abf:	48 85 ed             	test   %rbp,%rbp
  104ac2:	0f 84 d8 27 00 00    	je     1072a0 <synreal::SolverNewton::precompute_matrices()+0x2f30>
  104ac8:	49 89 ec             	mov    %rbp,%r12
  104acb:	49 c1 e4 04          	shl    $0x4,%r12
  104acf:	4c 89 e7             	mov    %r12,%rdi
  104ad2:	e8 79 86 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104ad7:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104adb:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  104adf:	48 89 84 24 18 01 00 	mov    %rax,0x118(%rsp)
  104ae6:	00 
  104ae7:	48 89 c2             	mov    %rax,%rdx
  104aea:	0f 11 00             	movups %xmm0,(%rax)
  104aed:	48 8d 40 10          	lea    0x10(%rax),%rax
  104af1:	48 89 8c 24 98 02 00 	mov    %rcx,0x298(%rsp)
  104af8:	00 
  104af9:	48 89 84 24 38 02 00 	mov    %rax,0x238(%rsp)
  104b00:	00 
  104b01:	48 83 fd 01          	cmp    $0x1,%rbp
  104b05:	74 1e                	je     104b25 <synreal::SolverNewton::precompute_matrices()+0x7b5>
  104b07:	48 39 c1             	cmp    %rax,%rcx
  104b0a:	74 19                	je     104b25 <synreal::SolverNewton::precompute_matrices()+0x7b5>
  104b0c:	f3 0f 6f 3a          	movdqu (%rdx),%xmm7
  104b10:	48 83 c0 10          	add    $0x10,%rax
  104b14:	0f 11 78 f0          	movups %xmm7,-0x10(%rax)
  104b18:	48 39 c1             	cmp    %rax,%rcx
  104b1b:	75 ef                	jne    104b0c <synreal::SolverNewton::precompute_matrices()+0x79c>
  104b1d:	48 89 84 24 38 02 00 	mov    %rax,0x238(%rsp)
  104b24:	00 
  104b25:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104b2a:	4c 89 a4 24 a0 02 00 	mov    %r12,0x2a0(%rsp)
  104b31:	00 
  104b32:	44 8b a8 f0 04 00 00 	mov    0x4f0(%rax),%r13d
  104b39:	4d 85 ed             	test   %r13,%r13
  104b3c:	0f 84 8e 27 00 00    	je     1072d0 <synreal::SolverNewton::precompute_matrices()+0x2f60>
  104b42:	4c 89 ed             	mov    %r13,%rbp
  104b45:	48 c1 e5 04          	shl    $0x4,%rbp
  104b49:	48 89 ef             	mov    %rbp,%rdi
  104b4c:	e8 ff 85 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104b51:	48 89 c1             	mov    %rax,%rcx
  104b54:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104b58:	48 89 84 24 e8 00 00 	mov    %rax,0xe8(%rsp)
  104b5f:	00 
  104b60:	48 8d 04 28          	lea    (%rax,%rbp,1),%rax
  104b64:	48 8d 51 10          	lea    0x10(%rcx),%rdx
  104b68:	48 89 ac 24 70 02 00 	mov    %rbp,0x270(%rsp)
  104b6f:	00 
  104b70:	48 89 94 24 10 02 00 	mov    %rdx,0x210(%rsp)
  104b77:	00 
  104b78:	0f 11 01             	movups %xmm0,(%rcx)
  104b7b:	49 83 fd 01          	cmp    $0x1,%r13
  104b7f:	74 1e                	je     104b9f <synreal::SolverNewton::precompute_matrices()+0x82f>
  104b81:	48 39 d0             	cmp    %rdx,%rax
  104b84:	74 19                	je     104b9f <synreal::SolverNewton::precompute_matrices()+0x82f>
  104b86:	f3 0f 6f 29          	movdqu (%rcx),%xmm5
  104b8a:	48 83 c2 10          	add    $0x10,%rdx
  104b8e:	0f 11 6a f0          	movups %xmm5,-0x10(%rdx)
  104b92:	48 39 d0             	cmp    %rdx,%rax
  104b95:	75 ef                	jne    104b86 <synreal::SolverNewton::precompute_matrices()+0x816>
  104b97:	48 89 94 24 10 02 00 	mov    %rdx,0x210(%rsp)
  104b9e:	00 
  104b9f:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104ba4:	44 8b a0 68 05 00 00 	mov    0x568(%rax),%r12d
  104bab:	4d 85 e4             	test   %r12,%r12
  104bae:	0f 84 9e 27 00 00    	je     107352 <synreal::SolverNewton::precompute_matrices()+0x2fe2>
  104bb4:	4c 89 e5             	mov    %r12,%rbp
  104bb7:	48 c1 e5 04          	shl    $0x4,%rbp
  104bbb:	48 89 ef             	mov    %rbp,%rdi
  104bbe:	e8 8d 85 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104bc3:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104bc7:	48 8d 34 28          	lea    (%rax,%rbp,1),%rsi
  104bcb:	48 89 84 24 10 01 00 	mov    %rax,0x110(%rsp)
  104bd2:	00 
  104bd3:	48 89 c2             	mov    %rax,%rdx
  104bd6:	0f 11 00             	movups %xmm0,(%rax)
  104bd9:	48 8d 40 10          	lea    0x10(%rax),%rax
  104bdd:	48 89 b4 24 b0 01 00 	mov    %rsi,0x1b0(%rsp)
  104be4:	00 
  104be5:	48 89 84 24 18 02 00 	mov    %rax,0x218(%rsp)
  104bec:	00 
  104bed:	49 83 fc 01          	cmp    $0x1,%r12
  104bf1:	74 23                	je     104c16 <synreal::SolverNewton::precompute_matrices()+0x8a6>
  104bf3:	48 39 c6             	cmp    %rax,%rsi
  104bf6:	74 1e                	je     104c16 <synreal::SolverNewton::precompute_matrices()+0x8a6>
  104bf8:	f3 0f 6f 2a          	movdqu (%rdx),%xmm5
  104bfc:	48 83 c0 10          	add    $0x10,%rax
  104c00:	0f 11 68 f0          	movups %xmm5,-0x10(%rax)
  104c04:	48 39 84 24 b0 01 00 	cmp    %rax,0x1b0(%rsp)
  104c0b:	00 
  104c0c:	75 ea                	jne    104bf8 <synreal::SolverNewton::precompute_matrices()+0x888>
  104c0e:	48 89 84 24 18 02 00 	mov    %rax,0x218(%rsp)
  104c15:	00 
  104c16:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104c1b:	48 89 ac 24 b0 02 00 	mov    %rbp,0x2b0(%rsp)
  104c22:	00 
  104c23:	44 8b a8 68 05 00 00 	mov    0x568(%rax),%r13d
  104c2a:	4d 85 ed             	test   %r13,%r13
  104c2d:	0f 84 4f 27 00 00    	je     107382 <synreal::SolverNewton::precompute_matrices()+0x3012>
  104c33:	4d 89 ec             	mov    %r13,%r12
  104c36:	49 c1 e4 04          	shl    $0x4,%r12
  104c3a:	4c 89 e7             	mov    %r12,%rdi
  104c3d:	e8 0e 85 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104c42:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104c46:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  104c4a:	48 89 84 24 08 01 00 	mov    %rax,0x108(%rsp)
  104c51:	00 
  104c52:	48 89 c2             	mov    %rax,%rdx
  104c55:	0f 11 00             	movups %xmm0,(%rax)
  104c58:	48 8d 40 10          	lea    0x10(%rax),%rax
  104c5c:	48 89 8c 24 78 01 00 	mov    %rcx,0x178(%rsp)
  104c63:	00 
  104c64:	48 89 84 24 28 02 00 	mov    %rax,0x228(%rsp)
  104c6b:	00 
  104c6c:	49 83 fd 01          	cmp    $0x1,%r13
  104c70:	74 23                	je     104c95 <synreal::SolverNewton::precompute_matrices()+0x925>
  104c72:	48 39 c1             	cmp    %rax,%rcx
  104c75:	74 1e                	je     104c95 <synreal::SolverNewton::precompute_matrices()+0x925>
  104c77:	f3 0f 6f 2a          	movdqu (%rdx),%xmm5
  104c7b:	48 83 c0 10          	add    $0x10,%rax
  104c7f:	0f 11 68 f0          	movups %xmm5,-0x10(%rax)
  104c83:	48 39 84 24 78 01 00 	cmp    %rax,0x178(%rsp)
  104c8a:	00 
  104c8b:	75 ea                	jne    104c77 <synreal::SolverNewton::precompute_matrices()+0x907>
  104c8d:	48 89 84 24 28 02 00 	mov    %rax,0x228(%rsp)
  104c94:	00 
  104c95:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104c9a:	4c 89 a4 24 b8 02 00 	mov    %r12,0x2b8(%rsp)
  104ca1:	00 
  104ca2:	44 8b a8 68 05 00 00 	mov    0x568(%rax),%r13d
  104ca9:	4d 85 ed             	test   %r13,%r13
  104cac:	0f 84 00 27 00 00    	je     1073b2 <synreal::SolverNewton::precompute_matrices()+0x3042>
  104cb2:	4c 89 ed             	mov    %r13,%rbp
  104cb5:	48 c1 e5 04          	shl    $0x4,%rbp
  104cb9:	48 89 ef             	mov    %rbp,%rdi
  104cbc:	e8 8f 84 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104cc1:	48 89 c1             	mov    %rax,%rcx
  104cc4:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104cc8:	48 89 84 24 f0 00 00 	mov    %rax,0xf0(%rsp)
  104ccf:	00 
  104cd0:	48 8d 04 28          	lea    (%rax,%rbp,1),%rax
  104cd4:	48 8d 51 10          	lea    0x10(%rcx),%rdx
  104cd8:	48 89 ac 24 78 02 00 	mov    %rbp,0x278(%rsp)
  104cdf:	00 
  104ce0:	48 89 94 24 30 02 00 	mov    %rdx,0x230(%rsp)
  104ce7:	00 
  104ce8:	0f 11 01             	movups %xmm0,(%rcx)
  104ceb:	49 83 fd 01          	cmp    $0x1,%r13
  104cef:	74 1e                	je     104d0f <synreal::SolverNewton::precompute_matrices()+0x99f>
  104cf1:	48 39 d0             	cmp    %rdx,%rax
  104cf4:	74 19                	je     104d0f <synreal::SolverNewton::precompute_matrices()+0x99f>
  104cf6:	f3 0f 6f 31          	movdqu (%rcx),%xmm6
  104cfa:	48 83 c2 10          	add    $0x10,%rdx
  104cfe:	0f 11 72 f0          	movups %xmm6,-0x10(%rdx)
  104d02:	48 39 d0             	cmp    %rdx,%rax
  104d05:	75 ef                	jne    104cf6 <synreal::SolverNewton::precompute_matrices()+0x986>
  104d07:	48 89 94 24 30 02 00 	mov    %rdx,0x230(%rsp)
  104d0e:	00 
  104d0f:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104d14:	44 8b a0 d4 05 00 00 	mov    0x5d4(%rax),%r12d
  104d1b:	4d 85 e4             	test   %r12,%r12
  104d1e:	0f 84 b7 26 00 00    	je     1073db <synreal::SolverNewton::precompute_matrices()+0x306b>
  104d24:	4c 89 e5             	mov    %r12,%rbp
  104d27:	48 c1 e5 04          	shl    $0x4,%rbp
  104d2b:	48 89 ef             	mov    %rbp,%rdi
  104d2e:	e8 1d 84 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104d33:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104d37:	48 8d 34 28          	lea    (%rax,%rbp,1),%rsi
  104d3b:	48 89 84 24 d0 00 00 	mov    %rax,0xd0(%rsp)
  104d42:	00 
  104d43:	48 89 c2             	mov    %rax,%rdx
  104d46:	0f 11 00             	movups %xmm0,(%rax)
  104d49:	48 8d 40 10          	lea    0x10(%rax),%rax
  104d4d:	48 89 b4 24 70 01 00 	mov    %rsi,0x170(%rsp)
  104d54:	00 
  104d55:	48 89 84 24 00 02 00 	mov    %rax,0x200(%rsp)
  104d5c:	00 
  104d5d:	49 83 fc 01          	cmp    $0x1,%r12
  104d61:	74 23                	je     104d86 <synreal::SolverNewton::precompute_matrices()+0xa16>
  104d63:	48 39 c6             	cmp    %rax,%rsi
  104d66:	74 1e                	je     104d86 <synreal::SolverNewton::precompute_matrices()+0xa16>
  104d68:	f3 0f 6f 22          	movdqu (%rdx),%xmm4
  104d6c:	48 83 c0 10          	add    $0x10,%rax
  104d70:	0f 11 60 f0          	movups %xmm4,-0x10(%rax)
  104d74:	48 39 84 24 70 01 00 	cmp    %rax,0x170(%rsp)
  104d7b:	00 
  104d7c:	75 ea                	jne    104d68 <synreal::SolverNewton::precompute_matrices()+0x9f8>
  104d7e:	48 89 84 24 00 02 00 	mov    %rax,0x200(%rsp)
  104d85:	00 
  104d86:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104d8b:	48 89 ac 24 d0 02 00 	mov    %rbp,0x2d0(%rsp)
  104d92:	00 
  104d93:	44 8b a8 d4 05 00 00 	mov    0x5d4(%rax),%r13d
  104d9a:	4d 85 ed             	test   %r13,%r13
  104d9d:	0f 84 68 26 00 00    	je     10740b <synreal::SolverNewton::precompute_matrices()+0x309b>
  104da3:	4d 89 ec             	mov    %r13,%r12
  104da6:	49 c1 e4 04          	shl    $0x4,%r12
  104daa:	4c 89 e7             	mov    %r12,%rdi
  104dad:	e8 9e 83 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104db2:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104db6:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  104dba:	48 89 84 24 50 01 00 	mov    %rax,0x150(%rsp)
  104dc1:	00 
  104dc2:	48 89 c2             	mov    %rax,%rdx
  104dc5:	0f 11 00             	movups %xmm0,(%rax)
  104dc8:	48 8d 40 10          	lea    0x10(%rax),%rax
  104dcc:	48 89 8c 24 c0 01 00 	mov    %rcx,0x1c0(%rsp)
  104dd3:	00 
  104dd4:	48 89 84 24 08 02 00 	mov    %rax,0x208(%rsp)
  104ddb:	00 
  104ddc:	49 83 fd 01          	cmp    $0x1,%r13
  104de0:	74 23                	je     104e05 <synreal::SolverNewton::precompute_matrices()+0xa95>
  104de2:	48 39 c1             	cmp    %rax,%rcx
  104de5:	74 1e                	je     104e05 <synreal::SolverNewton::precompute_matrices()+0xa95>
  104de7:	f3 0f 6f 2a          	movdqu (%rdx),%xmm5
  104deb:	48 83 c0 10          	add    $0x10,%rax
  104def:	0f 11 68 f0          	movups %xmm5,-0x10(%rax)
  104df3:	48 39 84 24 c0 01 00 	cmp    %rax,0x1c0(%rsp)
  104dfa:	00 
  104dfb:	75 ea                	jne    104de7 <synreal::SolverNewton::precompute_matrices()+0xa77>
  104dfd:	48 89 84 24 08 02 00 	mov    %rax,0x208(%rsp)
  104e04:	00 
  104e05:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104e0a:	4c 89 a4 24 c8 02 00 	mov    %r12,0x2c8(%rsp)
  104e11:	00 
  104e12:	44 8b a8 d4 05 00 00 	mov    0x5d4(%rax),%r13d
  104e19:	4d 85 ed             	test   %r13,%r13
  104e1c:	0f 84 19 26 00 00    	je     10743b <synreal::SolverNewton::precompute_matrices()+0x30cb>
  104e22:	4c 89 ed             	mov    %r13,%rbp
  104e25:	48 c1 e5 04          	shl    $0x4,%rbp
  104e29:	48 89 ef             	mov    %rbp,%rdi
  104e2c:	e8 1f 83 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104e31:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104e35:	48 8d 34 28          	lea    (%rax,%rbp,1),%rsi
  104e39:	48 89 84 24 48 01 00 	mov    %rax,0x148(%rsp)
  104e40:	00 
  104e41:	48 89 c2             	mov    %rax,%rdx
  104e44:	0f 11 00             	movups %xmm0,(%rax)
  104e47:	48 8d 40 10          	lea    0x10(%rax),%rax
  104e4b:	48 89 b4 24 e8 01 00 	mov    %rsi,0x1e8(%rsp)
  104e52:	00 
  104e53:	48 89 84 24 58 02 00 	mov    %rax,0x258(%rsp)
  104e5a:	00 
  104e5b:	49 83 fd 01          	cmp    $0x1,%r13
  104e5f:	74 23                	je     104e84 <synreal::SolverNewton::precompute_matrices()+0xb14>
  104e61:	48 39 c6             	cmp    %rax,%rsi
  104e64:	74 1e                	je     104e84 <synreal::SolverNewton::precompute_matrices()+0xb14>
  104e66:	f3 0f 6f 32          	movdqu (%rdx),%xmm6
  104e6a:	48 83 c0 10          	add    $0x10,%rax
  104e6e:	0f 11 70 f0          	movups %xmm6,-0x10(%rax)
  104e72:	48 39 84 24 e8 01 00 	cmp    %rax,0x1e8(%rsp)
  104e79:	00 
  104e7a:	75 ea                	jne    104e66 <synreal::SolverNewton::precompute_matrices()+0xaf6>
  104e7c:	48 89 84 24 58 02 00 	mov    %rax,0x258(%rsp)
  104e83:	00 
  104e84:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104e89:	48 89 ac 24 c0 02 00 	mov    %rbp,0x2c0(%rsp)
  104e90:	00 
  104e91:	44 8b a8 d4 05 00 00 	mov    0x5d4(%rax),%r13d
  104e98:	4d 85 ed             	test   %r13,%r13
  104e9b:	0f 84 ca 25 00 00    	je     10746b <synreal::SolverNewton::precompute_matrices()+0x30fb>
  104ea1:	4d 89 ec             	mov    %r13,%r12
  104ea4:	49 c1 e4 04          	shl    $0x4,%r12
  104ea8:	4c 89 e7             	mov    %r12,%rdi
  104eab:	e8 a0 82 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104eb0:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104eb4:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  104eb8:	48 89 84 24 40 01 00 	mov    %rax,0x140(%rsp)
  104ebf:	00 
  104ec0:	48 89 c2             	mov    %rax,%rdx
  104ec3:	0f 11 00             	movups %xmm0,(%rax)
  104ec6:	48 8d 40 10          	lea    0x10(%rax),%rax
  104eca:	48 89 8c 24 c8 01 00 	mov    %rcx,0x1c8(%rsp)
  104ed1:	00 
  104ed2:	48 89 84 24 60 02 00 	mov    %rax,0x260(%rsp)
  104ed9:	00 
  104eda:	49 83 fd 01          	cmp    $0x1,%r13
  104ede:	74 23                	je     104f03 <synreal::SolverNewton::precompute_matrices()+0xb93>
  104ee0:	48 39 c1             	cmp    %rax,%rcx
  104ee3:	74 1e                	je     104f03 <synreal::SolverNewton::precompute_matrices()+0xb93>
  104ee5:	f3 0f 6f 3a          	movdqu (%rdx),%xmm7
  104ee9:	48 83 c0 10          	add    $0x10,%rax
  104eed:	0f 11 78 f0          	movups %xmm7,-0x10(%rax)
  104ef1:	48 39 84 24 c8 01 00 	cmp    %rax,0x1c8(%rsp)
  104ef8:	00 
  104ef9:	75 ea                	jne    104ee5 <synreal::SolverNewton::precompute_matrices()+0xb75>
  104efb:	48 89 84 24 60 02 00 	mov    %rax,0x260(%rsp)
  104f02:	00 
  104f03:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104f08:	4c 89 a4 24 d8 02 00 	mov    %r12,0x2d8(%rsp)
  104f0f:	00 
  104f10:	44 8b a8 d4 05 00 00 	mov    0x5d4(%rax),%r13d
  104f17:	4d 85 ed             	test   %r13,%r13
  104f1a:	0f 84 7b 25 00 00    	je     10749b <synreal::SolverNewton::precompute_matrices()+0x312b>
  104f20:	4c 89 ed             	mov    %r13,%rbp
  104f23:	48 c1 e5 04          	shl    $0x4,%rbp
  104f27:	48 89 ef             	mov    %rbp,%rdi
  104f2a:	e8 21 82 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104f2f:	48 89 c1             	mov    %rax,%rcx
  104f32:	66 0f ef c0          	pxor   %xmm0,%xmm0
  104f36:	48 89 84 24 28 01 00 	mov    %rax,0x128(%rsp)
  104f3d:	00 
  104f3e:	48 8d 04 28          	lea    (%rax,%rbp,1),%rax
  104f42:	48 8d 51 10          	lea    0x10(%rcx),%rdx
  104f46:	48 89 ac 24 80 02 00 	mov    %rbp,0x280(%rsp)
  104f4d:	00 
  104f4e:	48 89 94 24 20 02 00 	mov    %rdx,0x220(%rsp)
  104f55:	00 
  104f56:	0f 11 01             	movups %xmm0,(%rcx)
  104f59:	49 83 fd 01          	cmp    $0x1,%r13
  104f5d:	74 1e                	je     104f7d <synreal::SolverNewton::precompute_matrices()+0xc0d>
  104f5f:	48 39 d0             	cmp    %rdx,%rax
  104f62:	74 19                	je     104f7d <synreal::SolverNewton::precompute_matrices()+0xc0d>
  104f64:	f3 0f 6f 31          	movdqu (%rcx),%xmm6
  104f68:	48 83 c2 10          	add    $0x10,%rdx
  104f6c:	0f 11 72 f0          	movups %xmm6,-0x10(%rdx)
  104f70:	48 39 d0             	cmp    %rdx,%rax
  104f73:	75 ef                	jne    104f64 <synreal::SolverNewton::precompute_matrices()+0xbf4>
  104f75:	48 89 94 24 20 02 00 	mov    %rdx,0x220(%rsp)
  104f7c:	00 
  104f7d:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  104f82:	44 8b a0 e0 02 00 00 	mov    0x2e0(%rax),%r12d
  104f89:	4d 85 e4             	test   %r12,%r12
  104f8c:	0f 84 67 25 00 00    	je     1074f9 <synreal::SolverNewton::precompute_matrices()+0x3189>
  104f92:	4a 8d 2c a5 00 00 00 	lea    0x0(,%r12,4),%rbp
  104f99:	00 
  104f9a:	48 89 ef             	mov    %rbp,%rdi
  104f9d:	e8 ae 81 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104fa2:	48 8d 34 28          	lea    (%rax,%rbp,1),%rsi
  104fa6:	48 89 84 24 20 01 00 	mov    %rax,0x120(%rsp)
  104fad:	00 
  104fae:	48 8d 78 04          	lea    0x4(%rax),%rdi
  104fb2:	48 89 b4 24 68 02 00 	mov    %rsi,0x268(%rsp)
  104fb9:	00 
  104fba:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  104fc0:	48 89 ac 24 88 02 00 	mov    %rbp,0x288(%rsp)
  104fc7:	00 
  104fc8:	49 83 fc 01          	cmp    $0x1,%r12
  104fcc:	0f 84 0b 74 00 00    	je     10c3dd <synreal::SolverNewton::precompute_matrices()+0x806d>
  104fd2:	48 39 fe             	cmp    %rdi,%rsi
  104fd5:	74 0b                	je     104fe2 <synreal::SolverNewton::precompute_matrices()+0xc72>
  104fd7:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
  104fdb:	31 f6                	xor    %esi,%esi
  104fdd:	e8 3e 71 f6 ff       	call   6c120 <memset@plt>
  104fe2:	48 85 db             	test   %rbx,%rbx
  104fe5:	0f 84 f1 24 00 00    	je     1074dc <synreal::SolverNewton::precompute_matrices()+0x316c>
  104feb:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
  104ff0:	4c 89 ff             	mov    %r15,%rdi
  104ff3:	e8 58 81 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  104ff8:	48 89 c1             	mov    %rax,%rcx
  104ffb:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  105002:	00 
  105003:	4c 01 f9             	add    %r15,%rcx
  105006:	48 89 8c 24 d0 01 00 	mov    %rcx,0x1d0(%rsp)
  10500d:	00 
  10500e:	48 39 c1             	cmp    %rax,%rcx
  105011:	74 0d                	je     105020 <synreal::SolverNewton::precompute_matrices()+0xcb0>
  105013:	4c 89 fa             	mov    %r15,%rdx
  105016:	31 f6                	xor    %esi,%esi
  105018:	48 89 c7             	mov    %rax,%rdi
  10501b:	e8 00 71 f6 ff       	call   6c120 <memset@plt>
  105020:	48 8b 84 24 e0 03 00 	mov    0x3e0(%rsp),%rax
  105027:	00 
  105028:	48 8b 94 24 e8 03 00 	mov    0x3e8(%rsp),%rdx
  10502f:	00 
  105030:	48 39 c2             	cmp    %rax,%rdx
  105033:	74 39                	je     10506e <synreal::SolverNewton::precompute_matrices()+0xcfe>
  105035:	f3 0f 10 05 4f a7 0e 	movss  0xea74f(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  10503c:	00 
  10503d:	f3 0f 10 15 5b a7 0e 	movss  0xea75b(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  105044:	00 
  105045:	66 0f ef e4          	pxor   %xmm4,%xmm4
  105049:	f3 0f 10 08          	movss  (%rax),%xmm1
  10504d:	0f 28 d9             	movaps %xmm1,%xmm3
  105050:	0f 54 da             	andps  %xmm2,%xmm3
  105053:	0f 2e c3             	ucomiss %xmm3,%xmm0
  105056:	0f 82 6f 35 f7 ff    	jb     785cb <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1129>
  10505c:	0f 2f e1             	comiss %xmm1,%xmm4
  10505f:	0f 87 66 35 f7 ff    	ja     785cb <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1129>
  105065:	48 83 c0 04          	add    $0x4,%rax
  105069:	48 39 c2             	cmp    %rax,%rdx
  10506c:	75 db                	jne    105049 <synreal::SolverNewton::precompute_matrices()+0xcd9>
  10506e:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  105073:	8b 80 98 03 00 00    	mov    0x398(%rax),%eax
  105079:	85 c0                	test   %eax,%eax
  10507b:	0f 85 a1 24 00 00    	jne    107522 <synreal::SolverNewton::precompute_matrices()+0x31b2>
  105081:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  105086:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  10508d:	00 
  10508e:	44 8b b8 d0 00 00 00 	mov    0xd0(%rax),%r15d
  105095:	45 85 ff             	test   %r15d,%r15d
  105098:	0f 84 cc 05 00 00    	je     10566a <synreal::SolverNewton::precompute_matrices()+0x12fa>
  10509e:	48 8b 6c 24 40       	mov    0x40(%rsp),%rbp
  1050a3:	4c 8d 05 2e 1f 0e 00 	lea    0xe1f2e(%rip),%r8        # 1e6fd8 <_fini+0x1894>
  1050aa:	4c 89 f9             	mov    %r15,%rcx
  1050ad:	4c 89 f7             	mov    %r14,%rdi
  1050b0:	48 8b b5 d8 00 00 00 	mov    0xd8(%rbp),%rsi
  1050b7:	48 8b 95 e0 00 00 00 	mov    0xe0(%rbp),%rdx
  1050be:	e8 4d 80 f6 ff       	call   6d110 <std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<2, int, (glm::qualifier)0> >(synreal::Span<glm::vec<2, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  1050c3:	48 8b b5 e8 00 00 00 	mov    0xe8(%rbp),%rsi
  1050ca:	48 8b 95 f0 00 00 00 	mov    0xf0(%rbp),%rdx
  1050d1:	4c 89 f9             	mov    %r15,%rcx
  1050d4:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  1050db:	00 
  1050dc:	4c 8d 05 65 1f 0e 00 	lea    0xe1f65(%rip),%r8        # 1e7048 <_fini+0x1904>
  1050e3:	e8 d8 8b f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  1050e8:	31 ed                	xor    %ebp,%ebp
  1050ea:	4c 8d 35 48 25 0f 00 	lea    0xf2548(%rip),%r14        # 1f7639 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7739>
  1050f1:	4d 85 ff             	test   %r15,%r15
  1050f4:	0f 84 36 05 00 00    	je     105630 <synreal::SolverNewton::precompute_matrices()+0x12c0>
  1050fa:	48 8b 84 24 60 07 00 	mov    0x760(%rsp),%rax
  105101:	00 
  105102:	4c 89 f2             	mov    %r14,%rdx
  105105:	48 89 de             	mov    %rbx,%rsi
  105108:	48 8b 04 e8          	mov    (%rax,%rbp,8),%rax
  10510c:	89 c7                	mov    %eax,%edi
  10510e:	48 89 84 24 40 07 00 	mov    %rax,0x740(%rsp)
  105115:	00 
  105116:	e8 85 61 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10511b:	8b bc 24 44 07 00 00 	mov    0x744(%rsp),%edi
  105122:	4c 89 f2             	mov    %r14,%rdx
  105125:	48 89 de             	mov    %rbx,%rsi
  105128:	e8 73 61 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10512d:	48 63 84 24 40 07 00 	movslq 0x740(%rsp),%rax
  105134:	00 
  105135:	8b b4 24 44 07 00 00 	mov    0x744(%rsp),%esi
  10513c:	39 f0                	cmp    %esi,%eax
  10513e:	0f 84 cb 31 f7 ff    	je     7830f <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xe6d>
  105144:	48 8b bc 24 80 07 00 	mov    0x780(%rsp),%rdi
  10514b:	00 
  10514c:	4c 8d 24 ad 00 00 00 	lea    0x0(,%rbp,4),%r12
  105153:	00 
  105154:	f3 0f 10 05 30 a6 0e 	movss  0xea630(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  10515b:	00 
  10515c:	4c 01 e7             	add    %r12,%rdi
  10515f:	44 8b 2f             	mov    (%rdi),%r13d
  105162:	66 41 0f 6e cd       	movd   %r13d,%xmm1
  105167:	0f 54 0d 32 a6 0e 00 	andps  0xea632(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10516e:	0f 2e c1             	ucomiss %xmm1,%xmm0
  105171:	0f 82 a1 30 f7 ff    	jb     78218 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xd76>
  105177:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
  10517b:	49 c1 e1 04          	shl    $0x4,%r9
  10517f:	4c 03 8c 24 98 00 00 	add    0x98(%rsp),%r9
  105186:	00 
  105187:	49 8b 41 10          	mov    0x10(%r9),%rax
  10518b:	4d 8d 51 08          	lea    0x8(%r9),%r10
  10518f:	4d 89 d0             	mov    %r10,%r8
  105192:	48 85 c0             	test   %rax,%rax
  105195:	0f 84 38 02 00 00    	je     1053d3 <synreal::SolverNewton::precompute_matrices()+0x1063>
  10519b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1051a0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1051a4:	48 8b 48 18          	mov    0x18(%rax),%rcx
  1051a8:	3b 70 20             	cmp    0x20(%rax),%esi
  1051ab:	7f 1c                	jg     1051c9 <synreal::SolverNewton::precompute_matrices()+0xe59>
  1051ad:	49 89 c0             	mov    %rax,%r8
  1051b0:	48 85 d2             	test   %rdx,%rdx
  1051b3:	0f 84 0f 02 00 00    	je     1053c8 <synreal::SolverNewton::precompute_matrices()+0x1058>
  1051b9:	48 89 d0             	mov    %rdx,%rax
  1051bc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1051c0:	48 8b 48 18          	mov    0x18(%rax),%rcx
  1051c4:	3b 70 20             	cmp    0x20(%rax),%esi
  1051c7:	7e e4                	jle    1051ad <synreal::SolverNewton::precompute_matrices()+0xe3d>
  1051c9:	48 85 c9             	test   %rcx,%rcx
  1051cc:	0f 84 f6 01 00 00    	je     1053c8 <synreal::SolverNewton::precompute_matrices()+0x1058>
  1051d2:	48 89 c8             	mov    %rcx,%rax
  1051d5:	eb c9                	jmp    1051a0 <synreal::SolverNewton::precompute_matrices()+0xe30>
  1051d7:	66 0f ef c0          	pxor   %xmm0,%xmm0
  1051db:	45 31 e4             	xor    %r12d,%r12d
  1051de:	48 c7 84 24 10 04 00 	movq   $0x0,0x410(%rsp)
  1051e5:	00 00 00 00 00 
  1051ea:	48 c7 84 24 30 04 00 	movq   $0x0,0x430(%rsp)
  1051f1:	00 00 00 00 00 
  1051f6:	48 c7 84 24 50 04 00 	movq   $0x0,0x450(%rsp)
  1051fd:	00 00 00 00 00 
  105202:	48 c7 84 24 70 04 00 	movq   $0x0,0x470(%rsp)
  105209:	00 00 00 00 00 
  10520e:	48 c7 84 24 90 04 00 	movq   $0x0,0x490(%rsp)
  105215:	00 00 00 00 00 
  10521a:	48 c7 84 24 b0 04 00 	movq   $0x0,0x4b0(%rsp)
  105221:	00 00 00 00 00 
  105226:	48 c7 84 24 d0 04 00 	movq   $0x0,0x4d0(%rsp)
  10522d:	00 00 00 00 00 
  105232:	48 c7 84 24 f0 04 00 	movq   $0x0,0x4f0(%rsp)
  105239:	00 00 00 00 00 
  10523e:	48 c7 84 24 10 05 00 	movq   $0x0,0x510(%rsp)
  105245:	00 00 00 00 00 
  10524a:	48 c7 84 24 30 05 00 	movq   $0x0,0x530(%rsp)
  105251:	00 00 00 00 00 
  105256:	48 c7 84 24 50 05 00 	movq   $0x0,0x550(%rsp)
  10525d:	00 00 00 00 00 
  105262:	48 c7 84 24 70 05 00 	movq   $0x0,0x570(%rsp)
  105269:	00 00 00 00 00 
  10526e:	48 c7 84 24 80 05 00 	movq   $0x0,0x580(%rsp)
  105275:	00 00 00 00 00 
  10527a:	48 c7 84 24 90 05 00 	movq   $0x0,0x590(%rsp)
  105281:	00 00 00 00 00 
  105286:	48 c7 84 24 d8 00 00 	movq   $0x0,0xd8(%rsp)
  10528d:	00 00 00 00 00 
  105292:	48 c7 84 24 f8 00 00 	movq   $0x0,0xf8(%rsp)
  105299:	00 00 00 00 00 
  10529e:	48 c7 84 24 c8 00 00 	movq   $0x0,0xc8(%rsp)
  1052a5:	00 00 00 00 00 
  1052aa:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
  1052b1:	00 00 
  1052b3:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
  1052ba:	00 00 
  1052bc:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
  1052c3:	00 00 
  1052c5:	0f 29 84 24 00 04 00 	movaps %xmm0,0x400(%rsp)
  1052cc:	00 
  1052cd:	0f 29 84 24 20 04 00 	movaps %xmm0,0x420(%rsp)
  1052d4:	00 
  1052d5:	0f 29 84 24 40 04 00 	movaps %xmm0,0x440(%rsp)
  1052dc:	00 
  1052dd:	0f 29 84 24 60 04 00 	movaps %xmm0,0x460(%rsp)
  1052e4:	00 
  1052e5:	0f 29 84 24 80 04 00 	movaps %xmm0,0x480(%rsp)
  1052ec:	00 
  1052ed:	0f 29 84 24 a0 04 00 	movaps %xmm0,0x4a0(%rsp)
  1052f4:	00 
  1052f5:	0f 29 84 24 c0 04 00 	movaps %xmm0,0x4c0(%rsp)
  1052fc:	00 
  1052fd:	0f 29 84 24 e0 04 00 	movaps %xmm0,0x4e0(%rsp)
  105304:	00 
  105305:	0f 29 84 24 00 05 00 	movaps %xmm0,0x500(%rsp)
  10530c:	00 
  10530d:	0f 29 84 24 20 05 00 	movaps %xmm0,0x520(%rsp)
  105314:	00 
  105315:	0f 29 84 24 40 05 00 	movaps %xmm0,0x540(%rsp)
  10531c:	00 
  10531d:	0f 29 84 24 60 05 00 	movaps %xmm0,0x560(%rsp)
  105324:	00 
  105325:	48 c7 44 24 58 00 00 	movq   $0x0,0x58(%rsp)
  10532c:	00 00 
  10532e:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
  105335:	00 00 
  105337:	48 c7 84 24 a0 00 00 	movq   $0x0,0xa0(%rsp)
  10533e:	00 00 00 00 00 
  105343:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
  10534a:	00 00 
  10534c:	48 c7 84 24 98 00 00 	movq   $0x0,0x98(%rsp)
  105353:	00 00 00 00 00 
  105358:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
  10535f:	00 00 
  105361:	48 c7 44 24 70 00 00 	movq   $0x0,0x70(%rsp)
  105368:	00 00 
  10536a:	48 c7 84 24 b0 00 00 	movq   $0x0,0xb0(%rsp)
  105371:	00 00 00 00 00 
  105376:	48 c7 84 24 68 01 00 	movq   $0x0,0x168(%rsp)
  10537d:	00 00 00 00 00 
  105382:	48 c7 84 24 88 00 00 	movq   $0x0,0x88(%rsp)
  105389:	00 00 00 00 00 
  10538e:	48 c7 84 24 60 01 00 	movq   $0x0,0x160(%rsp)
  105395:	00 00 00 00 00 
  10539a:	48 c7 84 24 80 00 00 	movq   $0x0,0x80(%rsp)
  1053a1:	00 00 00 00 00 
  1053a6:	48 c7 84 24 b8 01 00 	movq   $0x0,0x1b8(%rsp)
  1053ad:	00 00 00 00 00 
  1053b2:	e9 05 f6 ff ff       	jmp    1049bc <synreal::SolverNewton::precompute_matrices()+0x64c>
  1053b7:	48 89 84 24 50 02 00 	mov    %rax,0x250(%rsp)
  1053be:	00 
  1053bf:	e9 f0 f6 ff ff       	jmp    104ab4 <synreal::SolverNewton::precompute_matrices()+0x744>
  1053c4:	0f 1f 40 00          	nopl   0x0(%rax)
  1053c8:	4d 39 d0             	cmp    %r10,%r8
  1053cb:	74 06                	je     1053d3 <synreal::SolverNewton::precompute_matrices()+0x1063>
  1053cd:	41 3b 70 20          	cmp    0x20(%r8),%esi
  1053d1:	7d 38                	jge    10540b <synreal::SolverNewton::precompute_matrices()+0x109b>
  1053d3:	48 8d 84 24 44 07 00 	lea    0x744(%rsp),%rax
  1053da:	00 
  1053db:	48 8d 94 24 40 03 00 	lea    0x340(%rsp),%rdx
  1053e2:	00 
  1053e3:	4c 89 c6             	mov    %r8,%rsi
  1053e6:	4c 89 cf             	mov    %r9,%rdi
  1053e9:	48 89 84 24 40 03 00 	mov    %rax,0x340(%rsp)
  1053f0:	00 
  1053f1:	e8 8a b6 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  1053f6:	48 8b bc 24 80 07 00 	mov    0x780(%rsp),%rdi
  1053fd:	00 
  1053fe:	8b b4 24 44 07 00 00 	mov    0x744(%rsp),%esi
  105405:	49 89 c0             	mov    %rax,%r8
  105408:	4c 01 e7             	add    %r12,%rdi
  10540b:	48 63 c6             	movslq %esi,%rax
  10540e:	48 8b b4 24 98 00 00 	mov    0x98(%rsp),%rsi
  105415:	00 
  105416:	66 41 0f 6e c5       	movd   %r13d,%xmm0
  10541b:	f3 41 0f 58 40 24    	addss  0x24(%r8),%xmm0
  105421:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  105425:	48 c1 e0 04          	shl    $0x4,%rax
  105429:	4c 8d 0c 06          	lea    (%rsi,%rax,1),%r9
  10542d:	f3 41 0f 11 40 24    	movss  %xmm0,0x24(%r8)
  105433:	44 8b 27             	mov    (%rdi),%r12d
  105436:	49 8b 41 10          	mov    0x10(%r9),%rax
  10543a:	49 8d 79 08          	lea    0x8(%r9),%rdi
  10543e:	48 85 c0             	test   %rax,%rax
  105441:	0f 84 8d 20 00 00    	je     1074d4 <synreal::SolverNewton::precompute_matrices()+0x3164>
  105447:	48 63 b4 24 40 07 00 	movslq 0x740(%rsp),%rsi
  10544e:	00 
  10544f:	49 89 f8             	mov    %rdi,%r8
  105452:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  105458:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10545c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  105460:	3b 70 20             	cmp    0x20(%rax),%esi
  105463:	7f 18                	jg     10547d <synreal::SolverNewton::precompute_matrices()+0x110d>
  105465:	49 89 c0             	mov    %rax,%r8
  105468:	48 85 d2             	test   %rdx,%rdx
  10546b:	74 1a                	je     105487 <synreal::SolverNewton::precompute_matrices()+0x1117>
  10546d:	48 89 d0             	mov    %rdx,%rax
  105470:	48 8b 50 10          	mov    0x10(%rax),%rdx
  105474:	48 8b 48 18          	mov    0x18(%rax),%rcx
  105478:	3b 70 20             	cmp    0x20(%rax),%esi
  10547b:	7e e8                	jle    105465 <synreal::SolverNewton::precompute_matrices()+0x10f5>
  10547d:	48 85 c9             	test   %rcx,%rcx
  105480:	74 05                	je     105487 <synreal::SolverNewton::precompute_matrices()+0x1117>
  105482:	48 89 c8             	mov    %rcx,%rax
  105485:	eb d1                	jmp    105458 <synreal::SolverNewton::precompute_matrices()+0x10e8>
  105487:	49 39 f8             	cmp    %rdi,%r8
  10548a:	74 06                	je     105492 <synreal::SolverNewton::precompute_matrices()+0x1122>
  10548c:	41 3b 70 20          	cmp    0x20(%r8),%esi
  105490:	7d 2e                	jge    1054c0 <synreal::SolverNewton::precompute_matrices()+0x1150>
  105492:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  105499:	00 
  10549a:	48 8d 94 24 48 03 00 	lea    0x348(%rsp),%rdx
  1054a1:	00 
  1054a2:	4c 89 c6             	mov    %r8,%rsi
  1054a5:	4c 89 cf             	mov    %r9,%rdi
  1054a8:	4c 89 ac 24 48 03 00 	mov    %r13,0x348(%rsp)
  1054af:	00 
  1054b0:	e8 cb b5 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  1054b5:	48 63 b4 24 40 07 00 	movslq 0x740(%rsp),%rsi
  1054bc:	00 
  1054bd:	49 89 c0             	mov    %rax,%r8
  1054c0:	48 8d 04 76          	lea    (%rsi,%rsi,2),%rax
  1054c4:	48 8b b4 24 a0 00 00 	mov    0xa0(%rsp),%rsi
  1054cb:	00 
  1054cc:	66 41 0f 6e c4       	movd   %r12d,%xmm0
  1054d1:	f3 41 0f 58 40 24    	addss  0x24(%r8),%xmm0
  1054d7:	48 c1 e0 04          	shl    $0x4,%rax
  1054db:	4c 8d 0c 06          	lea    (%rsi,%rax,1),%r9
  1054df:	49 8b 41 10          	mov    0x10(%r9),%rax
  1054e3:	f3 41 0f 11 40 24    	movss  %xmm0,0x24(%r8)
  1054e9:	4d 8d 41 08          	lea    0x8(%r9),%r8
  1054ed:	48 85 c0             	test   %rax,%rax
  1054f0:	0f 84 d6 1f 00 00    	je     1074cc <synreal::SolverNewton::precompute_matrices()+0x315c>
  1054f6:	8b bc 24 44 07 00 00 	mov    0x744(%rsp),%edi
  1054fd:	4c 89 c6             	mov    %r8,%rsi
  105500:	48 8b 50 10          	mov    0x10(%rax),%rdx
  105504:	48 8b 48 18          	mov    0x18(%rax),%rcx
  105508:	3b 78 20             	cmp    0x20(%rax),%edi
  10550b:	7f 18                	jg     105525 <synreal::SolverNewton::precompute_matrices()+0x11b5>
  10550d:	48 89 c6             	mov    %rax,%rsi
  105510:	48 85 d2             	test   %rdx,%rdx
  105513:	74 1a                	je     10552f <synreal::SolverNewton::precompute_matrices()+0x11bf>
  105515:	48 89 d0             	mov    %rdx,%rax
  105518:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10551c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  105520:	3b 78 20             	cmp    0x20(%rax),%edi
  105523:	7e e8                	jle    10550d <synreal::SolverNewton::precompute_matrices()+0x119d>
  105525:	48 85 c9             	test   %rcx,%rcx
  105528:	74 05                	je     10552f <synreal::SolverNewton::precompute_matrices()+0x11bf>
  10552a:	48 89 c8             	mov    %rcx,%rax
  10552d:	eb d1                	jmp    105500 <synreal::SolverNewton::precompute_matrices()+0x1190>
  10552f:	4c 39 c6             	cmp    %r8,%rsi
  105532:	74 05                	je     105539 <synreal::SolverNewton::precompute_matrices()+0x11c9>
  105534:	3b 7e 20             	cmp    0x20(%rsi),%edi
  105537:	7d 23                	jge    10555c <synreal::SolverNewton::precompute_matrices()+0x11ec>
  105539:	48 8d 84 24 44 07 00 	lea    0x744(%rsp),%rax
  105540:	00 
  105541:	48 8d 94 24 50 03 00 	lea    0x350(%rsp),%rdx
  105548:	00 
  105549:	4c 89 cf             	mov    %r9,%rdi
  10554c:	48 89 84 24 50 03 00 	mov    %rax,0x350(%rsp)
  105553:	00 
  105554:	e8 c7 b7 fe ff       	call   f0d20 <std::_Rb_tree_iterator<std::pair<int const, std::vector<int, std::allocator<int> > > > std::_Rb_tree<int, std::pair<int const, std::vector<int, std::allocator<int> > >, std::_Select1st<std::pair<int const, std::vector<int, std::allocator<int> > > >, std::less<int>, std::allocator<std::pair<int const, std::vector<int, std::allocator<int> > > > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, std::vector<int, std::allocator<int> > > >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  105559:	48 89 c6             	mov    %rax,%rsi
  10555c:	4c 8d a4 24 20 07 00 	lea    0x720(%rsp),%r12
  105563:	00 
  105564:	48 8d 7e 28          	lea    0x28(%rsi),%rdi
  105568:	89 2c 24             	mov    %ebp,(%rsp)
  10556b:	4c 89 e6             	mov    %r12,%rsi
  10556e:	89 ac 24 20 07 00 00 	mov    %ebp,0x720(%rsp)
  105575:	e8 16 93 f6 ff       	call   6e890 <int& std::vector<int, std::allocator<int> >::emplace_back<int>(int&&)@plt>
  10557a:	48 63 84 24 44 07 00 	movslq 0x744(%rsp),%rax
  105581:	00 
  105582:	48 8d 3c 40          	lea    (%rax,%rax,2),%rdi
  105586:	48 c1 e7 04          	shl    $0x4,%rdi
  10558a:	48 03 bc 24 a0 00 00 	add    0xa0(%rsp),%rdi
  105591:	00 
  105592:	48 8b 57 10          	mov    0x10(%rdi),%rdx
  105596:	4c 8d 4f 08          	lea    0x8(%rdi),%r9
  10559a:	48 85 d2             	test   %rdx,%rdx
  10559d:	0f 84 21 1f 00 00    	je     1074c4 <synreal::SolverNewton::precompute_matrices()+0x3154>
  1055a3:	8b 84 24 40 07 00 00 	mov    0x740(%rsp),%eax
  1055aa:	4d 89 c8             	mov    %r9,%r8
  1055ad:	0f 1f 00             	nopl   (%rax)
  1055b0:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  1055b4:	48 8b 72 18          	mov    0x18(%rdx),%rsi
  1055b8:	3b 42 20             	cmp    0x20(%rdx),%eax
  1055bb:	7f 18                	jg     1055d5 <synreal::SolverNewton::precompute_matrices()+0x1265>
  1055bd:	49 89 d0             	mov    %rdx,%r8
  1055c0:	48 85 c9             	test   %rcx,%rcx
  1055c3:	74 1a                	je     1055df <synreal::SolverNewton::precompute_matrices()+0x126f>
  1055c5:	48 89 ca             	mov    %rcx,%rdx
  1055c8:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  1055cc:	48 8b 72 18          	mov    0x18(%rdx),%rsi
  1055d0:	3b 42 20             	cmp    0x20(%rdx),%eax
  1055d3:	7e e8                	jle    1055bd <synreal::SolverNewton::precompute_matrices()+0x124d>
  1055d5:	48 85 f6             	test   %rsi,%rsi
  1055d8:	74 05                	je     1055df <synreal::SolverNewton::precompute_matrices()+0x126f>
  1055da:	48 89 f2             	mov    %rsi,%rdx
  1055dd:	eb d1                	jmp    1055b0 <synreal::SolverNewton::precompute_matrices()+0x1240>
  1055df:	4d 39 c8             	cmp    %r9,%r8
  1055e2:	74 06                	je     1055ea <synreal::SolverNewton::precompute_matrices()+0x127a>
  1055e4:	41 3b 40 20          	cmp    0x20(%r8),%eax
  1055e8:	7d 23                	jge    10560d <synreal::SolverNewton::precompute_matrices()+0x129d>
  1055ea:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  1055f1:	00 
  1055f2:	48 8d 94 24 58 03 00 	lea    0x358(%rsp),%rdx
  1055f9:	00 
  1055fa:	4c 89 c6             	mov    %r8,%rsi
  1055fd:	4c 89 ac 24 58 03 00 	mov    %r13,0x358(%rsp)
  105604:	00 
  105605:	e8 16 b7 fe ff       	call   f0d20 <std::_Rb_tree_iterator<std::pair<int const, std::vector<int, std::allocator<int> > > > std::_Rb_tree<int, std::pair<int const, std::vector<int, std::allocator<int> > >, std::_Select1st<std::pair<int const, std::vector<int, std::allocator<int> > > >, std::less<int>, std::allocator<std::pair<int const, std::vector<int, std::allocator<int> > > > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, std::vector<int, std::allocator<int> > > >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10560a:	49 89 c0             	mov    %rax,%r8
  10560d:	8b 04 24             	mov    (%rsp),%eax
  105610:	49 8d 78 28          	lea    0x28(%r8),%rdi
  105614:	4c 89 e6             	mov    %r12,%rsi
  105617:	89 84 24 20 07 00 00 	mov    %eax,0x720(%rsp)
  10561e:	e8 6d 92 f6 ff       	call   6e890 <int& std::vector<int, std::allocator<int> >::emplace_back<int>(int&&)@plt>
  105623:	48 83 c5 01          	add    $0x1,%rbp
  105627:	49 39 ef             	cmp    %rbp,%r15
  10562a:	0f 85 ca fa ff ff    	jne    1050fa <synreal::SolverNewton::precompute_matrices()+0xd8a>
  105630:	48 8b bc 24 80 07 00 	mov    0x780(%rsp),%rdi
  105637:	00 
  105638:	48 85 ff             	test   %rdi,%rdi
  10563b:	74 10                	je     10564d <synreal::SolverNewton::precompute_matrices()+0x12dd>
  10563d:	48 8b b4 24 90 07 00 	mov    0x790(%rsp),%rsi
  105644:	00 
  105645:	48 29 fe             	sub    %rdi,%rsi
  105648:	e8 63 7b f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10564d:	48 8b bc 24 60 07 00 	mov    0x760(%rsp),%rdi
  105654:	00 
  105655:	48 85 ff             	test   %rdi,%rdi
  105658:	74 10                	je     10566a <synreal::SolverNewton::precompute_matrices()+0x12fa>
  10565a:	48 8b b4 24 70 07 00 	mov    0x770(%rsp),%rsi
  105661:	00 
  105662:	48 29 fe             	sub    %rdi,%rsi
  105665:	e8 46 7b f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10566a:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  10566f:	8b 80 40 02 00 00    	mov    0x240(%rax),%eax
  105675:	85 c0                	test   %eax,%eax
  105677:	0f 85 e8 30 00 00    	jne    108765 <synreal::SolverNewton::precompute_matrices()+0x43f5>
  10567d:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  105682:	8b 80 98 04 00 00    	mov    0x498(%rax),%eax
  105688:	85 c0                	test   %eax,%eax
  10568a:	0f 85 20 24 00 00    	jne    107ab0 <synreal::SolverNewton::precompute_matrices()+0x3740>
  105690:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  105695:	8b 80 f0 04 00 00    	mov    0x4f0(%rax),%eax
  10569b:	85 c0                	test   %eax,%eax
  10569d:	0f 85 a2 54 00 00    	jne    10ab45 <synreal::SolverNewton::precompute_matrices()+0x67d5>
  1056a3:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  1056a8:	8b 80 68 05 00 00    	mov    0x568(%rax),%eax
  1056ae:	85 c0                	test   %eax,%eax
  1056b0:	0f 85 03 47 00 00    	jne    109db9 <synreal::SolverNewton::precompute_matrices()+0x5a49>
  1056b6:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  1056bb:	c6 80 98 32 00 00 00 	movb   $0x0,0x3298(%rax)
  1056c2:	8b 80 d4 05 00 00    	mov    0x5d4(%rax),%eax
  1056c8:	85 c0                	test   %eax,%eax
  1056ca:	0f 85 a9 3d 00 00    	jne    109479 <synreal::SolverNewton::precompute_matrices()+0x5109>
  1056d0:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  1056d5:	8b 80 78 02 00 00    	mov    0x278(%rax),%eax
  1056db:	85 c0                	test   %eax,%eax
  1056dd:	0f 85 bc 38 00 00    	jne    108f9f <synreal::SolverNewton::precompute_matrices()+0x4c2f>
  1056e3:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  1056e8:	8b 80 e0 02 00 00    	mov    0x2e0(%rax),%eax
  1056ee:	85 c0                	test   %eax,%eax
  1056f0:	0f 85 ee 34 00 00    	jne    108be4 <synreal::SolverNewton::precompute_matrices()+0x4874>
  1056f6:	48 8b 6c 24 40       	mov    0x40(%rsp),%rbp
  1056fb:	8b 85 18 03 00 00    	mov    0x318(%rbp),%eax
  105701:	c6 85 40 33 00 00 00 	movb   $0x0,0x3340(%rbp)
  105708:	85 c0                	test   %eax,%eax
  10570a:	0f 84 5a 05 00 00    	je     105c6a <synreal::SolverNewton::precompute_matrices()+0x18fa>
  105710:	41 89 c7             	mov    %eax,%r15d
  105713:	48 8b b5 20 03 00 00 	mov    0x320(%rbp),%rsi
  10571a:	48 8b 95 28 03 00 00 	mov    0x328(%rbp),%rdx
  105721:	48 8d bc 24 20 07 00 	lea    0x720(%rsp),%rdi
  105728:	00 
  105729:	4c 8d 05 27 58 0e 00 	lea    0xe5827(%rip),%r8        # 1eaf57 <_fini+0x5813>
  105730:	4c 89 f9             	mov    %r15,%rcx
  105733:	e8 b8 9e f6 ff       	call   6f5f0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  105738:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  10573f:	00 
  105740:	48 8b b5 30 03 00 00 	mov    0x330(%rbp),%rsi
  105747:	4c 89 f9             	mov    %r15,%rcx
  10574a:	48 8b 95 38 03 00 00 	mov    0x338(%rbp),%rdx
  105751:	4c 8d 05 a0 57 0e 00 	lea    0xe57a0(%rip),%r8        # 1eaef8 <_fini+0x57b4>
  105758:	4c 89 ef             	mov    %r13,%rdi
  10575b:	e8 e0 8b f6 ff       	call   6e340 <std::vector<glm::vec<2, float, (glm::qualifier)0>, std::allocator<glm::vec<2, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<2, float, (glm::qualifier)0> >(synreal::Span<glm::vec<2, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  105760:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  105767:	00 
  105768:	48 8b b5 40 03 00 00 	mov    0x340(%rbp),%rsi
  10576f:	4c 89 f9             	mov    %r15,%rcx
  105772:	48 8b 95 48 03 00 00 	mov    0x348(%rbp),%rdx
  105779:	4c 8d 05 90 57 0e 00 	lea    0xe5790(%rip),%r8        # 1eaf10 <_fini+0x57cc>
  105780:	4c 89 f7             	mov    %r14,%rdi
  105783:	e8 38 85 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  105788:	48 8b b5 50 03 00 00 	mov    0x350(%rbp),%rsi
  10578f:	48 8b 95 58 03 00 00 	mov    0x358(%rbp),%rdx
  105796:	4c 89 f9             	mov    %r15,%rcx
  105799:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  1057a0:	00 
  1057a1:	4c 8d 05 78 57 0e 00 	lea    0xe5778(%rip),%r8        # 1eaf20 <_fini+0x57dc>
  1057a8:	e8 a3 89 f6 ff       	call   6e150 <std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, float, (glm::qualifier)0> >(synreal::Span<glm::vec<4, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  1057ad:	45 31 f6             	xor    %r14d,%r14d
  1057b0:	4c 8d 25 ec 1e 0f 00 	lea    0xf1eec(%rip),%r12        # 1f76a3 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x77a3>
  1057b7:	eb 0d                	jmp    1057c6 <synreal::SolverNewton::precompute_matrices()+0x1456>
  1057b9:	49 83 c6 01          	add    $0x1,%r14
  1057bd:	4d 39 f7             	cmp    %r14,%r15
  1057c0:	0f 84 30 04 00 00    	je     105bf6 <synreal::SolverNewton::precompute_matrices()+0x1886>
  1057c6:	48 8b 84 24 20 07 00 	mov    0x720(%rsp),%rax
  1057cd:	00 
  1057ce:	4d 89 f5             	mov    %r14,%r13
  1057d1:	49 c1 e5 04          	shl    $0x4,%r13
  1057d5:	66 42 0f 6e 64 28 0c 	movd   0xc(%rax,%r13,1),%xmm4
  1057dc:	f3 42 0f 6f 04 28    	movdqu (%rax,%r13,1),%xmm0
  1057e2:	66 42 0f 6e 6c 28 08 	movd   0x8(%rax,%r13,1),%xmm5
  1057e9:	66 0f 7e 64 24 48    	movd   %xmm4,0x48(%rsp)
  1057ef:	66 42 0f 6e 64 28 04 	movd   0x4(%rax,%r13,1),%xmm4
  1057f6:	66 0f 7e c0          	movd   %xmm0,%eax
  1057fa:	66 0f 7e 6c 24 58    	movd   %xmm5,0x58(%rsp)
  105800:	66 0f 7e 24 24       	movd   %xmm4,(%rsp)
  105805:	0b 04 24             	or     (%rsp),%eax
  105808:	66 0f 7e 44 24 38    	movd   %xmm0,0x38(%rsp)
  10580e:	78 a9                	js     1057b9 <synreal::SolverNewton::precompute_matrices()+0x1449>
  105810:	48 8d 84 24 c0 07 00 	lea    0x7c0(%rsp),%rax
  105817:	00 
  105818:	0f 29 84 24 c0 07 00 	movaps %xmm0,0x7c0(%rsp)
  10581f:	00 
  105820:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  105825:	48 89 c5             	mov    %rax,%rbp
  105828:	48 8d 84 24 d0 07 00 	lea    0x7d0(%rsp),%rax
  10582f:	00 
  105830:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  105835:	8b 7d 00             	mov    0x0(%rbp),%edi
  105838:	4c 89 e2             	mov    %r12,%rdx
  10583b:	48 89 de             	mov    %rbx,%rsi
  10583e:	e8 5d 5a f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  105843:	48 83 c5 04          	add    $0x4,%rbp
  105847:	48 39 6c 24 18       	cmp    %rbp,0x18(%rsp)
  10584c:	75 e7                	jne    105835 <synreal::SolverNewton::precompute_matrices()+0x14c5>
  10584e:	8b 74 24 38          	mov    0x38(%rsp),%esi
  105852:	8b 7c 24 58          	mov    0x58(%rsp),%edi
  105856:	8b 0c 24             	mov    (%rsp),%ecx
  105859:	44 8b 5c 24 48       	mov    0x48(%rsp),%r11d
  10585e:	39 fe                	cmp    %edi,%esi
  105860:	0f 94 c0             	sete   %al
  105863:	39 ce                	cmp    %ecx,%esi
  105865:	0f 94 c2             	sete   %dl
  105868:	09 d0                	or     %edx,%eax
  10586a:	44 39 de             	cmp    %r11d,%esi
  10586d:	0f 94 c2             	sete   %dl
  105870:	09 d0                	or     %edx,%eax
  105872:	39 f9                	cmp    %edi,%ecx
  105874:	0f 94 c2             	sete   %dl
  105877:	09 d0                	or     %edx,%eax
  105879:	44 39 d9             	cmp    %r11d,%ecx
  10587c:	0f 94 c2             	sete   %dl
  10587f:	08 d0                	or     %dl,%al
  105881:	0f 85 32 ff ff ff    	jne    1057b9 <synreal::SolverNewton::precompute_matrices()+0x1449>
  105887:	41 39 fb             	cmp    %edi,%r11d
  10588a:	0f 84 29 ff ff ff    	je     1057b9 <synreal::SolverNewton::precompute_matrices()+0x1449>
  105890:	48 8b 84 24 60 07 00 	mov    0x760(%rsp),%rax
  105897:	00 
  105898:	f3 0f 10 3d ec 9e 0e 	movss  0xe9eec(%rip),%xmm7        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  10589f:	00 
  1058a0:	f3 42 0f 10 2c b0    	movss  (%rax,%r14,4),%xmm5
  1058a6:	0f 28 c5             	movaps %xmm5,%xmm0
  1058a9:	0f 54 05 f0 9e 0e 00 	andps  0xe9ef0(%rip),%xmm0        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1058b0:	0f 2e f8             	ucomiss %xmm0,%xmm7
  1058b3:	0f 82 24 29 f7 ff    	jb     781dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xd3b>
  1058b9:	66 0f ef e4          	pxor   %xmm4,%xmm4
  1058bd:	0f 2f e5             	comiss %xmm5,%xmm4
  1058c0:	f3 0f 11 64 24 48    	movss  %xmm4,0x48(%rsp)
  1058c6:	0f 83 ed fe ff ff    	jae    1057b9 <synreal::SolverNewton::precompute_matrices()+0x1449>
  1058cc:	48 8b 84 24 40 07 00 	mov    0x740(%rsp),%rax
  1058d3:	00 
  1058d4:	4a 8d 04 f0          	lea    (%rax,%r14,8),%rax
  1058d8:	f3 0f 10 18          	movss  (%rax),%xmm3
  1058dc:	0f 28 c3             	movaps %xmm3,%xmm0
  1058df:	0f 54 05 ba 9e 0e 00 	andps  0xe9eba(%rip),%xmm0        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1058e6:	0f 2e f8             	ucomiss %xmm0,%xmm7
  1058e9:	0f 82 ff 30 f7 ff    	jb     789ee <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x154c>
  1058ef:	0f 2f e3             	comiss %xmm3,%xmm4
  1058f2:	0f 87 f6 30 f7 ff    	ja     789ee <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x154c>
  1058f8:	f3 0f 10 40 04       	movss  0x4(%rax),%xmm0
  1058fd:	0f 28 c8             	movaps %xmm0,%xmm1
  105900:	0f 54 0d 99 9e 0e 00 	andps  0xe9e99(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  105907:	0f 2e f9             	ucomiss %xmm1,%xmm7
  10590a:	0f 82 32 72 00 00    	jb     10cb42 <synreal::SolverNewton::precompute_matrices()+0x87d2>
  105910:	0f 2f e0             	comiss %xmm0,%xmm4
  105913:	0f 87 5f 30 f7 ff    	ja     78978 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x14d6>
  105919:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  10591e:	0f b6 80 40 33 00 00 	movzbl 0x3340(%rax),%eax
  105925:	84 c0                	test   %al,%al
  105927:	75 08                	jne    105931 <synreal::SolverNewton::precompute_matrices()+0x15c1>
  105929:	0f 2f 44 24 48       	comiss 0x48(%rsp),%xmm0
  10592e:	0f 97 c0             	seta   %al
  105931:	4c 03 ac 24 80 07 00 	add    0x780(%rsp),%r13
  105938:	00 
  105939:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
  10593e:	f3 44 0f 10 2d 45 9e 	movss  0xe9e45(%rip),%xmm13        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  105945:	0e 00 
  105947:	f3 41 0f 10 75 00    	movss  0x0(%r13),%xmm6
  10594d:	88 81 40 33 00 00    	mov    %al,0x3340(%rcx)
  105953:	41 0f 10 45 00       	movups 0x0(%r13),%xmm0
  105958:	0f 28 fe             	movaps %xmm6,%xmm7
  10595b:	0f 54 3d 3e 9e 0e 00 	andps  0xe9e3e(%rip),%xmm7        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  105962:	0f 28 e0             	movaps %xmm0,%xmm4
  105965:	0f 28 d0             	movaps %xmm0,%xmm2
  105968:	0f 28 c8             	movaps %xmm0,%xmm1
  10596b:	44 0f 2e ef          	ucomiss %xmm7,%xmm13
  10596f:	0f c6 e0 7e          	shufps $0x7e,%xmm0,%xmm4
  105973:	0f c6 d0 55          	shufps $0x55,%xmm0,%xmm2
  105977:	0f c6 c8 ff          	shufps $0xff,%xmm0,%xmm1
  10597b:	0f 15 c0             	unpckhps %xmm0,%xmm0
  10597e:	0f 82 38 30 f7 ff    	jb     789bc <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x151a>
  105984:	0f 28 fa             	movaps %xmm2,%xmm7
  105987:	0f 54 3d 12 9e 0e 00 	andps  0xe9e12(%rip),%xmm7        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10598e:	44 0f 2e ef          	ucomiss %xmm7,%xmm13
  105992:	0f 82 24 30 f7 ff    	jb     789bc <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x151a>
  105998:	0f 28 f8             	movaps %xmm0,%xmm7
  10599b:	0f 54 3d fe 9d 0e 00 	andps  0xe9dfe(%rip),%xmm7        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1059a2:	44 0f 2e ef          	ucomiss %xmm7,%xmm13
  1059a6:	0f 82 10 30 f7 ff    	jb     789bc <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x151a>
  1059ac:	0f 54 0d ed 9d 0e 00 	andps  0xe9ded(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1059b3:	44 0f 2e e9          	ucomiss %xmm1,%xmm13
  1059b7:	0f 82 ff 2f f7 ff    	jb     789bc <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x151a>
  1059bd:	0f 57 15 9c 25 0f 00 	xorps  0xf259c(%rip),%xmm2        # 1f7f60 <cuda::std::__4::in_place+0x13>
  1059c4:	0f 28 ce             	movaps %xmm6,%xmm1
  1059c7:	0f 14 c6             	unpcklps %xmm6,%xmm0
  1059ca:	45 31 ed             	xor    %r13d,%r13d
  1059cd:	0f 57 0d 8c 25 0f 00 	xorps  0xf258c(%rip),%xmm1        # 1f7f60 <cuda::std::__4::in_place+0x13>
  1059d4:	48 8d 84 24 1c 03 00 	lea    0x31c(%rsp),%rax
  1059db:	00 
  1059dc:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
  1059e1:	0f 14 ca             	unpcklps %xmm2,%xmm1
  1059e4:	0f 16 c8             	movlhps %xmm0,%xmm1
  1059e7:	0f 28 c1             	movaps %xmm1,%xmm0
  1059ea:	0f 5c c4             	subps  %xmm4,%xmm0
  1059ed:	0f 58 e1             	addps  %xmm1,%xmm4
  1059f0:	0f 28 d0             	movaps %xmm0,%xmm2
  1059f3:	0f c6 c4 e4          	shufps $0xe4,%xmm4,%xmm0
  1059f7:	0f 29 84 24 d0 07 00 	movaps %xmm0,0x7d0(%rsp)
  1059fe:	00 
  1059ff:	f3 0f 10 05 7d 25 0f 	movss  0xf257d(%rip),%xmm0        # 1f7f84 <cuda::std::__4::in_place+0x37>
  105a06:	00 
  105a07:	f3 0f 5e c5          	divss  %xmm5,%xmm0
  105a0b:	f3 0f 59 c3          	mulss  %xmm3,%xmm0
  105a0f:	f3 0f 11 44 24 60    	movss  %xmm0,0x60(%rsp)
  105a15:	f3 0f 59 54 24 60    	mulss  0x60(%rsp),%xmm2
  105a1b:	4c 89 ed             	mov    %r13,%rbp
  105a1e:	f3 0f 11 54 24 58    	movss  %xmm2,0x58(%rsp)
  105a24:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  105a29:	f3 0f 10 74 24 58    	movss  0x58(%rsp),%xmm6
  105a2f:	f3 0f 59 34 a8       	mulss  (%rax,%rbp,4),%xmm6
  105a34:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  105a39:	f3 0f 11 34 24       	movss  %xmm6,(%rsp)
  105a3e:	41 39 ed             	cmp    %ebp,%r13d
  105a41:	0f 84 59 5c 00 00    	je     10b6a0 <synreal::SolverNewton::precompute_matrices()+0x7330>
  105a47:	8b 0c a8             	mov    (%rax,%rbp,4),%ecx
  105a4a:	42 8b 04 a8          	mov    (%rax,%r13,4),%eax
  105a4e:	4c 89 e2             	mov    %r12,%rdx
  105a51:	48 89 de             	mov    %rbx,%rsi
  105a54:	89 c7                	mov    %eax,%edi
  105a56:	89 4c 24 38          	mov    %ecx,0x38(%rsp)
  105a5a:	89 8c 24 18 03 00 00 	mov    %ecx,0x318(%rsp)
  105a61:	89 44 24 48          	mov    %eax,0x48(%rsp)
  105a65:	e8 36 58 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  105a6a:	8b bc 24 18 03 00 00 	mov    0x318(%rsp),%edi
  105a71:	4c 89 e2             	mov    %r12,%rdx
  105a74:	48 89 de             	mov    %rbx,%rsi
  105a77:	e8 24 58 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  105a7c:	48 63 44 24 48       	movslq 0x48(%rsp),%rax
  105a81:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
  105a86:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  105a8a:	48 c1 e0 04          	shl    $0x4,%rax
  105a8e:	4c 8d 0c 01          	lea    (%rcx,%rax,1),%r9
  105a92:	49 8b 41 10          	mov    0x10(%r9),%rax
  105a96:	4d 8d 41 08          	lea    0x8(%r9),%r8
  105a9a:	48 85 c0             	test   %rax,%rax
  105a9d:	0f 84 4a 6a 00 00    	je     10c4ed <synreal::SolverNewton::precompute_matrices()+0x817d>
  105aa3:	8b bc 24 18 03 00 00 	mov    0x318(%rsp),%edi
  105aaa:	4c 89 c6             	mov    %r8,%rsi
  105aad:	eb 12                	jmp    105ac1 <synreal::SolverNewton::precompute_matrices()+0x1751>
  105aaf:	48 85 c9             	test   %rcx,%rcx
  105ab2:	0f 84 11 5c 00 00    	je     10b6c9 <synreal::SolverNewton::precompute_matrices()+0x7359>
  105ab8:	48 89 ca             	mov    %rcx,%rdx
  105abb:	48 89 c6             	mov    %rax,%rsi
  105abe:	48 89 d0             	mov    %rdx,%rax
  105ac1:	48 8b 48 10          	mov    0x10(%rax),%rcx
  105ac5:	48 8b 50 18          	mov    0x18(%rax),%rdx
  105ac9:	3b 78 20             	cmp    0x20(%rax),%edi
  105acc:	7e e1                	jle    105aaf <synreal::SolverNewton::precompute_matrices()+0x173f>
  105ace:	48 85 d2             	test   %rdx,%rdx
  105ad1:	75 eb                	jne    105abe <synreal::SolverNewton::precompute_matrices()+0x174e>
  105ad3:	49 39 f0             	cmp    %rsi,%r8
  105ad6:	74 05                	je     105add <synreal::SolverNewton::precompute_matrices()+0x176d>
  105ad8:	3b 7e 20             	cmp    0x20(%rsi),%edi
  105adb:	7d 23                	jge    105b00 <synreal::SolverNewton::precompute_matrices()+0x1790>
  105add:	48 8d 84 24 18 03 00 	lea    0x318(%rsp),%rax
  105ae4:	00 
  105ae5:	48 8d 94 24 20 06 00 	lea    0x620(%rsp),%rdx
  105aec:	00 
  105aed:	4c 89 cf             	mov    %r9,%rdi
  105af0:	48 89 84 24 20 06 00 	mov    %rax,0x620(%rsp)
  105af7:	00 
  105af8:	e8 83 af fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  105afd:	48 89 c6             	mov    %rax,%rsi
  105b00:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  105b05:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  105b0a:	4c 89 e2             	mov    %r12,%rdx
  105b0d:	8b 44 24 48          	mov    0x48(%rsp),%eax
  105b11:	8b 7c 24 38          	mov    0x38(%rsp),%edi
  105b15:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  105b1a:	48 89 de             	mov    %rbx,%rsi
  105b1d:	89 84 24 1c 03 00 00 	mov    %eax,0x31c(%rsp)
  105b24:	e8 77 57 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  105b29:	8b bc 24 1c 03 00 00 	mov    0x31c(%rsp),%edi
  105b30:	4c 89 e2             	mov    %r12,%rdx
  105b33:	48 89 de             	mov    %rbx,%rsi
  105b36:	e8 65 57 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  105b3b:	48 63 44 24 38       	movslq 0x38(%rsp),%rax
  105b40:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  105b45:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  105b49:	48 c1 e0 04          	shl    $0x4,%rax
  105b4d:	4c 8d 0c 07          	lea    (%rdi,%rax,1),%r9
  105b51:	49 8b 41 10          	mov    0x10(%r9),%rax
  105b55:	4d 8d 41 08          	lea    0x8(%r9),%r8
  105b59:	48 85 c0             	test   %rax,%rax
  105b5c:	0f 84 93 69 00 00    	je     10c4f5 <synreal::SolverNewton::precompute_matrices()+0x8185>
  105b62:	8b bc 24 1c 03 00 00 	mov    0x31c(%rsp),%edi
  105b69:	4c 89 c6             	mov    %r8,%rsi
  105b6c:	eb 12                	jmp    105b80 <synreal::SolverNewton::precompute_matrices()+0x1810>
  105b6e:	48 85 c9             	test   %rcx,%rcx
  105b71:	0f 84 5a 5b 00 00    	je     10b6d1 <synreal::SolverNewton::precompute_matrices()+0x7361>
  105b77:	48 89 ca             	mov    %rcx,%rdx
  105b7a:	48 89 c6             	mov    %rax,%rsi
  105b7d:	48 89 d0             	mov    %rdx,%rax
  105b80:	48 8b 48 10          	mov    0x10(%rax),%rcx
  105b84:	48 8b 50 18          	mov    0x18(%rax),%rdx
  105b88:	3b 78 20             	cmp    0x20(%rax),%edi
  105b8b:	7e e1                	jle    105b6e <synreal::SolverNewton::precompute_matrices()+0x17fe>
  105b8d:	48 85 d2             	test   %rdx,%rdx
  105b90:	75 eb                	jne    105b7d <synreal::SolverNewton::precompute_matrices()+0x180d>
  105b92:	49 39 f0             	cmp    %rsi,%r8
  105b95:	74 05                	je     105b9c <synreal::SolverNewton::precompute_matrices()+0x182c>
  105b97:	3b 7e 20             	cmp    0x20(%rsi),%edi
  105b9a:	7d 20                	jge    105bbc <synreal::SolverNewton::precompute_matrices()+0x184c>
  105b9c:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  105ba1:	48 8d 94 24 40 06 00 	lea    0x640(%rsp),%rdx
  105ba8:	00 
  105ba9:	4c 89 cf             	mov    %r9,%rdi
  105bac:	48 89 84 24 40 06 00 	mov    %rax,0x640(%rsp)
  105bb3:	00 
  105bb4:	e8 c7 ae fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  105bb9:	48 89 c6             	mov    %rax,%rsi
  105bbc:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  105bc1:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  105bc6:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  105bcb:	48 83 c5 01          	add    $0x1,%rbp
  105bcf:	83 fd 04             	cmp    $0x4,%ebp
  105bd2:	0f 85 4c fe ff ff    	jne    105a24 <synreal::SolverNewton::precompute_matrices()+0x16b4>
  105bd8:	49 83 c5 01          	add    $0x1,%r13
  105bdc:	49 83 fd 04          	cmp    $0x4,%r13
  105be0:	0f 84 d3 fb ff ff    	je     1057b9 <synreal::SolverNewton::precompute_matrices()+0x1449>
  105be6:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  105beb:	f3 42 0f 10 14 a8    	movss  (%rax,%r13,4),%xmm2
  105bf1:	e9 1f fe ff ff       	jmp    105a15 <synreal::SolverNewton::precompute_matrices()+0x16a5>
  105bf6:	48 8b bc 24 80 07 00 	mov    0x780(%rsp),%rdi
  105bfd:	00 
  105bfe:	48 85 ff             	test   %rdi,%rdi
  105c01:	74 10                	je     105c13 <synreal::SolverNewton::precompute_matrices()+0x18a3>
  105c03:	48 8b b4 24 90 07 00 	mov    0x790(%rsp),%rsi
  105c0a:	00 
  105c0b:	48 29 fe             	sub    %rdi,%rsi
  105c0e:	e8 9d 75 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  105c13:	48 8b bc 24 60 07 00 	mov    0x760(%rsp),%rdi
  105c1a:	00 
  105c1b:	48 85 ff             	test   %rdi,%rdi
  105c1e:	74 10                	je     105c30 <synreal::SolverNewton::precompute_matrices()+0x18c0>
  105c20:	48 8b b4 24 70 07 00 	mov    0x770(%rsp),%rsi
  105c27:	00 
  105c28:	48 29 fe             	sub    %rdi,%rsi
  105c2b:	e8 80 75 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  105c30:	48 8b bc 24 40 07 00 	mov    0x740(%rsp),%rdi
  105c37:	00 
  105c38:	48 85 ff             	test   %rdi,%rdi
  105c3b:	74 10                	je     105c4d <synreal::SolverNewton::precompute_matrices()+0x18dd>
  105c3d:	48 8b b4 24 50 07 00 	mov    0x750(%rsp),%rsi
  105c44:	00 
  105c45:	48 29 fe             	sub    %rdi,%rsi
  105c48:	e8 63 75 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  105c4d:	48 8b bc 24 20 07 00 	mov    0x720(%rsp),%rdi
  105c54:	00 
  105c55:	48 85 ff             	test   %rdi,%rdi
  105c58:	74 10                	je     105c6a <synreal::SolverNewton::precompute_matrices()+0x18fa>
  105c5a:	48 8b b4 24 30 07 00 	mov    0x730(%rsp),%rsi
  105c61:	00 
  105c62:	48 29 fe             	sub    %rdi,%rsi
  105c65:	e8 46 75 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  105c6a:	48 8d 2c 5b          	lea    (%rbx,%rbx,2),%rbp
  105c6e:	48 c1 e5 04          	shl    $0x4,%rbp
  105c72:	48 85 db             	test   %rbx,%rbx
  105c75:	0f 84 5e 2e 00 00    	je     108ad9 <synreal::SolverNewton::precompute_matrices()+0x4769>
  105c7b:	48 89 ef             	mov    %rbp,%rdi
  105c7e:	e8 cd 74 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  105c83:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  105c8a:	00 
  105c8b:	48 01 c5             	add    %rax,%rbp
  105c8e:	48 8d 50 08          	lea    0x8(%rax),%rdx
  105c92:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  105c99:	48 83 c0 30          	add    $0x30,%rax
  105c9d:	48 c7 40 e0 00 00 00 	movq   $0x0,-0x20(%rax)
  105ca4:	00 
  105ca5:	48 89 50 e8          	mov    %rdx,-0x18(%rax)
  105ca9:	48 89 50 f0          	mov    %rdx,-0x10(%rax)
  105cad:	48 c7 40 f8 00 00 00 	movq   $0x0,-0x8(%rax)
  105cb4:	00 
  105cb5:	48 39 c5             	cmp    %rax,%rbp
  105cb8:	75 d4                	jne    105c8e <synreal::SolverNewton::precompute_matrices()+0x191e>
  105cba:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
  105cbf:	48 89 84 24 00 01 00 	mov    %rax,0x100(%rsp)
  105cc6:	00 
  105cc7:	4c 89 ff             	mov    %r15,%rdi
  105cca:	e8 81 74 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  105ccf:	48 89 c1             	mov    %rax,%rcx
  105cd2:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  105cd9:	00 
  105cda:	4c 01 f9             	add    %r15,%rcx
  105cdd:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
  105ce2:	48 89 8c 24 a8 01 00 	mov    %rcx,0x1a8(%rsp)
  105ce9:	00 
  105cea:	48 39 c1             	cmp    %rax,%rcx
  105ced:	74 0f                	je     105cfe <synreal::SolverNewton::precompute_matrices()+0x198e>
  105cef:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
  105cf4:	48 89 c7             	mov    %rax,%rdi
  105cf7:	31 f6                	xor    %esi,%esi
  105cf9:	e8 22 64 f6 ff       	call   6c120 <memset@plt>
  105cfe:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  105d03:	48 8b 8c 24 a0 00 00 	mov    0xa0(%rsp),%rcx
  105d0a:	00 
  105d0b:	48 c7 44 24 78 00 00 	movq   $0x0,0x78(%rsp)
  105d12:	00 00 
  105d14:	48 83 c0 08          	add    $0x8,%rax
  105d18:	49 89 cd             	mov    %rcx,%r13
  105d1b:	48 8d 69 08          	lea    0x8(%rcx),%rbp
  105d1f:	48 89 04 24          	mov    %rax,(%rsp)
  105d23:	48 8b 84 24 a8 00 00 	mov    0xa8(%rsp),%rax
  105d2a:	00 
  105d2b:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  105d30:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  105d35:	48 c7 44 24 10 08 00 	movq   $0x8,0x10(%rsp)
  105d3c:	00 00 
  105d3e:	48 83 c0 08          	add    $0x8,%rax
  105d42:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  105d47:	48 8d 84 24 60 06 00 	lea    0x660(%rsp),%rax
  105d4e:	00 
  105d4f:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  105d54:	48 8b 04 24          	mov    (%rsp),%rax
  105d58:	4c 8b 60 10          	mov    0x10(%rax),%r12
  105d5c:	49 39 c4             	cmp    %rax,%r12
  105d5f:	0f 84 88 00 00 00    	je     105ded <synreal::SolverNewton::precompute_matrices()+0x1a7d>
  105d65:	0f 1f 00             	nopl   (%rax)
  105d68:	48 8b 55 08          	mov    0x8(%rbp),%rdx
  105d6c:	48 85 d2             	test   %rdx,%rdx
  105d6f:	0f 84 1b 15 00 00    	je     107290 <synreal::SolverNewton::precompute_matrices()+0x2f20>
  105d75:	41 8b 44 24 20       	mov    0x20(%r12),%eax
  105d7a:	48 89 ee             	mov    %rbp,%rsi
  105d7d:	eb 0f                	jmp    105d8e <synreal::SolverNewton::precompute_matrices()+0x1a1e>
  105d7f:	90                   	nop
  105d80:	48 89 d6             	mov    %rdx,%rsi
  105d83:	48 85 ff             	test   %rdi,%rdi
  105d86:	74 18                	je     105da0 <synreal::SolverNewton::precompute_matrices()+0x1a30>
  105d88:	48 89 f9             	mov    %rdi,%rcx
  105d8b:	48 89 ca             	mov    %rcx,%rdx
  105d8e:	48 8b 7a 10          	mov    0x10(%rdx),%rdi
  105d92:	48 8b 4a 18          	mov    0x18(%rdx),%rcx
  105d96:	3b 42 20             	cmp    0x20(%rdx),%eax
  105d99:	7e e5                	jle    105d80 <synreal::SolverNewton::precompute_matrices()+0x1a10>
  105d9b:	48 85 c9             	test   %rcx,%rcx
  105d9e:	75 eb                	jne    105d8b <synreal::SolverNewton::precompute_matrices()+0x1a1b>
  105da0:	48 39 ee             	cmp    %rbp,%rsi
  105da3:	74 05                	je     105daa <synreal::SolverNewton::precompute_matrices()+0x1a3a>
  105da5:	3b 46 20             	cmp    0x20(%rsi),%eax
  105da8:	7d 1d                	jge    105dc7 <synreal::SolverNewton::precompute_matrices()+0x1a57>
  105daa:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
  105daf:	49 8d 44 24 20       	lea    0x20(%r12),%rax
  105db4:	4c 89 ef             	mov    %r13,%rdi
  105db7:	48 89 84 24 60 06 00 	mov    %rax,0x660(%rsp)
  105dbe:	00 
  105dbf:	e8 fc a9 fe ff       	call   f07c0 <std::_Rb_tree_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > std::_Rb_tree<int, std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues>, std::_Select1st<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::less<int>, std::allocator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .constprop.0]>
  105dc4:	48 89 c6             	mov    %rax,%rsi
  105dc7:	f3 0f 10 46 24       	movss  0x24(%rsi),%xmm0
  105dcc:	f3 41 0f 58 44 24 24 	addss  0x24(%r12),%xmm0
  105dd3:	4c 89 e7             	mov    %r12,%rdi
  105dd6:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  105ddb:	e8 90 68 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  105de0:	49 89 c4             	mov    %rax,%r12
  105de3:	48 3b 04 24          	cmp    (%rsp),%rax
  105de7:	0f 85 7b ff ff ff    	jne    105d68 <synreal::SolverNewton::precompute_matrices()+0x19f8>
  105ded:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  105df4:	00 
  105df5:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  105dfa:	4c 8d bc 24 80 06 00 	lea    0x680(%rsp),%r15
  105e01:	00 
  105e02:	4c 8b 64 08 10       	mov    0x10(%rax,%rcx,1),%r12
  105e07:	48 01 c8             	add    %rcx,%rax
  105e0a:	49 89 c6             	mov    %rax,%r14
  105e0d:	49 39 c4             	cmp    %rax,%r12
  105e10:	0f 84 94 00 00 00    	je     105eaa <synreal::SolverNewton::precompute_matrices()+0x1b3a>
  105e16:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  105e1d:	00 00 00 
  105e20:	48 8b 55 08          	mov    0x8(%rbp),%rdx
  105e24:	48 85 d2             	test   %rdx,%rdx
  105e27:	0f 84 6b 14 00 00    	je     107298 <synreal::SolverNewton::precompute_matrices()+0x2f28>
  105e2d:	41 8b 44 24 20       	mov    0x20(%r12),%eax
  105e32:	48 89 ee             	mov    %rbp,%rsi
  105e35:	eb 17                	jmp    105e4e <synreal::SolverNewton::precompute_matrices()+0x1ade>
  105e37:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  105e3e:	00 00 
  105e40:	48 89 d6             	mov    %rdx,%rsi
  105e43:	48 85 ff             	test   %rdi,%rdi
  105e46:	74 18                	je     105e60 <synreal::SolverNewton::precompute_matrices()+0x1af0>
  105e48:	48 89 f9             	mov    %rdi,%rcx
  105e4b:	48 89 ca             	mov    %rcx,%rdx
  105e4e:	48 8b 7a 10          	mov    0x10(%rdx),%rdi
  105e52:	48 8b 4a 18          	mov    0x18(%rdx),%rcx
  105e56:	3b 42 20             	cmp    0x20(%rdx),%eax
  105e59:	7e e5                	jle    105e40 <synreal::SolverNewton::precompute_matrices()+0x1ad0>
  105e5b:	48 85 c9             	test   %rcx,%rcx
  105e5e:	75 eb                	jne    105e4b <synreal::SolverNewton::precompute_matrices()+0x1adb>
  105e60:	48 39 ee             	cmp    %rbp,%rsi
  105e63:	74 05                	je     105e6a <synreal::SolverNewton::precompute_matrices()+0x1afa>
  105e65:	3b 46 20             	cmp    0x20(%rsi),%eax
  105e68:	7d 1b                	jge    105e85 <synreal::SolverNewton::precompute_matrices()+0x1b15>
  105e6a:	49 8d 44 24 20       	lea    0x20(%r12),%rax
  105e6f:	4c 89 fa             	mov    %r15,%rdx
  105e72:	4c 89 ef             	mov    %r13,%rdi
  105e75:	48 89 84 24 80 06 00 	mov    %rax,0x680(%rsp)
  105e7c:	00 
  105e7d:	e8 3e a9 fe ff       	call   f07c0 <std::_Rb_tree_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > std::_Rb_tree<int, std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues>, std::_Select1st<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::less<int>, std::allocator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .constprop.0]>
  105e82:	48 89 c6             	mov    %rax,%rsi
  105e85:	f3 0f 10 46 28       	movss  0x28(%rsi),%xmm0
  105e8a:	f3 41 0f 58 44 24 24 	addss  0x24(%r12),%xmm0
  105e91:	4c 89 e7             	mov    %r12,%rdi
  105e94:	f3 0f 11 46 28       	movss  %xmm0,0x28(%rsi)
  105e99:	e8 d2 67 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  105e9e:	49 89 c4             	mov    %rax,%r12
  105ea1:	4c 39 f0             	cmp    %r14,%rax
  105ea4:	0f 85 76 ff ff ff    	jne    105e20 <synreal::SolverNewton::precompute_matrices()+0x1ab0>
  105eaa:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  105eaf:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  105eb4:	4c 8d bc 24 a0 06 00 	lea    0x6a0(%rsp),%r15
  105ebb:	00 
  105ebc:	4c 8b 64 08 10       	mov    0x10(%rax,%rcx,1),%r12
  105ec1:	48 01 c8             	add    %rcx,%rax
  105ec4:	49 89 c6             	mov    %rax,%r14
  105ec7:	49 39 c4             	cmp    %rax,%r12
  105eca:	0f 84 8e 00 00 00    	je     105f5e <synreal::SolverNewton::precompute_matrices()+0x1bee>
  105ed0:	48 8b 55 08          	mov    0x8(%rbp),%rdx
  105ed4:	48 85 d2             	test   %rdx,%rdx
  105ed7:	0f 84 93 13 00 00    	je     107270 <synreal::SolverNewton::precompute_matrices()+0x2f00>
  105edd:	41 8b 44 24 20       	mov    0x20(%r12),%eax
  105ee2:	48 89 ee             	mov    %rbp,%rsi
  105ee5:	eb 1b                	jmp    105f02 <synreal::SolverNewton::precompute_matrices()+0x1b92>
  105ee7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  105eee:	00 00 
  105ef0:	48 85 ff             	test   %rdi,%rdi
  105ef3:	0f 84 67 13 00 00    	je     107260 <synreal::SolverNewton::precompute_matrices()+0x2ef0>
  105ef9:	48 89 f9             	mov    %rdi,%rcx
  105efc:	48 89 d6             	mov    %rdx,%rsi
  105eff:	48 89 ca             	mov    %rcx,%rdx
  105f02:	48 8b 7a 10          	mov    0x10(%rdx),%rdi
  105f06:	48 8b 4a 18          	mov    0x18(%rdx),%rcx
  105f0a:	3b 42 20             	cmp    0x20(%rdx),%eax
  105f0d:	7e e1                	jle    105ef0 <synreal::SolverNewton::precompute_matrices()+0x1b80>
  105f0f:	48 85 c9             	test   %rcx,%rcx
  105f12:	75 eb                	jne    105eff <synreal::SolverNewton::precompute_matrices()+0x1b8f>
  105f14:	48 39 ee             	cmp    %rbp,%rsi
  105f17:	74 05                	je     105f1e <synreal::SolverNewton::precompute_matrices()+0x1bae>
  105f19:	3b 46 20             	cmp    0x20(%rsi),%eax
  105f1c:	7d 1b                	jge    105f39 <synreal::SolverNewton::precompute_matrices()+0x1bc9>
  105f1e:	49 8d 44 24 20       	lea    0x20(%r12),%rax
  105f23:	4c 89 fa             	mov    %r15,%rdx
  105f26:	4c 89 ef             	mov    %r13,%rdi
  105f29:	48 89 84 24 a0 06 00 	mov    %rax,0x6a0(%rsp)
  105f30:	00 
  105f31:	e8 8a a8 fe ff       	call   f07c0 <std::_Rb_tree_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > std::_Rb_tree<int, std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues>, std::_Select1st<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::less<int>, std::allocator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .constprop.0]>
  105f36:	48 89 c6             	mov    %rax,%rsi
  105f39:	f3 0f 10 46 2c       	movss  0x2c(%rsi),%xmm0
  105f3e:	f3 41 0f 58 44 24 24 	addss  0x24(%r12),%xmm0
  105f45:	4c 89 e7             	mov    %r12,%rdi
  105f48:	f3 0f 11 46 2c       	movss  %xmm0,0x2c(%rsi)
  105f4d:	e8 1e 67 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  105f52:	49 89 c4             	mov    %rax,%r12
  105f55:	4c 39 f0             	cmp    %r14,%rax
  105f58:	0f 85 72 ff ff ff    	jne    105ed0 <synreal::SolverNewton::precompute_matrices()+0x1b60>
  105f5e:	48 8b 84 24 c8 00 00 	mov    0xc8(%rsp),%rax
  105f65:	00 
  105f66:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  105f6b:	4c 8d bc 24 c0 06 00 	lea    0x6c0(%rsp),%r15
  105f72:	00 
  105f73:	4c 8b 64 30 10       	mov    0x10(%rax,%rsi,1),%r12
  105f78:	48 01 f0             	add    %rsi,%rax
  105f7b:	49 89 c6             	mov    %rax,%r14
  105f7e:	49 39 c4             	cmp    %rax,%r12
  105f81:	0f 84 97 00 00 00    	je     10601e <synreal::SolverNewton::precompute_matrices()+0x1cae>
  105f87:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  105f8e:	00 00 
  105f90:	48 8b 55 08          	mov    0x8(%rbp),%rdx
  105f94:	48 85 d2             	test   %rdx,%rdx
  105f97:	0f 84 cb 12 00 00    	je     107268 <synreal::SolverNewton::precompute_matrices()+0x2ef8>
  105f9d:	41 8b 44 24 20       	mov    0x20(%r12),%eax
  105fa2:	48 89 ee             	mov    %rbp,%rsi
  105fa5:	eb 1b                	jmp    105fc2 <synreal::SolverNewton::precompute_matrices()+0x1c52>
  105fa7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  105fae:	00 00 
  105fb0:	48 85 ff             	test   %rdi,%rdi
  105fb3:	0f 84 87 12 00 00    	je     107240 <synreal::SolverNewton::precompute_matrices()+0x2ed0>
  105fb9:	48 89 f9             	mov    %rdi,%rcx
  105fbc:	48 89 d6             	mov    %rdx,%rsi
  105fbf:	48 89 ca             	mov    %rcx,%rdx
  105fc2:	48 8b 7a 10          	mov    0x10(%rdx),%rdi
  105fc6:	48 8b 4a 18          	mov    0x18(%rdx),%rcx
  105fca:	3b 42 20             	cmp    0x20(%rdx),%eax
  105fcd:	7e e1                	jle    105fb0 <synreal::SolverNewton::precompute_matrices()+0x1c40>
  105fcf:	48 85 c9             	test   %rcx,%rcx
  105fd2:	75 eb                	jne    105fbf <synreal::SolverNewton::precompute_matrices()+0x1c4f>
  105fd4:	48 39 ee             	cmp    %rbp,%rsi
  105fd7:	74 05                	je     105fde <synreal::SolverNewton::precompute_matrices()+0x1c6e>
  105fd9:	3b 46 20             	cmp    0x20(%rsi),%eax
  105fdc:	7d 1b                	jge    105ff9 <synreal::SolverNewton::precompute_matrices()+0x1c89>
  105fde:	49 8d 44 24 20       	lea    0x20(%r12),%rax
  105fe3:	4c 89 fa             	mov    %r15,%rdx
  105fe6:	4c 89 ef             	mov    %r13,%rdi
  105fe9:	48 89 84 24 c0 06 00 	mov    %rax,0x6c0(%rsp)
  105ff0:	00 
  105ff1:	e8 ca a7 fe ff       	call   f07c0 <std::_Rb_tree_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > std::_Rb_tree<int, std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues>, std::_Select1st<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::less<int>, std::allocator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .constprop.0]>
  105ff6:	48 89 c6             	mov    %rax,%rsi
  105ff9:	f3 0f 10 46 30       	movss  0x30(%rsi),%xmm0
  105ffe:	f3 41 0f 58 44 24 24 	addss  0x24(%r12),%xmm0
  106005:	4c 89 e7             	mov    %r12,%rdi
  106008:	f3 0f 11 46 30       	movss  %xmm0,0x30(%rsi)
  10600d:	e8 5e 66 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  106012:	49 89 c4             	mov    %rax,%r12
  106015:	4c 39 f0             	cmp    %r14,%rax
  106018:	0f 85 72 ff ff ff    	jne    105f90 <synreal::SolverNewton::precompute_matrices()+0x1c20>
  10601e:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
  106023:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  106028:	4c 8d bc 24 e0 06 00 	lea    0x6e0(%rsp),%r15
  10602f:	00 
  106030:	4c 8b 64 38 10       	mov    0x10(%rax,%rdi,1),%r12
  106035:	48 01 f8             	add    %rdi,%rax
  106038:	49 89 c6             	mov    %rax,%r14
  10603b:	49 39 c4             	cmp    %rax,%r12
  10603e:	0f 84 8a 00 00 00    	je     1060ce <synreal::SolverNewton::precompute_matrices()+0x1d5e>
  106044:	0f 1f 40 00          	nopl   0x0(%rax)
  106048:	48 8b 55 08          	mov    0x8(%rbp),%rdx
  10604c:	48 85 d2             	test   %rdx,%rdx
  10604f:	0f 84 33 12 00 00    	je     107288 <synreal::SolverNewton::precompute_matrices()+0x2f18>
  106055:	41 8b 44 24 20       	mov    0x20(%r12),%eax
  10605a:	48 89 ee             	mov    %rbp,%rsi
  10605d:	eb 13                	jmp    106072 <synreal::SolverNewton::precompute_matrices()+0x1d02>
  10605f:	90                   	nop
  106060:	48 85 ff             	test   %rdi,%rdi
  106063:	0f 84 e7 11 00 00    	je     107250 <synreal::SolverNewton::precompute_matrices()+0x2ee0>
  106069:	48 89 f9             	mov    %rdi,%rcx
  10606c:	48 89 d6             	mov    %rdx,%rsi
  10606f:	48 89 ca             	mov    %rcx,%rdx
  106072:	48 8b 7a 10          	mov    0x10(%rdx),%rdi
  106076:	48 8b 4a 18          	mov    0x18(%rdx),%rcx
  10607a:	3b 42 20             	cmp    0x20(%rdx),%eax
  10607d:	7e e1                	jle    106060 <synreal::SolverNewton::precompute_matrices()+0x1cf0>
  10607f:	48 85 c9             	test   %rcx,%rcx
  106082:	75 eb                	jne    10606f <synreal::SolverNewton::precompute_matrices()+0x1cff>
  106084:	48 39 ee             	cmp    %rbp,%rsi
  106087:	74 05                	je     10608e <synreal::SolverNewton::precompute_matrices()+0x1d1e>
  106089:	3b 46 20             	cmp    0x20(%rsi),%eax
  10608c:	7d 1b                	jge    1060a9 <synreal::SolverNewton::precompute_matrices()+0x1d39>
  10608e:	49 8d 44 24 20       	lea    0x20(%r12),%rax
  106093:	4c 89 fa             	mov    %r15,%rdx
  106096:	4c 89 ef             	mov    %r13,%rdi
  106099:	48 89 84 24 e0 06 00 	mov    %rax,0x6e0(%rsp)
  1060a0:	00 
  1060a1:	e8 1a a7 fe ff       	call   f07c0 <std::_Rb_tree_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > std::_Rb_tree<int, std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues>, std::_Select1st<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::less<int>, std::allocator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .constprop.0]>
  1060a6:	48 89 c6             	mov    %rax,%rsi
  1060a9:	f3 0f 10 46 34       	movss  0x34(%rsi),%xmm0
  1060ae:	f3 41 0f 58 44 24 24 	addss  0x24(%r12),%xmm0
  1060b5:	4c 89 e7             	mov    %r12,%rdi
  1060b8:	f3 0f 11 46 34       	movss  %xmm0,0x34(%rsi)
  1060bd:	e8 ae 65 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  1060c2:	49 89 c4             	mov    %rax,%r12
  1060c5:	4c 39 f0             	cmp    %r14,%rax
  1060c8:	0f 85 7a ff ff ff    	jne    106048 <synreal::SolverNewton::precompute_matrices()+0x1cd8>
  1060ce:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  1060d3:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  1060d8:	4c 8d bc 24 00 07 00 	lea    0x700(%rsp),%r15
  1060df:	00 
  1060e0:	4c 8b 64 08 10       	mov    0x10(%rax,%rcx,1),%r12
  1060e5:	48 01 c8             	add    %rcx,%rax
  1060e8:	49 89 c6             	mov    %rax,%r14
  1060eb:	4c 39 e0             	cmp    %r12,%rax
  1060ee:	0f 84 8a 00 00 00    	je     10617e <synreal::SolverNewton::precompute_matrices()+0x1e0e>
  1060f4:	0f 1f 40 00          	nopl   0x0(%rax)
  1060f8:	48 8b 55 08          	mov    0x8(%rbp),%rdx
  1060fc:	48 85 d2             	test   %rdx,%rdx
  1060ff:	0f 84 7b 11 00 00    	je     107280 <synreal::SolverNewton::precompute_matrices()+0x2f10>
  106105:	41 8b 44 24 20       	mov    0x20(%r12),%eax
  10610a:	48 89 ee             	mov    %rbp,%rsi
  10610d:	eb 13                	jmp    106122 <synreal::SolverNewton::precompute_matrices()+0x1db2>
  10610f:	90                   	nop
  106110:	48 85 ff             	test   %rdi,%rdi
  106113:	0f 84 17 11 00 00    	je     107230 <synreal::SolverNewton::precompute_matrices()+0x2ec0>
  106119:	48 89 f9             	mov    %rdi,%rcx
  10611c:	48 89 d6             	mov    %rdx,%rsi
  10611f:	48 89 ca             	mov    %rcx,%rdx
  106122:	48 8b 7a 10          	mov    0x10(%rdx),%rdi
  106126:	48 8b 4a 18          	mov    0x18(%rdx),%rcx
  10612a:	3b 42 20             	cmp    0x20(%rdx),%eax
  10612d:	7e e1                	jle    106110 <synreal::SolverNewton::precompute_matrices()+0x1da0>
  10612f:	48 85 c9             	test   %rcx,%rcx
  106132:	75 eb                	jne    10611f <synreal::SolverNewton::precompute_matrices()+0x1daf>
  106134:	48 39 ee             	cmp    %rbp,%rsi
  106137:	74 05                	je     10613e <synreal::SolverNewton::precompute_matrices()+0x1dce>
  106139:	3b 46 20             	cmp    0x20(%rsi),%eax
  10613c:	7d 1b                	jge    106159 <synreal::SolverNewton::precompute_matrices()+0x1de9>
  10613e:	49 8d 44 24 20       	lea    0x20(%r12),%rax
  106143:	4c 89 fa             	mov    %r15,%rdx
  106146:	4c 89 ef             	mov    %r13,%rdi
  106149:	48 89 84 24 00 07 00 	mov    %rax,0x700(%rsp)
  106150:	00 
  106151:	e8 6a a6 fe ff       	call   f07c0 <std::_Rb_tree_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > std::_Rb_tree<int, std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues>, std::_Select1st<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::less<int>, std::allocator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .constprop.0]>
  106156:	48 89 c6             	mov    %rax,%rsi
  106159:	f3 0f 10 46 38       	movss  0x38(%rsi),%xmm0
  10615e:	f3 41 0f 58 44 24 24 	addss  0x24(%r12),%xmm0
  106165:	4c 89 e7             	mov    %r12,%rdi
  106168:	f3 0f 11 46 38       	movss  %xmm0,0x38(%rsi)
  10616d:	e8 fe 64 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  106172:	49 89 c4             	mov    %rax,%r12
  106175:	49 39 c6             	cmp    %rax,%r14
  106178:	0f 85 7a ff ff ff    	jne    1060f8 <synreal::SolverNewton::precompute_matrices()+0x1d88>
  10617e:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  106183:	4c 8d b4 24 20 07 00 	lea    0x720(%rsp),%r14
  10618a:	00 
  10618b:	4c 8b 60 10          	mov    0x10(%rax),%r12
  10618f:	4c 39 e0             	cmp    %r12,%rax
  106192:	0f 84 98 00 00 00    	je     106230 <synreal::SolverNewton::precompute_matrices()+0x1ec0>
  106198:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10619f:	00 
  1061a0:	48 8b 55 08          	mov    0x8(%rbp),%rdx
  1061a4:	48 85 d2             	test   %rdx,%rdx
  1061a7:	0f 84 cb 10 00 00    	je     107278 <synreal::SolverNewton::precompute_matrices()+0x2f08>
  1061ad:	41 8b 44 24 20       	mov    0x20(%r12),%eax
  1061b2:	48 89 ee             	mov    %rbp,%rsi
  1061b5:	eb 1b                	jmp    1061d2 <synreal::SolverNewton::precompute_matrices()+0x1e62>
  1061b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  1061be:	00 00 
  1061c0:	48 85 ff             	test   %rdi,%rdi
  1061c3:	0f 84 57 10 00 00    	je     107220 <synreal::SolverNewton::precompute_matrices()+0x2eb0>
  1061c9:	48 89 f9             	mov    %rdi,%rcx
  1061cc:	48 89 d6             	mov    %rdx,%rsi
  1061cf:	48 89 ca             	mov    %rcx,%rdx
  1061d2:	48 8b 7a 10          	mov    0x10(%rdx),%rdi
  1061d6:	48 8b 4a 18          	mov    0x18(%rdx),%rcx
  1061da:	3b 42 20             	cmp    0x20(%rdx),%eax
  1061dd:	7e e1                	jle    1061c0 <synreal::SolverNewton::precompute_matrices()+0x1e50>
  1061df:	48 85 c9             	test   %rcx,%rcx
  1061e2:	75 eb                	jne    1061cf <synreal::SolverNewton::precompute_matrices()+0x1e5f>
  1061e4:	48 39 ee             	cmp    %rbp,%rsi
  1061e7:	74 05                	je     1061ee <synreal::SolverNewton::precompute_matrices()+0x1e7e>
  1061e9:	3b 46 20             	cmp    0x20(%rsi),%eax
  1061ec:	7d 1b                	jge    106209 <synreal::SolverNewton::precompute_matrices()+0x1e99>
  1061ee:	49 8d 44 24 20       	lea    0x20(%r12),%rax
  1061f3:	4c 89 f2             	mov    %r14,%rdx
  1061f6:	4c 89 ef             	mov    %r13,%rdi
  1061f9:	48 89 84 24 20 07 00 	mov    %rax,0x720(%rsp)
  106200:	00 
  106201:	e8 ba a5 fe ff       	call   f07c0 <std::_Rb_tree_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > std::_Rb_tree<int, std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues>, std::_Select1st<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::less<int>, std::allocator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .constprop.0]>
  106206:	48 89 c6             	mov    %rax,%rsi
  106209:	f3 0f 10 46 3c       	movss  0x3c(%rsi),%xmm0
  10620e:	f3 41 0f 58 44 24 24 	addss  0x24(%r12),%xmm0
  106215:	4c 89 e7             	mov    %r12,%rdi
  106218:	f3 0f 11 46 3c       	movss  %xmm0,0x3c(%rsi)
  10621d:	e8 4e 64 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  106222:	49 89 c4             	mov    %rax,%r12
  106225:	48 39 44 24 08       	cmp    %rax,0x8(%rsp)
  10622a:	0f 85 70 ff ff ff    	jne    1061a0 <synreal::SolverNewton::precompute_matrices()+0x1e30>
  106230:	48 8b 45 20          	mov    0x20(%rbp),%rax
  106234:	48 8b 74 24 78       	mov    0x78(%rsp),%rsi
  106239:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  10623e:	48 39 c6             	cmp    %rax,%rsi
  106241:	48 0f 42 f0          	cmovb  %rax,%rsi
  106245:	89 07                	mov    %eax,(%rdi)
  106247:	48 89 f8             	mov    %rdi,%rax
  10624a:	49 83 c5 30          	add    $0x30,%r13
  10624e:	48 83 c0 04          	add    $0x4,%rax
  106252:	48 83 04 24 30       	addq   $0x30,(%rsp)
  106257:	48 83 c5 30          	add    $0x30,%rbp
  10625b:	48 83 44 24 08 30    	addq   $0x30,0x8(%rsp)
  106261:	48 83 44 24 10 30    	addq   $0x30,0x10(%rsp)
  106267:	48 89 74 24 78       	mov    %rsi,0x78(%rsp)
  10626c:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  106271:	48 39 44 24 38       	cmp    %rax,0x38(%rsp)
  106276:	0f 85 d8 fa ff ff    	jne    105d54 <synreal::SolverNewton::precompute_matrices()+0x19e4>
  10627c:	48 89 f0             	mov    %rsi,%rax
  10627f:	48 0f af c3          	imul   %rbx,%rax
  106283:	48 89 c1             	mov    %rax,%rcx
  106286:	48 c1 e9 3c          	shr    $0x3c,%rcx
  10628a:	0f 85 db 63 00 00    	jne    10c66b <synreal::SolverNewton::precompute_matrices()+0x82fb>
  106290:	48 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%rbp
  106297:	00 
  106298:	48 85 c0             	test   %rax,%rax
  10629b:	0f 84 73 28 00 00    	je     108b14 <synreal::SolverNewton::precompute_matrices()+0x47a4>
  1062a1:	48 89 ef             	mov    %rbp,%rdi
  1062a4:	e8 a7 6e f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  1062a9:	48 8d 0c 28          	lea    (%rax,%rbp,1),%rcx
  1062ad:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
  1062b2:	48 89 8c 24 c0 00 00 	mov    %rcx,0xc0(%rsp)
  1062b9:	00 
  1062ba:	48 39 c1             	cmp    %rax,%rcx
  1062bd:	0f 84 9b 63 00 00    	je     10c65e <synreal::SolverNewton::precompute_matrices()+0x82ee>
  1062c3:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%rax)
  1062c9:	48 83 c0 08          	add    $0x8,%rax
  1062cd:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%rax)
  1062d4:	48 3b 84 24 c0 00 00 	cmp    0xc0(%rsp),%rax
  1062db:	00 
  1062dc:	75 e5                	jne    1062c3 <synreal::SolverNewton::precompute_matrices()+0x1f53>
  1062de:	48 8b 84 24 c0 00 00 	mov    0xc0(%rsp),%rax
  1062e5:	00 
  1062e6:	48 89 84 24 f0 01 00 	mov    %rax,0x1f0(%rsp)
  1062ed:	00 
  1062ee:	48 89 ef             	mov    %rbp,%rdi
  1062f1:	e8 5a 6e f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  1062f6:	48 8d 3c 28          	lea    (%rax,%rbp,1),%rdi
  1062fa:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
  1062ff:	48 89 bc 24 b8 00 00 	mov    %rdi,0xb8(%rsp)
  106306:	00 
  106307:	48 39 c7             	cmp    %rax,%rdi
  10630a:	0f 84 41 63 00 00    	je     10c651 <synreal::SolverNewton::precompute_matrices()+0x82e1>
  106310:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%rax)
  106316:	48 83 c0 08          	add    $0x8,%rax
  10631a:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%rax)
  106321:	48 3b 84 24 b8 00 00 	cmp    0xb8(%rsp),%rax
  106328:	00 
  106329:	75 e5                	jne    106310 <synreal::SolverNewton::precompute_matrices()+0x1fa0>
  10632b:	48 8b 84 24 b8 00 00 	mov    0xb8(%rsp),%rax
  106332:	00 
  106333:	48 89 84 24 80 01 00 	mov    %rax,0x180(%rsp)
  10633a:	00 
  10633b:	48 89 ef             	mov    %rbp,%rdi
  10633e:	e8 0d 6e f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  106343:	48 8d 0c 28          	lea    (%rax,%rbp,1),%rcx
  106347:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  10634c:	48 89 8c 24 c8 00 00 	mov    %rcx,0xc8(%rsp)
  106353:	00 
  106354:	48 39 c1             	cmp    %rax,%rcx
  106357:	0f 84 e7 62 00 00    	je     10c644 <synreal::SolverNewton::precompute_matrices()+0x82d4>
  10635d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%rax)
  106363:	48 83 c0 08          	add    $0x8,%rax
  106367:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%rax)
  10636e:	48 3b 84 24 c8 00 00 	cmp    0xc8(%rsp),%rax
  106375:	00 
  106376:	75 e5                	jne    10635d <synreal::SolverNewton::precompute_matrices()+0x1fed>
  106378:	48 8b 84 24 c8 00 00 	mov    0xc8(%rsp),%rax
  10637f:	00 
  106380:	48 89 84 24 88 01 00 	mov    %rax,0x188(%rsp)
  106387:	00 
  106388:	48 89 ef             	mov    %rbp,%rdi
  10638b:	e8 c0 6d f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  106390:	48 8d 0c 28          	lea    (%rax,%rbp,1),%rcx
  106394:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  106399:	48 89 8c 24 d8 00 00 	mov    %rcx,0xd8(%rsp)
  1063a0:	00 
  1063a1:	48 39 c1             	cmp    %rax,%rcx
  1063a4:	0f 84 8d 62 00 00    	je     10c637 <synreal::SolverNewton::precompute_matrices()+0x82c7>
  1063aa:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%rax)
  1063b0:	48 83 c0 08          	add    $0x8,%rax
  1063b4:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%rax)
  1063bb:	48 3b 84 24 d8 00 00 	cmp    0xd8(%rsp),%rax
  1063c2:	00 
  1063c3:	75 e5                	jne    1063aa <synreal::SolverNewton::precompute_matrices()+0x203a>
  1063c5:	48 8b 84 24 d8 00 00 	mov    0xd8(%rsp),%rax
  1063cc:	00 
  1063cd:	48 89 84 24 f8 01 00 	mov    %rax,0x1f8(%rsp)
  1063d4:	00 
  1063d5:	48 89 ef             	mov    %rbp,%rdi
  1063d8:	e8 73 6d f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  1063dd:	48 8d 0c 28          	lea    (%rax,%rbp,1),%rcx
  1063e1:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  1063e6:	48 89 8c 24 30 01 00 	mov    %rcx,0x130(%rsp)
  1063ed:	00 
  1063ee:	48 39 c1             	cmp    %rax,%rcx
  1063f1:	0f 84 33 62 00 00    	je     10c62a <synreal::SolverNewton::precompute_matrices()+0x82ba>
  1063f7:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%rax)
  1063fd:	48 83 c0 08          	add    $0x8,%rax
  106401:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%rax)
  106408:	48 3b 84 24 30 01 00 	cmp    0x130(%rsp),%rax
  10640f:	00 
  106410:	75 e5                	jne    1063f7 <synreal::SolverNewton::precompute_matrices()+0x2087>
  106412:	48 8b 84 24 30 01 00 	mov    0x130(%rsp),%rax
  106419:	00 
  10641a:	48 89 84 24 a0 01 00 	mov    %rax,0x1a0(%rsp)
  106421:	00 
  106422:	48 89 ef             	mov    %rbp,%rdi
  106425:	e8 26 6d f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  10642a:	48 8d 0c 28          	lea    (%rax,%rbp,1),%rcx
  10642e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  106433:	48 89 8c 24 f8 00 00 	mov    %rcx,0xf8(%rsp)
  10643a:	00 
  10643b:	48 39 c1             	cmp    %rax,%rcx
  10643e:	0f 84 d9 61 00 00    	je     10c61d <synreal::SolverNewton::precompute_matrices()+0x82ad>
  106444:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%rax)
  10644a:	48 83 c0 08          	add    $0x8,%rax
  10644e:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%rax)
  106455:	48 3b 84 24 f8 00 00 	cmp    0xf8(%rsp),%rax
  10645c:	00 
  10645d:	75 e5                	jne    106444 <synreal::SolverNewton::precompute_matrices()+0x20d4>
  10645f:	48 8b 84 24 f8 00 00 	mov    0xf8(%rsp),%rax
  106466:	00 
  106467:	48 89 84 24 e0 01 00 	mov    %rax,0x1e0(%rsp)
  10646e:	00 
  10646f:	48 89 ef             	mov    %rbp,%rdi
  106472:	e8 d9 6c f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  106477:	48 01 c5             	add    %rax,%rbp
  10647a:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  10647f:	48 89 ac 24 58 01 00 	mov    %rbp,0x158(%rsp)
  106486:	00 
  106487:	48 39 c5             	cmp    %rax,%rbp
  10648a:	0f 84 80 61 00 00    	je     10c610 <synreal::SolverNewton::precompute_matrices()+0x82a0>
  106490:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%rax)
  106496:	48 83 c0 08          	add    $0x8,%rax
  10649a:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%rax)
  1064a1:	48 3b 84 24 58 01 00 	cmp    0x158(%rsp),%rax
  1064a8:	00 
  1064a9:	75 e5                	jne    106490 <synreal::SolverNewton::precompute_matrices()+0x2120>
  1064ab:	48 8b 84 24 58 01 00 	mov    0x158(%rsp),%rax
  1064b2:	00 
  1064b3:	48 89 84 24 d8 01 00 	mov    %rax,0x1d8(%rsp)
  1064ba:	00 
  1064bb:	48 8b 84 24 b8 00 00 	mov    0xb8(%rsp),%rax
  1064c2:	00 
  1064c3:	48 2b 44 24 38       	sub    0x38(%rsp),%rax
  1064c8:	48 ba a8 aa aa aa aa 	movabs $0x2aaaaaaaaaaaaaa8,%rdx
  1064cf:	aa aa 2a 
  1064d2:	48 89 c5             	mov    %rax,%rbp
  1064d5:	48 c1 fd 03          	sar    $0x3,%rbp
  1064d9:	48 39 d0             	cmp    %rdx,%rax
  1064dc:	0f 87 1b 61 00 00    	ja     10c5fd <synreal::SolverNewton::precompute_matrices()+0x828d>
  1064e2:	66 0f ef c0          	pxor   %xmm0,%xmm0
  1064e6:	48 8d 44 6d 00       	lea    0x0(%rbp,%rbp,2),%rax
  1064eb:	48 c7 84 24 50 07 00 	movq   $0x0,0x750(%rsp)
  1064f2:	00 00 00 00 00 
  1064f7:	0f 29 84 24 40 07 00 	movaps %xmm0,0x740(%rsp)
  1064fe:	00 
  1064ff:	4c 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%r13
  106506:	00 
  106507:	48 85 ed             	test   %rbp,%rbp
  10650a:	0f 84 cb 60 00 00    	je     10c5db <synreal::SolverNewton::precompute_matrices()+0x826b>
  106510:	4c 89 ef             	mov    %r13,%rdi
  106513:	e8 38 6c f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  106518:	66 48 0f 6e c0       	movq   %rax,%xmm0
  10651d:	4a 8d 0c 28          	lea    (%rax,%r13,1),%rcx
  106521:	49 89 c4             	mov    %rax,%r12
  106524:	66 0f 6c c0          	punpcklqdq %xmm0,%xmm0
  106528:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  10652c:	48 89 8c 24 50 07 00 	mov    %rcx,0x750(%rsp)
  106533:	00 
  106534:	0f 29 84 24 40 07 00 	movaps %xmm0,0x740(%rsp)
  10653b:	00 
  10653c:	48 83 f8 01          	cmp    $0x1,%rax
  106540:	0f 86 8a 60 00 00    	jbe    10c5d0 <synreal::SolverNewton::precompute_matrices()+0x8260>
  106546:	48 89 ee             	mov    %rbp,%rsi
  106549:	48 89 e8             	mov    %rbp,%rax
  10654c:	66 0f ef c0          	pxor   %xmm0,%xmm0
  106550:	4c 89 e2             	mov    %r12,%rdx
  106553:	48 d1 ee             	shr    %rsi
  106556:	48 83 e0 fe          	and    $0xfffffffffffffffe,%rax
  10655a:	48 01 f0             	add    %rsi,%rax
  10655d:	48 c1 e0 04          	shl    $0x4,%rax
  106561:	4c 01 e0             	add    %r12,%rax
  106564:	0f 11 02             	movups %xmm0,(%rdx)
  106567:	48 83 c2 30          	add    $0x30,%rdx
  10656b:	0f 11 42 e0          	movups %xmm0,-0x20(%rdx)
  10656f:	0f 11 42 f0          	movups %xmm0,-0x10(%rdx)
  106573:	48 39 d0             	cmp    %rdx,%rax
  106576:	75 ec                	jne    106564 <synreal::SolverNewton::precompute_matrices()+0x21f4>
  106578:	48 89 ea             	mov    %rbp,%rdx
  10657b:	48 89 ee             	mov    %rbp,%rsi
  10657e:	48 83 e2 fe          	and    $0xfffffffffffffffe,%rdx
  106582:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
  106586:	48 29 d6             	sub    %rdx,%rsi
  106589:	49 8d 04 c4          	lea    (%r12,%rax,8),%rax
  10658d:	48 39 d5             	cmp    %rdx,%rbp
  106590:	74 21                	je     1065b3 <synreal::SolverNewton::precompute_matrices()+0x2243>
  106592:	66 0f ef c0          	pxor   %xmm0,%xmm0
  106596:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  10659d:	00 
  10659e:	0f 11 00             	movups %xmm0,(%rax)
  1065a1:	48 83 fe 01          	cmp    $0x1,%rsi
  1065a5:	74 0c                	je     1065b3 <synreal::SolverNewton::precompute_matrices()+0x2243>
  1065a7:	48 c7 40 28 00 00 00 	movq   $0x0,0x28(%rax)
  1065ae:	00 
  1065af:	0f 11 40 18          	movups %xmm0,0x18(%rax)
  1065b3:	48 8b 84 24 c8 00 00 	mov    0xc8(%rsp),%rax
  1065ba:	00 
  1065bb:	48 2b 44 24 30       	sub    0x30(%rsp),%rax
  1065c0:	48 ba a8 aa aa aa aa 	movabs $0x2aaaaaaaaaaaaaa8,%rdx
  1065c7:	aa aa 2a 
  1065ca:	48 89 8c 24 48 07 00 	mov    %rcx,0x748(%rsp)
  1065d1:	00 
  1065d2:	48 89 c5             	mov    %rax,%rbp
  1065d5:	48 c1 fd 03          	sar    $0x3,%rbp
  1065d9:	48 39 d0             	cmp    %rdx,%rax
  1065dc:	0f 87 d8 5f 00 00    	ja     10c5ba <synreal::SolverNewton::precompute_matrices()+0x824a>
  1065e2:	66 0f ef c0          	pxor   %xmm0,%xmm0
  1065e6:	48 8d 44 6d 00       	lea    0x0(%rbp,%rbp,2),%rax
  1065eb:	48 c7 84 24 70 07 00 	movq   $0x0,0x770(%rsp)
  1065f2:	00 00 00 00 00 
  1065f7:	0f 29 84 24 60 07 00 	movaps %xmm0,0x760(%rsp)
  1065fe:	00 
  1065ff:	4c 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%r13
  106606:	00 
  106607:	48 85 ed             	test   %rbp,%rbp
  10660a:	0f 84 89 5f 00 00    	je     10c599 <synreal::SolverNewton::precompute_matrices()+0x8229>
  106610:	4c 89 ef             	mov    %r13,%rdi
  106613:	e8 38 6b f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  106618:	66 48 0f 6e c0       	movq   %rax,%xmm0
  10661d:	4a 8d 34 28          	lea    (%rax,%r13,1),%rsi
  106621:	48 8d 55 ff          	lea    -0x1(%rbp),%rdx
  106625:	66 0f 6c c0          	punpcklqdq %xmm0,%xmm0
  106629:	48 89 b4 24 70 07 00 	mov    %rsi,0x770(%rsp)
  106630:	00 
  106631:	0f 29 84 24 60 07 00 	movaps %xmm0,0x760(%rsp)
  106638:	00 
  106639:	48 83 fa 01          	cmp    $0x1,%rdx
  10663d:	0f 86 4b 5f 00 00    	jbe    10c58e <synreal::SolverNewton::precompute_matrices()+0x821e>
  106643:	48 89 ef             	mov    %rbp,%rdi
  106646:	48 89 ea             	mov    %rbp,%rdx
  106649:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10664d:	48 89 c1             	mov    %rax,%rcx
  106650:	48 d1 ef             	shr    %rdi
  106653:	48 83 e2 fe          	and    $0xfffffffffffffffe,%rdx
  106657:	48 01 fa             	add    %rdi,%rdx
  10665a:	48 c1 e2 04          	shl    $0x4,%rdx
  10665e:	48 01 c2             	add    %rax,%rdx
  106661:	0f 11 01             	movups %xmm0,(%rcx)
  106664:	48 83 c1 30          	add    $0x30,%rcx
  106668:	0f 11 41 e0          	movups %xmm0,-0x20(%rcx)
  10666c:	0f 11 41 f0          	movups %xmm0,-0x10(%rcx)
  106670:	48 39 d1             	cmp    %rdx,%rcx
  106673:	75 ec                	jne    106661 <synreal::SolverNewton::precompute_matrices()+0x22f1>
  106675:	48 89 e9             	mov    %rbp,%rcx
  106678:	48 89 ef             	mov    %rbp,%rdi
  10667b:	48 83 e1 fe          	and    $0xfffffffffffffffe,%rcx
  10667f:	48 8d 14 49          	lea    (%rcx,%rcx,2),%rdx
  106683:	48 29 cf             	sub    %rcx,%rdi
  106686:	48 8d 14 d0          	lea    (%rax,%rdx,8),%rdx
  10668a:	48 39 cd             	cmp    %rcx,%rbp
  10668d:	74 21                	je     1066b0 <synreal::SolverNewton::precompute_matrices()+0x2340>
  10668f:	66 0f ef c0          	pxor   %xmm0,%xmm0
  106693:	48 c7 42 10 00 00 00 	movq   $0x0,0x10(%rdx)
  10669a:	00 
  10669b:	0f 11 02             	movups %xmm0,(%rdx)
  10669e:	48 83 ff 01          	cmp    $0x1,%rdi
  1066a2:	74 0c                	je     1066b0 <synreal::SolverNewton::precompute_matrices()+0x2340>
  1066a4:	48 c7 42 28 00 00 00 	movq   $0x0,0x28(%rdx)
  1066ab:	00 
  1066ac:	0f 11 42 18          	movups %xmm0,0x18(%rdx)
  1066b0:	48 89 b4 24 68 07 00 	mov    %rsi,0x768(%rsp)
  1066b7:	00 
  1066b8:	48 85 db             	test   %rbx,%rbx
  1066bb:	0f 84 76 02 00 00    	je     106937 <synreal::SolverNewton::precompute_matrices()+0x25c7>
  1066c1:	48 8b 8c 24 a0 00 00 	mov    0xa0(%rsp),%rcx
  1066c8:	00 
  1066c9:	4c 8d 3c 5b          	lea    (%rbx,%rbx,2),%r15
  1066cd:	48 89 84 24 98 01 00 	mov    %rax,0x198(%rsp)
  1066d4:	00 
  1066d5:	48 8d 04 dd 00 00 00 	lea    0x0(,%rbx,8),%rax
  1066dc:	00 
  1066dd:	4c 89 a4 24 90 01 00 	mov    %r12,0x190(%rsp)
  1066e4:	00 
  1066e5:	49 c1 e7 03          	shl    $0x3,%r15
  1066e9:	48 8d 79 08          	lea    0x8(%rcx),%rdi
  1066ed:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  1066f2:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
  1066f7:	48 c7 84 24 98 00 00 	movq   $0x0,0x98(%rsp)
  1066fe:	00 00 00 00 00 
  106703:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  10670a:	00 
  10670b:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  10670f:	48 c1 e0 04          	shl    $0x4,%rax
  106713:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  106718:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10671d:	48 8b 68 10          	mov    0x10(%rax),%rbp
  106721:	48 39 e8             	cmp    %rbp,%rax
  106724:	0f 84 db 01 00 00    	je     106905 <synreal::SolverNewton::precompute_matrices()+0x2595>
  10672a:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
  10672f:	48 03 84 24 e0 04 00 	add    0x4e0(%rsp),%rax
  106736:	00 
  106737:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  10673c:	48 83 c0 08          	add    $0x8,%rax
  106740:	4c 8b ac 24 90 01 00 	mov    0x190(%rsp),%r13
  106747:	00 
  106748:	48 89 04 24          	mov    %rax,(%rsp)
  10674c:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  106753:	00 
  106754:	4c 8b b4 24 98 01 00 	mov    0x198(%rsp),%r14
  10675b:	00 
  10675c:	4c 8d 24 c5 00 00 00 	lea    0x0(,%rax,8),%r12
  106763:	00 
  106764:	0f 1f 40 00          	nopl   0x0(%rax)
  106768:	8b 45 20             	mov    0x20(%rbp),%eax
  10676b:	f3 0f 10 45 24       	movss  0x24(%rbp),%xmm0
  106770:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
  106775:	48 8b 74 24 48       	mov    0x48(%rsp),%rsi
  10677a:	42 89 04 26          	mov    %eax,(%rsi,%r12,1)
  10677e:	f3 42 0f 11 44 26 04 	movss  %xmm0,0x4(%rsi,%r12,1)
  106785:	f3 0f 10 45 28       	movss  0x28(%rbp),%xmm0
  10678a:	42 89 04 27          	mov    %eax,(%rdi,%r12,1)
  10678e:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  106793:	f3 42 0f 11 44 27 04 	movss  %xmm0,0x4(%rdi,%r12,1)
  10679a:	8b 55 20             	mov    0x20(%rbp),%edx
  10679d:	48 8b 3c 24          	mov    (%rsp),%rdi
  1067a1:	48 8b 40 10          	mov    0x10(%rax),%rax
  1067a5:	48 85 c0             	test   %rax,%rax
  1067a8:	74 50                	je     1067fa <synreal::SolverNewton::precompute_matrices()+0x248a>
  1067aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  1067b0:	48 8b 48 10          	mov    0x10(%rax),%rcx
  1067b4:	48 8b 70 18          	mov    0x18(%rax),%rsi
  1067b8:	3b 50 20             	cmp    0x20(%rax),%edx
  1067bb:	7f 18                	jg     1067d5 <synreal::SolverNewton::precompute_matrices()+0x2465>
  1067bd:	48 89 c7             	mov    %rax,%rdi
  1067c0:	48 85 c9             	test   %rcx,%rcx
  1067c3:	74 1b                	je     1067e0 <synreal::SolverNewton::precompute_matrices()+0x2470>
  1067c5:	48 89 c8             	mov    %rcx,%rax
  1067c8:	48 8b 48 10          	mov    0x10(%rax),%rcx
  1067cc:	48 8b 70 18          	mov    0x18(%rax),%rsi
  1067d0:	3b 50 20             	cmp    0x20(%rax),%edx
  1067d3:	7e e8                	jle    1067bd <synreal::SolverNewton::precompute_matrices()+0x244d>
  1067d5:	48 85 f6             	test   %rsi,%rsi
  1067d8:	74 06                	je     1067e0 <synreal::SolverNewton::precompute_matrices()+0x2470>
  1067da:	48 89 f0             	mov    %rsi,%rax
  1067dd:	eb d1                	jmp    1067b0 <synreal::SolverNewton::precompute_matrices()+0x2440>
  1067df:	90                   	nop
  1067e0:	48 3b 3c 24          	cmp    (%rsp),%rdi
  1067e4:	74 14                	je     1067fa <synreal::SolverNewton::precompute_matrices()+0x248a>
  1067e6:	3b 57 20             	cmp    0x20(%rdi),%edx
  1067e9:	7c 0f                	jl     1067fa <synreal::SolverNewton::precompute_matrices()+0x248a>
  1067eb:	48 8d 77 28          	lea    0x28(%rdi),%rsi
  1067ef:	4c 89 ef             	mov    %r13,%rdi
  1067f2:	e8 49 95 fe ff       	call   efd40 <std::vector<int, std::allocator<int> >::operator=(std::vector<int, std::allocator<int> > const&) [clone .isra.0]>
  1067f7:	8b 55 20             	mov    0x20(%rbp),%edx
  1067fa:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
  1067ff:	f3 0f 10 45 2c       	movss  0x2c(%rbp),%xmm0
  106804:	42 89 14 20          	mov    %edx,(%rax,%r12,1)
  106808:	f3 42 0f 11 44 20 04 	movss  %xmm0,0x4(%rax,%r12,1)
  10680f:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
  106814:	48 03 84 24 00 05 00 	add    0x500(%rsp),%rax
  10681b:	00 
  10681c:	4c 8d 40 08          	lea    0x8(%rax),%r8
  106820:	48 8b 40 10          	mov    0x10(%rax),%rax
  106824:	48 85 c0             	test   %rax,%rax
  106827:	74 4d                	je     106876 <synreal::SolverNewton::precompute_matrices()+0x2506>
  106829:	4c 89 c7             	mov    %r8,%rdi
  10682c:	0f 1f 40 00          	nopl   0x0(%rax)
  106830:	48 8b 48 10          	mov    0x10(%rax),%rcx
  106834:	48 8b 70 18          	mov    0x18(%rax),%rsi
  106838:	39 50 20             	cmp    %edx,0x20(%rax)
  10683b:	7c 18                	jl     106855 <synreal::SolverNewton::precompute_matrices()+0x24e5>
  10683d:	48 89 c7             	mov    %rax,%rdi
  106840:	48 85 c9             	test   %rcx,%rcx
  106843:	74 1b                	je     106860 <synreal::SolverNewton::precompute_matrices()+0x24f0>
  106845:	48 89 c8             	mov    %rcx,%rax
  106848:	48 8b 48 10          	mov    0x10(%rax),%rcx
  10684c:	48 8b 70 18          	mov    0x18(%rax),%rsi
  106850:	39 50 20             	cmp    %edx,0x20(%rax)
  106853:	7d e8                	jge    10683d <synreal::SolverNewton::precompute_matrices()+0x24cd>
  106855:	48 85 f6             	test   %rsi,%rsi
  106858:	74 06                	je     106860 <synreal::SolverNewton::precompute_matrices()+0x24f0>
  10685a:	48 89 f0             	mov    %rsi,%rax
  10685d:	eb d1                	jmp    106830 <synreal::SolverNewton::precompute_matrices()+0x24c0>
  10685f:	90                   	nop
  106860:	49 39 f8             	cmp    %rdi,%r8
  106863:	74 11                	je     106876 <synreal::SolverNewton::precompute_matrices()+0x2506>
  106865:	39 57 20             	cmp    %edx,0x20(%rdi)
  106868:	7f 0c                	jg     106876 <synreal::SolverNewton::precompute_matrices()+0x2506>
  10686a:	48 8d 77 28          	lea    0x28(%rdi),%rsi
  10686e:	4c 89 f7             	mov    %r14,%rdi
  106871:	e8 ca 94 fe ff       	call   efd40 <std::vector<int, std::allocator<int> >::operator=(std::vector<int, std::allocator<int> > const&) [clone .isra.0]>
  106876:	8b 45 20             	mov    0x20(%rbp),%eax
  106879:	f3 0f 10 45 30       	movss  0x30(%rbp),%xmm0
  10687e:	4d 01 fe             	add    %r15,%r14
  106881:	4d 01 fd             	add    %r15,%r13
  106884:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
  106889:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
  10688e:	f3 42 0f 11 44 26 04 	movss  %xmm0,0x4(%rsi,%r12,1)
  106895:	f3 0f 10 4d 34       	movss  0x34(%rbp),%xmm1
  10689a:	42 89 04 26          	mov    %eax,(%rsi,%r12,1)
  10689e:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  1068a3:	42 89 04 27          	mov    %eax,(%rdi,%r12,1)
  1068a7:	8b 45 20             	mov    0x20(%rbp),%eax
  1068aa:	f3 0f 10 86 d0 05 00 	movss  0x5d0(%rsi),%xmm0
  1068b1:	00 
  1068b2:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  1068b7:	f3 0f 59 c8          	mulss  %xmm0,%xmm1
  1068bb:	f3 42 0f 11 4c 27 04 	movss  %xmm1,0x4(%rdi,%r12,1)
  1068c2:	f3 0f 59 45 38       	mulss  0x38(%rbp),%xmm0
  1068c7:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  1068cc:	42 89 04 26          	mov    %eax,(%rsi,%r12,1)
  1068d0:	8b 45 20             	mov    0x20(%rbp),%eax
  1068d3:	f3 42 0f 11 44 26 04 	movss  %xmm0,0x4(%rsi,%r12,1)
  1068da:	f3 0f 10 45 3c       	movss  0x3c(%rbp),%xmm0
  1068df:	42 89 04 27          	mov    %eax,(%rdi,%r12,1)
  1068e3:	f3 42 0f 11 44 27 04 	movss  %xmm0,0x4(%rdi,%r12,1)
  1068ea:	48 89 ef             	mov    %rbp,%rdi
  1068ed:	e8 7e 5d f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  1068f2:	4c 03 64 24 50       	add    0x50(%rsp),%r12
  1068f7:	48 89 c5             	mov    %rax,%rbp
  1068fa:	48 39 44 24 28       	cmp    %rax,0x28(%rsp)
  1068ff:	0f 85 63 fe ff ff    	jne    106768 <synreal::SolverNewton::precompute_matrices()+0x23f8>
  106905:	48 83 84 24 98 00 00 	addq   $0x1,0x98(%rsp)
  10690c:	00 01 
  10690e:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  106915:	00 
  106916:	48 83 44 24 28 30    	addq   $0x30,0x28(%rsp)
  10691c:	48 83 84 24 98 01 00 	addq   $0x18,0x198(%rsp)
  106923:	00 18 
  106925:	48 83 84 24 90 01 00 	addq   $0x18,0x190(%rsp)
  10692c:	00 18 
  10692e:	48 39 c3             	cmp    %rax,%rbx
  106931:	0f 85 cc fd ff ff    	jne    106703 <synreal::SolverNewton::precompute_matrices()+0x2393>
  106937:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  10693c:	48 8b 94 24 08 04 00 	mov    0x408(%rsp),%rdx
  106943:	00 
  106944:	48 8b b4 24 80 00 00 	mov    0x80(%rsp),%rsi
  10694b:	00 
  10694c:	48 8d b8 f8 2d 00 00 	lea    0x2df8(%rax),%rdi
  106953:	e8 98 52 f6 ff       	call   6bbf0 <void thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::range_assign<__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > > >(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, __gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  106958:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  10695d:	48 8b 94 24 60 01 00 	mov    0x160(%rsp),%rdx
  106964:	00 
  106965:	48 8b b4 24 88 00 00 	mov    0x88(%rsp),%rsi
  10696c:	00 
  10696d:	49 8d bf 18 2e 00 00 	lea    0x2e18(%r15),%rdi
  106974:	e8 77 52 f6 ff       	call   6bbf0 <void thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::range_assign<__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > > >(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, __gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  106979:	48 8b 94 24 68 01 00 	mov    0x168(%rsp),%rdx
  106980:	00 
  106981:	48 8b b4 24 b0 00 00 	mov    0xb0(%rsp),%rsi
  106988:	00 
  106989:	49 8d bf 38 2e 00 00 	lea    0x2e38(%r15),%rdi
  106990:	e8 5b 52 f6 ff       	call   6bbf0 <void thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::range_assign<__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > > >(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, __gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  106995:	48 8b 84 24 20 04 00 	mov    0x420(%rsp),%rax
  10699c:	00 
  10699d:	48 8b 94 24 28 04 00 	mov    0x428(%rsp),%rdx
  1069a4:	00 
  1069a5:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  1069aa:	48 39 c2             	cmp    %rax,%rdx
  1069ad:	0f 84 a6 00 00 00    	je     106a59 <synreal::SolverNewton::precompute_matrices()+0x26e9>
  1069b3:	49 89 c3             	mov    %rax,%r11
  1069b6:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  1069bb:	4c 89 de             	mov    %r11,%rsi
  1069be:	f3 0f 10 80 d0 05 00 	movss  0x5d0(%rax),%xmm0
  1069c5:	00 
  1069c6:	48 8d 42 fc          	lea    -0x4(%rdx),%rax
  1069ca:	4c 29 d8             	sub    %r11,%rax
  1069cd:	48 89 c7             	mov    %rax,%rdi
  1069d0:	48 c1 ef 02          	shr    $0x2,%rdi
  1069d4:	48 8d 4f 01          	lea    0x1(%rdi),%rcx
  1069d8:	48 83 f8 08          	cmp    $0x8,%rax
  1069dc:	0f 86 a5 5b 00 00    	jbe    10c587 <synreal::SolverNewton::precompute_matrices()+0x8217>
  1069e2:	48 89 c8             	mov    %rcx,%rax
  1069e5:	0f 28 d0             	movaps %xmm0,%xmm2
  1069e8:	48 c1 e8 02          	shr    $0x2,%rax
  1069ec:	0f c6 d2 00          	shufps $0x0,%xmm2,%xmm2
  1069f0:	48 c1 e0 04          	shl    $0x4,%rax
  1069f4:	4c 01 d8             	add    %r11,%rax
  1069f7:	0f 10 0e             	movups (%rsi),%xmm1
  1069fa:	48 83 c6 10          	add    $0x10,%rsi
  1069fe:	0f 59 ca             	mulps  %xmm2,%xmm1
  106a01:	0f 11 4e f0          	movups %xmm1,-0x10(%rsi)
  106a05:	48 39 f0             	cmp    %rsi,%rax
  106a08:	75 ed                	jne    1069f7 <synreal::SolverNewton::precompute_matrices()+0x2687>
  106a0a:	48 8b 74 24 50       	mov    0x50(%rsp),%rsi
  106a0f:	48 89 c8             	mov    %rcx,%rax
  106a12:	48 83 e0 fc          	and    $0xfffffffffffffffc,%rax
  106a16:	48 8d 34 86          	lea    (%rsi,%rax,4),%rsi
  106a1a:	48 39 c8             	cmp    %rcx,%rax
  106a1d:	74 3a                	je     106a59 <synreal::SolverNewton::precompute_matrices()+0x26e9>
  106a1f:	48 29 c1             	sub    %rax,%rcx
  106a22:	48 39 f8             	cmp    %rdi,%rax
  106a25:	74 2a                	je     106a51 <synreal::SolverNewton::precompute_matrices()+0x26e1>
  106a27:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
  106a2c:	0f 28 d0             	movaps %xmm0,%xmm2
  106a2f:	0f c6 d2 e0          	shufps $0xe0,%xmm2,%xmm2
  106a33:	48 8d 04 87          	lea    (%rdi,%rax,4),%rax
  106a37:	f3 0f 7e 08          	movq   (%rax),%xmm1
  106a3b:	0f 59 ca             	mulps  %xmm2,%xmm1
  106a3e:	0f 13 08             	movlps %xmm1,(%rax)
  106a41:	48 89 c8             	mov    %rcx,%rax
  106a44:	48 83 e0 fe          	and    $0xfffffffffffffffe,%rax
  106a48:	48 8d 34 86          	lea    (%rsi,%rax,4),%rsi
  106a4c:	48 39 c8             	cmp    %rcx,%rax
  106a4f:	74 08                	je     106a59 <synreal::SolverNewton::precompute_matrices()+0x26e9>
  106a51:	f3 0f 59 06          	mulss  (%rsi),%xmm0
  106a55:	f3 0f 11 06          	movss  %xmm0,(%rsi)
  106a59:	48 8b 84 24 40 04 00 	mov    0x440(%rsp),%rax
  106a60:	00 
  106a61:	4c 8b a4 24 48 04 00 	mov    0x448(%rsp),%r12
  106a68:	00 
  106a69:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  106a6e:	49 39 c4             	cmp    %rax,%r12
  106a71:	0f 84 a7 00 00 00    	je     106b1e <synreal::SolverNewton::precompute_matrices()+0x27ae>
  106a77:	49 89 c3             	mov    %rax,%r11
  106a7a:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  106a7f:	4c 89 de             	mov    %r11,%rsi
  106a82:	f3 0f 10 80 d0 05 00 	movss  0x5d0(%rax),%xmm0
  106a89:	00 
  106a8a:	49 8d 44 24 fc       	lea    -0x4(%r12),%rax
  106a8f:	4c 29 d8             	sub    %r11,%rax
  106a92:	48 89 c7             	mov    %rax,%rdi
  106a95:	48 c1 ef 02          	shr    $0x2,%rdi
  106a99:	48 8d 4f 01          	lea    0x1(%rdi),%rcx
  106a9d:	48 83 f8 08          	cmp    $0x8,%rax
  106aa1:	0f 86 d9 5a 00 00    	jbe    10c580 <synreal::SolverNewton::precompute_matrices()+0x8210>
  106aa7:	48 89 c8             	mov    %rcx,%rax
  106aaa:	0f 28 d0             	movaps %xmm0,%xmm2
  106aad:	48 c1 e8 02          	shr    $0x2,%rax
  106ab1:	0f c6 d2 00          	shufps $0x0,%xmm2,%xmm2
  106ab5:	48 c1 e0 04          	shl    $0x4,%rax
  106ab9:	4c 01 d8             	add    %r11,%rax
  106abc:	0f 10 0e             	movups (%rsi),%xmm1
  106abf:	48 83 c6 10          	add    $0x10,%rsi
  106ac3:	0f 59 ca             	mulps  %xmm2,%xmm1
  106ac6:	0f 11 4e f0          	movups %xmm1,-0x10(%rsi)
  106aca:	48 39 c6             	cmp    %rax,%rsi
  106acd:	75 ed                	jne    106abc <synreal::SolverNewton::precompute_matrices()+0x274c>
  106acf:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
  106ad4:	48 89 c8             	mov    %rcx,%rax
  106ad7:	48 83 e0 fc          	and    $0xfffffffffffffffc,%rax
  106adb:	48 8d 34 86          	lea    (%rsi,%rax,4),%rsi
  106adf:	48 39 c8             	cmp    %rcx,%rax
  106ae2:	74 3a                	je     106b1e <synreal::SolverNewton::precompute_matrices()+0x27ae>
  106ae4:	48 29 c1             	sub    %rax,%rcx
  106ae7:	48 39 f8             	cmp    %rdi,%rax
  106aea:	74 2a                	je     106b16 <synreal::SolverNewton::precompute_matrices()+0x27a6>
  106aec:	48 8b 7c 24 58       	mov    0x58(%rsp),%rdi
  106af1:	0f 28 d0             	movaps %xmm0,%xmm2
  106af4:	0f c6 d2 e0          	shufps $0xe0,%xmm2,%xmm2
  106af8:	48 8d 04 87          	lea    (%rdi,%rax,4),%rax
  106afc:	f3 0f 7e 08          	movq   (%rax),%xmm1
  106b00:	0f 59 ca             	mulps  %xmm2,%xmm1
  106b03:	0f 13 08             	movlps %xmm1,(%rax)
  106b06:	48 89 c8             	mov    %rcx,%rax
  106b09:	48 83 e0 fe          	and    $0xfffffffffffffffe,%rax
  106b0d:	48 8d 34 86          	lea    (%rsi,%rax,4),%rsi
  106b11:	48 39 c8             	cmp    %rcx,%rax
  106b14:	74 08                	je     106b1e <synreal::SolverNewton::precompute_matrices()+0x27ae>
  106b16:	f3 0f 59 06          	mulss  (%rsi),%xmm0
  106b1a:	f3 0f 11 06          	movss  %xmm0,(%rsi)
  106b1e:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  106b23:	48 8b 74 24 50       	mov    0x50(%rsp),%rsi
  106b28:	48 8d b8 58 2e 00 00 	lea    0x2e58(%rax),%rdi
  106b2f:	e8 bc 50 f6 ff       	call   6bbf0 <void thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::range_assign<__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > > >(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, __gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  106b34:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  106b39:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
  106b3e:	4c 89 e2             	mov    %r12,%rdx
  106b41:	49 8d bf 78 2e 00 00 	lea    0x2e78(%r15),%rdi
  106b48:	e8 a3 50 f6 ff       	call   6bbf0 <void thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::range_assign<__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > > >(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, __gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  106b4d:	48 8b 94 24 b8 01 00 	mov    0x1b8(%rsp),%rdx
  106b54:	00 
  106b55:	48 8b 74 24 70       	mov    0x70(%rsp),%rsi
  106b5a:	49 8d bf 98 2e 00 00 	lea    0x2e98(%r15),%rdi
  106b61:	e8 8a 50 f6 ff       	call   6bbf0 <void thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::range_assign<__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > > >(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, __gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  106b66:	48 8b 94 24 a8 01 00 	mov    0x1a8(%rsp),%rdx
  106b6d:	00 
  106b6e:	48 8b b4 24 a8 00 00 	mov    0xa8(%rsp),%rsi
  106b75:	00 
  106b76:	49 8d bf b8 2b 00 00 	lea    0x2bb8(%r15),%rdi
  106b7d:	e8 1e 49 f6 ff       	call   6b4a0 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::range_assign<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > > >(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  106b82:	41 8b 87 ac 00 00 00 	mov    0xac(%r15),%eax
  106b89:	85 c0                	test   %eax,%eax
  106b8b:	0f 84 27 4a 00 00    	je     10b5b8 <synreal::SolverNewton::precompute_matrices()+0x7248>
  106b91:	4c 8d 3c 85 00 00 00 	lea    0x0(,%rax,4),%r15
  106b98:	00 
  106b99:	48 89 04 24          	mov    %rax,(%rsp)
  106b9d:	4c 89 ff             	mov    %r15,%rdi
  106ba0:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
  106ba5:	e8 a6 65 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  106baa:	49 89 c4             	mov    %rax,%r12
  106bad:	4c 89 fa             	mov    %r15,%rdx
  106bb0:	31 f6                	xor    %esi,%esi
  106bb2:	48 89 c7             	mov    %rax,%rdi
  106bb5:	4c 89 bc 24 90 01 00 	mov    %r15,0x190(%rsp)
  106bbc:	00 
  106bbd:	4d 01 fc             	add    %r15,%r12
  106bc0:	49 89 c7             	mov    %rax,%r15
  106bc3:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  106bca:	00 
  106bcb:	e8 50 55 f6 ff       	call   6c120 <memset@plt>
  106bd0:	48 8b b4 24 a8 00 00 	mov    0xa8(%rsp),%rsi
  106bd7:	00 
  106bd8:	31 c9                	xor    %ecx,%ecx
  106bda:	4c 89 ff             	mov    %r15,%rdi
  106bdd:	48 89 c8             	mov    %rcx,%rax
  106be0:	31 d2                	xor    %edx,%edx
  106be2:	48 f7 f3             	div    %rbx
  106be5:	8b 04 96             	mov    (%rsi,%rdx,4),%eax
  106be8:	89 04 8f             	mov    %eax,(%rdi,%rcx,4)
  106beb:	48 83 c1 01          	add    $0x1,%rcx
  106bef:	48 3b 0c 24          	cmp    (%rsp),%rcx
  106bf3:	75 e8                	jne    106bdd <synreal::SolverNewton::precompute_matrices()+0x286d>
  106bf5:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  106bfa:	48 8b b4 24 98 00 00 	mov    0x98(%rsp),%rsi
  106c01:	00 
  106c02:	4c 89 e2             	mov    %r12,%rdx
  106c05:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  106c0c:	00 
  106c0d:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  106c14:	00 
  106c15:	49 8d bf d8 2b 00 00 	lea    0x2bd8(%r15),%rdi
  106c1c:	e8 7f 48 f6 ff       	call   6b4a0 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::range_assign<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > > >(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  106c21:	48 8b 94 24 c0 00 00 	mov    0xc0(%rsp),%rdx
  106c28:	00 
  106c29:	48 8b 74 24 48       	mov    0x48(%rsp),%rsi
  106c2e:	49 8d bf f8 2b 00 00 	lea    0x2bf8(%r15),%rdi
  106c35:	e8 86 d0 ff ff       	call   103cc0 <void thrust::THRUST_200302_520_NS::detail::vector_base<synreal::NonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::NonZeroEntry> >::range_assign<__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > > >(__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, __gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106c3a:	48 8b 94 24 b8 00 00 	mov    0xb8(%rsp),%rdx
  106c41:	00 
  106c42:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
  106c47:	49 8d bf 18 2c 00 00 	lea    0x2c18(%r15),%rdi
  106c4e:	e8 6d d0 ff ff       	call   103cc0 <void thrust::THRUST_200302_520_NS::detail::vector_base<synreal::NonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::NonZeroEntry> >::range_assign<__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > > >(__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, __gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106c53:	49 8d 97 58 2c 00 00 	lea    0x2c58(%r15),%rdx
  106c5a:	49 8d b7 38 2c 00 00 	lea    0x2c38(%r15),%rsi
  106c61:	4c 89 ef             	mov    %r13,%rdi
  106c64:	e8 f7 d1 ff ff       	call   103e60 <synreal::SolverNewton::precompute_matrices()::{lambda(std::vector<std::vector<int, std::allocator<int> >, std::allocator<std::vector<int, std::allocator<int> > > > const&, thrust::THRUST_200302_520_NS::device_vector<unsigned long, thrust::THRUST_200302_520_NS::device_allocator<unsigned long> >&, thrust::THRUST_200302_520_NS::device_vector<int, thrust::THRUST_200302_520_NS::device_allocator<int> >&)#11}::operator()(std::vector<std::vector<int, std::allocator<int> >, std::allocator<std::vector<int, std::allocator<int> > > > const&, thrust::THRUST_200302_520_NS::device_vector<unsigned long, thrust::THRUST_200302_520_NS::device_allocator<unsigned long> >&, thrust::THRUST_200302_520_NS::device_vector<int, thrust::THRUST_200302_520_NS::device_allocator<int> >&) const [clone .constprop.0]>
  106c69:	49 8d 97 98 2c 00 00 	lea    0x2c98(%r15),%rdx
  106c70:	49 8d b7 78 2c 00 00 	lea    0x2c78(%r15),%rsi
  106c77:	4c 89 f7             	mov    %r14,%rdi
  106c7a:	e8 e1 d1 ff ff       	call   103e60 <synreal::SolverNewton::precompute_matrices()::{lambda(std::vector<std::vector<int, std::allocator<int> >, std::allocator<std::vector<int, std::allocator<int> > > > const&, thrust::THRUST_200302_520_NS::device_vector<unsigned long, thrust::THRUST_200302_520_NS::device_allocator<unsigned long> >&, thrust::THRUST_200302_520_NS::device_vector<int, thrust::THRUST_200302_520_NS::device_allocator<int> >&)#11}::operator()(std::vector<std::vector<int, std::allocator<int> >, std::allocator<std::vector<int, std::allocator<int> > > > const&, thrust::THRUST_200302_520_NS::device_vector<unsigned long, thrust::THRUST_200302_520_NS::device_allocator<unsigned long> >&, thrust::THRUST_200302_520_NS::device_vector<int, thrust::THRUST_200302_520_NS::device_allocator<int> >&) const [clone .constprop.0]>
  106c7f:	49 8d 97 d8 2c 00 00 	lea    0x2cd8(%r15),%rdx
  106c86:	49 8d b7 b8 2c 00 00 	lea    0x2cb8(%r15),%rsi
  106c8d:	48 8d bc 24 20 05 00 	lea    0x520(%rsp),%rdi
  106c94:	00 
  106c95:	e8 c6 d1 ff ff       	call   103e60 <synreal::SolverNewton::precompute_matrices()::{lambda(std::vector<std::vector<int, std::allocator<int> >, std::allocator<std::vector<int, std::allocator<int> > > > const&, thrust::THRUST_200302_520_NS::device_vector<unsigned long, thrust::THRUST_200302_520_NS::device_allocator<unsigned long> >&, thrust::THRUST_200302_520_NS::device_vector<int, thrust::THRUST_200302_520_NS::device_allocator<int> >&)#11}::operator()(std::vector<std::vector<int, std::allocator<int> >, std::allocator<std::vector<int, std::allocator<int> > > > const&, thrust::THRUST_200302_520_NS::device_vector<unsigned long, thrust::THRUST_200302_520_NS::device_allocator<unsigned long> >&, thrust::THRUST_200302_520_NS::device_vector<int, thrust::THRUST_200302_520_NS::device_allocator<int> >&) const [clone .constprop.0]>
  106c9a:	48 8b 94 24 c8 00 00 	mov    0xc8(%rsp),%rdx
  106ca1:	00 
  106ca2:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
  106ca7:	49 8d bf f8 2c 00 00 	lea    0x2cf8(%r15),%rdi
  106cae:	e8 0d d0 ff ff       	call   103cc0 <void thrust::THRUST_200302_520_NS::detail::vector_base<synreal::NonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::NonZeroEntry> >::range_assign<__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > > >(__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, __gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106cb3:	48 8b 94 24 d8 00 00 	mov    0xd8(%rsp),%rdx
  106cba:	00 
  106cbb:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
  106cc0:	49 8d bf 18 2d 00 00 	lea    0x2d18(%r15),%rdi
  106cc7:	e8 f4 cf ff ff       	call   103cc0 <void thrust::THRUST_200302_520_NS::detail::vector_base<synreal::NonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::NonZeroEntry> >::range_assign<__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > > >(__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, __gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106ccc:	48 8b 94 24 30 01 00 	mov    0x130(%rsp),%rdx
  106cd3:	00 
  106cd4:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  106cd9:	49 8d bf 38 2d 00 00 	lea    0x2d38(%r15),%rdi
  106ce0:	e8 db cf ff ff       	call   103cc0 <void thrust::THRUST_200302_520_NS::detail::vector_base<synreal::NonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::NonZeroEntry> >::range_assign<__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > > >(__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, __gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106ce5:	48 8b 94 24 f8 00 00 	mov    0xf8(%rsp),%rdx
  106cec:	00 
  106ced:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  106cf2:	49 8d bf 58 2d 00 00 	lea    0x2d58(%r15),%rdi
  106cf9:	e8 c2 cf ff ff       	call   103cc0 <void thrust::THRUST_200302_520_NS::detail::vector_base<synreal::NonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::NonZeroEntry> >::range_assign<__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > > >(__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, __gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106cfe:	48 8b 94 24 58 01 00 	mov    0x158(%rsp),%rdx
  106d05:	00 
  106d06:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  106d0b:	49 8d bf 78 2d 00 00 	lea    0x2d78(%r15),%rdi
  106d12:	e8 a9 cf ff ff       	call   103cc0 <void thrust::THRUST_200302_520_NS::detail::vector_base<synreal::NonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::NonZeroEntry> >::range_assign<__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > > >(__gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, __gnu_cxx::__normal_iterator<synreal::NonZeroEntry*, std::vector<synreal::NonZeroEntry, std::allocator<synreal::NonZeroEntry> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106d17:	45 8b 8f d0 00 00 00 	mov    0xd0(%r15),%r9d
  106d1e:	49 8b 87 b0 2d 00 00 	mov    0x2db0(%r15),%rax
  106d25:	49 8d bf 98 2d 00 00 	lea    0x2d98(%r15),%rdi
  106d2c:	45 85 c9             	test   %r9d,%r9d
  106d2f:	75 10                	jne    106d41 <synreal::SolverNewton::precompute_matrices()+0x29d1>
  106d31:	45 8b 87 98 03 00 00 	mov    0x398(%r15),%r8d
  106d38:	45 85 c0             	test   %r8d,%r8d
  106d3b:	0f 84 d5 48 00 00    	je     10b616 <synreal::SolverNewton::precompute_matrices()+0x72a6>
  106d41:	48 8b 8c 24 c0 00 00 	mov    0xc0(%rsp),%rcx
  106d48:	00 
  106d49:	48 2b 4c 24 48       	sub    0x48(%rsp),%rcx
  106d4e:	48 89 ca             	mov    %rcx,%rdx
  106d51:	48 c1 fa 03          	sar    $0x3,%rdx
  106d55:	48 39 c2             	cmp    %rax,%rdx
  106d58:	0f 82 97 48 00 00    	jb     10b5f5 <synreal::SolverNewton::precompute_matrices()+0x7285>
  106d5e:	48 89 d6             	mov    %rdx,%rsi
  106d61:	48 29 c6             	sub    %rax,%rsi
  106d64:	e8 e7 4a f6 ff       	call   6b850 <thrust::THRUST_200302_520_NS::detail::vector_base<synreal::NonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::NonZeroEntry> >::append(unsigned long)@plt>
  106d69:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  106d6e:	48 8b 94 24 48 02 00 	mov    0x248(%rsp),%rdx
  106d75:	00 
  106d76:	48 8b b4 24 38 01 00 	mov    0x138(%rsp),%rsi
  106d7d:	00 
  106d7e:	49 8d bf c8 33 00 00 	lea    0x33c8(%r15),%rdi
  106d85:	e8 46 d4 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106d8a:	48 8b 94 24 50 02 00 	mov    0x250(%rsp),%rdx
  106d91:	00 
  106d92:	48 8b b4 24 e0 00 00 	mov    0xe0(%rsp),%rsi
  106d99:	00 
  106d9a:	49 8d bf e8 33 00 00 	lea    0x33e8(%r15),%rdi
  106da1:	e8 2a d4 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106da6:	48 8b 94 24 38 02 00 	mov    0x238(%rsp),%rdx
  106dad:	00 
  106dae:	48 8b b4 24 18 01 00 	mov    0x118(%rsp),%rsi
  106db5:	00 
  106db6:	49 8d bf 28 34 00 00 	lea    0x3428(%r15),%rdi
  106dbd:	e8 0e d4 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106dc2:	48 8b 94 24 10 02 00 	mov    0x210(%rsp),%rdx
  106dc9:	00 
  106dca:	48 8b b4 24 e8 00 00 	mov    0xe8(%rsp),%rsi
  106dd1:	00 
  106dd2:	49 8d bf 48 34 00 00 	lea    0x3448(%r15),%rdi
  106dd9:	e8 f2 d3 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106dde:	48 8b 94 24 18 02 00 	mov    0x218(%rsp),%rdx
  106de5:	00 
  106de6:	48 8b b4 24 10 01 00 	mov    0x110(%rsp),%rsi
  106ded:	00 
  106dee:	49 8d bf a8 34 00 00 	lea    0x34a8(%r15),%rdi
  106df5:	e8 d6 d3 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106dfa:	48 8b 94 24 28 02 00 	mov    0x228(%rsp),%rdx
  106e01:	00 
  106e02:	48 8b b4 24 08 01 00 	mov    0x108(%rsp),%rsi
  106e09:	00 
  106e0a:	49 8d bf c8 34 00 00 	lea    0x34c8(%r15),%rdi
  106e11:	e8 ba d3 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106e16:	48 8b 94 24 30 02 00 	mov    0x230(%rsp),%rdx
  106e1d:	00 
  106e1e:	48 8b b4 24 f0 00 00 	mov    0xf0(%rsp),%rsi
  106e25:	00 
  106e26:	49 8d bf e8 34 00 00 	lea    0x34e8(%r15),%rdi
  106e2d:	e8 9e d3 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106e32:	48 8b 94 24 00 02 00 	mov    0x200(%rsp),%rdx
  106e39:	00 
  106e3a:	48 8b b4 24 d0 00 00 	mov    0xd0(%rsp),%rsi
  106e41:	00 
  106e42:	49 8d bf 68 35 00 00 	lea    0x3568(%r15),%rdi
  106e49:	e8 82 d3 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106e4e:	48 8b 94 24 08 02 00 	mov    0x208(%rsp),%rdx
  106e55:	00 
  106e56:	48 8b b4 24 50 01 00 	mov    0x150(%rsp),%rsi
  106e5d:	00 
  106e5e:	49 8d bf 88 35 00 00 	lea    0x3588(%r15),%rdi
  106e65:	e8 66 d3 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106e6a:	48 8b 94 24 58 02 00 	mov    0x258(%rsp),%rdx
  106e71:	00 
  106e72:	48 8b b4 24 48 01 00 	mov    0x148(%rsp),%rsi
  106e79:	00 
  106e7a:	49 8d bf a8 35 00 00 	lea    0x35a8(%r15),%rdi
  106e81:	e8 4a d3 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106e86:	48 8b 94 24 60 02 00 	mov    0x260(%rsp),%rdx
  106e8d:	00 
  106e8e:	48 8b b4 24 40 01 00 	mov    0x140(%rsp),%rsi
  106e95:	00 
  106e96:	49 8d bf c8 35 00 00 	lea    0x35c8(%r15),%rdi
  106e9d:	e8 2e d3 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106ea2:	48 8b 94 24 20 02 00 	mov    0x220(%rsp),%rdx
  106ea9:	00 
  106eaa:	48 8b b4 24 28 01 00 	mov    0x128(%rsp),%rsi
  106eb1:	00 
  106eb2:	49 8d bf e8 35 00 00 	lea    0x35e8(%r15),%rdi
  106eb9:	e8 12 d3 ff ff       	call   1041d0 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<4, float, (glm::qualifier)0>*, std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  106ebe:	48 8b 94 24 68 02 00 	mov    0x268(%rsp),%rdx
  106ec5:	00 
  106ec6:	48 8b b4 24 20 01 00 	mov    0x120(%rsp),%rsi
  106ecd:	00 
  106ece:	49 8d bf 88 33 00 00 	lea    0x3388(%r15),%rdi
  106ed5:	e8 16 4d f6 ff       	call   6bbf0 <void thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::range_assign<__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > > >(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, __gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  106eda:	48 8b 94 24 d0 01 00 	mov    0x1d0(%rsp),%rdx
  106ee1:	00 
  106ee2:	48 8b b4 24 90 00 00 	mov    0x90(%rsp),%rsi
  106ee9:	00 
  106eea:	49 8d bf a8 33 00 00 	lea    0x33a8(%r15),%rdi
  106ef1:	e8 aa 45 f6 ff       	call   6b4a0 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::range_assign<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > > >(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  106ef6:	49 8b 8f 30 2c 00 00 	mov    0x2c30(%r15),%rcx
  106efd:	49 8b bf 10 2c 00 00 	mov    0x2c10(%r15),%rdi
  106f04:	49 89 9f 20 2b 00 00 	mov    %rbx,0x2b20(%r15)
  106f0b:	49 8b 87 d0 2b 00 00 	mov    0x2bd0(%r15),%rax
  106f12:	49 8b 97 c0 2b 00 00 	mov    0x2bc0(%r15),%rdx
  106f19:	49 89 9f 50 2b 00 00 	mov    %rbx,0x2b50(%r15)
  106f20:	66 48 0f 6e c1       	movq   %rcx,%xmm0
  106f25:	49 8b 8f 20 2c 00 00 	mov    0x2c20(%r15),%rcx
  106f2c:	48 89 7c 24 60       	mov    %rdi,0x60(%rsp)
  106f31:	0f 16 44 24 78       	movhps 0x78(%rsp),%xmm0
  106f36:	49 89 97 f8 2a 00 00 	mov    %rdx,0x2af8(%r15)
  106f3d:	49 89 8f 08 2b 00 00 	mov    %rcx,0x2b08(%r15)
  106f44:	49 8b 8f 00 2c 00 00 	mov    0x2c00(%r15),%rcx
  106f4b:	41 0f 11 87 10 2b 00 	movups %xmm0,0x2b10(%r15)
  106f52:	00 
  106f53:	66 48 0f 6e c7       	movq   %rdi,%xmm0
  106f58:	41 8b bf d0 00 00 00 	mov    0xd0(%r15),%edi
  106f5f:	0f 16 44 24 78       	movhps 0x78(%rsp),%xmm0
  106f64:	49 89 87 00 2b 00 00 	mov    %rax,0x2b00(%r15)
  106f6b:	49 89 97 28 2b 00 00 	mov    %rdx,0x2b28(%r15)
  106f72:	49 89 87 30 2b 00 00 	mov    %rax,0x2b30(%r15)
  106f79:	49 89 8f 38 2b 00 00 	mov    %rcx,0x2b38(%r15)
  106f80:	41 0f 11 87 40 2b 00 	movups %xmm0,0x2b40(%r15)
  106f87:	00 
  106f88:	85 ff                	test   %edi,%edi
  106f8a:	0f 85 2e 51 00 00    	jne    10c0be <synreal::SolverNewton::precompute_matrices()+0x7d4e>
  106f90:	41 8b 8f 98 03 00 00 	mov    0x398(%r15),%ecx
  106f97:	85 c9                	test   %ecx,%ecx
  106f99:	0f 85 1f 51 00 00    	jne    10c0be <synreal::SolverNewton::precompute_matrices()+0x7d4e>
  106f9f:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  106fa4:	31 f6                	xor    %esi,%esi
  106fa6:	31 c9                	xor    %ecx,%ecx
  106fa8:	31 d2                	xor    %edx,%edx
  106faa:	48 c7 80 58 2b 00 00 	movq   $0x0,0x2b58(%rax)
  106fb1:	00 00 00 00 
  106fb5:	48 c7 80 60 2b 00 00 	movq   $0x0,0x2b60(%rax)
  106fbc:	00 00 00 00 
  106fc0:	31 c0                	xor    %eax,%eax
  106fc2:	4c 8b 24 24          	mov    (%rsp),%r12
  106fc6:	48 8b 6c 24 78       	mov    0x78(%rsp),%rbp
  106fcb:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  106fd0:	49 0f af ec          	imul   %r12,%rbp
  106fd4:	49 89 b7 68 2b 00 00 	mov    %rsi,0x2b68(%r15)
  106fdb:	49 8d bf b8 2d 00 00 	lea    0x2db8(%r15),%rdi
  106fe2:	49 89 8f 70 2b 00 00 	mov    %rcx,0x2b70(%r15)
  106fe9:	49 89 97 78 2b 00 00 	mov    %rdx,0x2b78(%r15)
  106ff0:	48 89 ee             	mov    %rbp,%rsi
  106ff3:	49 89 87 80 2b 00 00 	mov    %rax,0x2b80(%r15)
  106ffa:	e8 71 57 f6 ff       	call   6c770 <thrust::THRUST_200302_520_NS::detail::vector_base<synreal::BlockNonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::BlockNonZeroEntry> >::resize(unsigned long)@plt>
  106fff:	49 8d bf d8 2d 00 00 	lea    0x2dd8(%r15),%rdi
  107006:	48 89 ee             	mov    %rbp,%rsi
  107009:	e8 62 57 f6 ff       	call   6c770 <thrust::THRUST_200302_520_NS::detail::vector_base<synreal::BlockNonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::BlockNonZeroEntry> >::resize(unsigned long)@plt>
  10700e:	49 8b 8f f0 2d 00 00 	mov    0x2df0(%r15),%rcx
  107015:	49 8b 97 f0 2b 00 00 	mov    0x2bf0(%r15),%rdx
  10701c:	4d 89 a7 b0 2b 00 00 	mov    %r12,0x2bb0(%r15)
  107023:	49 8b 87 e0 2d 00 00 	mov    0x2de0(%r15),%rax
  10702a:	66 48 0f 6e c1       	movq   %rcx,%xmm0
  10702f:	48 89 4c 24 60       	mov    %rcx,0x60(%rsp)
  107034:	49 8b 8f e0 2b 00 00 	mov    0x2be0(%r15),%rcx
  10703b:	0f 16 44 24 78       	movhps 0x78(%rsp),%xmm0
  107040:	49 89 97 90 2b 00 00 	mov    %rdx,0x2b90(%r15)
  107047:	49 89 8f 88 2b 00 00 	mov    %rcx,0x2b88(%r15)
  10704e:	49 89 87 98 2b 00 00 	mov    %rax,0x2b98(%r15)
  107055:	41 0f 11 87 a0 2b 00 	movups %xmm0,0x2ba0(%r15)
  10705c:	00 
  10705d:	48 85 db             	test   %rbx,%rbx
  107060:	0f 84 62 52 00 00    	je     10c2c8 <synreal::SolverNewton::precompute_matrices()+0x7f58>
  107066:	4c 8b 64 24 68       	mov    0x68(%rsp),%r12
  10706b:	4c 89 e7             	mov    %r12,%rdi
  10706e:	e8 dd 60 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  107073:	48 89 c5             	mov    %rax,%rbp
  107076:	4a 8d 04 20          	lea    (%rax,%r12,1),%rax
  10707a:	4c 89 e2             	mov    %r12,%rdx
  10707d:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  107082:	48 39 e8             	cmp    %rbp,%rax
  107085:	0f 84 3f 52 00 00    	je     10c2ca <synreal::SolverNewton::precompute_matrices()+0x7f5a>
  10708b:	31 f6                	xor    %esi,%esi
  10708d:	48 89 ef             	mov    %rbp,%rdi
  107090:	e8 8b 50 f6 ff       	call   6c120 <memset@plt>
  107095:	49 83 bf 10 01 00 00 	cmpq   $0x0,0x110(%r15)
  10709c:	00 
  10709d:	0f 85 c4 54 00 00    	jne    10c567 <synreal::SolverNewton::precompute_matrices()+0x81f7>
  1070a3:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  1070a8:	4c 8d bc 24 88 07 00 	lea    0x788(%rsp),%r15
  1070af:	00 
  1070b0:	c7 84 24 88 07 00 00 	movl   $0x0,0x788(%rsp)
  1070b7:	00 00 00 00 
  1070bb:	48 c7 84 24 90 07 00 	movq   $0x0,0x790(%rsp)
  1070c2:	00 00 00 00 00 
  1070c7:	4c 89 bc 24 98 07 00 	mov    %r15,0x798(%rsp)
  1070ce:	00 
  1070cf:	4c 89 bc 24 a0 07 00 	mov    %r15,0x7a0(%rsp)
  1070d6:	00 
  1070d7:	48 c7 84 24 a8 07 00 	movq   $0x0,0x7a8(%rsp)
  1070de:	00 00 00 00 00 
  1070e3:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
  1070e8:	48 8d 8c 24 80 07 00 	lea    0x780(%rsp),%rcx
  1070ef:	00 
  1070f0:	49 89 ec             	mov    %rbp,%r12
  1070f3:	31 c0                	xor    %eax,%eax
  1070f5:	48 c7 44 24 68 00 00 	movq   $0x0,0x68(%rsp)
  1070fc:	00 00 
  1070fe:	48 89 8c 24 c0 00 00 	mov    %rcx,0xc0(%rsp)
  107105:	00 
  107106:	48 85 c0             	test   %rax,%rax
  107109:	0f 84 f9 45 00 00    	je     10b708 <synreal::SolverNewton::precompute_matrices()+0x7398>
  10710f:	41 8b 34 24          	mov    (%r12),%esi
  107113:	4d 89 f8             	mov    %r15,%r8
  107116:	eb 12                	jmp    10712a <synreal::SolverNewton::precompute_matrices()+0x2dba>
  107118:	48 85 c9             	test   %rcx,%rcx
  10711b:	0f 84 a0 45 00 00    	je     10b6c1 <synreal::SolverNewton::precompute_matrices()+0x7351>
  107121:	48 89 ca             	mov    %rcx,%rdx
  107124:	49 89 c0             	mov    %rax,%r8
  107127:	48 89 d0             	mov    %rdx,%rax
  10712a:	48 8b 48 10          	mov    0x10(%rax),%rcx
  10712e:	48 8b 50 18          	mov    0x18(%rax),%rdx
  107132:	3b 70 20             	cmp    0x20(%rax),%esi
  107135:	7e e1                	jle    107118 <synreal::SolverNewton::precompute_matrices()+0x2da8>
  107137:	48 85 d2             	test   %rdx,%rdx
  10713a:	75 eb                	jne    107127 <synreal::SolverNewton::precompute_matrices()+0x2db7>
  10713c:	4d 39 f8             	cmp    %r15,%r8
  10713f:	74 0a                	je     10714b <synreal::SolverNewton::precompute_matrices()+0x2ddb>
  107141:	41 3b 70 20          	cmp    0x20(%r8),%esi
  107145:	0f 8d aa 00 00 00    	jge    1071f5 <synreal::SolverNewton::precompute_matrices()+0x2e85>
  10714b:	bf 28 00 00 00       	mov    $0x28,%edi
  107150:	4c 89 84 24 b8 00 00 	mov    %r8,0xb8(%rsp)
  107157:	00 
  107158:	e8 f3 5f f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  10715d:	41 8b 0c 24          	mov    (%r12),%ecx
  107161:	66 0f 6e 5c 24 68    	movd   0x68(%rsp),%xmm3
  107167:	48 8d 50 20          	lea    0x20(%rax),%rdx
  10716b:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  107170:	48 8b b4 24 b8 00 00 	mov    0xb8(%rsp),%rsi
  107177:	00 
  107178:	48 8b bc 24 c0 00 00 	mov    0xc0(%rsp),%rdi
  10717f:	00 
  107180:	66 0f 6e c1          	movd   %ecx,%xmm0
  107184:	89 8c 24 c8 00 00 00 	mov    %ecx,0xc8(%rsp)
  10718b:	66 0f 62 c3          	punpckldq %xmm3,%xmm0
  10718f:	66 0f d6 40 20       	movq   %xmm0,0x20(%rax)
  107194:	e8 f7 7c f6 ff       	call   6ee90 <std::_Rb_tree<int, std::pair<int const, int>, std::_Select1st<std::pair<int const, int> >, std::less<int>, std::allocator<std::pair<int const, int> > >::_M_get_insert_hint_unique_pos(std::_Rb_tree_const_iterator<std::pair<int const, int> >, int const&)@plt>
  107199:	4c 8b 44 24 68       	mov    0x68(%rsp),%r8
  10719e:	48 85 d2             	test   %rdx,%rdx
  1071a1:	0f 84 32 45 00 00    	je     10b6d9 <synreal::SolverNewton::precompute_matrices()+0x7369>
  1071a7:	48 85 c0             	test   %rax,%rax
  1071aa:	75 10                	jne    1071bc <synreal::SolverNewton::precompute_matrices()+0x2e4c>
  1071ac:	49 39 d7             	cmp    %rdx,%r15
  1071af:	8b 8c 24 c8 00 00 00 	mov    0xc8(%rsp),%ecx
  1071b6:	0f 85 13 52 00 00    	jne    10c3cf <synreal::SolverNewton::precompute_matrices()+0x805f>
  1071bc:	bf 01 00 00 00       	mov    $0x1,%edi
  1071c1:	4c 89 c6             	mov    %r8,%rsi
  1071c4:	4c 89 f9             	mov    %r15,%rcx
  1071c7:	4c 89 84 24 b8 00 00 	mov    %r8,0xb8(%rsp)
  1071ce:	00 
  1071cf:	e8 ac 41 f6 ff       	call   6b380 <std::_Rb_tree_insert_and_rebalance(bool, std::_Rb_tree_node_base*, std::_Rb_tree_node_base*, std::_Rb_tree_node_base&)@plt>
  1071d4:	48 8b 84 24 a8 07 00 	mov    0x7a8(%rsp),%rax
  1071db:	00 
  1071dc:	4c 8b 84 24 b8 00 00 	mov    0xb8(%rsp),%r8
  1071e3:	00 
  1071e4:	48 83 c0 01          	add    $0x1,%rax
  1071e8:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  1071ed:	48 89 84 24 a8 07 00 	mov    %rax,0x7a8(%rsp)
  1071f4:	00 
  1071f5:	41 8b 40 24          	mov    0x24(%r8),%eax
  1071f9:	49 83 c4 04          	add    $0x4,%r12
  1071fd:	41 89 44 24 fc       	mov    %eax,-0x4(%r12)
  107202:	4c 39 64 24 78       	cmp    %r12,0x78(%rsp)
  107207:	0f 84 03 45 00 00    	je     10b710 <synreal::SolverNewton::precompute_matrices()+0x73a0>
  10720d:	48 8b 84 24 90 07 00 	mov    0x790(%rsp),%rax
  107214:	00 
  107215:	e9 ec fe ff ff       	jmp    107106 <synreal::SolverNewton::precompute_matrices()+0x2d96>
  10721a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  107220:	48 89 d6             	mov    %rdx,%rsi
  107223:	e9 bc ef ff ff       	jmp    1061e4 <synreal::SolverNewton::precompute_matrices()+0x1e74>
  107228:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10722f:	00 
  107230:	48 89 d6             	mov    %rdx,%rsi
  107233:	e9 fc ee ff ff       	jmp    106134 <synreal::SolverNewton::precompute_matrices()+0x1dc4>
  107238:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10723f:	00 
  107240:	48 89 d6             	mov    %rdx,%rsi
  107243:	e9 8c ed ff ff       	jmp    105fd4 <synreal::SolverNewton::precompute_matrices()+0x1c64>
  107248:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10724f:	00 
  107250:	48 89 d6             	mov    %rdx,%rsi
  107253:	e9 2c ee ff ff       	jmp    106084 <synreal::SolverNewton::precompute_matrices()+0x1d14>
  107258:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10725f:	00 
  107260:	48 89 d6             	mov    %rdx,%rsi
  107263:	e9 ac ec ff ff       	jmp    105f14 <synreal::SolverNewton::precompute_matrices()+0x1ba4>
  107268:	48 89 ee             	mov    %rbp,%rsi
  10726b:	e9 6e ed ff ff       	jmp    105fde <synreal::SolverNewton::precompute_matrices()+0x1c6e>
  107270:	48 89 ee             	mov    %rbp,%rsi
  107273:	e9 a6 ec ff ff       	jmp    105f1e <synreal::SolverNewton::precompute_matrices()+0x1bae>
  107278:	48 89 ee             	mov    %rbp,%rsi
  10727b:	e9 6e ef ff ff       	jmp    1061ee <synreal::SolverNewton::precompute_matrices()+0x1e7e>
  107280:	48 89 ee             	mov    %rbp,%rsi
  107283:	e9 b6 ee ff ff       	jmp    10613e <synreal::SolverNewton::precompute_matrices()+0x1dce>
  107288:	48 89 ee             	mov    %rbp,%rsi
  10728b:	e9 fe ed ff ff       	jmp    10608e <synreal::SolverNewton::precompute_matrices()+0x1d1e>
  107290:	48 89 ee             	mov    %rbp,%rsi
  107293:	e9 12 eb ff ff       	jmp    105daa <synreal::SolverNewton::precompute_matrices()+0x1a3a>
  107298:	48 89 ee             	mov    %rbp,%rsi
  10729b:	e9 ca eb ff ff       	jmp    105e6a <synreal::SolverNewton::precompute_matrices()+0x1afa>
  1072a0:	48 c7 84 24 a0 02 00 	movq   $0x0,0x2a0(%rsp)
  1072a7:	00 00 00 00 00 
  1072ac:	48 c7 84 24 38 02 00 	movq   $0x0,0x238(%rsp)
  1072b3:	00 00 00 00 00 
  1072b8:	48 c7 84 24 18 01 00 	movq   $0x0,0x118(%rsp)
  1072bf:	00 00 00 00 00 
  1072c4:	48 c7 84 24 98 02 00 	movq   $0x0,0x298(%rsp)
  1072cb:	00 00 00 00 00 
  1072d0:	48 c7 84 24 70 02 00 	movq   $0x0,0x270(%rsp)
  1072d7:	00 00 00 00 00 
  1072dc:	48 c7 84 24 e8 00 00 	movq   $0x0,0xe8(%rsp)
  1072e3:	00 00 00 00 00 
  1072e8:	48 c7 84 24 10 02 00 	movq   $0x0,0x210(%rsp)
  1072ef:	00 00 00 00 00 
  1072f4:	e9 a6 d8 ff ff       	jmp    104b9f <synreal::SolverNewton::precompute_matrices()+0x82f>
  1072f9:	48 c7 84 24 a8 02 00 	movq   $0x0,0x2a8(%rsp)
  107300:	00 00 00 00 00 
  107305:	48 c7 84 24 48 02 00 	movq   $0x0,0x248(%rsp)
  10730c:	00 00 00 00 00 
  107311:	48 c7 84 24 38 01 00 	movq   $0x0,0x138(%rsp)
  107318:	00 00 00 00 00 
  10731d:	48 c7 84 24 90 02 00 	movq   $0x0,0x290(%rsp)
  107324:	00 00 00 00 00 
  107329:	48 c7 84 24 40 02 00 	movq   $0x0,0x240(%rsp)
  107330:	00 00 00 00 00 
  107335:	48 c7 84 24 e0 00 00 	movq   $0x0,0xe0(%rsp)
  10733c:	00 00 00 00 00 
  107341:	48 c7 84 24 50 02 00 	movq   $0x0,0x250(%rsp)
  107348:	00 00 00 00 00 
  10734d:	e9 62 d7 ff ff       	jmp    104ab4 <synreal::SolverNewton::precompute_matrices()+0x744>
  107352:	48 c7 84 24 b0 02 00 	movq   $0x0,0x2b0(%rsp)
  107359:	00 00 00 00 00 
  10735e:	48 c7 84 24 18 02 00 	movq   $0x0,0x218(%rsp)
  107365:	00 00 00 00 00 
  10736a:	48 c7 84 24 10 01 00 	movq   $0x0,0x110(%rsp)
  107371:	00 00 00 00 00 
  107376:	48 c7 84 24 b0 01 00 	movq   $0x0,0x1b0(%rsp)
  10737d:	00 00 00 00 00 
  107382:	48 c7 84 24 b8 02 00 	movq   $0x0,0x2b8(%rsp)
  107389:	00 00 00 00 00 
  10738e:	48 c7 84 24 28 02 00 	movq   $0x0,0x228(%rsp)
  107395:	00 00 00 00 00 
  10739a:	48 c7 84 24 08 01 00 	movq   $0x0,0x108(%rsp)
  1073a1:	00 00 00 00 00 
  1073a6:	48 c7 84 24 78 01 00 	movq   $0x0,0x178(%rsp)
  1073ad:	00 00 00 00 00 
  1073b2:	48 c7 84 24 78 02 00 	movq   $0x0,0x278(%rsp)
  1073b9:	00 00 00 00 00 
  1073be:	48 c7 84 24 f0 00 00 	movq   $0x0,0xf0(%rsp)
  1073c5:	00 00 00 00 00 
  1073ca:	48 c7 84 24 30 02 00 	movq   $0x0,0x230(%rsp)
  1073d1:	00 00 00 00 00 
  1073d6:	e9 34 d9 ff ff       	jmp    104d0f <synreal::SolverNewton::precompute_matrices()+0x99f>
  1073db:	48 c7 84 24 d0 02 00 	movq   $0x0,0x2d0(%rsp)
  1073e2:	00 00 00 00 00 
  1073e7:	48 c7 84 24 70 01 00 	movq   $0x0,0x170(%rsp)
  1073ee:	00 00 00 00 00 
  1073f3:	48 c7 84 24 00 02 00 	movq   $0x0,0x200(%rsp)
  1073fa:	00 00 00 00 00 
  1073ff:	48 c7 84 24 d0 00 00 	movq   $0x0,0xd0(%rsp)
  107406:	00 00 00 00 00 
  10740b:	48 c7 84 24 c8 02 00 	movq   $0x0,0x2c8(%rsp)
  107412:	00 00 00 00 00 
  107417:	48 c7 84 24 c0 01 00 	movq   $0x0,0x1c0(%rsp)
  10741e:	00 00 00 00 00 
  107423:	48 c7 84 24 08 02 00 	movq   $0x0,0x208(%rsp)
  10742a:	00 00 00 00 00 
  10742f:	48 c7 84 24 50 01 00 	movq   $0x0,0x150(%rsp)
  107436:	00 00 00 00 00 
  10743b:	48 c7 84 24 c0 02 00 	movq   $0x0,0x2c0(%rsp)
  107442:	00 00 00 00 00 
  107447:	48 c7 84 24 58 02 00 	movq   $0x0,0x258(%rsp)
  10744e:	00 00 00 00 00 
  107453:	48 c7 84 24 48 01 00 	movq   $0x0,0x148(%rsp)
  10745a:	00 00 00 00 00 
  10745f:	48 c7 84 24 e8 01 00 	movq   $0x0,0x1e8(%rsp)
  107466:	00 00 00 00 00 
  10746b:	48 c7 84 24 d8 02 00 	movq   $0x0,0x2d8(%rsp)
  107472:	00 00 00 00 00 
  107477:	48 c7 84 24 c8 01 00 	movq   $0x0,0x1c8(%rsp)
  10747e:	00 00 00 00 00 
  107483:	48 c7 84 24 60 02 00 	movq   $0x0,0x260(%rsp)
  10748a:	00 00 00 00 00 
  10748f:	48 c7 84 24 40 01 00 	movq   $0x0,0x140(%rsp)
  107496:	00 00 00 00 00 
  10749b:	48 c7 84 24 80 02 00 	movq   $0x0,0x280(%rsp)
  1074a2:	00 00 00 00 00 
  1074a7:	48 c7 84 24 28 01 00 	movq   $0x0,0x128(%rsp)
  1074ae:	00 00 00 00 00 
  1074b3:	48 c7 84 24 20 02 00 	movq   $0x0,0x220(%rsp)
  1074ba:	00 00 00 00 00 
  1074bf:	e9 b9 da ff ff       	jmp    104f7d <synreal::SolverNewton::precompute_matrices()+0xc0d>
  1074c4:	4d 89 c8             	mov    %r9,%r8
  1074c7:	e9 1e e1 ff ff       	jmp    1055ea <synreal::SolverNewton::precompute_matrices()+0x127a>
  1074cc:	4c 89 c6             	mov    %r8,%rsi
  1074cf:	e9 65 e0 ff ff       	jmp    105539 <synreal::SolverNewton::precompute_matrices()+0x11c9>
  1074d4:	49 89 f8             	mov    %rdi,%r8
  1074d7:	e9 b6 df ff ff       	jmp    105492 <synreal::SolverNewton::precompute_matrices()+0x1122>
  1074dc:	48 c7 84 24 90 00 00 	movq   $0x0,0x90(%rsp)
  1074e3:	00 00 00 00 00 
  1074e8:	48 c7 84 24 d0 01 00 	movq   $0x0,0x1d0(%rsp)
  1074ef:	00 00 00 00 00 
  1074f4:	e9 27 db ff ff       	jmp    105020 <synreal::SolverNewton::precompute_matrices()+0xcb0>
  1074f9:	48 c7 84 24 88 02 00 	movq   $0x0,0x288(%rsp)
  107500:	00 00 00 00 00 
  107505:	48 c7 84 24 20 01 00 	movq   $0x0,0x120(%rsp)
  10750c:	00 00 00 00 00 
  107511:	48 c7 84 24 68 02 00 	movq   $0x0,0x268(%rsp)
  107518:	00 00 00 00 00 
  10751d:	e9 c0 da ff ff       	jmp    104fe2 <synreal::SolverNewton::precompute_matrices()+0xc72>
  107522:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  107527:	89 c1                	mov    %eax,%ecx
  107529:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  107530:	00 
  107531:	4c 8d 05 95 3a 0e 00 	lea    0xe3a95(%rip),%r8        # 1eafcd <_fini+0x5889>
  107538:	4c 89 f7             	mov    %r14,%rdi
  10753b:	49 8b b7 d0 03 00 00 	mov    0x3d0(%r15),%rsi
  107542:	49 8b 97 d8 03 00 00 	mov    0x3d8(%r15),%rdx
  107549:	e8 a2 80 f6 ff       	call   6f5f0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10754e:	41 8b 8f 98 03 00 00 	mov    0x398(%r15),%ecx
  107555:	49 8b b7 a0 03 00 00 	mov    0x3a0(%r15),%rsi
  10755c:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  107563:	00 
  107564:	4c 8d 05 2b 3a 0e 00 	lea    0xe3a2b(%rip),%r8        # 1eaf96 <_fini+0x5852>
  10756b:	49 8b 97 a8 03 00 00 	mov    0x3a8(%r15),%rdx
  107572:	e8 49 67 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  107577:	45 8b 9f 98 03 00 00 	mov    0x398(%r15),%r11d
  10757e:	45 85 db             	test   %r11d,%r11d
  107581:	0f 84 a2 04 00 00    	je     107a29 <synreal::SolverNewton::precompute_matrices()+0x36b9>
  107587:	48 c7 84 24 b8 00 00 	movq   $0x0,0xb8(%rsp)
  10758e:	00 00 00 00 00 
  107593:	66 0f ef f6          	pxor   %xmm6,%xmm6
  107597:	f3 0f 11 74 24 48    	movss  %xmm6,0x48(%rsp)
  10759d:	48 8b 84 24 80 07 00 	mov    0x780(%rsp),%rax
  1075a4:	00 
  1075a5:	48 8b 8c 24 b8 00 00 	mov    0xb8(%rsp),%rcx
  1075ac:	00 
  1075ad:	f3 0f 10 2c 88       	movss  (%rax,%rcx,4),%xmm5
  1075b2:	0f 2f 6c 24 48       	comiss 0x48(%rsp),%xmm5
  1075b7:	f3 0f 11 2c 24       	movss  %xmm5,(%rsp)
  1075bc:	0f 86 93 0b f7 ff    	jbe    78155 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xcb3>
  1075c2:	f3 0f 10 05 c2 81 0e 	movss  0xe81c2(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  1075c9:	00 
  1075ca:	0f 28 cd             	movaps %xmm5,%xmm1
  1075cd:	0f 54 0d cc 81 0e 00 	andps  0xe81cc(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1075d4:	0f 2e c1             	ucomiss %xmm1,%xmm0
  1075d7:	0f 82 78 0b f7 ff    	jb     78155 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xcb3>
  1075dd:	48 89 c8             	mov    %rcx,%rax
  1075e0:	4c 8d bc 24 e0 07 00 	lea    0x7e0(%rsp),%r15
  1075e7:	00 
  1075e8:	4c 8d 2d 35 00 0f 00 	lea    0xf0035(%rip),%r13        # 1f7624 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7724>
  1075ef:	48 c1 e0 04          	shl    $0x4,%rax
  1075f3:	48 03 84 24 60 07 00 	add    0x760(%rsp),%rax
  1075fa:	00 
  1075fb:	f3 0f 6f 30          	movdqu (%rax),%xmm6
  1075ff:	48 8d 84 24 d0 07 00 	lea    0x7d0(%rsp),%rax
  107606:	00 
  107607:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  10760c:	49 89 c4             	mov    %rax,%r12
  10760f:	0f 29 b4 24 d0 07 00 	movaps %xmm6,0x7d0(%rsp)
  107616:	00 
  107617:	49 63 2c 24          	movslq (%r12),%rbp
  10761b:	4c 89 ea             	mov    %r13,%rdx
  10761e:	48 89 de             	mov    %rbx,%rsi
  107621:	89 ef                	mov    %ebp,%edi
  107623:	e8 78 3c f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  107628:	48 8b 84 24 90 00 00 	mov    0x90(%rsp),%rax
  10762f:	00 
  107630:	49 83 c4 04          	add    $0x4,%r12
  107634:	c7 04 a8 01 00 00 00 	movl   $0x1,(%rax,%rbp,4)
  10763b:	4d 39 fc             	cmp    %r15,%r12
  10763e:	75 d7                	jne    107617 <synreal::SolverNewton::precompute_matrices()+0x32a7>
  107640:	48 89 c7             	mov    %rax,%rdi
  107643:	48 63 84 24 d4 07 00 	movslq 0x7d4(%rsp),%rax
  10764a:	00 
  10764b:	f3 0f 10 34 24       	movss  (%rsp),%xmm6
  107650:	48 c7 44 24 60 01 00 	movq   $0x1,0x60(%rsp)
  107657:	00 00 
  107659:	f3 0f 59 35 23 09 0f 	mulss  0xf0923(%rip),%xmm6        # 1f7f84 <cuda::std::__4::in_place+0x37>
  107660:	00 
  107661:	44 8b bc 24 b8 00 00 	mov    0xb8(%rsp),%r15d
  107668:	00 
  107669:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  107670:	00 
  107671:	c7 04 87 02 00 00 00 	movl   $0x2,(%rdi,%rax,4)
  107678:	48 63 84 24 d8 07 00 	movslq 0x7d8(%rsp),%rax
  10767f:	00 
  107680:	c7 04 87 02 00 00 00 	movl   $0x2,(%rdi,%rax,4)
  107687:	48 63 84 24 dc 07 00 	movslq 0x7dc(%rsp),%rax
  10768e:	00 
  10768f:	c7 04 87 02 00 00 00 	movl   $0x2,(%rdi,%rax,4)
  107696:	48 8d 84 24 d4 07 00 	lea    0x7d4(%rsp),%rax
  10769d:	00 
  10769e:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
  1076a3:	f3 0f 11 b4 24 c0 00 	movss  %xmm6,0xc0(%rsp)
  1076aa:	00 00 
  1076ac:	48 8b 6c 24 78       	mov    0x78(%rsp),%rbp
  1076b1:	48 8b bc 24 88 00 00 	mov    0x88(%rsp),%rdi
  1076b8:	00 
  1076b9:	44 89 bc 24 40 07 00 	mov    %r15d,0x740(%rsp)
  1076c0:	00 
  1076c1:	f3 0f 10 84 24 c0 00 	movss  0xc0(%rsp),%xmm0
  1076c8:	00 00 
  1076ca:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
  1076cf:	48 63 45 00          	movslq 0x0(%rbp),%rax
  1076d3:	49 89 ec             	mov    %rbp,%r12
  1076d6:	48 8d 14 87          	lea    (%rdi,%rax,4),%rdx
  1076da:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  1076de:	f3 0f 58 02          	addss  (%rdx),%xmm0
  1076e2:	48 8d 3c c6          	lea    (%rsi,%rax,8),%rdi
  1076e6:	4c 89 ee             	mov    %r13,%rsi
  1076e9:	f3 0f 11 02          	movss  %xmm0,(%rdx)
  1076ed:	e8 9e 71 f6 ff       	call   6e890 <int& std::vector<int, std::allocator<int> >::emplace_back<int>(int&&)@plt>
  1076f2:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
  1076f7:	48 83 ff 03          	cmp    $0x3,%rdi
  1076fb:	0f 84 b2 02 00 00    	je     1079b3 <synreal::SolverNewton::precompute_matrices()+0x3643>
  107701:	b8 02 00 00 00       	mov    $0x2,%eax
  107706:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  10770b:	48 83 c5 04          	add    $0x4,%rbp
  10770f:	29 f8                	sub    %edi,%eax
  107711:	48 89 6c 24 78       	mov    %rbp,0x78(%rsp)
  107716:	48 01 f8             	add    %rdi,%rax
  107719:	48 8d 44 86 08       	lea    0x8(%rsi,%rax,4),%rax
  10771e:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
  107723:	48 8d 84 24 20 03 00 	lea    0x320(%rsp),%rax
  10772a:	00 
  10772b:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  107732:	00 
  107733:	49 63 04 24          	movslq (%r12),%rax
  107737:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
  10773b:	49 c1 e1 04          	shl    $0x4,%r9
  10773f:	4c 03 4c 24 50       	add    0x50(%rsp),%r9
  107744:	49 8b 51 10          	mov    0x10(%r9),%rdx
  107748:	49 8d 41 08          	lea    0x8(%r9),%rax
  10774c:	48 85 d2             	test   %rdx,%rdx
  10774f:	0f 84 3b 03 00 00    	je     107a90 <synreal::SolverNewton::precompute_matrices()+0x3720>
  107755:	48 63 7d 00          	movslq 0x0(%rbp),%rdi
  107759:	49 89 c0             	mov    %rax,%r8
  10775c:	0f 1f 40 00          	nopl   0x0(%rax)
  107760:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  107764:	48 8b 72 18          	mov    0x18(%rdx),%rsi
  107768:	3b 7a 20             	cmp    0x20(%rdx),%edi
  10776b:	7f 18                	jg     107785 <synreal::SolverNewton::precompute_matrices()+0x3415>
  10776d:	49 89 d0             	mov    %rdx,%r8
  107770:	48 85 c9             	test   %rcx,%rcx
  107773:	74 1a                	je     10778f <synreal::SolverNewton::precompute_matrices()+0x341f>
  107775:	48 89 ca             	mov    %rcx,%rdx
  107778:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  10777c:	48 8b 72 18          	mov    0x18(%rdx),%rsi
  107780:	3b 7a 20             	cmp    0x20(%rdx),%edi
  107783:	7e e8                	jle    10776d <synreal::SolverNewton::precompute_matrices()+0x33fd>
  107785:	48 85 f6             	test   %rsi,%rsi
  107788:	74 05                	je     10778f <synreal::SolverNewton::precompute_matrices()+0x341f>
  10778a:	48 89 f2             	mov    %rsi,%rdx
  10778d:	eb d1                	jmp    107760 <synreal::SolverNewton::precompute_matrices()+0x33f0>
  10778f:	49 39 c0             	cmp    %rax,%r8
  107792:	74 06                	je     10779a <synreal::SolverNewton::precompute_matrices()+0x342a>
  107794:	41 3b 78 20          	cmp    0x20(%r8),%edi
  107798:	7d 22                	jge    1077bc <synreal::SolverNewton::precompute_matrices()+0x344c>
  10779a:	48 8b 94 24 a8 00 00 	mov    0xa8(%rsp),%rdx
  1077a1:	00 
  1077a2:	4c 89 c6             	mov    %r8,%rsi
  1077a5:	4c 89 cf             	mov    %r9,%rdi
  1077a8:	48 89 ac 24 20 03 00 	mov    %rbp,0x320(%rsp)
  1077af:	00 
  1077b0:	e8 cb 92 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  1077b5:	48 63 7d 00          	movslq 0x0(%rbp),%rdi
  1077b9:	49 89 c0             	mov    %rax,%r8
  1077bc:	48 8d 04 7f          	lea    (%rdi,%rdi,2),%rax
  1077c0:	48 8b 74 24 50       	mov    0x50(%rsp),%rsi
  1077c5:	f3 41 0f 10 40 24    	movss  0x24(%r8),%xmm0
  1077cb:	48 c1 e0 04          	shl    $0x4,%rax
  1077cf:	f3 0f 5c 04 24       	subss  (%rsp),%xmm0
  1077d4:	4c 8d 0c 06          	lea    (%rsi,%rax,1),%r9
  1077d8:	49 8b 41 10          	mov    0x10(%r9),%rax
  1077dc:	49 8d 79 08          	lea    0x8(%r9),%rdi
  1077e0:	f3 41 0f 11 40 24    	movss  %xmm0,0x24(%r8)
  1077e6:	48 85 c0             	test   %rax,%rax
  1077e9:	0f 84 b1 02 00 00    	je     107aa0 <synreal::SolverNewton::precompute_matrices()+0x3730>
  1077ef:	49 63 34 24          	movslq (%r12),%rsi
  1077f3:	49 89 f8             	mov    %rdi,%r8
  1077f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1077fd:	00 00 00 
  107800:	48 8b 50 10          	mov    0x10(%rax),%rdx
  107804:	48 8b 48 18          	mov    0x18(%rax),%rcx
  107808:	3b 70 20             	cmp    0x20(%rax),%esi
  10780b:	7f 18                	jg     107825 <synreal::SolverNewton::precompute_matrices()+0x34b5>
  10780d:	49 89 c0             	mov    %rax,%r8
  107810:	48 85 d2             	test   %rdx,%rdx
  107813:	74 1a                	je     10782f <synreal::SolverNewton::precompute_matrices()+0x34bf>
  107815:	48 89 d0             	mov    %rdx,%rax
  107818:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10781c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  107820:	3b 70 20             	cmp    0x20(%rax),%esi
  107823:	7e e8                	jle    10780d <synreal::SolverNewton::precompute_matrices()+0x349d>
  107825:	48 85 c9             	test   %rcx,%rcx
  107828:	74 05                	je     10782f <synreal::SolverNewton::precompute_matrices()+0x34bf>
  10782a:	48 89 c8             	mov    %rcx,%rax
  10782d:	eb d1                	jmp    107800 <synreal::SolverNewton::precompute_matrices()+0x3490>
  10782f:	49 39 f8             	cmp    %rdi,%r8
  107832:	74 06                	je     10783a <synreal::SolverNewton::precompute_matrices()+0x34ca>
  107834:	41 3b 70 20          	cmp    0x20(%r8),%esi
  107838:	7d 22                	jge    10785c <synreal::SolverNewton::precompute_matrices()+0x34ec>
  10783a:	48 8d 94 24 28 03 00 	lea    0x328(%rsp),%rdx
  107841:	00 
  107842:	4c 89 c6             	mov    %r8,%rsi
  107845:	4c 89 cf             	mov    %r9,%rdi
  107848:	4c 89 a4 24 28 03 00 	mov    %r12,0x328(%rsp)
  10784f:	00 
  107850:	e8 2b 92 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  107855:	49 63 34 24          	movslq (%r12),%rsi
  107859:	49 89 c0             	mov    %rax,%r8
  10785c:	48 8d 3c 76          	lea    (%rsi,%rsi,2),%rdi
  107860:	f3 41 0f 10 40 24    	movss  0x24(%r8),%xmm0
  107866:	f3 0f 5c 04 24       	subss  (%rsp),%xmm0
  10786b:	48 c1 e7 04          	shl    $0x4,%rdi
  10786f:	48 03 7c 24 20       	add    0x20(%rsp),%rdi
  107874:	48 8b 57 10          	mov    0x10(%rdi),%rdx
  107878:	4c 8d 4f 08          	lea    0x8(%rdi),%r9
  10787c:	f3 41 0f 11 40 24    	movss  %xmm0,0x24(%r8)
  107882:	48 85 d2             	test   %rdx,%rdx
  107885:	0f 84 1d 02 00 00    	je     107aa8 <synreal::SolverNewton::precompute_matrices()+0x3738>
  10788b:	8b 45 00             	mov    0x0(%rbp),%eax
  10788e:	4d 89 c8             	mov    %r9,%r8
  107891:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  107898:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  10789c:	48 8b 72 18          	mov    0x18(%rdx),%rsi
  1078a0:	3b 42 20             	cmp    0x20(%rdx),%eax
  1078a3:	7f 18                	jg     1078bd <synreal::SolverNewton::precompute_matrices()+0x354d>
  1078a5:	49 89 d0             	mov    %rdx,%r8
  1078a8:	48 85 c9             	test   %rcx,%rcx
  1078ab:	74 1a                	je     1078c7 <synreal::SolverNewton::precompute_matrices()+0x3557>
  1078ad:	48 89 ca             	mov    %rcx,%rdx
  1078b0:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  1078b4:	48 8b 72 18          	mov    0x18(%rdx),%rsi
  1078b8:	3b 42 20             	cmp    0x20(%rdx),%eax
  1078bb:	7e e8                	jle    1078a5 <synreal::SolverNewton::precompute_matrices()+0x3535>
  1078bd:	48 85 f6             	test   %rsi,%rsi
  1078c0:	74 05                	je     1078c7 <synreal::SolverNewton::precompute_matrices()+0x3557>
  1078c2:	48 89 f2             	mov    %rsi,%rdx
  1078c5:	eb d1                	jmp    107898 <synreal::SolverNewton::precompute_matrices()+0x3528>
  1078c7:	4d 39 c8             	cmp    %r9,%r8
  1078ca:	74 06                	je     1078d2 <synreal::SolverNewton::precompute_matrices()+0x3562>
  1078cc:	41 3b 40 20          	cmp    0x20(%r8),%eax
  1078d0:	7d 1b                	jge    1078ed <synreal::SolverNewton::precompute_matrices()+0x357d>
  1078d2:	48 8d 94 24 30 03 00 	lea    0x330(%rsp),%rdx
  1078d9:	00 
  1078da:	4c 89 c6             	mov    %r8,%rsi
  1078dd:	48 89 ac 24 30 03 00 	mov    %rbp,0x330(%rsp)
  1078e4:	00 
  1078e5:	e8 36 94 fe ff       	call   f0d20 <std::_Rb_tree_iterator<std::pair<int const, std::vector<int, std::allocator<int> > > > std::_Rb_tree<int, std::pair<int const, std::vector<int, std::allocator<int> > >, std::_Select1st<std::pair<int const, std::vector<int, std::allocator<int> > > >, std::less<int>, std::allocator<std::pair<int const, std::vector<int, std::allocator<int> > > > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, std::vector<int, std::allocator<int> > > >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  1078ea:	49 89 c0             	mov    %rax,%r8
  1078ed:	49 8d 78 28          	lea    0x28(%r8),%rdi
  1078f1:	4c 89 ee             	mov    %r13,%rsi
  1078f4:	44 89 bc 24 40 07 00 	mov    %r15d,0x740(%rsp)
  1078fb:	00 
  1078fc:	e8 8f 6f f6 ff       	call   6e890 <int& std::vector<int, std::allocator<int> >::emplace_back<int>(int&&)@plt>
  107901:	48 63 45 00          	movslq 0x0(%rbp),%rax
  107905:	48 8d 3c 40          	lea    (%rax,%rax,2),%rdi
  107909:	48 c1 e7 04          	shl    $0x4,%rdi
  10790d:	48 03 7c 24 20       	add    0x20(%rsp),%rdi
  107912:	48 8b 57 10          	mov    0x10(%rdi),%rdx
  107916:	4c 8d 4f 08          	lea    0x8(%rdi),%r9
  10791a:	48 85 d2             	test   %rdx,%rdx
  10791d:	0f 84 75 01 00 00    	je     107a98 <synreal::SolverNewton::precompute_matrices()+0x3728>
  107923:	41 8b 04 24          	mov    (%r12),%eax
  107927:	4d 89 c8             	mov    %r9,%r8
  10792a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  107930:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  107934:	48 8b 72 18          	mov    0x18(%rdx),%rsi
  107938:	3b 42 20             	cmp    0x20(%rdx),%eax
  10793b:	7f 18                	jg     107955 <synreal::SolverNewton::precompute_matrices()+0x35e5>
  10793d:	49 89 d0             	mov    %rdx,%r8
  107940:	48 85 c9             	test   %rcx,%rcx
  107943:	74 1a                	je     10795f <synreal::SolverNewton::precompute_matrices()+0x35ef>
  107945:	48 89 ca             	mov    %rcx,%rdx
  107948:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
  10794c:	48 8b 72 18          	mov    0x18(%rdx),%rsi
  107950:	3b 42 20             	cmp    0x20(%rdx),%eax
  107953:	7e e8                	jle    10793d <synreal::SolverNewton::precompute_matrices()+0x35cd>
  107955:	48 85 f6             	test   %rsi,%rsi
  107958:	74 05                	je     10795f <synreal::SolverNewton::precompute_matrices()+0x35ef>
  10795a:	48 89 f2             	mov    %rsi,%rdx
  10795d:	eb d1                	jmp    107930 <synreal::SolverNewton::precompute_matrices()+0x35c0>
  10795f:	4d 39 c8             	cmp    %r9,%r8
  107962:	74 06                	je     10796a <synreal::SolverNewton::precompute_matrices()+0x35fa>
  107964:	41 3b 40 20          	cmp    0x20(%r8),%eax
  107968:	7d 1b                	jge    107985 <synreal::SolverNewton::precompute_matrices()+0x3615>
  10796a:	48 8d 94 24 38 03 00 	lea    0x338(%rsp),%rdx
  107971:	00 
  107972:	4c 89 c6             	mov    %r8,%rsi
  107975:	4c 89 a4 24 38 03 00 	mov    %r12,0x338(%rsp)
  10797c:	00 
  10797d:	e8 9e 93 fe ff       	call   f0d20 <std::_Rb_tree_iterator<std::pair<int const, std::vector<int, std::allocator<int> > > > std::_Rb_tree<int, std::pair<int const, std::vector<int, std::allocator<int> > >, std::_Select1st<std::pair<int const, std::vector<int, std::allocator<int> > > >, std::less<int>, std::allocator<std::pair<int const, std::vector<int, std::allocator<int> > > > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, std::vector<int, std::allocator<int> > > >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  107982:	49 89 c0             	mov    %rax,%r8
  107985:	49 8d 78 28          	lea    0x28(%r8),%rdi
  107989:	4c 89 ee             	mov    %r13,%rsi
  10798c:	44 89 bc 24 40 07 00 	mov    %r15d,0x740(%rsp)
  107993:	00 
  107994:	e8 f7 6e f6 ff       	call   6e890 <int& std::vector<int, std::allocator<int> >::emplace_back<int>(int&&)@plt>
  107999:	48 83 c5 04          	add    $0x4,%rbp
  10799d:	48 39 6c 24 38       	cmp    %rbp,0x38(%rsp)
  1079a2:	0f 85 8b fd ff ff    	jne    107733 <synreal::SolverNewton::precompute_matrices()+0x33c3>
  1079a8:	48 83 44 24 60 01    	addq   $0x1,0x60(%rsp)
  1079ae:	e9 f9 fc ff ff       	jmp    1076ac <synreal::SolverNewton::precompute_matrices()+0x333c>
  1079b3:	48 8b b4 24 b0 00 00 	mov    0xb0(%rsp),%rsi
  1079ba:	00 
  1079bb:	f3 0f 10 3c 24       	movss  (%rsp),%xmm7
  1079c0:	48 63 84 24 d4 07 00 	movslq 0x7d4(%rsp),%rax
  1079c7:	00 
  1079c8:	48 83 84 24 b8 00 00 	addq   $0x1,0xb8(%rsp)
  1079cf:	00 01 
  1079d1:	48 8b 8c 24 b8 00 00 	mov    0xb8(%rsp),%rcx
  1079d8:	00 
  1079d9:	48 8d 04 86          	lea    (%rsi,%rax,4),%rax
  1079dd:	f3 0f 10 00          	movss  (%rax),%xmm0
  1079e1:	f3 0f 58 c7          	addss  %xmm7,%xmm0
  1079e5:	f3 0f 11 00          	movss  %xmm0,(%rax)
  1079e9:	48 63 84 24 d8 07 00 	movslq 0x7d8(%rsp),%rax
  1079f0:	00 
  1079f1:	48 8d 04 86          	lea    (%rsi,%rax,4),%rax
  1079f5:	f3 0f 10 00          	movss  (%rax),%xmm0
  1079f9:	f3 0f 58 c7          	addss  %xmm7,%xmm0
  1079fd:	f3 0f 11 00          	movss  %xmm0,(%rax)
  107a01:	48 63 84 24 dc 07 00 	movslq 0x7dc(%rsp),%rax
  107a08:	00 
  107a09:	48 8d 04 86          	lea    (%rsi,%rax,4),%rax
  107a0d:	f3 0f 58 38          	addss  (%rax),%xmm7
  107a11:	f3 0f 11 38          	movss  %xmm7,(%rax)
  107a15:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  107a1a:	8b 80 98 03 00 00    	mov    0x398(%rax),%eax
  107a20:	48 39 c8             	cmp    %rcx,%rax
  107a23:	0f 87 74 fb ff ff    	ja     10759d <synreal::SolverNewton::precompute_matrices()+0x322d>
  107a29:	48 8b bc 24 80 07 00 	mov    0x780(%rsp),%rdi
  107a30:	00 
  107a31:	48 85 ff             	test   %rdi,%rdi
  107a34:	74 10                	je     107a46 <synreal::SolverNewton::precompute_matrices()+0x36d6>
  107a36:	48 8b b4 24 90 07 00 	mov    0x790(%rsp),%rsi
  107a3d:	00 
  107a3e:	48 29 fe             	sub    %rdi,%rsi
  107a41:	e8 6a 57 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  107a46:	48 8b bc 24 60 07 00 	mov    0x760(%rsp),%rdi
  107a4d:	00 
  107a4e:	48 85 ff             	test   %rdi,%rdi
  107a51:	74 10                	je     107a63 <synreal::SolverNewton::precompute_matrices()+0x36f3>
  107a53:	48 8b b4 24 70 07 00 	mov    0x770(%rsp),%rsi
  107a5a:	00 
  107a5b:	48 29 fe             	sub    %rdi,%rsi
  107a5e:	e8 4d 57 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  107a63:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  107a68:	44 8b b8 d0 00 00 00 	mov    0xd0(%rax),%r15d
  107a6f:	45 85 ff             	test   %r15d,%r15d
  107a72:	0f 85 26 d6 ff ff    	jne    10509e <synreal::SolverNewton::precompute_matrices()+0xd2e>
  107a78:	44 8b 90 98 03 00 00 	mov    0x398(%rax),%r10d
  107a7f:	45 85 d2             	test   %r10d,%r10d
  107a82:	0f 85 16 d6 ff ff    	jne    10509e <synreal::SolverNewton::precompute_matrices()+0xd2e>
  107a88:	e9 dd db ff ff       	jmp    10566a <synreal::SolverNewton::precompute_matrices()+0x12fa>
  107a8d:	0f 1f 00             	nopl   (%rax)
  107a90:	49 89 c0             	mov    %rax,%r8
  107a93:	e9 02 fd ff ff       	jmp    10779a <synreal::SolverNewton::precompute_matrices()+0x342a>
  107a98:	4d 89 c8             	mov    %r9,%r8
  107a9b:	e9 ca fe ff ff       	jmp    10796a <synreal::SolverNewton::precompute_matrices()+0x35fa>
  107aa0:	49 89 f8             	mov    %rdi,%r8
  107aa3:	e9 92 fd ff ff       	jmp    10783a <synreal::SolverNewton::precompute_matrices()+0x34ca>
  107aa8:	4d 89 c8             	mov    %r9,%r8
  107aab:	e9 22 fe ff ff       	jmp    1078d2 <synreal::SolverNewton::precompute_matrices()+0x3562>
  107ab0:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  107ab5:	41 89 c6             	mov    %eax,%r14d
  107ab8:	48 8d bc 24 a0 06 00 	lea    0x6a0(%rsp),%rdi
  107abf:	00 
  107ac0:	4c 8d 05 62 36 0e 00 	lea    0xe3662(%rip),%r8        # 1eb129 <_fini+0x59e5>
  107ac7:	4c 89 f1             	mov    %r14,%rcx
  107aca:	4c 89 74 24 60       	mov    %r14,0x60(%rsp)
  107acf:	41 8b 87 9c 04 00 00 	mov    0x49c(%r15),%eax
  107ad6:	49 8b b7 a0 04 00 00 	mov    0x4a0(%r15),%rsi
  107add:	49 8b 97 a8 04 00 00 	mov    0x4a8(%r15),%rdx
  107ae4:	49 29 c6             	sub    %rax,%r14
  107ae7:	4c 89 74 24 38       	mov    %r14,0x38(%rsp)
  107aec:	49 89 ce             	mov    %rcx,%r14
  107aef:	e8 1c 56 f6 ff       	call   6d110 <std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<2, int, (glm::qualifier)0> >(synreal::Span<glm::vec<2, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  107af4:	49 8b b7 b0 04 00 00 	mov    0x4b0(%r15),%rsi
  107afb:	49 8b 97 b8 04 00 00 	mov    0x4b8(%r15),%rdx
  107b02:	4c 89 f1             	mov    %r14,%rcx
  107b05:	48 8d bc 24 c0 06 00 	lea    0x6c0(%rsp),%rdi
  107b0c:	00 
  107b0d:	4c 8d 05 29 36 0e 00 	lea    0xe3629(%rip),%r8        # 1eb13d <_fini+0x59f9>
  107b14:	e8 97 52 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  107b19:	49 8b b7 c0 04 00 00 	mov    0x4c0(%r15),%rsi
  107b20:	49 8b 97 c8 04 00 00 	mov    0x4c8(%r15),%rdx
  107b27:	4c 89 f1             	mov    %r14,%rcx
  107b2a:	48 8d bc 24 e0 06 00 	lea    0x6e0(%rsp),%rdi
  107b31:	00 
  107b32:	4c 8d 05 18 36 0e 00 	lea    0xe3618(%rip),%r8        # 1eb151 <_fini+0x5a0d>
  107b39:	e8 72 52 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  107b3e:	49 8b b7 d0 04 00 00 	mov    0x4d0(%r15),%rsi
  107b45:	49 8b 97 d8 04 00 00 	mov    0x4d8(%r15),%rdx
  107b4c:	4c 89 f1             	mov    %r14,%rcx
  107b4f:	48 8d bc 24 00 07 00 	lea    0x700(%rsp),%rdi
  107b56:	00 
  107b57:	4c 8d 05 07 36 0e 00 	lea    0xe3607(%rip),%r8        # 1eb165 <_fini+0x5a21>
  107b5e:	e8 5d 61 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  107b63:	49 8b b7 e0 04 00 00 	mov    0x4e0(%r15),%rsi
  107b6a:	49 8b 97 e8 04 00 00 	mov    0x4e8(%r15),%rdx
  107b71:	4c 89 f1             	mov    %r14,%rcx
  107b74:	48 8d bc 24 20 07 00 	lea    0x720(%rsp),%rdi
  107b7b:	00 
  107b7c:	4c 8d 05 fa 35 0e 00 	lea    0xe35fa(%rip),%r8        # 1eb17d <_fini+0x5a39>
  107b83:	e8 38 61 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  107b88:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  107b8f:	00 
  107b90:	41 8b 8f 98 03 00 00 	mov    0x398(%r15),%ecx
  107b97:	49 8b b7 d0 03 00 00 	mov    0x3d0(%r15),%rsi
  107b9e:	4c 8d 05 28 34 0e 00 	lea    0xe3428(%rip),%r8        # 1eafcd <_fini+0x5889>
  107ba5:	49 8b 97 d8 03 00 00 	mov    0x3d8(%r15),%rdx
  107bac:	4c 89 ef             	mov    %r13,%rdi
  107baf:	e8 3c 7a f6 ff       	call   6f5f0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  107bb4:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  107bbb:	00 
  107bbc:	41 8b 8f 98 03 00 00 	mov    0x398(%r15),%ecx
  107bc3:	49 8b b7 e0 03 00 00 	mov    0x3e0(%r15),%rsi
  107bca:	4c 8d 05 20 34 0e 00 	lea    0xe3420(%rip),%r8        # 1eaff1 <_fini+0x58ad>
  107bd1:	49 8b 97 e8 03 00 00 	mov    0x3e8(%r15),%rdx
  107bd8:	4c 89 f7             	mov    %r14,%rdi
  107bdb:	e8 d0 51 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  107be0:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
  107be7:	00 00 
  107be9:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
  107bf0:	00 00 
  107bf2:	48 8b 84 24 a0 06 00 	mov    0x6a0(%rsp),%rax
  107bf9:	00 
  107bfa:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  107bff:	48 8d 14 f8          	lea    (%rax,%rdi,8),%rdx
  107c03:	48 63 02             	movslq (%rdx),%rax
  107c06:	44 8b 6a 04          	mov    0x4(%rdx),%r13d
  107c0a:	83 f8 ff             	cmp    $0xffffffff,%eax
  107c0d:	0f 8c 0a 05 f7 ff    	jl     7811d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc7b>
  107c13:	41 83 fd ff          	cmp    $0xffffffff,%r13d
  107c17:	0f 8c 00 05 f7 ff    	jl     7811d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc7b>
  107c1d:	83 f8 ff             	cmp    $0xffffffff,%eax
  107c20:	0f 84 15 0b 00 00    	je     10873b <synreal::SolverNewton::precompute_matrices()+0x43cb>
  107c26:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
  107c2b:	8b 91 98 03 00 00    	mov    0x398(%rcx),%edx
  107c31:	48 63 c8             	movslq %eax,%rcx
  107c34:	48 39 d1             	cmp    %rdx,%rcx
  107c37:	0f 83 b5 4a 00 00    	jae    10c6f2 <synreal::SolverNewton::precompute_matrices()+0x8382>
  107c3d:	41 83 fd ff          	cmp    $0xffffffff,%r13d
  107c41:	74 0c                	je     107c4f <synreal::SolverNewton::precompute_matrices()+0x38df>
  107c43:	49 63 cd             	movslq %r13d,%rcx
  107c46:	48 39 d1             	cmp    %rdx,%rcx
  107c49:	0f 83 ce 04 f7 ff    	jae    7811d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc7b>
  107c4f:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
  107c54:	48 8b 8c 24 c0 06 00 	mov    0x6c0(%rsp),%rcx
  107c5b:	00 
  107c5c:	f3 0f 10 05 28 7b 0e 	movss  0xe7b28(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  107c63:	00 
  107c64:	48 8d 14 76          	lea    (%rsi,%rsi,2),%rdx
  107c68:	48 01 d1             	add    %rdx,%rcx
  107c6b:	f3 0f 10 21          	movss  (%rcx),%xmm4
  107c6f:	f3 0f 10 71 04       	movss  0x4(%rcx),%xmm6
  107c74:	f3 0f 10 49 08       	movss  0x8(%rcx),%xmm1
  107c79:	0f 28 d4             	movaps %xmm4,%xmm2
  107c7c:	0f 54 15 1d 7b 0e 00 	andps  0xe7b1d(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  107c83:	0f 2e c2             	ucomiss %xmm2,%xmm0
  107c86:	0f 82 59 04 f7 ff    	jb     780e5 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc43>
  107c8c:	0f 28 d6             	movaps %xmm6,%xmm2
  107c8f:	0f 54 15 0a 7b 0e 00 	andps  0xe7b0a(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  107c96:	0f 2e c2             	ucomiss %xmm2,%xmm0
  107c99:	0f 82 46 04 f7 ff    	jb     780e5 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc43>
  107c9f:	0f 28 d1             	movaps %xmm1,%xmm2
  107ca2:	0f 54 15 f7 7a 0e 00 	andps  0xe7af7(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  107ca9:	0f 2e c2             	ucomiss %xmm2,%xmm0
  107cac:	0f 82 33 04 f7 ff    	jb     780e5 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc43>
  107cb2:	48 03 94 24 e0 06 00 	add    0x6e0(%rsp),%rdx
  107cb9:	00 
  107cba:	f3 0f 10 1a          	movss  (%rdx),%xmm3
  107cbe:	f3 0f 10 52 04       	movss  0x4(%rdx),%xmm2
  107cc3:	f3 0f 10 7a 08       	movss  0x8(%rdx),%xmm7
  107cc8:	0f 28 eb             	movaps %xmm3,%xmm5
  107ccb:	0f 54 2d ce 7a 0e 00 	andps  0xe7ace(%rip),%xmm5        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  107cd2:	0f 2e c5             	ucomiss %xmm5,%xmm0
  107cd5:	0f 82 0a 04 f7 ff    	jb     780e5 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc43>
  107cdb:	0f 28 ea             	movaps %xmm2,%xmm5
  107cde:	0f 54 2d bb 7a 0e 00 	andps  0xe7abb(%rip),%xmm5        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  107ce5:	0f 2e c5             	ucomiss %xmm5,%xmm0
  107ce8:	0f 82 f7 03 f7 ff    	jb     780e5 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc43>
  107cee:	0f 28 ef             	movaps %xmm7,%xmm5
  107cf1:	0f 54 2d a8 7a 0e 00 	andps  0xe7aa8(%rip),%xmm5        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  107cf8:	0f 2e c5             	ucomiss %xmm5,%xmm0
  107cfb:	0f 82 e4 03 f7 ff    	jb     780e5 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc43>
  107d01:	48 8b 94 24 00 07 00 	mov    0x700(%rsp),%rdx
  107d08:	00 
  107d09:	f3 0f 10 2c 32       	movss  (%rdx,%rsi,1),%xmm5
  107d0e:	44 0f 28 c5          	movaps %xmm5,%xmm8
  107d12:	44 0f 54 05 86 7a 0e 	andps  0xe7a86(%rip),%xmm8        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  107d19:	00 
  107d1a:	41 0f 2e c0          	ucomiss %xmm8,%xmm0
  107d1e:	0f 82 c9 49 00 00    	jb     10c6ed <synreal::SolverNewton::precompute_matrices()+0x837d>
  107d24:	66 45 0f ef f6       	pxor   %xmm14,%xmm14
  107d29:	44 0f 2f f5          	comiss %xmm5,%xmm14
  107d2d:	f3 44 0f 11 74 24 48 	movss  %xmm14,0x48(%rsp)
  107d34:	0f 87 8f 02 f7 ff    	ja     77fc9 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xb27>
  107d3a:	48 8b 94 24 20 07 00 	mov    0x720(%rsp),%rdx
  107d41:	00 
  107d42:	f3 0f 10 2c 32       	movss  (%rdx,%rsi,1),%xmm5
  107d47:	44 0f 28 c5          	movaps %xmm5,%xmm8
  107d4b:	44 0f 54 05 4d 7a 0e 	andps  0xe7a4d(%rip),%xmm8        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  107d52:	00 
  107d53:	41 0f 2e c0          	ucomiss %xmm8,%xmm0
  107d57:	0f 82 d6 4a 00 00    	jb     10c833 <synreal::SolverNewton::precompute_matrices()+0x84c3>
  107d5d:	44 0f 2f f5          	comiss %xmm5,%xmm14
  107d61:	0f 87 19 08 f7 ff    	ja     78580 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x10de>
  107d67:	0f 2e 6c 24 48       	ucomiss 0x48(%rsp),%xmm5
  107d6c:	b9 01 00 00 00       	mov    $0x1,%ecx
  107d71:	0f 9a c2             	setp   %dl
  107d74:	0f 45 d1             	cmovne %ecx,%edx
  107d77:	84 d2                	test   %dl,%dl
  107d79:	74 10                	je     107d8b <synreal::SolverNewton::precompute_matrices()+0x3a1b>
  107d7b:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  107d80:	48 39 4c 24 38       	cmp    %rcx,0x38(%rsp)
  107d85:	0f 86 9f 07 f7 ff    	jbe    7852a <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1088>
  107d8b:	83 f8 ff             	cmp    $0xffffffff,%eax
  107d8e:	0f 84 9e 09 00 00    	je     108732 <synreal::SolverNewton::precompute_matrices()+0x43c2>
  107d94:	48 63 d0             	movslq %eax,%rdx
  107d97:	48 8d 0c 52          	lea    (%rdx,%rdx,2),%rcx
  107d9b:	48 8b 94 24 60 07 00 	mov    0x760(%rsp),%rdx
  107da2:	00 
  107da3:	48 8d 14 8a          	lea    (%rdx,%rcx,4),%rdx
  107da7:	f3 0f 5c 72 04       	subss  0x4(%rdx),%xmm6
  107dac:	f3 0f 5c 4a 08       	subss  0x8(%rdx),%xmm1
  107db1:	f3 0f 5c 22          	subss  (%rdx),%xmm4
  107db5:	0f 28 c6             	movaps %xmm6,%xmm0
  107db8:	f3 0f 10 35 c0 01 0f 	movss  0xf01c0(%rip),%xmm6        # 1f7f80 <cuda::std::__4::in_place+0x33>
  107dbf:	00 
  107dc0:	0f 14 c1             	unpcklps %xmm1,%xmm0
  107dc3:	0f 28 ce             	movaps %xmm6,%xmm1
  107dc6:	0f 14 cc             	unpcklps %xmm4,%xmm1
  107dc9:	0f 16 c8             	movlhps %xmm0,%xmm1
  107dcc:	f3 0f 11 8c 24 a8 00 	movss  %xmm1,0xa8(%rsp)
  107dd3:	00 00 
  107dd5:	0f 28 c1             	movaps %xmm1,%xmm0
  107dd8:	0f c6 c1 ff          	shufps $0xff,%xmm1,%xmm0
  107ddc:	66 41 0f 7e c6       	movd   %xmm0,%r14d
  107de1:	0f 28 c1             	movaps %xmm1,%xmm0
  107de4:	0f 15 c1             	unpckhps %xmm1,%xmm0
  107de7:	f3 0f 11 44 24 48    	movss  %xmm0,0x48(%rsp)
  107ded:	0f 28 c1             	movaps %xmm1,%xmm0
  107df0:	0f c6 c1 55          	shufps $0x55,%xmm1,%xmm0
  107df4:	f3 0f 11 84 24 a0 00 	movss  %xmm0,0xa0(%rsp)
  107dfb:	00 00 
  107dfd:	66 0f ef c0          	pxor   %xmm0,%xmm0
  107e01:	41 83 fd ff          	cmp    $0xffffffff,%r13d
  107e05:	74 35                	je     107e3c <synreal::SolverNewton::precompute_matrices()+0x3acc>
  107e07:	49 63 d5             	movslq %r13d,%rdx
  107e0a:	48 8d 0c 52          	lea    (%rdx,%rdx,2),%rcx
  107e0e:	48 8b 94 24 60 07 00 	mov    0x760(%rsp),%rdx
  107e15:	00 
  107e16:	48 8d 14 8a          	lea    (%rdx,%rcx,4),%rdx
  107e1a:	f3 0f 5c 7a 08       	subss  0x8(%rdx),%xmm7
  107e1f:	f3 0f 5c 52 04       	subss  0x4(%rdx),%xmm2
  107e24:	f3 0f 5c 1a          	subss  (%rdx),%xmm3
  107e28:	0f 14 d7             	unpcklps %xmm7,%xmm2
  107e2b:	f3 0f 10 3d 4d 01 0f 	movss  0xf014d(%rip),%xmm7        # 1f7f80 <cuda::std::__4::in_place+0x33>
  107e32:	00 
  107e33:	0f 28 c7             	movaps %xmm7,%xmm0
  107e36:	0f 14 c3             	unpcklps %xmm3,%xmm0
  107e39:	0f 16 c2             	movlhps %xmm2,%xmm0
  107e3c:	48 8b bc 24 38 01 00 	mov    0x138(%rsp),%rdi
  107e43:	00 
  107e44:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  107e49:	0f 28 d0             	movaps %xmm0,%xmm2
  107e4c:	4c 8d bc 24 88 07 00 	lea    0x788(%rsp),%r15
  107e53:	00 
  107e54:	0f c6 d0 ff          	shufps $0xff,%xmm0,%xmm2
  107e58:	4c 89 bc 24 98 07 00 	mov    %r15,0x798(%rsp)
  107e5f:	00 
  107e60:	f3 0f 11 94 24 c0 00 	movss  %xmm2,0xc0(%rsp)
  107e67:	00 00 
  107e69:	0f 28 d0             	movaps %xmm0,%xmm2
  107e6c:	0f 15 d0             	unpckhps %xmm0,%xmm2
  107e6f:	0f 11 0c 8f          	movups %xmm1,(%rdi,%rcx,4)
  107e73:	48 8b bc 24 e0 00 00 	mov    0xe0(%rsp),%rdi
  107e7a:	00 
  107e7b:	f3 0f 11 94 24 b8 00 	movss  %xmm2,0xb8(%rsp)
  107e82:	00 00 
  107e84:	0f 28 d0             	movaps %xmm0,%xmm2
  107e87:	0f c6 d0 55          	shufps $0x55,%xmm0,%xmm2
  107e8b:	4c 89 bc 24 a0 07 00 	mov    %r15,0x7a0(%rsp)
  107e92:	00 
  107e93:	c7 84 24 88 07 00 00 	movl   $0x0,0x788(%rsp)
  107e9a:	00 00 00 00 
  107e9e:	48 c7 84 24 90 07 00 	movq   $0x0,0x790(%rsp)
  107ea5:	00 00 00 00 00 
  107eaa:	48 c7 84 24 a8 07 00 	movq   $0x0,0x7a8(%rsp)
  107eb1:	00 00 00 00 00 
  107eb6:	f3 0f 11 54 24 58    	movss  %xmm2,0x58(%rsp)
  107ebc:	f3 0f 11 44 24 78    	movss  %xmm0,0x78(%rsp)
  107ec2:	0f 11 04 8f          	movups %xmm0,(%rdi,%rcx,4)
  107ec6:	83 f8 ff             	cmp    $0xffffffff,%eax
  107ec9:	0f 85 b1 06 00 00    	jne    108580 <synreal::SolverNewton::precompute_matrices()+0x4210>
  107ecf:	41 83 fd ff          	cmp    $0xffffffff,%r13d
  107ed3:	0f 85 67 05 00 00    	jne    108440 <synreal::SolverNewton::precompute_matrices()+0x40d0>
  107ed9:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  107ede:	48 8b 84 24 80 00 00 	mov    0x80(%rsp),%rax
  107ee5:	00 
  107ee6:	4c 8d 2d 61 f7 0e 00 	lea    0xef761(%rip),%r13        # 1f764e <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x774e>
  107eed:	48 39 4c 24 38       	cmp    %rcx,0x38(%rsp)
  107ef2:	4c 8b b4 24 98 07 00 	mov    0x798(%rsp),%r14
  107ef9:	00 
  107efa:	48 0f 46 84 24 d8 00 	cmovbe 0xd8(%rsp),%rax
  107f01:	00 00 
  107f03:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  107f08:	4d 39 fe             	cmp    %r15,%r14
  107f0b:	0f 84 0b 04 00 00    	je     10831c <synreal::SolverNewton::precompute_matrices()+0x3fac>
  107f11:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  107f18:	49 63 46 20          	movslq 0x20(%r14),%rax
  107f1c:	48 8b 7c 24 58       	mov    0x58(%rsp),%rdi
  107f21:	48 8b 94 24 00 07 00 	mov    0x700(%rsp),%rdx
  107f28:	00 
  107f29:	f3 41 0f 10 4e 24    	movss  0x24(%r14),%xmm1
  107f2f:	49 89 c4             	mov    %rax,%r12
  107f32:	48 8d 04 87          	lea    (%rdi,%rax,4),%rax
  107f36:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
  107f3b:	48 89 14 24          	mov    %rdx,(%rsp)
  107f3f:	f3 0f 10 04 3a       	movss  (%rdx,%rdi,1),%xmm0
  107f44:	4c 89 f7             	mov    %r14,%rdi
  107f47:	f3 0f 59 c1          	mulss  %xmm1,%xmm0
  107f4b:	f3 0f 59 c1          	mulss  %xmm1,%xmm0
  107f4f:	f3 0f 58 00          	addss  (%rax),%xmm0
  107f53:	f3 0f 11 00          	movss  %xmm0,(%rax)
  107f57:	e8 14 47 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  107f5c:	48 89 c5             	mov    %rax,%rbp
  107f5f:	4c 39 f8             	cmp    %r15,%rax
  107f62:	0f 84 a0 03 00 00    	je     108308 <synreal::SolverNewton::precompute_matrices()+0x3f98>
  107f68:	48 8d 84 24 fc 02 00 	lea    0x2fc(%rsp),%rax
  107f6f:	00 
  107f70:	48 8b 14 24          	mov    (%rsp),%rdx
  107f74:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
  107f79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  107f80:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  107f85:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  107f8a:	f3 0f 10 04 02       	movss  (%rdx,%rax,1),%xmm0
  107f8f:	f3 41 0f 59 46 24    	mulss  0x24(%r14),%xmm0
  107f95:	f3 0f 59 45 24       	mulss  0x24(%rbp),%xmm0
  107f9a:	8b 45 20             	mov    0x20(%rbp),%eax
  107f9d:	f3 0f 11 04 24       	movss  %xmm0,(%rsp)
  107fa2:	48 39 7c 24 38       	cmp    %rdi,0x38(%rsp)
  107fa7:	0f 87 93 00 00 00    	ja     108040 <synreal::SolverNewton::precompute_matrices()+0x3cd0>
  107fad:	4c 89 ea             	mov    %r13,%rdx
  107fb0:	48 89 de             	mov    %rbx,%rsi
  107fb3:	44 89 e7             	mov    %r12d,%edi
  107fb6:	89 84 24 f0 02 00 00 	mov    %eax,0x2f0(%rsp)
  107fbd:	e8 de 32 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  107fc2:	8b bc 24 f0 02 00 00 	mov    0x2f0(%rsp),%edi
  107fc9:	4c 89 ea             	mov    %r13,%rdx
  107fcc:	48 89 de             	mov    %rbx,%rsi
  107fcf:	e8 cc 32 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  107fd4:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
  107fd9:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  107fdd:	48 c1 e0 04          	shl    $0x4,%rax
  107fe1:	4c 8d 0c 06          	lea    (%rsi,%rax,1),%r9
  107fe5:	49 8b 41 10          	mov    0x10(%r9),%rax
  107fe9:	4d 8d 41 08          	lea    0x8(%r9),%r8
  107fed:	48 85 c0             	test   %rax,%rax
  107ff0:	0f 84 3a 04 00 00    	je     108430 <synreal::SolverNewton::precompute_matrices()+0x40c0>
  107ff6:	8b bc 24 f0 02 00 00 	mov    0x2f0(%rsp),%edi
  107ffd:	4c 89 c6             	mov    %r8,%rsi
  108000:	48 8b 50 10          	mov    0x10(%rax),%rdx
  108004:	48 8b 48 18          	mov    0x18(%rax),%rcx
  108008:	3b 78 20             	cmp    0x20(%rax),%edi
  10800b:	7f 1c                	jg     108029 <synreal::SolverNewton::precompute_matrices()+0x3cb9>
  10800d:	48 89 c6             	mov    %rax,%rsi
  108010:	48 85 d2             	test   %rdx,%rdx
  108013:	0f 84 e7 01 00 00    	je     108200 <synreal::SolverNewton::precompute_matrices()+0x3e90>
  108019:	48 89 d0             	mov    %rdx,%rax
  10801c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  108020:	48 8b 48 18          	mov    0x18(%rax),%rcx
  108024:	3b 78 20             	cmp    0x20(%rax),%edi
  108027:	7e e4                	jle    10800d <synreal::SolverNewton::precompute_matrices()+0x3c9d>
  108029:	48 85 c9             	test   %rcx,%rcx
  10802c:	0f 84 ce 01 00 00    	je     108200 <synreal::SolverNewton::precompute_matrices()+0x3e90>
  108032:	48 89 c8             	mov    %rcx,%rax
  108035:	eb c9                	jmp    108000 <synreal::SolverNewton::precompute_matrices()+0x3c90>
  108037:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10803e:	00 00 
  108040:	4c 89 ea             	mov    %r13,%rdx
  108043:	48 89 de             	mov    %rbx,%rsi
  108046:	44 89 e7             	mov    %r12d,%edi
  108049:	89 84 24 f8 02 00 00 	mov    %eax,0x2f8(%rsp)
  108050:	e8 4b 32 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  108055:	8b bc 24 f8 02 00 00 	mov    0x2f8(%rsp),%edi
  10805c:	4c 89 ea             	mov    %r13,%rdx
  10805f:	48 89 de             	mov    %rbx,%rsi
  108062:	e8 39 32 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  108067:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  10806c:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  108070:	48 c1 e0 04          	shl    $0x4,%rax
  108074:	4c 8d 0c 06          	lea    (%rsi,%rax,1),%r9
  108078:	49 8b 41 10          	mov    0x10(%r9),%rax
  10807c:	4d 8d 41 08          	lea    0x8(%r9),%r8
  108080:	48 85 c0             	test   %rax,%rax
  108083:	0f 84 9f 03 00 00    	je     108428 <synreal::SolverNewton::precompute_matrices()+0x40b8>
  108089:	8b bc 24 f8 02 00 00 	mov    0x2f8(%rsp),%edi
  108090:	4c 89 c6             	mov    %r8,%rsi
  108093:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  108098:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10809c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  1080a0:	3b 78 20             	cmp    0x20(%rax),%edi
  1080a3:	7f 18                	jg     1080bd <synreal::SolverNewton::precompute_matrices()+0x3d4d>
  1080a5:	48 89 c6             	mov    %rax,%rsi
  1080a8:	48 85 d2             	test   %rdx,%rdx
  1080ab:	74 23                	je     1080d0 <synreal::SolverNewton::precompute_matrices()+0x3d60>
  1080ad:	48 89 d0             	mov    %rdx,%rax
  1080b0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1080b4:	48 8b 48 18          	mov    0x18(%rax),%rcx
  1080b8:	3b 78 20             	cmp    0x20(%rax),%edi
  1080bb:	7e e8                	jle    1080a5 <synreal::SolverNewton::precompute_matrices()+0x3d35>
  1080bd:	48 85 c9             	test   %rcx,%rcx
  1080c0:	74 0e                	je     1080d0 <synreal::SolverNewton::precompute_matrices()+0x3d60>
  1080c2:	48 89 c8             	mov    %rcx,%rax
  1080c5:	eb d1                	jmp    108098 <synreal::SolverNewton::precompute_matrices()+0x3d28>
  1080c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  1080ce:	00 00 
  1080d0:	4c 39 c6             	cmp    %r8,%rsi
  1080d3:	74 05                	je     1080da <synreal::SolverNewton::precompute_matrices()+0x3d6a>
  1080d5:	3b 7e 20             	cmp    0x20(%rsi),%edi
  1080d8:	7d 23                	jge    1080fd <synreal::SolverNewton::precompute_matrices()+0x3d8d>
  1080da:	48 8d 84 24 f8 02 00 	lea    0x2f8(%rsp),%rax
  1080e1:	00 
  1080e2:	48 8d 94 24 90 03 00 	lea    0x390(%rsp),%rdx
  1080e9:	00 
  1080ea:	4c 89 cf             	mov    %r9,%rdi
  1080ed:	48 89 84 24 90 03 00 	mov    %rax,0x390(%rsp)
  1080f4:	00 
  1080f5:	e8 86 89 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  1080fa:	48 89 c6             	mov    %rax,%rsi
  1080fd:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  108102:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  108107:	4c 89 ea             	mov    %r13,%rdx
  10810a:	4c 63 65 20          	movslq 0x20(%rbp),%r12
  10810e:	41 8b 46 20          	mov    0x20(%r14),%eax
  108112:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  108117:	44 89 e7             	mov    %r12d,%edi
  10811a:	48 89 de             	mov    %rbx,%rsi
  10811d:	89 84 24 fc 02 00 00 	mov    %eax,0x2fc(%rsp)
  108124:	e8 77 31 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  108129:	8b bc 24 fc 02 00 00 	mov    0x2fc(%rsp),%edi
  108130:	4c 89 ea             	mov    %r13,%rdx
  108133:	48 89 de             	mov    %rbx,%rsi
  108136:	e8 65 31 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10813b:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  108140:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  108144:	48 c1 e0 04          	shl    $0x4,%rax
  108148:	4c 8d 0c 07          	lea    (%rdi,%rax,1),%r9
  10814c:	49 8b 41 10          	mov    0x10(%r9),%rax
  108150:	4d 8d 41 08          	lea    0x8(%r9),%r8
  108154:	48 85 c0             	test   %rax,%rax
  108157:	0f 84 db 02 00 00    	je     108438 <synreal::SolverNewton::precompute_matrices()+0x40c8>
  10815d:	8b bc 24 fc 02 00 00 	mov    0x2fc(%rsp),%edi
  108164:	4c 89 c6             	mov    %r8,%rsi
  108167:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10816e:	00 00 
  108170:	48 8b 50 10          	mov    0x10(%rax),%rdx
  108174:	48 8b 48 18          	mov    0x18(%rax),%rcx
  108178:	3b 78 20             	cmp    0x20(%rax),%edi
  10817b:	7f 18                	jg     108195 <synreal::SolverNewton::precompute_matrices()+0x3e25>
  10817d:	48 89 c6             	mov    %rax,%rsi
  108180:	48 85 d2             	test   %rdx,%rdx
  108183:	74 1b                	je     1081a0 <synreal::SolverNewton::precompute_matrices()+0x3e30>
  108185:	48 89 d0             	mov    %rdx,%rax
  108188:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10818c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  108190:	3b 78 20             	cmp    0x20(%rax),%edi
  108193:	7e e8                	jle    10817d <synreal::SolverNewton::precompute_matrices()+0x3e0d>
  108195:	48 85 c9             	test   %rcx,%rcx
  108198:	74 06                	je     1081a0 <synreal::SolverNewton::precompute_matrices()+0x3e30>
  10819a:	48 89 c8             	mov    %rcx,%rax
  10819d:	eb d1                	jmp    108170 <synreal::SolverNewton::precompute_matrices()+0x3e00>
  10819f:	90                   	nop
  1081a0:	4c 39 c6             	cmp    %r8,%rsi
  1081a3:	74 05                	je     1081aa <synreal::SolverNewton::precompute_matrices()+0x3e3a>
  1081a5:	3b 7e 20             	cmp    0x20(%rsi),%edi
  1081a8:	7d 20                	jge    1081ca <synreal::SolverNewton::precompute_matrices()+0x3e5a>
  1081aa:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
  1081af:	48 8d 94 24 98 03 00 	lea    0x398(%rsp),%rdx
  1081b6:	00 
  1081b7:	4c 89 cf             	mov    %r9,%rdi
  1081ba:	48 89 84 24 98 03 00 	mov    %rax,0x398(%rsp)
  1081c1:	00 
  1081c2:	e8 b9 88 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  1081c7:	48 89 c6             	mov    %rax,%rsi
  1081ca:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  1081cf:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  1081d4:	48 89 ef             	mov    %rbp,%rdi
  1081d7:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  1081dc:	e8 8f 44 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  1081e1:	48 89 c5             	mov    %rax,%rbp
  1081e4:	4c 39 f8             	cmp    %r15,%rax
  1081e7:	0f 84 1b 01 00 00    	je     108308 <synreal::SolverNewton::precompute_matrices()+0x3f98>
  1081ed:	48 8b 94 24 00 07 00 	mov    0x700(%rsp),%rdx
  1081f4:	00 
  1081f5:	4d 63 66 20          	movslq 0x20(%r14),%r12
  1081f9:	e9 82 fd ff ff       	jmp    107f80 <synreal::SolverNewton::precompute_matrices()+0x3c10>
  1081fe:	66 90                	xchg   %ax,%ax
  108200:	4c 39 c6             	cmp    %r8,%rsi
  108203:	74 05                	je     10820a <synreal::SolverNewton::precompute_matrices()+0x3e9a>
  108205:	3b 7e 20             	cmp    0x20(%rsi),%edi
  108208:	7d 23                	jge    10822d <synreal::SolverNewton::precompute_matrices()+0x3ebd>
  10820a:	48 8d 84 24 f0 02 00 	lea    0x2f0(%rsp),%rax
  108211:	00 
  108212:	48 8d 94 24 80 03 00 	lea    0x380(%rsp),%rdx
  108219:	00 
  10821a:	4c 89 cf             	mov    %r9,%rdi
  10821d:	48 89 84 24 80 03 00 	mov    %rax,0x380(%rsp)
  108224:	00 
  108225:	e8 56 88 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10822a:	48 89 c6             	mov    %rax,%rsi
  10822d:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  108232:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  108237:	4c 89 ea             	mov    %r13,%rdx
  10823a:	4c 63 65 20          	movslq 0x20(%rbp),%r12
  10823e:	41 8b 46 20          	mov    0x20(%r14),%eax
  108242:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  108247:	44 89 e7             	mov    %r12d,%edi
  10824a:	48 89 de             	mov    %rbx,%rsi
  10824d:	89 84 24 f4 02 00 00 	mov    %eax,0x2f4(%rsp)
  108254:	e8 47 30 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  108259:	8b bc 24 f4 02 00 00 	mov    0x2f4(%rsp),%edi
  108260:	4c 89 ea             	mov    %r13,%rdx
  108263:	48 89 de             	mov    %rbx,%rsi
  108266:	e8 35 30 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10826b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
  108270:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  108274:	48 c1 e0 04          	shl    $0x4,%rax
  108278:	4c 8d 0c 07          	lea    (%rdi,%rax,1),%r9
  10827c:	49 8b 41 10          	mov    0x10(%r9),%rax
  108280:	4d 8d 41 08          	lea    0x8(%r9),%r8
  108284:	48 85 c0             	test   %rax,%rax
  108287:	0f 84 93 01 00 00    	je     108420 <synreal::SolverNewton::precompute_matrices()+0x40b0>
  10828d:	8b bc 24 f4 02 00 00 	mov    0x2f4(%rsp),%edi
  108294:	4c 89 c6             	mov    %r8,%rsi
  108297:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10829e:	00 00 
  1082a0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1082a4:	48 8b 48 18          	mov    0x18(%rax),%rcx
  1082a8:	3b 78 20             	cmp    0x20(%rax),%edi
  1082ab:	7f 18                	jg     1082c5 <synreal::SolverNewton::precompute_matrices()+0x3f55>
  1082ad:	48 89 c6             	mov    %rax,%rsi
  1082b0:	48 85 d2             	test   %rdx,%rdx
  1082b3:	74 1b                	je     1082d0 <synreal::SolverNewton::precompute_matrices()+0x3f60>
  1082b5:	48 89 d0             	mov    %rdx,%rax
  1082b8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1082bc:	48 8b 48 18          	mov    0x18(%rax),%rcx
  1082c0:	3b 78 20             	cmp    0x20(%rax),%edi
  1082c3:	7e e8                	jle    1082ad <synreal::SolverNewton::precompute_matrices()+0x3f3d>
  1082c5:	48 85 c9             	test   %rcx,%rcx
  1082c8:	74 06                	je     1082d0 <synreal::SolverNewton::precompute_matrices()+0x3f60>
  1082ca:	48 89 c8             	mov    %rcx,%rax
  1082cd:	eb d1                	jmp    1082a0 <synreal::SolverNewton::precompute_matrices()+0x3f30>
  1082cf:	90                   	nop
  1082d0:	4c 39 c6             	cmp    %r8,%rsi
  1082d3:	74 09                	je     1082de <synreal::SolverNewton::precompute_matrices()+0x3f6e>
  1082d5:	3b 7e 20             	cmp    0x20(%rsi),%edi
  1082d8:	0f 8d ec fe ff ff    	jge    1081ca <synreal::SolverNewton::precompute_matrices()+0x3e5a>
  1082de:	48 8d 84 24 f4 02 00 	lea    0x2f4(%rsp),%rax
  1082e5:	00 
  1082e6:	48 8d 94 24 88 03 00 	lea    0x388(%rsp),%rdx
  1082ed:	00 
  1082ee:	4c 89 cf             	mov    %r9,%rdi
  1082f1:	48 89 84 24 88 03 00 	mov    %rax,0x388(%rsp)
  1082f8:	00 
  1082f9:	e8 82 87 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  1082fe:	e9 c4 fe ff ff       	jmp    1081c7 <synreal::SolverNewton::precompute_matrices()+0x3e57>
  108303:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  108308:	4c 89 f7             	mov    %r14,%rdi
  10830b:	e8 60 43 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  108310:	49 89 c6             	mov    %rax,%r14
  108313:	4c 39 f8             	cmp    %r15,%rax
  108316:	0f 85 fc fb ff ff    	jne    107f18 <synreal::SolverNewton::precompute_matrices()+0x3ba8>
  10831c:	48 8b bc 24 90 07 00 	mov    0x790(%rsp),%rdi
  108323:	00 
  108324:	e8 c7 82 fe ff       	call   f05f0 <std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, float> >*) [clone .isra.0]>
  108329:	48 83 44 24 20 01    	addq   $0x1,0x20(%rsp)
  10832f:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  108334:	48 83 44 24 18 04    	addq   $0x4,0x18(%rsp)
  10833a:	48 39 44 24 60       	cmp    %rax,0x60(%rsp)
  10833f:	0f 85 ad f8 ff ff    	jne    107bf2 <synreal::SolverNewton::precompute_matrices()+0x3882>
  108345:	48 8b bc 24 60 07 00 	mov    0x760(%rsp),%rdi
  10834c:	00 
  10834d:	48 85 ff             	test   %rdi,%rdi
  108350:	74 10                	je     108362 <synreal::SolverNewton::precompute_matrices()+0x3ff2>
  108352:	48 8b b4 24 70 07 00 	mov    0x770(%rsp),%rsi
  108359:	00 
  10835a:	48 29 fe             	sub    %rdi,%rsi
  10835d:	e8 4e 4e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  108362:	48 8b bc 24 40 07 00 	mov    0x740(%rsp),%rdi
  108369:	00 
  10836a:	48 85 ff             	test   %rdi,%rdi
  10836d:	74 10                	je     10837f <synreal::SolverNewton::precompute_matrices()+0x400f>
  10836f:	48 8b b4 24 50 07 00 	mov    0x750(%rsp),%rsi
  108376:	00 
  108377:	48 29 fe             	sub    %rdi,%rsi
  10837a:	e8 31 4e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10837f:	48 8b bc 24 20 07 00 	mov    0x720(%rsp),%rdi
  108386:	00 
  108387:	48 85 ff             	test   %rdi,%rdi
  10838a:	74 10                	je     10839c <synreal::SolverNewton::precompute_matrices()+0x402c>
  10838c:	48 8b b4 24 30 07 00 	mov    0x730(%rsp),%rsi
  108393:	00 
  108394:	48 29 fe             	sub    %rdi,%rsi
  108397:	e8 14 4e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10839c:	48 8b bc 24 00 07 00 	mov    0x700(%rsp),%rdi
  1083a3:	00 
  1083a4:	48 85 ff             	test   %rdi,%rdi
  1083a7:	74 10                	je     1083b9 <synreal::SolverNewton::precompute_matrices()+0x4049>
  1083a9:	48 8b b4 24 10 07 00 	mov    0x710(%rsp),%rsi
  1083b0:	00 
  1083b1:	48 29 fe             	sub    %rdi,%rsi
  1083b4:	e8 f7 4d f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1083b9:	48 8b bc 24 e0 06 00 	mov    0x6e0(%rsp),%rdi
  1083c0:	00 
  1083c1:	48 85 ff             	test   %rdi,%rdi
  1083c4:	74 10                	je     1083d6 <synreal::SolverNewton::precompute_matrices()+0x4066>
  1083c6:	48 8b b4 24 f0 06 00 	mov    0x6f0(%rsp),%rsi
  1083cd:	00 
  1083ce:	48 29 fe             	sub    %rdi,%rsi
  1083d1:	e8 da 4d f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1083d6:	48 8b bc 24 c0 06 00 	mov    0x6c0(%rsp),%rdi
  1083dd:	00 
  1083de:	48 85 ff             	test   %rdi,%rdi
  1083e1:	74 10                	je     1083f3 <synreal::SolverNewton::precompute_matrices()+0x4083>
  1083e3:	48 8b b4 24 d0 06 00 	mov    0x6d0(%rsp),%rsi
  1083ea:	00 
  1083eb:	48 29 fe             	sub    %rdi,%rsi
  1083ee:	e8 bd 4d f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1083f3:	48 8b bc 24 a0 06 00 	mov    0x6a0(%rsp),%rdi
  1083fa:	00 
  1083fb:	48 85 ff             	test   %rdi,%rdi
  1083fe:	0f 84 8c d2 ff ff    	je     105690 <synreal::SolverNewton::precompute_matrices()+0x1320>
  108404:	48 8b b4 24 b0 06 00 	mov    0x6b0(%rsp),%rsi
  10840b:	00 
  10840c:	48 29 fe             	sub    %rdi,%rsi
  10840f:	e8 9c 4d f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  108414:	e9 77 d2 ff ff       	jmp    105690 <synreal::SolverNewton::precompute_matrices()+0x1320>
  108419:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  108420:	4c 89 c6             	mov    %r8,%rsi
  108423:	e9 b6 fe ff ff       	jmp    1082de <synreal::SolverNewton::precompute_matrices()+0x3f6e>
  108428:	4c 89 c6             	mov    %r8,%rsi
  10842b:	e9 aa fc ff ff       	jmp    1080da <synreal::SolverNewton::precompute_matrices()+0x3d6a>
  108430:	4c 89 c6             	mov    %r8,%rsi
  108433:	e9 d2 fd ff ff       	jmp    10820a <synreal::SolverNewton::precompute_matrices()+0x3e9a>
  108438:	4c 89 c6             	mov    %r8,%rsi
  10843b:	e9 6a fd ff ff       	jmp    1081aa <synreal::SolverNewton::precompute_matrices()+0x3e3a>
  108440:	49 63 c5             	movslq %r13d,%rax
  108443:	31 ed                	xor    %ebp,%ebp
  108445:	4c 8d 25 02 f2 0e 00 	lea    0xef202(%rip),%r12        # 1f764e <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x774e>
  10844c:	48 c1 e0 04          	shl    $0x4,%rax
  108450:	48 03 84 24 40 07 00 	add    0x740(%rsp),%rax
  108457:	00 
  108458:	f3 0f 6f 38          	movdqu (%rax),%xmm7
  10845c:	0f 29 bc 24 80 06 00 	movaps %xmm7,0x680(%rsp)
  108463:	00 
  108464:	83 fd 02             	cmp    $0x2,%ebp
  108467:	0f 84 e0 00 00 00    	je     10854d <synreal::SolverNewton::precompute_matrices()+0x41dd>
  10846d:	83 fd 03             	cmp    $0x3,%ebp
  108470:	0f 84 b0 02 00 00    	je     108726 <synreal::SolverNewton::precompute_matrices()+0x43b6>
  108476:	83 fd 01             	cmp    $0x1,%ebp
  108479:	0f 84 9b 02 00 00    	je     10871a <synreal::SolverNewton::precompute_matrices()+0x43aa>
  10847f:	8b bc 24 80 06 00 00 	mov    0x680(%rsp),%edi
  108486:	4c 89 e2             	mov    %r12,%rdx
  108489:	48 89 de             	mov    %rbx,%rsi
  10848c:	e8 0f 2e f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  108491:	83 fd 02             	cmp    $0x2,%ebp
  108494:	0f 84 6b 02 00 00    	je     108705 <synreal::SolverNewton::precompute_matrices()+0x4395>
  10849a:	83 fd 03             	cmp    $0x3,%ebp
  10849d:	0f 84 b6 00 00 00    	je     108559 <synreal::SolverNewton::precompute_matrices()+0x41e9>
  1084a3:	83 fd 01             	cmp    $0x1,%ebp
  1084a6:	0f 84 c2 00 00 00    	je     10856e <synreal::SolverNewton::precompute_matrices()+0x41fe>
  1084ac:	44 8b 6c 24 78       	mov    0x78(%rsp),%r13d
  1084b1:	4c 8d 84 24 80 06 00 	lea    0x680(%rsp),%r8
  1084b8:	00 
  1084b9:	48 8b 84 24 90 07 00 	mov    0x790(%rsp),%rax
  1084c0:	00 
  1084c1:	48 85 c0             	test   %rax,%rax
  1084c4:	0f 84 93 02 00 00    	je     10875d <synreal::SolverNewton::precompute_matrices()+0x43ed>
  1084ca:	41 8b 38             	mov    (%r8),%edi
  1084cd:	4c 89 fe             	mov    %r15,%rsi
  1084d0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1084d4:	48 8b 48 18          	mov    0x18(%rax),%rcx
  1084d8:	3b 78 20             	cmp    0x20(%rax),%edi
  1084db:	7f 18                	jg     1084f5 <synreal::SolverNewton::precompute_matrices()+0x4185>
  1084dd:	48 89 c6             	mov    %rax,%rsi
  1084e0:	48 85 d2             	test   %rdx,%rdx
  1084e3:	74 1a                	je     1084ff <synreal::SolverNewton::precompute_matrices()+0x418f>
  1084e5:	48 89 d0             	mov    %rdx,%rax
  1084e8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1084ec:	48 8b 48 18          	mov    0x18(%rax),%rcx
  1084f0:	3b 78 20             	cmp    0x20(%rax),%edi
  1084f3:	7e e8                	jle    1084dd <synreal::SolverNewton::precompute_matrices()+0x416d>
  1084f5:	48 85 c9             	test   %rcx,%rcx
  1084f8:	74 05                	je     1084ff <synreal::SolverNewton::precompute_matrices()+0x418f>
  1084fa:	48 89 c8             	mov    %rcx,%rax
  1084fd:	eb d1                	jmp    1084d0 <synreal::SolverNewton::precompute_matrices()+0x4160>
  1084ff:	4c 39 fe             	cmp    %r15,%rsi
  108502:	74 05                	je     108509 <synreal::SolverNewton::precompute_matrices()+0x4199>
  108504:	3b 7e 20             	cmp    0x20(%rsi),%edi
  108507:	7d 20                	jge    108529 <synreal::SolverNewton::precompute_matrices()+0x41b9>
  108509:	48 8d 94 24 78 03 00 	lea    0x378(%rsp),%rdx
  108510:	00 
  108511:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  108518:	00 
  108519:	4c 89 84 24 78 03 00 	mov    %r8,0x378(%rsp)
  108520:	00 
  108521:	e8 5a 85 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  108526:	48 89 c6             	mov    %rax,%rsi
  108529:	66 41 0f 6e c5       	movd   %r13d,%xmm0
  10852e:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  108533:	83 c5 01             	add    $0x1,%ebp
  108536:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  10853b:	83 fd 04             	cmp    $0x4,%ebp
  10853e:	0f 84 95 f9 ff ff    	je     107ed9 <synreal::SolverNewton::precompute_matrices()+0x3b69>
  108544:	83 fd 02             	cmp    $0x2,%ebp
  108547:	0f 85 20 ff ff ff    	jne    10846d <synreal::SolverNewton::precompute_matrices()+0x40fd>
  10854d:	8b bc 24 88 06 00 00 	mov    0x688(%rsp),%edi
  108554:	e9 2d ff ff ff       	jmp    108486 <synreal::SolverNewton::precompute_matrices()+0x4116>
  108559:	44 8b ac 24 c0 00 00 	mov    0xc0(%rsp),%r13d
  108560:	00 
  108561:	4c 8d 84 24 8c 06 00 	lea    0x68c(%rsp),%r8
  108568:	00 
  108569:	e9 4b ff ff ff       	jmp    1084b9 <synreal::SolverNewton::precompute_matrices()+0x4149>
  10856e:	44 8b 6c 24 58       	mov    0x58(%rsp),%r13d
  108573:	4c 8d 84 24 84 06 00 	lea    0x684(%rsp),%r8
  10857a:	00 
  10857b:	e9 39 ff ff ff       	jmp    1084b9 <synreal::SolverNewton::precompute_matrices()+0x4149>
  108580:	48 c1 e0 04          	shl    $0x4,%rax
  108584:	48 03 84 24 40 07 00 	add    0x740(%rsp),%rax
  10858b:	00 
  10858c:	31 ed                	xor    %ebp,%ebp
  10858e:	f3 0f 6f 38          	movdqu (%rax),%xmm7
  108592:	4c 8d 25 b5 f0 0e 00 	lea    0xef0b5(%rip),%r12        # 1f764e <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x774e>
  108599:	0f 29 bc 24 80 06 00 	movaps %xmm7,0x680(%rsp)
  1085a0:	00 
  1085a1:	83 fd 02             	cmp    $0x2,%ebp
  1085a4:	0f 84 f3 00 00 00    	je     10869d <synreal::SolverNewton::precompute_matrices()+0x432d>
  1085aa:	83 fd 03             	cmp    $0x3,%ebp
  1085ad:	0f 84 46 01 00 00    	je     1086f9 <synreal::SolverNewton::precompute_matrices()+0x4389>
  1085b3:	83 fd 01             	cmp    $0x1,%ebp
  1085b6:	0f 84 31 01 00 00    	je     1086ed <synreal::SolverNewton::precompute_matrices()+0x437d>
  1085bc:	8b bc 24 80 06 00 00 	mov    0x680(%rsp),%edi
  1085c3:	4c 89 e2             	mov    %r12,%rdx
  1085c6:	48 89 de             	mov    %rbx,%rsi
  1085c9:	e8 d2 2c f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  1085ce:	83 fd 02             	cmp    $0x2,%ebp
  1085d1:	0f 84 fe 00 00 00    	je     1086d5 <synreal::SolverNewton::precompute_matrices()+0x4365>
  1085d7:	83 fd 03             	cmp    $0x3,%ebp
  1085da:	0f 84 e4 00 00 00    	je     1086c4 <synreal::SolverNewton::precompute_matrices()+0x4354>
  1085e0:	83 fd 01             	cmp    $0x1,%ebp
  1085e3:	0f 84 c0 00 00 00    	je     1086a9 <synreal::SolverNewton::precompute_matrices()+0x4339>
  1085e9:	f3 0f 10 b4 24 a8 00 	movss  0xa8(%rsp),%xmm6
  1085f0:	00 00 
  1085f2:	4c 8d 84 24 80 06 00 	lea    0x680(%rsp),%r8
  1085f9:	00 
  1085fa:	f3 0f 11 34 24       	movss  %xmm6,(%rsp)
  1085ff:	48 8b 84 24 90 07 00 	mov    0x790(%rsp),%rax
  108606:	00 
  108607:	48 85 c0             	test   %rax,%rax
  10860a:	0f 84 45 01 00 00    	je     108755 <synreal::SolverNewton::precompute_matrices()+0x43e5>
  108610:	41 8b 38             	mov    (%r8),%edi
  108613:	4c 89 fe             	mov    %r15,%rsi
  108616:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10861d:	00 00 00 
  108620:	48 8b 50 10          	mov    0x10(%rax),%rdx
  108624:	48 8b 48 18          	mov    0x18(%rax),%rcx
  108628:	3b 78 20             	cmp    0x20(%rax),%edi
  10862b:	7f 18                	jg     108645 <synreal::SolverNewton::precompute_matrices()+0x42d5>
  10862d:	48 89 c6             	mov    %rax,%rsi
  108630:	48 85 d2             	test   %rdx,%rdx
  108633:	74 1a                	je     10864f <synreal::SolverNewton::precompute_matrices()+0x42df>
  108635:	48 89 d0             	mov    %rdx,%rax
  108638:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10863c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  108640:	3b 78 20             	cmp    0x20(%rax),%edi
  108643:	7e e8                	jle    10862d <synreal::SolverNewton::precompute_matrices()+0x42bd>
  108645:	48 85 c9             	test   %rcx,%rcx
  108648:	74 05                	je     10864f <synreal::SolverNewton::precompute_matrices()+0x42df>
  10864a:	48 89 c8             	mov    %rcx,%rax
  10864d:	eb d1                	jmp    108620 <synreal::SolverNewton::precompute_matrices()+0x42b0>
  10864f:	4c 39 fe             	cmp    %r15,%rsi
  108652:	74 05                	je     108659 <synreal::SolverNewton::precompute_matrices()+0x42e9>
  108654:	3b 7e 20             	cmp    0x20(%rsi),%edi
  108657:	7d 20                	jge    108679 <synreal::SolverNewton::precompute_matrices()+0x4309>
  108659:	48 8d 94 24 70 03 00 	lea    0x370(%rsp),%rdx
  108660:	00 
  108661:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  108668:	00 
  108669:	4c 89 84 24 70 03 00 	mov    %r8,0x370(%rsp)
  108670:	00 
  108671:	e8 0a 84 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  108676:	48 89 c6             	mov    %rax,%rsi
  108679:	f3 0f 10 46 24       	movss  0x24(%rsi),%xmm0
  10867e:	f3 0f 5c 04 24       	subss  (%rsp),%xmm0
  108683:	83 c5 01             	add    $0x1,%ebp
  108686:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  10868b:	83 fd 04             	cmp    $0x4,%ebp
  10868e:	0f 84 3b f8 ff ff    	je     107ecf <synreal::SolverNewton::precompute_matrices()+0x3b5f>
  108694:	83 fd 02             	cmp    $0x2,%ebp
  108697:	0f 85 0d ff ff ff    	jne    1085aa <synreal::SolverNewton::precompute_matrices()+0x423a>
  10869d:	8b bc 24 88 06 00 00 	mov    0x688(%rsp),%edi
  1086a4:	e9 1a ff ff ff       	jmp    1085c3 <synreal::SolverNewton::precompute_matrices()+0x4253>
  1086a9:	f3 0f 10 b4 24 a0 00 	movss  0xa0(%rsp),%xmm6
  1086b0:	00 00 
  1086b2:	4c 8d 84 24 84 06 00 	lea    0x684(%rsp),%r8
  1086b9:	00 
  1086ba:	f3 0f 11 34 24       	movss  %xmm6,(%rsp)
  1086bf:	e9 3b ff ff ff       	jmp    1085ff <synreal::SolverNewton::precompute_matrices()+0x428f>
  1086c4:	44 89 34 24          	mov    %r14d,(%rsp)
  1086c8:	4c 8d 84 24 8c 06 00 	lea    0x68c(%rsp),%r8
  1086cf:	00 
  1086d0:	e9 2a ff ff ff       	jmp    1085ff <synreal::SolverNewton::precompute_matrices()+0x428f>
  1086d5:	f3 0f 10 7c 24 48    	movss  0x48(%rsp),%xmm7
  1086db:	4c 8d 84 24 88 06 00 	lea    0x688(%rsp),%r8
  1086e2:	00 
  1086e3:	f3 0f 11 3c 24       	movss  %xmm7,(%rsp)
  1086e8:	e9 12 ff ff ff       	jmp    1085ff <synreal::SolverNewton::precompute_matrices()+0x428f>
  1086ed:	8b bc 24 84 06 00 00 	mov    0x684(%rsp),%edi
  1086f4:	e9 ca fe ff ff       	jmp    1085c3 <synreal::SolverNewton::precompute_matrices()+0x4253>
  1086f9:	8b bc 24 8c 06 00 00 	mov    0x68c(%rsp),%edi
  108700:	e9 be fe ff ff       	jmp    1085c3 <synreal::SolverNewton::precompute_matrices()+0x4253>
  108705:	44 8b ac 24 b8 00 00 	mov    0xb8(%rsp),%r13d
  10870c:	00 
  10870d:	4c 8d 84 24 88 06 00 	lea    0x688(%rsp),%r8
  108714:	00 
  108715:	e9 9f fd ff ff       	jmp    1084b9 <synreal::SolverNewton::precompute_matrices()+0x4149>
  10871a:	8b bc 24 84 06 00 00 	mov    0x684(%rsp),%edi
  108721:	e9 60 fd ff ff       	jmp    108486 <synreal::SolverNewton::precompute_matrices()+0x4116>
  108726:	8b bc 24 8c 06 00 00 	mov    0x68c(%rsp),%edi
  10872d:	e9 54 fd ff ff       	jmp    108486 <synreal::SolverNewton::precompute_matrices()+0x4116>
  108732:	66 0f ef c9          	pxor   %xmm1,%xmm1
  108736:	e9 91 f6 ff ff       	jmp    107dcc <synreal::SolverNewton::precompute_matrices()+0x3a5c>
  10873b:	41 83 fd ff          	cmp    $0xffffffff,%r13d
  10873f:	0f 84 d6 3f 00 00    	je     10c71b <synreal::SolverNewton::precompute_matrices()+0x83ab>
  108745:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
  10874a:	8b 97 98 03 00 00    	mov    0x398(%rdi),%edx
  108750:	e9 ee f4 ff ff       	jmp    107c43 <synreal::SolverNewton::precompute_matrices()+0x38d3>
  108755:	4c 89 fe             	mov    %r15,%rsi
  108758:	e9 fc fe ff ff       	jmp    108659 <synreal::SolverNewton::precompute_matrices()+0x42e9>
  10875d:	4c 89 fe             	mov    %r15,%rsi
  108760:	e9 a4 fd ff ff       	jmp    108509 <synreal::SolverNewton::precompute_matrices()+0x4199>
  108765:	48 8b 6c 24 40       	mov    0x40(%rsp),%rbp
  10876a:	41 89 c7             	mov    %eax,%r15d
  10876d:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  108774:	00 
  108775:	4c 8d 05 b2 29 0e 00 	lea    0xe29b2(%rip),%r8        # 1eb12e <_fini+0x59ea>
  10877c:	4c 89 f9             	mov    %r15,%rcx
  10877f:	4c 89 ef             	mov    %r13,%rdi
  108782:	48 8b b5 48 02 00 00 	mov    0x248(%rbp),%rsi
  108789:	48 8b 95 50 02 00 00 	mov    0x250(%rbp),%rdx
  108790:	e8 7b 49 f6 ff       	call   6d110 <std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<2, int, (glm::qualifier)0> >(synreal::Span<glm::vec<2, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  108795:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  10879c:	00 
  10879d:	48 8b b5 58 02 00 00 	mov    0x258(%rbp),%rsi
  1087a4:	4c 89 f9             	mov    %r15,%rcx
  1087a7:	48 8b 95 60 02 00 00 	mov    0x260(%rbp),%rdx
  1087ae:	4c 8d 05 b5 29 0e 00 	lea    0xe29b5(%rip),%r8        # 1eb16a <_fini+0x5a26>
  1087b5:	4c 89 f7             	mov    %r14,%rdi
  1087b8:	e8 03 55 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  1087bd:	48 8b b5 68 02 00 00 	mov    0x268(%rbp),%rsi
  1087c4:	48 8b 95 70 02 00 00 	mov    0x270(%rbp),%rdx
  1087cb:	4c 89 f9             	mov    %r15,%rcx
  1087ce:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  1087d5:	00 
  1087d6:	4c 8d 05 a5 29 0e 00 	lea    0xe29a5(%rip),%r8        # 1eb182 <_fini+0x5a3e>
  1087dd:	e8 de 54 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  1087e2:	45 31 f6             	xor    %r14d,%r14d
  1087e5:	48 8d 2d 67 ee 0e 00 	lea    0xeee67(%rip),%rbp        # 1f7653 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7753>
  1087ec:	48 8b 84 24 40 07 00 	mov    0x740(%rsp),%rax
  1087f3:	00 
  1087f4:	48 89 ea             	mov    %rbp,%rdx
  1087f7:	48 89 de             	mov    %rbx,%rsi
  1087fa:	4a 8d 04 f0          	lea    (%rax,%r14,8),%rax
  1087fe:	44 8b 20             	mov    (%rax),%r12d
  108801:	44 8b 68 04          	mov    0x4(%rax),%r13d
  108805:	44 89 e7             	mov    %r12d,%edi
  108808:	e8 93 2a f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10880d:	48 89 ea             	mov    %rbp,%rdx
  108810:	48 89 de             	mov    %rbx,%rsi
  108813:	44 89 ef             	mov    %r13d,%edi
  108816:	e8 85 2a f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10881b:	45 39 ec             	cmp    %r13d,%r12d
  10881e:	0f 84 2c fb f6 ff    	je     78350 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xeae>
  108824:	48 8b 94 24 60 07 00 	mov    0x760(%rsp),%rdx
  10882b:	00 
  10882c:	f3 0f 10 05 58 6f 0e 	movss  0xe6f58(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  108833:	00 
  108834:	4a 8d 04 b5 00 00 00 	lea    0x0(,%r14,4),%rax
  10883b:	00 
  10883c:	f3 42 0f 10 3c b2    	movss  (%rdx,%r14,4),%xmm7
  108842:	0f 28 cf             	movaps %xmm7,%xmm1
  108845:	0f 54 0d 54 6f 0e 00 	andps  0xe6f54(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10884c:	f3 0f 11 3c 24       	movss  %xmm7,(%rsp)
  108851:	0f 2e c1             	ucomiss %xmm1,%xmm0
  108854:	0f 82 14 fc f6 ff    	jb     7846e <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xfcc>
  10885a:	66 0f ef c9          	pxor   %xmm1,%xmm1
  10885e:	0f 2f cf             	comiss %xmm7,%xmm1
  108861:	0f 87 07 fc f6 ff    	ja     7846e <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xfcc>
  108867:	48 8b 94 24 80 07 00 	mov    0x780(%rsp),%rdx
  10886e:	00 
  10886f:	f3 0f 10 14 02       	movss  (%rdx,%rax,1),%xmm2
  108874:	0f 28 da             	movaps %xmm2,%xmm3
  108877:	0f 54 1d 22 6f 0e 00 	andps  0xe6f22(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10887e:	0f 2e c3             	ucomiss %xmm3,%xmm0
  108881:	0f 82 83 3f 00 00    	jb     10c80a <synreal::SolverNewton::precompute_matrices()+0x849a>
  108887:	0f 2f ca             	comiss %xmm2,%xmm1
  10888a:	0f 83 10 fc f6 ff    	jae    784a0 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xffe>
  108890:	0f 2e f9             	ucomiss %xmm1,%xmm7
  108893:	7a 06                	jp     10889b <synreal::SolverNewton::precompute_matrices()+0x452b>
  108895:	0f 84 05 01 00 00    	je     1089a0 <synreal::SolverNewton::precompute_matrices()+0x4630>
  10889b:	49 63 c4             	movslq %r12d,%rax
  10889e:	f3 0f 10 24 24       	movss  (%rsp),%xmm4
  1088a3:	49 63 f5             	movslq %r13d,%rsi
  1088a6:	48 89 ea             	mov    %rbp,%rdx
  1088a9:	48 8b 8c 24 80 00 00 	mov    0x80(%rsp),%rcx
  1088b0:	00 
  1088b1:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  1088b6:	44 89 e7             	mov    %r12d,%edi
  1088b9:	48 89 74 24 20       	mov    %rsi,0x20(%rsp)
  1088be:	48 8d 04 81          	lea    (%rcx,%rax,4),%rax
  1088c2:	44 89 ac 24 e8 02 00 	mov    %r13d,0x2e8(%rsp)
  1088c9:	00 
  1088ca:	f3 0f 10 00          	movss  (%rax),%xmm0
  1088ce:	f3 0f 58 c4          	addss  %xmm4,%xmm0
  1088d2:	f3 0f 11 00          	movss  %xmm0,(%rax)
  1088d6:	48 8d 04 b1          	lea    (%rcx,%rsi,4),%rax
  1088da:	48 89 de             	mov    %rbx,%rsi
  1088dd:	f3 0f 58 20          	addss  (%rax),%xmm4
  1088e1:	f3 0f 11 20          	movss  %xmm4,(%rax)
  1088e5:	e8 b6 29 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  1088ea:	8b bc 24 e8 02 00 00 	mov    0x2e8(%rsp),%edi
  1088f1:	48 89 ea             	mov    %rbp,%rdx
  1088f4:	48 89 de             	mov    %rbx,%rsi
  1088f7:	e8 a4 29 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  1088fc:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  108901:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  108906:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  10890a:	48 c1 e0 04          	shl    $0x4,%rax
  10890e:	4c 8d 0c 07          	lea    (%rdi,%rax,1),%r9
  108912:	49 8b 41 10          	mov    0x10(%r9),%rax
  108916:	4d 8d 41 08          	lea    0x8(%r9),%r8
  10891a:	48 85 c0             	test   %rax,%rax
  10891d:	0f 84 6a 3b 00 00    	je     10c48d <synreal::SolverNewton::precompute_matrices()+0x811d>
  108923:	8b bc 24 e8 02 00 00 	mov    0x2e8(%rsp),%edi
  10892a:	4c 89 c6             	mov    %r8,%rsi
  10892d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  108931:	48 8b 48 18          	mov    0x18(%rax),%rcx
  108935:	3b 78 20             	cmp    0x20(%rax),%edi
  108938:	7f 1c                	jg     108956 <synreal::SolverNewton::precompute_matrices()+0x45e6>
  10893a:	48 89 c6             	mov    %rax,%rsi
  10893d:	48 85 d2             	test   %rdx,%rdx
  108940:	0f 84 c7 00 00 00    	je     108a0d <synreal::SolverNewton::precompute_matrices()+0x469d>
  108946:	48 89 d0             	mov    %rdx,%rax
  108949:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10894d:	48 8b 48 18          	mov    0x18(%rax),%rcx
  108951:	3b 78 20             	cmp    0x20(%rax),%edi
  108954:	7e e4                	jle    10893a <synreal::SolverNewton::precompute_matrices()+0x45ca>
  108956:	48 85 c9             	test   %rcx,%rcx
  108959:	0f 84 ae 00 00 00    	je     108a0d <synreal::SolverNewton::precompute_matrices()+0x469d>
  10895f:	48 89 c8             	mov    %rcx,%rax
  108962:	eb c9                	jmp    10892d <synreal::SolverNewton::precompute_matrices()+0x45bd>
  108964:	4c 39 c6             	cmp    %r8,%rsi
  108967:	74 05                	je     10896e <synreal::SolverNewton::precompute_matrices()+0x45fe>
  108969:	3b 7e 20             	cmp    0x20(%rsi),%edi
  10896c:	7d 23                	jge    108991 <synreal::SolverNewton::precompute_matrices()+0x4621>
  10896e:	48 8d 84 24 ec 02 00 	lea    0x2ec(%rsp),%rax
  108975:	00 
  108976:	48 8d 94 24 68 03 00 	lea    0x368(%rsp),%rdx
  10897d:	00 
  10897e:	4c 89 cf             	mov    %r9,%rdi
  108981:	48 89 84 24 68 03 00 	mov    %rax,0x368(%rsp)
  108988:	00 
  108989:	e8 f2 80 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10898e:	48 89 c6             	mov    %rax,%rsi
  108991:	f3 0f 10 46 24       	movss  0x24(%rsi),%xmm0
  108996:	f3 0f 5c 04 24       	subss  (%rsp),%xmm0
  10899b:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  1089a0:	49 83 c6 01          	add    $0x1,%r14
  1089a4:	4d 39 f7             	cmp    %r14,%r15
  1089a7:	0f 85 3f fe ff ff    	jne    1087ec <synreal::SolverNewton::precompute_matrices()+0x447c>
  1089ad:	48 8b bc 24 80 07 00 	mov    0x780(%rsp),%rdi
  1089b4:	00 
  1089b5:	48 85 ff             	test   %rdi,%rdi
  1089b8:	74 10                	je     1089ca <synreal::SolverNewton::precompute_matrices()+0x465a>
  1089ba:	48 8b b4 24 90 07 00 	mov    0x790(%rsp),%rsi
  1089c1:	00 
  1089c2:	48 29 fe             	sub    %rdi,%rsi
  1089c5:	e8 e6 47 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1089ca:	48 8b bc 24 60 07 00 	mov    0x760(%rsp),%rdi
  1089d1:	00 
  1089d2:	48 85 ff             	test   %rdi,%rdi
  1089d5:	74 10                	je     1089e7 <synreal::SolverNewton::precompute_matrices()+0x4677>
  1089d7:	48 8b b4 24 70 07 00 	mov    0x770(%rsp),%rsi
  1089de:	00 
  1089df:	48 29 fe             	sub    %rdi,%rsi
  1089e2:	e8 c9 47 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1089e7:	48 8b bc 24 40 07 00 	mov    0x740(%rsp),%rdi
  1089ee:	00 
  1089ef:	48 85 ff             	test   %rdi,%rdi
  1089f2:	0f 84 85 cc ff ff    	je     10567d <synreal::SolverNewton::precompute_matrices()+0x130d>
  1089f8:	48 8b b4 24 50 07 00 	mov    0x750(%rsp),%rsi
  1089ff:	00 
  108a00:	48 29 fe             	sub    %rdi,%rsi
  108a03:	e8 a8 47 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  108a08:	e9 70 cc ff ff       	jmp    10567d <synreal::SolverNewton::precompute_matrices()+0x130d>
  108a0d:	4c 39 c6             	cmp    %r8,%rsi
  108a10:	74 05                	je     108a17 <synreal::SolverNewton::precompute_matrices()+0x46a7>
  108a12:	3b 7e 20             	cmp    0x20(%rsi),%edi
  108a15:	7d 23                	jge    108a3a <synreal::SolverNewton::precompute_matrices()+0x46ca>
  108a17:	48 8d 84 24 e8 02 00 	lea    0x2e8(%rsp),%rax
  108a1e:	00 
  108a1f:	48 8d 94 24 60 03 00 	lea    0x360(%rsp),%rdx
  108a26:	00 
  108a27:	4c 89 cf             	mov    %r9,%rdi
  108a2a:	48 89 84 24 60 03 00 	mov    %rax,0x360(%rsp)
  108a31:	00 
  108a32:	e8 49 80 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  108a37:	48 89 c6             	mov    %rax,%rsi
  108a3a:	f3 0f 10 46 24       	movss  0x24(%rsi),%xmm0
  108a3f:	f3 0f 5c 04 24       	subss  (%rsp),%xmm0
  108a44:	48 89 ea             	mov    %rbp,%rdx
  108a47:	44 89 ef             	mov    %r13d,%edi
  108a4a:	44 89 a4 24 ec 02 00 	mov    %r12d,0x2ec(%rsp)
  108a51:	00 
  108a52:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  108a57:	48 89 de             	mov    %rbx,%rsi
  108a5a:	e8 41 28 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  108a5f:	8b bc 24 ec 02 00 00 	mov    0x2ec(%rsp),%edi
  108a66:	48 89 ea             	mov    %rbp,%rdx
  108a69:	48 89 de             	mov    %rbx,%rsi
  108a6c:	e8 2f 28 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  108a71:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  108a76:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
  108a7b:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  108a7f:	48 c1 e0 04          	shl    $0x4,%rax
  108a83:	4c 8d 0c 01          	lea    (%rcx,%rax,1),%r9
  108a87:	49 8b 41 10          	mov    0x10(%r9),%rax
  108a8b:	4d 8d 41 08          	lea    0x8(%r9),%r8
  108a8f:	48 85 c0             	test   %rax,%rax
  108a92:	0f 84 ed 39 00 00    	je     10c485 <synreal::SolverNewton::precompute_matrices()+0x8115>
  108a98:	8b bc 24 ec 02 00 00 	mov    0x2ec(%rsp),%edi
  108a9f:	4c 89 c6             	mov    %r8,%rsi
  108aa2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  108aa6:	48 8b 48 18          	mov    0x18(%rax),%rcx
  108aaa:	3b 78 20             	cmp    0x20(%rax),%edi
  108aad:	7f 1c                	jg     108acb <synreal::SolverNewton::precompute_matrices()+0x475b>
  108aaf:	48 89 c6             	mov    %rax,%rsi
  108ab2:	48 85 d2             	test   %rdx,%rdx
  108ab5:	0f 84 a9 fe ff ff    	je     108964 <synreal::SolverNewton::precompute_matrices()+0x45f4>
  108abb:	48 89 d0             	mov    %rdx,%rax
  108abe:	48 8b 50 10          	mov    0x10(%rax),%rdx
  108ac2:	48 8b 48 18          	mov    0x18(%rax),%rcx
  108ac6:	3b 78 20             	cmp    0x20(%rax),%edi
  108ac9:	7e e4                	jle    108aaf <synreal::SolverNewton::precompute_matrices()+0x473f>
  108acb:	48 85 c9             	test   %rcx,%rcx
  108ace:	0f 84 90 fe ff ff    	je     108964 <synreal::SolverNewton::precompute_matrices()+0x45f4>
  108ad4:	48 89 c8             	mov    %rcx,%rax
  108ad7:	eb c9                	jmp    108aa2 <synreal::SolverNewton::precompute_matrices()+0x4732>
  108ad9:	48 c7 44 24 78 00 00 	movq   $0x0,0x78(%rsp)
  108ae0:	00 00 
  108ae2:	31 ed                	xor    %ebp,%ebp
  108ae4:	48 c7 84 24 a0 00 00 	movq   $0x0,0xa0(%rsp)
  108aeb:	00 00 00 00 00 
  108af0:	48 c7 84 24 00 01 00 	movq   $0x0,0x100(%rsp)
  108af7:	00 00 00 00 00 
  108afc:	48 c7 84 24 a8 00 00 	movq   $0x0,0xa8(%rsp)
  108b03:	00 00 00 00 00 
  108b08:	48 c7 84 24 a8 01 00 	movq   $0x0,0x1a8(%rsp)
  108b0f:	00 00 00 00 00 
  108b14:	48 89 ac 24 f0 01 00 	mov    %rbp,0x1f0(%rsp)
  108b1b:	00 
  108b1c:	48 89 ac 24 80 01 00 	mov    %rbp,0x180(%rsp)
  108b23:	00 
  108b24:	48 89 ac 24 88 01 00 	mov    %rbp,0x188(%rsp)
  108b2b:	00 
  108b2c:	48 89 ac 24 f8 01 00 	mov    %rbp,0x1f8(%rsp)
  108b33:	00 
  108b34:	48 89 ac 24 a0 01 00 	mov    %rbp,0x1a0(%rsp)
  108b3b:	00 
  108b3c:	48 89 ac 24 e0 01 00 	mov    %rbp,0x1e0(%rsp)
  108b43:	00 
  108b44:	48 89 ac 24 d8 01 00 	mov    %rbp,0x1d8(%rsp)
  108b4b:	00 
  108b4c:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
  108b53:	00 00 
  108b55:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
  108b5c:	00 00 
  108b5e:	48 c7 84 24 f8 00 00 	movq   $0x0,0xf8(%rsp)
  108b65:	00 00 00 00 00 
  108b6a:	48 c7 84 24 30 01 00 	movq   $0x0,0x130(%rsp)
  108b71:	00 00 00 00 00 
  108b76:	48 c7 84 24 d8 00 00 	movq   $0x0,0xd8(%rsp)
  108b7d:	00 00 00 00 00 
  108b82:	48 c7 84 24 c8 00 00 	movq   $0x0,0xc8(%rsp)
  108b89:	00 00 00 00 00 
  108b8e:	48 c7 84 24 b8 00 00 	movq   $0x0,0xb8(%rsp)
  108b95:	00 00 00 00 00 
  108b9a:	48 c7 84 24 c0 00 00 	movq   $0x0,0xc0(%rsp)
  108ba1:	00 00 00 00 00 
  108ba6:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
  108bad:	00 00 
  108baf:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
  108bb6:	00 00 
  108bb8:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
  108bbf:	00 00 
  108bc1:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
  108bc8:	00 00 
  108bca:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
  108bd1:	00 00 
  108bd3:	48 c7 84 24 58 01 00 	movq   $0x0,0x158(%rsp)
  108bda:	00 00 00 00 00 
  108bdf:	e9 d7 d8 ff ff       	jmp    1064bb <synreal::SolverNewton::precompute_matrices()+0x214b>
  108be4:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  108be9:	89 c5                	mov    %eax,%ebp
  108beb:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  108bf2:	00 
  108bf3:	4c 8d 05 bc 22 0e 00 	lea    0xe22bc(%rip),%r8        # 1eaeb6 <_fini+0x5772>
  108bfa:	48 89 e9             	mov    %rbp,%rcx
  108bfd:	4c 89 ef             	mov    %r13,%rdi
  108c00:	48 89 2c 24          	mov    %rbp,(%rsp)
  108c04:	49 8b b7 e8 02 00 00 	mov    0x2e8(%r15),%rsi
  108c0b:	49 8b 97 f0 02 00 00 	mov    0x2f0(%r15),%rdx
  108c12:	e8 d9 69 f6 ff       	call   6f5f0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  108c17:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  108c1e:	00 
  108c1f:	49 8b b7 f8 02 00 00 	mov    0x2f8(%r15),%rsi
  108c26:	48 89 e9             	mov    %rbp,%rcx
  108c29:	49 8b 97 00 03 00 00 	mov    0x300(%r15),%rdx
  108c30:	4c 8d 05 93 22 0e 00 	lea    0xe2293(%rip),%r8        # 1eaeca <_fini+0x5786>
  108c37:	4c 89 f7             	mov    %r14,%rdi
  108c3a:	e8 41 4c f6 ff       	call   6d880 <std::vector<glm::mat<3, 3, float, (glm::qualifier)0>, std::allocator<glm::mat<3, 3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::mat<3, 3, float, (glm::qualifier)0> >(synreal::Span<glm::mat<3, 3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  108c3f:	49 8b b7 08 03 00 00 	mov    0x308(%r15),%rsi
  108c46:	49 8b 97 10 03 00 00 	mov    0x310(%r15),%rdx
  108c4d:	48 89 e9             	mov    %rbp,%rcx
  108c50:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  108c57:	00 
  108c58:	4c 8d 05 83 22 0e 00 	lea    0xe2283(%rip),%r8        # 1eaee2 <_fini+0x579e>
  108c5f:	e8 4c 41 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  108c64:	48 8d 84 24 d0 07 00 	lea    0x7d0(%rsp),%rax
  108c6b:	00 
  108c6c:	45 31 ed             	xor    %r13d,%r13d
  108c6f:	45 31 f6             	xor    %r14d,%r14d
  108c72:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  108c77:	4c 8d bc 24 e0 07 00 	lea    0x7e0(%rsp),%r15
  108c7e:	00 
  108c7f:	4c 8d 25 11 ea 0e 00 	lea    0xeea11(%rip),%r12        # 1f7697 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7797>
  108c86:	4c 89 f0             	mov    %r14,%rax
  108c89:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
  108c8e:	48 c1 e0 04          	shl    $0x4,%rax
  108c92:	48 03 84 24 40 07 00 	add    0x740(%rsp),%rax
  108c99:	00 
  108c9a:	66 0f 6e 70 0c       	movd   0xc(%rax),%xmm6
  108c9f:	66 0f 6e 78 08       	movd   0x8(%rax),%xmm7
  108ca4:	f3 0f 6f 00          	movdqu (%rax),%xmm0
  108ca8:	66 0f 6e 68 04       	movd   0x4(%rax),%xmm5
  108cad:	66 0f 7e 74 24 58    	movd   %xmm6,0x58(%rsp)
  108cb3:	66 0f 7e 7c 24 38    	movd   %xmm7,0x38(%rsp)
  108cb9:	66 0f 7e 6c 24 20    	movd   %xmm5,0x20(%rsp)
  108cbf:	66 0f 7e 44 24 48    	movd   %xmm0,0x48(%rsp)
  108cc5:	0f 29 84 24 d0 07 00 	movaps %xmm0,0x7d0(%rsp)
  108ccc:	00 
  108ccd:	8b 7d 00             	mov    0x0(%rbp),%edi
  108cd0:	4c 89 e2             	mov    %r12,%rdx
  108cd3:	48 89 de             	mov    %rbx,%rsi
  108cd6:	e8 c5 25 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  108cdb:	48 83 c5 04          	add    $0x4,%rbp
  108cdf:	4c 39 fd             	cmp    %r15,%rbp
  108ce2:	75 e9                	jne    108ccd <synreal::SolverNewton::precompute_matrices()+0x495d>
  108ce4:	8b 44 24 20          	mov    0x20(%rsp),%eax
  108ce8:	8b 74 24 48          	mov    0x48(%rsp),%esi
  108cec:	39 f0                	cmp    %esi,%eax
  108cee:	0f 84 5d fb f6 ff    	je     78851 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13af>
  108cf4:	8b 7c 24 38          	mov    0x38(%rsp),%edi
  108cf8:	39 f7                	cmp    %esi,%edi
  108cfa:	0f 84 51 fb f6 ff    	je     78851 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13af>
  108d00:	8b 4c 24 58          	mov    0x58(%rsp),%ecx
  108d04:	39 ce                	cmp    %ecx,%esi
  108d06:	0f 84 45 fb f6 ff    	je     78851 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13af>
  108d0c:	39 f8                	cmp    %edi,%eax
  108d0e:	0f 84 3d fb f6 ff    	je     78851 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13af>
  108d14:	39 c8                	cmp    %ecx,%eax
  108d16:	0f 84 35 fb f6 ff    	je     78851 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13af>
  108d1c:	39 cf                	cmp    %ecx,%edi
  108d1e:	0f 84 2d fb f6 ff    	je     78851 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13af>
  108d24:	48 8b bc 24 60 07 00 	mov    0x760(%rsp),%rdi
  108d2b:	00 
  108d2c:	4b 8d 44 6d 00       	lea    0x0(%r13,%r13,2),%rax
  108d31:	f3 0f 10 05 53 6a 0e 	movss  0xe6a53(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  108d38:	00 
  108d39:	48 01 f8             	add    %rdi,%rax
  108d3c:	f3 44 0f 10 10       	movss  (%rax),%xmm10
  108d41:	f3 44 0f 10 48 04    	movss  0x4(%rax),%xmm9
  108d47:	f3 0f 10 68 08       	movss  0x8(%rax),%xmm5
  108d4c:	41 0f 28 ca          	movaps %xmm10,%xmm1
  108d50:	0f 54 0d 49 6a 0e 00 	andps  0xe6a49(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108d57:	0f 2e c1             	ucomiss %xmm1,%xmm0
  108d5a:	0f 82 5f 3d 00 00    	jb     10cabf <synreal::SolverNewton::precompute_matrices()+0x874f>
  108d60:	41 0f 28 c9          	movaps %xmm9,%xmm1
  108d64:	0f 54 0d 35 6a 0e 00 	andps  0xe6a35(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108d6b:	0f 2e c1             	ucomiss %xmm1,%xmm0
  108d6e:	0f 82 18 fb f6 ff    	jb     7888c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13ea>
  108d74:	0f 28 cd             	movaps %xmm5,%xmm1
  108d77:	0f 54 0d 22 6a 0e 00 	andps  0xe6a22(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108d7e:	0f 2e c1             	ucomiss %xmm1,%xmm0
  108d81:	0f 82 05 fb f6 ff    	jb     7888c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13ea>
  108d87:	f3 44 0f 10 40 0c    	movss  0xc(%rax),%xmm8
  108d8d:	f3 0f 10 70 10       	movss  0x10(%rax),%xmm6
  108d92:	f3 0f 10 60 14       	movss  0x14(%rax),%xmm4
  108d97:	41 0f 28 c8          	movaps %xmm8,%xmm1
  108d9b:	0f 54 0d fe 69 0e 00 	andps  0xe69fe(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108da2:	0f 2e c1             	ucomiss %xmm1,%xmm0
  108da5:	0f 82 e1 fa f6 ff    	jb     7888c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13ea>
  108dab:	0f 28 ce             	movaps %xmm6,%xmm1
  108dae:	0f 54 0d eb 69 0e 00 	andps  0xe69eb(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108db5:	0f 2e c1             	ucomiss %xmm1,%xmm0
  108db8:	0f 82 ce fa f6 ff    	jb     7888c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13ea>
  108dbe:	0f 28 cc             	movaps %xmm4,%xmm1
  108dc1:	0f 54 0d d8 69 0e 00 	andps  0xe69d8(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108dc8:	0f 2e c1             	ucomiss %xmm1,%xmm0
  108dcb:	0f 82 bb fa f6 ff    	jb     7888c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13ea>
  108dd1:	f3 0f 10 78 18       	movss  0x18(%rax),%xmm7
  108dd6:	f3 0f 10 50 1c       	movss  0x1c(%rax),%xmm2
  108ddb:	f3 0f 10 58 20       	movss  0x20(%rax),%xmm3
  108de0:	0f 28 cf             	movaps %xmm7,%xmm1
  108de3:	0f 54 0d b6 69 0e 00 	andps  0xe69b6(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108dea:	0f 2e c1             	ucomiss %xmm1,%xmm0
  108ded:	0f 82 99 fa f6 ff    	jb     7888c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13ea>
  108df3:	0f 28 ca             	movaps %xmm2,%xmm1
  108df6:	0f 54 0d a3 69 0e 00 	andps  0xe69a3(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108dfd:	0f 2e c1             	ucomiss %xmm1,%xmm0
  108e00:	0f 82 86 fa f6 ff    	jb     7888c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13ea>
  108e06:	0f 28 cb             	movaps %xmm3,%xmm1
  108e09:	0f 54 0d 90 69 0e 00 	andps  0xe6990(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108e10:	0f 2e c1             	ucomiss %xmm1,%xmm0
  108e13:	0f 82 73 fa f6 ff    	jb     7888c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13ea>
  108e19:	0f 28 ce             	movaps %xmm6,%xmm1
  108e1c:	44 0f 28 da          	movaps %xmm2,%xmm11
  108e20:	f3 0f 59 cb          	mulss  %xmm3,%xmm1
  108e24:	f3 44 0f 59 dc       	mulss  %xmm4,%xmm11
  108e29:	f3 41 0f 59 d8       	mulss  %xmm8,%xmm3
  108e2e:	f3 0f 59 e7          	mulss  %xmm7,%xmm4
  108e32:	f3 0f 59 f7          	mulss  %xmm7,%xmm6
  108e36:	66 0f ef ff          	pxor   %xmm7,%xmm7
  108e3a:	f3 41 0f 59 d0       	mulss  %xmm8,%xmm2
  108e3f:	f3 0f 11 7c 24 48    	movss  %xmm7,0x48(%rsp)
  108e45:	f3 41 0f 5c cb       	subss  %xmm11,%xmm1
  108e4a:	f3 0f 5c dc          	subss  %xmm4,%xmm3
  108e4e:	f3 41 0f 59 ca       	mulss  %xmm10,%xmm1
  108e53:	f3 0f 5c d6          	subss  %xmm6,%xmm2
  108e57:	f3 41 0f 59 d9       	mulss  %xmm9,%xmm3
  108e5c:	f3 0f 59 d5          	mulss  %xmm5,%xmm2
  108e60:	f3 0f 5c cb          	subss  %xmm3,%xmm1
  108e64:	f3 0f 58 ca          	addss  %xmm2,%xmm1
  108e68:	0f 2f cf             	comiss %xmm7,%xmm1
  108e6b:	0f 86 53 3c 00 00    	jbe    10cac4 <synreal::SolverNewton::precompute_matrices()+0x8754>
  108e71:	0f 28 d1             	movaps %xmm1,%xmm2
  108e74:	0f 54 15 25 69 0e 00 	andps  0xe6925(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108e7b:	0f 2e c2             	ucomiss %xmm2,%xmm0
  108e7e:	0f 82 27 f8 f6 ff    	jb     786ab <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1209>
  108e84:	f3 0f 59 0d 00 f1 0e 	mulss  0xef100(%rip),%xmm1        # 1f7f8c <cuda::std::__4::in_place+0x3f>
  108e8b:	00 
  108e8c:	f3 0f 10 15 ec f0 0e 	movss  0xef0ec(%rip),%xmm2        # 1f7f80 <cuda::std::__4::in_place+0x33>
  108e93:	00 
  108e94:	f3 0f 5e d1          	divss  %xmm1,%xmm2
  108e98:	0f 2f 54 24 48       	comiss 0x48(%rsp),%xmm2
  108e9d:	0f 86 62 39 00 00    	jbe    10c805 <synreal::SolverNewton::precompute_matrices()+0x8495>
  108ea3:	0f 28 ca             	movaps %xmm2,%xmm1
  108ea6:	0f 54 0d f3 68 0e 00 	andps  0xe68f3(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108ead:	0f 2e c1             	ucomiss %xmm1,%xmm0
  108eb0:	0f 82 7d f5 f6 ff    	jb     78433 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xf91>
  108eb6:	48 8b 84 24 20 01 00 	mov    0x120(%rsp),%rax
  108ebd:	00 
  108ebe:	4c 8b 84 24 80 07 00 	mov    0x780(%rsp),%r8
  108ec5:	00 
  108ec6:	f3 42 0f 11 14 b0    	movss  %xmm2,(%rax,%r14,4)
  108ecc:	4b 8d 04 28          	lea    (%r8,%r13,1),%rax
  108ed0:	f3 0f 10 18          	movss  (%rax),%xmm3
  108ed4:	f3 0f 10 50 04       	movss  0x4(%rax),%xmm2
  108ed9:	f3 0f 10 48 08       	movss  0x8(%rax),%xmm1
  108ede:	0f 28 e3             	movaps %xmm3,%xmm4
  108ee1:	0f 54 25 b8 68 0e 00 	andps  0xe68b8(%rip),%xmm4        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108ee8:	0f 2e c4             	ucomiss %xmm4,%xmm0
  108eeb:	0f 82 0f 39 00 00    	jb     10c800 <synreal::SolverNewton::precompute_matrices()+0x8490>
  108ef1:	0f 28 e2             	movaps %xmm2,%xmm4
  108ef4:	0f 54 25 a5 68 0e 00 	andps  0xe68a5(%rip),%xmm4        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108efb:	0f 2e c4             	ucomiss %xmm4,%xmm0
  108efe:	0f 82 8a f4 f6 ff    	jb     7838e <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xeec>
  108f04:	0f 28 e1             	movaps %xmm1,%xmm4
  108f07:	0f 54 25 92 68 0e 00 	andps  0xe6892(%rip),%xmm4        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  108f0e:	0f 2e c4             	ucomiss %xmm4,%xmm0
  108f11:	0f 82 77 f4 f6 ff    	jb     7838e <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xeec>
  108f17:	0f 2f fb             	comiss %xmm3,%xmm7
  108f1a:	0f 87 6e f4 f6 ff    	ja     7838e <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xeec>
  108f20:	0f 2f fa             	comiss %xmm2,%xmm7
  108f23:	0f 87 65 f4 f6 ff    	ja     7838e <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xeec>
  108f29:	0f 2f f9             	comiss %xmm1,%xmm7
  108f2c:	0f 87 5c f4 f6 ff    	ja     7838e <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xeec>
  108f32:	49 83 c6 01          	add    $0x1,%r14
  108f36:	49 83 c5 0c          	add    $0xc,%r13
  108f3a:	4c 39 34 24          	cmp    %r14,(%rsp)
  108f3e:	0f 85 42 fd ff ff    	jne    108c86 <synreal::SolverNewton::precompute_matrices()+0x4916>
  108f44:	4d 85 c0             	test   %r8,%r8
  108f47:	74 1b                	je     108f64 <synreal::SolverNewton::precompute_matrices()+0x4bf4>
  108f49:	48 8b b4 24 90 07 00 	mov    0x790(%rsp),%rsi
  108f50:	00 
  108f51:	4c 89 c7             	mov    %r8,%rdi
  108f54:	4c 29 c6             	sub    %r8,%rsi
  108f57:	e8 54 42 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  108f5c:	48 8b bc 24 60 07 00 	mov    0x760(%rsp),%rdi
  108f63:	00 
  108f64:	48 85 ff             	test   %rdi,%rdi
  108f67:	74 10                	je     108f79 <synreal::SolverNewton::precompute_matrices()+0x4c09>
  108f69:	48 8b b4 24 70 07 00 	mov    0x770(%rsp),%rsi
  108f70:	00 
  108f71:	48 29 fe             	sub    %rdi,%rsi
  108f74:	e8 37 42 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  108f79:	48 8b bc 24 40 07 00 	mov    0x740(%rsp),%rdi
  108f80:	00 
  108f81:	48 85 ff             	test   %rdi,%rdi
  108f84:	0f 84 6c c7 ff ff    	je     1056f6 <synreal::SolverNewton::precompute_matrices()+0x1386>
  108f8a:	48 8b b4 24 50 07 00 	mov    0x750(%rsp),%rsi
  108f91:	00 
  108f92:	48 29 fe             	sub    %rdi,%rsi
  108f95:	e8 16 42 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  108f9a:	e9 57 c7 ff ff       	jmp    1056f6 <synreal::SolverNewton::precompute_matrices()+0x1386>
  108f9f:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  108fa4:	89 c5                	mov    %eax,%ebp
  108fa6:	48 8d bc 24 20 07 00 	lea    0x720(%rsp),%rdi
  108fad:	00 
  108fae:	4c 8d 05 87 1f 0e 00 	lea    0xe1f87(%rip),%r8        # 1eaf3c <_fini+0x57f8>
  108fb5:	48 89 e9             	mov    %rbp,%rcx
  108fb8:	48 89 ac 24 d8 00 00 	mov    %rbp,0xd8(%rsp)
  108fbf:	00 
  108fc0:	49 8b b7 80 02 00 00 	mov    0x280(%r15),%rsi
  108fc7:	49 8b 97 88 02 00 00 	mov    0x288(%r15),%rdx
  108fce:	e8 5d 5f f6 ff       	call   6ef30 <std::vector<glm::vec<3, int, (glm::qualifier)0>, std::allocator<glm::vec<3, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, int, (glm::qualifier)0> >(synreal::Span<glm::vec<3, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  108fd3:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  108fda:	00 
  108fdb:	49 8b b7 a0 02 00 00 	mov    0x2a0(%r15),%rsi
  108fe2:	48 89 e9             	mov    %rbp,%rcx
  108fe5:	49 8b 97 a8 02 00 00 	mov    0x2a8(%r15),%rdx
  108fec:	4c 8d 05 6c 1e 0e 00 	lea    0xe1e6c(%rip),%r8        # 1eae5f <_fini+0x571b>
  108ff3:	4c 89 ef             	mov    %r13,%rdi
  108ff6:	e8 45 62 f6 ff       	call   6f240 <std::vector<glm::mat<2, 2, float, (glm::qualifier)0>, std::allocator<glm::mat<2, 2, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::mat<2, 2, float, (glm::qualifier)0> >(synreal::Span<glm::mat<2, 2, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  108ffb:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  109002:	00 
  109003:	49 8b b7 90 02 00 00 	mov    0x290(%r15),%rsi
  10900a:	48 89 e9             	mov    %rbp,%rcx
  10900d:	49 8b 97 98 02 00 00 	mov    0x298(%r15),%rdx
  109014:	4c 8d 05 30 1e 0e 00 	lea    0xe1e30(%rip),%r8        # 1eae4b <_fini+0x5707>
  10901b:	4c 89 f7             	mov    %r14,%rdi
  10901e:	e8 9d 4c f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  109023:	49 8b b7 c0 02 00 00 	mov    0x2c0(%r15),%rsi
  10902a:	49 8b 97 c8 02 00 00 	mov    0x2c8(%r15),%rdx
  109031:	48 89 e9             	mov    %rbp,%rcx
  109034:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  10903b:	00 
  10903c:	4c 8d 05 3d 1e 0e 00 	lea    0xe1e3d(%rip),%r8        # 1eae80 <_fini+0x573c>
  109043:	e8 68 3d f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  109048:	48 8d 84 24 b0 07 00 	lea    0x7b0(%rsp),%rax
  10904f:	00 
  109050:	4c 8d 2d 37 e6 0e 00 	lea    0xee637(%rip),%r13        # 1f768e <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x778e>
  109057:	48 c7 44 24 78 00 00 	movq   $0x0,0x78(%rsp)
  10905e:	00 00 
  109060:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  109065:	48 8d 84 24 bc 07 00 	lea    0x7bc(%rsp),%rax
  10906c:	00 
  10906d:	48 89 84 24 c0 00 00 	mov    %rax,0xc0(%rsp)
  109074:	00 
  109075:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  10907a:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
  10907f:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  109083:	4c 8d 24 85 00 00 00 	lea    0x0(,%rax,4),%r12
  10908a:	00 
  10908b:	48 8b 84 24 20 07 00 	mov    0x720(%rsp),%rax
  109092:	00 
  109093:	4c 01 e0             	add    %r12,%rax
  109096:	48 8b 10             	mov    (%rax),%rdx
  109099:	8b 40 08             	mov    0x8(%rax),%eax
  10909c:	48 89 94 24 b0 07 00 	mov    %rdx,0x7b0(%rsp)
  1090a3:	00 
  1090a4:	89 84 24 b8 07 00 00 	mov    %eax,0x7b8(%rsp)
  1090ab:	8b 7d 00             	mov    0x0(%rbp),%edi
  1090ae:	4c 89 ea             	mov    %r13,%rdx
  1090b1:	48 89 de             	mov    %rbx,%rsi
  1090b4:	e8 e7 21 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  1090b9:	48 83 c5 04          	add    $0x4,%rbp
  1090bd:	48 39 ac 24 c0 00 00 	cmp    %rbp,0xc0(%rsp)
  1090c4:	00 
  1090c5:	75 e4                	jne    1090ab <synreal::SolverNewton::precompute_matrices()+0x4d3b>
  1090c7:	48 8b 74 24 78       	mov    0x78(%rsp),%rsi
  1090cc:	4c 03 a4 24 80 07 00 	add    0x780(%rsp),%r12
  1090d3:	00 
  1090d4:	45 31 ff             	xor    %r15d,%r15d
  1090d7:	48 89 f0             	mov    %rsi,%rax
  1090da:	48 c1 e0 04          	shl    $0x4,%rax
  1090de:	48 03 84 24 40 07 00 	add    0x740(%rsp),%rax
  1090e5:	00 
  1090e6:	f3 0f 10 10          	movss  (%rax),%xmm2
  1090ea:	f3 0f 10 40 08       	movss  0x8(%rax),%xmm0
  1090ef:	f3 0f 11 84 24 c8 07 	movss  %xmm0,0x7c8(%rsp)
  1090f6:	00 00 
  1090f8:	0f 28 ca             	movaps %xmm2,%xmm1
  1090fb:	0f 57 0d 5e ee 0e 00 	xorps  0xeee5e(%rip),%xmm1        # 1f7f60 <cuda::std::__4::in_place+0x13>
  109102:	f3 0f 5c c8          	subss  %xmm0,%xmm1
  109106:	0f 28 d9             	movaps %xmm1,%xmm3
  109109:	0f 14 da             	unpcklps %xmm2,%xmm3
  10910c:	f3 0f 10 50 0c       	movss  0xc(%rax),%xmm2
  109111:	0f 13 9c 24 c0 07 00 	movlps %xmm3,0x7c0(%rsp)
  109118:	00 
  109119:	f3 0f 10 58 04       	movss  0x4(%rax),%xmm3
  10911e:	48 8d 04 b5 00 00 00 	lea    0x0(,%rsi,4),%rax
  109125:	00 
  109126:	f3 0f 11 94 24 d8 07 	movss  %xmm2,0x7d8(%rsp)
  10912d:	00 00 
  10912f:	0f 28 c3             	movaps %xmm3,%xmm0
  109132:	0f 57 05 27 ee 0e 00 	xorps  0xeee27(%rip),%xmm0        # 1f7f60 <cuda::std::__4::in_place+0x13>
  109139:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  10913e:	48 8d 84 24 d0 07 00 	lea    0x7d0(%rsp),%rax
  109145:	00 
  109146:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  10914b:	48 8d 84 24 c0 07 00 	lea    0x7c0(%rsp),%rax
  109152:	00 
  109153:	f3 0f 5c c2          	subss  %xmm2,%xmm0
  109157:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  10915c:	48 8d 84 24 14 03 00 	lea    0x314(%rsp),%rax
  109163:	00 
  109164:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  10916b:	00 
  10916c:	0f 28 e0             	movaps %xmm0,%xmm4
  10916f:	0f 14 e3             	unpcklps %xmm3,%xmm4
  109172:	0f 13 a4 24 d0 07 00 	movlps %xmm4,0x7d0(%rsp)
  109179:	00 
  10917a:	f3 41 0f 10 54 24 08 	movss  0x8(%r12),%xmm2
  109181:	f3 41 0f 10 3c 24    	movss  (%r12),%xmm7
  109187:	f3 0f 58 fa          	addss  %xmm2,%xmm7
  10918b:	f3 41 0f 58 54 24 04 	addss  0x4(%r12),%xmm2
  109192:	f3 0f 11 bc 24 a8 00 	movss  %xmm7,0xa8(%rsp)
  109199:	00 00 
  10919b:	f3 0f 11 94 24 b8 00 	movss  %xmm2,0xb8(%rsp)
  1091a2:	00 00 
  1091a4:	f3 0f 59 8c 24 a8 00 	mulss  0xa8(%rsp),%xmm1
  1091ab:	00 00 
  1091ad:	4c 89 fd             	mov    %r15,%rbp
  1091b0:	f3 0f 59 84 24 b8 00 	mulss  0xb8(%rsp),%xmm0
  1091b7:	00 00 
  1091b9:	f3 0f 11 4c 24 38    	movss  %xmm1,0x38(%rsp)
  1091bf:	f3 0f 11 44 24 48    	movss  %xmm0,0x48(%rsp)
  1091c5:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  1091ca:	f3 0f 10 44 24 38    	movss  0x38(%rsp),%xmm0
  1091d0:	f3 0f 10 4c 24 48    	movss  0x48(%rsp),%xmm1
  1091d6:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
  1091db:	f3 0f 59 04 a8       	mulss  (%rax,%rbp,4),%xmm0
  1091e0:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  1091e5:	f3 0f 59 0c a8       	mulss  (%rax,%rbp,4),%xmm1
  1091ea:	48 8b 84 24 60 07 00 	mov    0x760(%rsp),%rax
  1091f1:	00 
  1091f2:	f3 0f 58 c1          	addss  %xmm1,%xmm0
  1091f6:	f3 0f 59 04 38       	mulss  (%rax,%rdi,1),%xmm0
  1091fb:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
  109200:	f3 0f 11 04 24       	movss  %xmm0,(%rsp)
  109205:	44 39 fd             	cmp    %r15d,%ebp
  109208:	0f 84 ab 01 00 00    	je     1093b9 <synreal::SolverNewton::precompute_matrices()+0x5049>
  10920e:	46 8b 34 b8          	mov    (%rax,%r15,4),%r14d
  109212:	4c 63 24 a8          	movslq (%rax,%rbp,4),%r12
  109216:	4c 89 ea             	mov    %r13,%rdx
  109219:	48 89 de             	mov    %rbx,%rsi
  10921c:	44 89 f7             	mov    %r14d,%edi
  10921f:	44 89 a4 24 10 03 00 	mov    %r12d,0x310(%rsp)
  109226:	00 
  109227:	e8 74 20 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10922c:	8b bc 24 10 03 00 00 	mov    0x310(%rsp),%edi
  109233:	4c 89 ea             	mov    %r13,%rdx
  109236:	48 89 de             	mov    %rbx,%rsi
  109239:	e8 62 20 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10923e:	49 63 c6             	movslq %r14d,%rax
  109241:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  109246:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  10924a:	48 c1 e0 04          	shl    $0x4,%rax
  10924e:	4c 8d 0c 07          	lea    (%rdi,%rax,1),%r9
  109252:	49 8b 41 10          	mov    0x10(%r9),%rax
  109256:	4d 8d 41 08          	lea    0x8(%r9),%r8
  10925a:	48 85 c0             	test   %rax,%rax
  10925d:	0f 84 0e 02 00 00    	je     109471 <synreal::SolverNewton::precompute_matrices()+0x5101>
  109263:	8b bc 24 10 03 00 00 	mov    0x310(%rsp),%edi
  10926a:	4c 89 c6             	mov    %r8,%rsi
  10926d:	eb 0f                	jmp    10927e <synreal::SolverNewton::precompute_matrices()+0x4f0e>
  10926f:	90                   	nop
  109270:	48 89 c6             	mov    %rax,%rsi
  109273:	48 85 c9             	test   %rcx,%rcx
  109276:	74 18                	je     109290 <synreal::SolverNewton::precompute_matrices()+0x4f20>
  109278:	48 89 ca             	mov    %rcx,%rdx
  10927b:	48 89 d0             	mov    %rdx,%rax
  10927e:	48 8b 48 10          	mov    0x10(%rax),%rcx
  109282:	48 8b 50 18          	mov    0x18(%rax),%rdx
  109286:	39 78 20             	cmp    %edi,0x20(%rax)
  109289:	7d e5                	jge    109270 <synreal::SolverNewton::precompute_matrices()+0x4f00>
  10928b:	48 85 d2             	test   %rdx,%rdx
  10928e:	75 eb                	jne    10927b <synreal::SolverNewton::precompute_matrices()+0x4f0b>
  109290:	4c 39 c6             	cmp    %r8,%rsi
  109293:	74 05                	je     10929a <synreal::SolverNewton::precompute_matrices()+0x4f2a>
  109295:	3b 7e 20             	cmp    0x20(%rsi),%edi
  109298:	7d 23                	jge    1092bd <synreal::SolverNewton::precompute_matrices()+0x4f4d>
  10929a:	48 8d 84 24 10 03 00 	lea    0x310(%rsp),%rax
  1092a1:	00 
  1092a2:	48 8d 94 24 e0 05 00 	lea    0x5e0(%rsp),%rdx
  1092a9:	00 
  1092aa:	4c 89 cf             	mov    %r9,%rdi
  1092ad:	48 89 84 24 e0 05 00 	mov    %rax,0x5e0(%rsp)
  1092b4:	00 
  1092b5:	e8 c6 77 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  1092ba:	48 89 c6             	mov    %rax,%rsi
  1092bd:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  1092c2:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  1092c7:	4c 89 ea             	mov    %r13,%rdx
  1092ca:	44 89 e7             	mov    %r12d,%edi
  1092cd:	44 89 b4 24 14 03 00 	mov    %r14d,0x314(%rsp)
  1092d4:	00 
  1092d5:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  1092da:	48 89 de             	mov    %rbx,%rsi
  1092dd:	e8 be 1f f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  1092e2:	8b bc 24 14 03 00 00 	mov    0x314(%rsp),%edi
  1092e9:	4c 89 ea             	mov    %r13,%rdx
  1092ec:	48 89 de             	mov    %rbx,%rsi
  1092ef:	e8 ac 1f f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  1092f4:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  1092f9:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  1092fd:	48 c1 e0 04          	shl    $0x4,%rax
  109301:	4c 8d 0c 06          	lea    (%rsi,%rax,1),%r9
  109305:	49 8b 71 10          	mov    0x10(%r9),%rsi
  109309:	4d 8d 41 08          	lea    0x8(%r9),%r8
  10930d:	48 85 f6             	test   %rsi,%rsi
  109310:	0f 84 53 01 00 00    	je     109469 <synreal::SolverNewton::precompute_matrices()+0x50f9>
  109316:	8b 8c 24 14 03 00 00 	mov    0x314(%rsp),%ecx
  10931d:	4c 89 c7             	mov    %r8,%rdi
  109320:	eb 14                	jmp    109336 <synreal::SolverNewton::precompute_matrices()+0x4fc6>
  109322:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  109328:	48 85 d2             	test   %rdx,%rdx
  10932b:	74 1e                	je     10934b <synreal::SolverNewton::precompute_matrices()+0x4fdb>
  10932d:	48 89 f7             	mov    %rsi,%rdi
  109330:	48 89 d0             	mov    %rdx,%rax
  109333:	48 89 c6             	mov    %rax,%rsi
  109336:	48 8b 56 10          	mov    0x10(%rsi),%rdx
  10933a:	48 8b 46 18          	mov    0x18(%rsi),%rax
  10933e:	3b 4e 20             	cmp    0x20(%rsi),%ecx
  109341:	7e e5                	jle    109328 <synreal::SolverNewton::precompute_matrices()+0x4fb8>
  109343:	48 85 c0             	test   %rax,%rax
  109346:	75 eb                	jne    109333 <synreal::SolverNewton::precompute_matrices()+0x4fc3>
  109348:	48 89 fe             	mov    %rdi,%rsi
  10934b:	4c 39 c6             	cmp    %r8,%rsi
  10934e:	74 05                	je     109355 <synreal::SolverNewton::precompute_matrices()+0x4fe5>
  109350:	3b 4e 20             	cmp    0x20(%rsi),%ecx
  109353:	7d 23                	jge    109378 <synreal::SolverNewton::precompute_matrices()+0x5008>
  109355:	48 8b 84 24 a0 00 00 	mov    0xa0(%rsp),%rax
  10935c:	00 
  10935d:	48 8d 94 24 00 06 00 	lea    0x600(%rsp),%rdx
  109364:	00 
  109365:	4c 89 cf             	mov    %r9,%rdi
  109368:	48 89 84 24 00 06 00 	mov    %rax,0x600(%rsp)
  10936f:	00 
  109370:	e8 0b 77 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  109375:	48 89 c6             	mov    %rax,%rsi
  109378:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  10937d:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  109382:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  109387:	48 83 c5 01          	add    $0x1,%rbp
  10938b:	83 fd 03             	cmp    $0x3,%ebp
  10938e:	0f 85 31 fe ff ff    	jne    1091c5 <synreal::SolverNewton::precompute_matrices()+0x4e55>
  109394:	49 83 c7 01          	add    $0x1,%r15
  109398:	49 83 ff 03          	cmp    $0x3,%r15
  10939c:	74 35                	je     1093d3 <synreal::SolverNewton::precompute_matrices()+0x5063>
  10939e:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  1093a3:	f3 42 0f 10 0c b8    	movss  (%rax,%r15,4),%xmm1
  1093a9:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  1093ae:	f3 42 0f 10 04 b8    	movss  (%rax,%r15,4),%xmm0
  1093b4:	e9 eb fd ff ff       	jmp    1091a4 <synreal::SolverNewton::precompute_matrices()+0x4e34>
  1093b9:	4a 63 04 b8          	movslq (%rax,%r15,4),%rax
  1093bd:	48 8b bc 24 80 00 00 	mov    0x80(%rsp),%rdi
  1093c4:	00 
  1093c5:	48 8d 04 87          	lea    (%rdi,%rax,4),%rax
  1093c9:	f3 0f 58 00          	addss  (%rax),%xmm0
  1093cd:	f3 0f 11 00          	movss  %xmm0,(%rax)
  1093d1:	eb b4                	jmp    109387 <synreal::SolverNewton::precompute_matrices()+0x5017>
  1093d3:	48 83 44 24 78 01    	addq   $0x1,0x78(%rsp)
  1093d9:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  1093de:	48 39 84 24 d8 00 00 	cmp    %rax,0xd8(%rsp)
  1093e5:	00 
  1093e6:	0f 85 89 fc ff ff    	jne    109075 <synreal::SolverNewton::precompute_matrices()+0x4d05>
  1093ec:	48 8b bc 24 80 07 00 	mov    0x780(%rsp),%rdi
  1093f3:	00 
  1093f4:	48 85 ff             	test   %rdi,%rdi
  1093f7:	74 10                	je     109409 <synreal::SolverNewton::precompute_matrices()+0x5099>
  1093f9:	48 8b b4 24 90 07 00 	mov    0x790(%rsp),%rsi
  109400:	00 
  109401:	48 29 fe             	sub    %rdi,%rsi
  109404:	e8 a7 3d f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  109409:	48 8b bc 24 60 07 00 	mov    0x760(%rsp),%rdi
  109410:	00 
  109411:	48 85 ff             	test   %rdi,%rdi
  109414:	74 10                	je     109426 <synreal::SolverNewton::precompute_matrices()+0x50b6>
  109416:	48 8b b4 24 70 07 00 	mov    0x770(%rsp),%rsi
  10941d:	00 
  10941e:	48 29 fe             	sub    %rdi,%rsi
  109421:	e8 8a 3d f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  109426:	48 8b bc 24 40 07 00 	mov    0x740(%rsp),%rdi
  10942d:	00 
  10942e:	48 85 ff             	test   %rdi,%rdi
  109431:	74 10                	je     109443 <synreal::SolverNewton::precompute_matrices()+0x50d3>
  109433:	48 8b b4 24 50 07 00 	mov    0x750(%rsp),%rsi
  10943a:	00 
  10943b:	48 29 fe             	sub    %rdi,%rsi
  10943e:	e8 6d 3d f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  109443:	48 8b bc 24 20 07 00 	mov    0x720(%rsp),%rdi
  10944a:	00 
  10944b:	48 85 ff             	test   %rdi,%rdi
  10944e:	0f 84 8f c2 ff ff    	je     1056e3 <synreal::SolverNewton::precompute_matrices()+0x1373>
  109454:	48 8b b4 24 30 07 00 	mov    0x730(%rsp),%rsi
  10945b:	00 
  10945c:	48 29 fe             	sub    %rdi,%rsi
  10945f:	e8 4c 3d f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  109464:	e9 7a c2 ff ff       	jmp    1056e3 <synreal::SolverNewton::precompute_matrices()+0x1373>
  109469:	4c 89 c6             	mov    %r8,%rsi
  10946c:	e9 e4 fe ff ff       	jmp    109355 <synreal::SolverNewton::precompute_matrices()+0x4fe5>
  109471:	4c 89 c6             	mov    %r8,%rsi
  109474:	e9 21 fe ff ff       	jmp    10929a <synreal::SolverNewton::precompute_matrices()+0x4f2a>
  109479:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
  10947e:	41 89 c7             	mov    %eax,%r15d
  109481:	48 8d bc 24 a0 05 00 	lea    0x5a0(%rsp),%rdi
  109488:	00 
  109489:	4c 8d 05 a0 1d 0e 00 	lea    0xe1da0(%rip),%r8        # 1eb230 <_fini+0x5aec>
  109490:	4c 89 f9             	mov    %r15,%rcx
  109493:	49 8b b6 e0 05 00 00 	mov    0x5e0(%r14),%rsi
  10949a:	49 8b 96 e8 05 00 00 	mov    0x5e8(%r14),%rdx
  1094a1:	e8 8a 43 f6 ff       	call   6d830 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  1094a6:	49 8b b6 f0 05 00 00 	mov    0x5f0(%r14),%rsi
  1094ad:	49 8b 96 f8 05 00 00 	mov    0x5f8(%r14),%rdx
  1094b4:	4c 89 f9             	mov    %r15,%rcx
  1094b7:	48 8d bc 24 c0 05 00 	lea    0x5c0(%rsp),%rdi
  1094be:	00 
  1094bf:	4c 8d 05 7c 1d 0e 00 	lea    0xe1d7c(%rip),%r8        # 1eb242 <_fini+0x5afe>
  1094c6:	e8 45 3c f6 ff       	call   6d110 <std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<2, int, (glm::qualifier)0> >(synreal::Span<glm::vec<2, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  1094cb:	49 8b b6 00 06 00 00 	mov    0x600(%r14),%rsi
  1094d2:	49 8b 96 08 06 00 00 	mov    0x608(%r14),%rdx
  1094d9:	4c 89 f9             	mov    %r15,%rcx
  1094dc:	48 8d bc 24 e0 05 00 	lea    0x5e0(%rsp),%rdi
  1094e3:	00 
  1094e4:	4c 8d 05 70 1d 0e 00 	lea    0xe1d70(%rip),%r8        # 1eb25b <_fini+0x5b17>
  1094eb:	e8 c0 38 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  1094f0:	49 8b b6 10 06 00 00 	mov    0x610(%r14),%rsi
  1094f7:	49 8b 96 18 06 00 00 	mov    0x618(%r14),%rdx
  1094fe:	4c 89 f9             	mov    %r15,%rcx
  109501:	48 8d bc 24 00 06 00 	lea    0x600(%rsp),%rdi
  109508:	00 
  109509:	4c 8d 05 66 1d 0e 00 	lea    0xe1d66(%rip),%r8        # 1eb276 <_fini+0x5b32>
  109510:	e8 9b 38 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  109515:	49 8b b6 20 06 00 00 	mov    0x620(%r14),%rsi
  10951c:	49 8b 96 28 06 00 00 	mov    0x628(%r14),%rdx
  109523:	4c 89 f9             	mov    %r15,%rcx
  109526:	48 8d bc 24 20 06 00 	lea    0x620(%rsp),%rdi
  10952d:	00 
  10952e:	4c 8d 05 53 ee 0d 00 	lea    0xdee53(%rip),%r8        # 1e8388 <_fini+0x2c44>
  109535:	e8 76 38 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10953a:	49 8b b6 30 06 00 00 	mov    0x630(%r14),%rsi
  109541:	49 8b 96 38 06 00 00 	mov    0x638(%r14),%rdx
  109548:	4c 89 f9             	mov    %r15,%rcx
  10954b:	48 8d bc 24 40 06 00 	lea    0x640(%rsp),%rdi
  109552:	00 
  109553:	4c 8d 05 8e ee 0d 00 	lea    0xdee8e(%rip),%r8        # 1e83e8 <_fini+0x2ca4>
  10955a:	e8 51 38 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10955f:	49 8b b6 40 06 00 00 	mov    0x640(%r14),%rsi
  109566:	49 8b 96 48 06 00 00 	mov    0x648(%r14),%rdx
  10956d:	4c 89 f9             	mov    %r15,%rcx
  109570:	48 8d bc 24 60 06 00 	lea    0x660(%rsp),%rdi
  109577:	00 
  109578:	4c 8d 05 d1 ee 0d 00 	lea    0xdeed1(%rip),%r8        # 1e8450 <_fini+0x2d0c>
  10957f:	e8 2c 38 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  109584:	49 8b b6 50 06 00 00 	mov    0x650(%r14),%rsi
  10958b:	49 8b 96 58 06 00 00 	mov    0x658(%r14),%rdx
  109592:	4c 89 f9             	mov    %r15,%rcx
  109595:	48 8d bc 24 80 06 00 	lea    0x680(%rsp),%rdi
  10959c:	00 
  10959d:	4c 8d 05 ec 1c 0e 00 	lea    0xe1cec(%rip),%r8        # 1eb290 <_fini+0x5b4c>
  1095a4:	e8 87 42 f6 ff       	call   6d830 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  1095a9:	49 8b b6 60 06 00 00 	mov    0x660(%r14),%rsi
  1095b0:	49 8b 96 68 06 00 00 	mov    0x668(%r14),%rdx
  1095b7:	4c 89 f9             	mov    %r15,%rcx
  1095ba:	48 8d bc 24 a0 06 00 	lea    0x6a0(%rsp),%rdi
  1095c1:	00 
  1095c2:	4c 8d 05 df 1c 0e 00 	lea    0xe1cdf(%rip),%r8        # 1eb2a8 <_fini+0x5b64>
  1095c9:	e8 62 42 f6 ff       	call   6d830 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  1095ce:	41 8b 8e d8 05 00 00 	mov    0x5d8(%r14),%ecx
  1095d5:	49 8b b6 70 06 00 00 	mov    0x670(%r14),%rsi
  1095dc:	48 8d bc 24 c0 06 00 	lea    0x6c0(%rsp),%rdi
  1095e3:	00 
  1095e4:	4c 8d 05 d8 1c 0e 00 	lea    0xe1cd8(%rip),%r8        # 1eb2c3 <_fini+0x5b7f>
  1095eb:	49 8b 96 78 06 00 00 	mov    0x678(%r14),%rdx
  1095f2:	e8 c9 46 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  1095f7:	41 8b 8e d8 05 00 00 	mov    0x5d8(%r14),%ecx
  1095fe:	49 8b b6 80 06 00 00 	mov    0x680(%r14),%rsi
  109605:	48 8d bc 24 e0 06 00 	lea    0x6e0(%rsp),%rdi
  10960c:	00 
  10960d:	4c 8d 05 c8 1c 0e 00 	lea    0xe1cc8(%rip),%r8        # 1eb2dc <_fini+0x5b98>
  109614:	49 8b 96 88 06 00 00 	mov    0x688(%r14),%rdx
  10961b:	e8 a0 46 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  109620:	41 8b 8e d8 05 00 00 	mov    0x5d8(%r14),%ecx
  109627:	49 8b b6 c0 06 00 00 	mov    0x6c0(%r14),%rsi
  10962e:	48 8d bc 24 00 07 00 	lea    0x700(%rsp),%rdi
  109635:	00 
  109636:	4c 8d 05 ee 1c 0e 00 	lea    0xe1cee(%rip),%r8        # 1eb32b <_fini+0x5be7>
  10963d:	49 8b 96 c8 06 00 00 	mov    0x6c8(%r14),%rdx
  109644:	e8 77 46 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  109649:	49 83 be b8 06 00 00 	cmpq   $0x0,0x6b8(%r14)
  109650:	00 
  109651:	41 8b 8e d8 05 00 00 	mov    0x5d8(%r14),%ecx
  109658:	0f 84 d2 1f 00 00    	je     10b630 <synreal::SolverNewton::precompute_matrices()+0x72c0>
  10965e:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
  109663:	48 8d bc 24 20 07 00 	lea    0x720(%rsp),%rdi
  10966a:	00 
  10966b:	4c 8d 05 aa 1c 0e 00 	lea    0xe1caa(%rip),%r8        # 1eb31c <_fini+0x5bd8>
  109672:	49 8b b6 b0 06 00 00 	mov    0x6b0(%r14),%rsi
  109679:	49 8b 96 b8 06 00 00 	mov    0x6b8(%r14),%rdx
  109680:	e8 3b 46 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  109685:	41 8b 8e d8 05 00 00 	mov    0x5d8(%r14),%ecx
  10968c:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
  109691:	49 83 be a8 06 00 00 	cmpq   $0x0,0x6a8(%r14)
  109698:	00 
  109699:	0f 85 f6 2d 00 00    	jne    10c495 <synreal::SolverNewton::precompute_matrices()+0x8125>
  10969f:	48 c7 84 24 50 07 00 	movq   $0x0,0x750(%rsp)
  1096a6:	00 00 00 00 00 
  1096ab:	66 0f ef c0          	pxor   %xmm0,%xmm0
  1096af:	0f 29 84 24 40 07 00 	movaps %xmm0,0x740(%rsp)
  1096b6:	00 
  1096b7:	48 85 c9             	test   %rcx,%rcx
  1096ba:	0f 84 5d 2d 00 00    	je     10c41d <synreal::SolverNewton::precompute_matrices()+0x80ad>
  1096c0:	4c 8d 24 8d 00 00 00 	lea    0x0(,%rcx,4),%r12
  1096c7:	00 
  1096c8:	4c 89 e7             	mov    %r12,%rdi
  1096cb:	e8 80 3a f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  1096d0:	4a 8d 2c 20          	lea    (%rax,%r12,1),%rbp
  1096d4:	48 89 c7             	mov    %rax,%rdi
  1096d7:	4c 89 e2             	mov    %r12,%rdx
  1096da:	31 f6                	xor    %esi,%esi
  1096dc:	48 89 84 24 40 07 00 	mov    %rax,0x740(%rsp)
  1096e3:	00 
  1096e4:	48 89 ac 24 50 07 00 	mov    %rbp,0x750(%rsp)
  1096eb:	00 
  1096ec:	e8 2f 2a f6 ff       	call   6c120 <memset@plt>
  1096f1:	48 89 ac 24 48 07 00 	mov    %rbp,0x748(%rsp)
  1096f8:	00 
  1096f9:	41 8b 8e d8 05 00 00 	mov    0x5d8(%r14),%ecx
  109700:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  109705:	48 83 b8 98 06 00 00 	cmpq   $0x0,0x698(%rax)
  10970c:	00 
  10970d:	0f 85 43 2d 00 00    	jne    10c456 <synreal::SolverNewton::precompute_matrices()+0x80e6>
  109713:	48 c7 84 24 70 07 00 	movq   $0x0,0x770(%rsp)
  10971a:	00 00 00 00 00 
  10971f:	66 0f ef c0          	pxor   %xmm0,%xmm0
  109723:	0f 29 84 24 60 07 00 	movaps %xmm0,0x760(%rsp)
  10972a:	00 
  10972b:	48 85 c9             	test   %rcx,%rcx
  10972e:	0f 84 c9 2d 00 00    	je     10c4fd <synreal::SolverNewton::precompute_matrices()+0x818d>
  109734:	48 8d 2c 8d 00 00 00 	lea    0x0(,%rcx,4),%rbp
  10973b:	00 
  10973c:	48 89 ef             	mov    %rbp,%rdi
  10973f:	e8 0c 3a f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  109744:	48 8d 3c 28          	lea    (%rax,%rbp,1),%rdi
  109748:	48 83 ed 04          	sub    $0x4,%rbp
  10974c:	66 48 0f 6e c0       	movq   %rax,%xmm0
  109751:	48 89 c6             	mov    %rax,%rsi
  109754:	48 89 ea             	mov    %rbp,%rdx
  109757:	66 0f 6c c0          	punpcklqdq %xmm0,%xmm0
  10975b:	48 89 bc 24 70 07 00 	mov    %rdi,0x770(%rsp)
  109762:	00 
  109763:	48 c1 ea 02          	shr    $0x2,%rdx
  109767:	0f 29 84 24 60 07 00 	movaps %xmm0,0x760(%rsp)
  10976e:	00 
  10976f:	48 83 c2 01          	add    $0x1,%rdx
  109773:	48 83 fd 08          	cmp    $0x8,%rbp
  109777:	76 32                	jbe    1097ab <synreal::SolverNewton::precompute_matrices()+0x543b>
  109779:	48 89 d1             	mov    %rdx,%rcx
  10977c:	66 0f 6f 05 cc e7 0e 	movdqa 0xee7cc(%rip),%xmm0        # 1f7f50 <cuda::std::__4::in_place+0x3>
  109783:	00 
  109784:	48 c1 e9 02          	shr    $0x2,%rcx
  109788:	48 c1 e1 04          	shl    $0x4,%rcx
  10978c:	48 01 c1             	add    %rax,%rcx
  10978f:	0f 11 06             	movups %xmm0,(%rsi)
  109792:	48 83 c6 10          	add    $0x10,%rsi
  109796:	48 39 f1             	cmp    %rsi,%rcx
  109799:	75 f4                	jne    10978f <synreal::SolverNewton::precompute_matrices()+0x541f>
  10979b:	48 89 d1             	mov    %rdx,%rcx
  10979e:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
  1097a2:	48 8d 04 88          	lea    (%rax,%rcx,4),%rax
  1097a6:	48 39 d1             	cmp    %rdx,%rcx
  1097a9:	74 26                	je     1097d1 <synreal::SolverNewton::precompute_matrices()+0x5461>
  1097ab:	48 8d 50 04          	lea    0x4(%rax),%rdx
  1097af:	c7 00 03 00 00 00    	movl   $0x3,(%rax)
  1097b5:	48 39 d7             	cmp    %rdx,%rdi
  1097b8:	74 17                	je     1097d1 <synreal::SolverNewton::precompute_matrices()+0x5461>
  1097ba:	48 8d 50 08          	lea    0x8(%rax),%rdx
  1097be:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%rax)
  1097c5:	48 39 d7             	cmp    %rdx,%rdi
  1097c8:	74 07                	je     1097d1 <synreal::SolverNewton::precompute_matrices()+0x5461>
  1097ca:	c7 40 08 03 00 00 00 	movl   $0x3,0x8(%rax)
  1097d1:	48 89 bc 24 68 07 00 	mov    %rdi,0x768(%rsp)
  1097d8:	00 
  1097d9:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  1097de:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  1097e5:	00 
  1097e6:	4c 8d 05 04 18 0e 00 	lea    0xe1804(%rip),%r8        # 1eaff1 <_fini+0x58ad>
  1097ed:	8b 88 98 03 00 00    	mov    0x398(%rax),%ecx
  1097f3:	48 8b b0 e0 03 00 00 	mov    0x3e0(%rax),%rsi
  1097fa:	48 8b 90 e8 03 00 00 	mov    0x3e8(%rax),%rdx
  109801:	e8 aa 35 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  109806:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  10980b:	48 8b 8c 24 20 07 00 	mov    0x720(%rsp),%rcx
  109812:	00 
  109813:	8b 80 d8 05 00 00    	mov    0x5d8(%rax),%eax
  109819:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
  10981e:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  109823:	48 85 c0             	test   %rax,%rax
  109826:	0f 84 e9 00 00 00    	je     109915 <synreal::SolverNewton::precompute_matrices()+0x55a5>
  10982c:	4c 8b 84 24 c0 06 00 	mov    0x6c0(%rsp),%r8
  109833:	00 
  109834:	48 8b bc 24 e0 06 00 	mov    0x6e0(%rsp),%rdi
  10983b:	00 
  10983c:	31 c0                	xor    %eax,%eax
  10983e:	f3 0f 10 15 5a 5f 0e 	movss  0xe5f5a(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  109845:	00 
  109846:	48 8b b4 24 00 07 00 	mov    0x700(%rsp),%rsi
  10984d:	00 
  10984e:	48 8b 8c 24 40 07 00 	mov    0x740(%rsp),%rcx
  109855:	00 
  109856:	66 0f ef c9          	pxor   %xmm1,%xmm1
  10985a:	48 8b 94 24 60 07 00 	mov    0x760(%rsp),%rdx
  109861:	00 
  109862:	f3 0f 10 05 22 5f 0e 	movss  0xe5f22(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  109869:	00 
  10986a:	f3 41 0f 10 1c 80    	movss  (%r8,%rax,4),%xmm3
  109870:	0f 28 e3             	movaps %xmm3,%xmm4
  109873:	0f 54 e2             	andps  %xmm2,%xmm4
  109876:	0f 2e c4             	ucomiss %xmm4,%xmm0
  109879:	0f 82 cb e6 f6 ff    	jb     77f4a <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xaa8>
  10987f:	0f 2f cb             	comiss %xmm3,%xmm1
  109882:	0f 87 c2 e6 f6 ff    	ja     77f4a <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xaa8>
  109888:	f3 0f 10 1c 87       	movss  (%rdi,%rax,4),%xmm3
  10988d:	0f 28 e3             	movaps %xmm3,%xmm4
  109890:	0f 54 e2             	andps  %xmm2,%xmm4
  109893:	0f 2e c4             	ucomiss %xmm4,%xmm0
  109896:	0f 82 ae e6 f6 ff    	jb     77f4a <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xaa8>
  10989c:	0f 2f cb             	comiss %xmm3,%xmm1
  10989f:	0f 87 a5 e6 f6 ff    	ja     77f4a <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xaa8>
  1098a5:	f3 0f 10 1c 86       	movss  (%rsi,%rax,4),%xmm3
  1098aa:	0f 2e db             	ucomiss %xmm3,%xmm3
  1098ad:	0f 8a 35 2e 00 00    	jp     10c6e8 <synreal::SolverNewton::precompute_matrices()+0x8378>
  1098b3:	0f 2f cb             	comiss %xmm3,%xmm1
  1098b6:	0f 87 c0 e6 f6 ff    	ja     77f7c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xada>
  1098bc:	4c 8b 54 24 38       	mov    0x38(%rsp),%r10
  1098c1:	f3 41 0f 10 1c 82    	movss  (%r10,%rax,4),%xmm3
  1098c7:	0f 28 e3             	movaps %xmm3,%xmm4
  1098ca:	0f 54 e2             	andps  %xmm2,%xmm4
  1098cd:	0f 2e c4             	ucomiss %xmm4,%xmm0
  1098d0:	0f 82 0d 2e 00 00    	jb     10c6e3 <synreal::SolverNewton::precompute_matrices()+0x8373>
  1098d6:	0f 2f cb             	comiss %xmm3,%xmm1
  1098d9:	0f 87 39 e6 f6 ff    	ja     77f18 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xa76>
  1098df:	f3 0f 10 1c 81       	movss  (%rcx,%rax,4),%xmm3
  1098e4:	0f 28 e3             	movaps %xmm3,%xmm4
  1098e7:	0f 54 e2             	andps  %xmm2,%xmm4
  1098ea:	0f 2e c4             	ucomiss %xmm4,%xmm0
  1098ed:	0f 82 eb 2d 00 00    	jb     10c6de <synreal::SolverNewton::precompute_matrices()+0x836e>
  1098f3:	0f 2f cb             	comiss %xmm3,%xmm1
  1098f6:	0f 87 a6 e5 f6 ff    	ja     77ea2 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xa00>
  1098fc:	83 3c 82 04          	cmpl   $0x4,(%rdx,%rax,4)
  109900:	0f 87 d3 2d 00 00    	ja     10c6d9 <synreal::SolverNewton::precompute_matrices()+0x8369>
  109906:	48 83 c0 01          	add    $0x1,%rax
  10990a:	48 3b 44 24 20       	cmp    0x20(%rsp),%rax
  10990f:	0f 85 55 ff ff ff    	jne    10986a <synreal::SolverNewton::precompute_matrices()+0x54fa>
  109915:	48 8b 84 24 c0 05 00 	mov    0x5c0(%rsp),%rax
  10991c:	00 
  10991d:	48 89 9c 24 a8 00 00 	mov    %rbx,0xa8(%rsp)
  109924:	00 
  109925:	45 31 db             	xor    %r11d,%r11d
  109928:	45 31 d2             	xor    %r10d,%r10d
  10992b:	4c 89 bc 24 b8 00 00 	mov    %r15,0xb8(%rsp)
  109932:	00 
  109933:	4c 8b ac 24 e0 05 00 	mov    0x5e0(%rsp),%r13
  10993a:	00 
  10993b:	31 ed                	xor    %ebp,%ebp
  10993d:	66 0f ef d2          	pxor   %xmm2,%xmm2
  109941:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  109946:	48 8b 84 24 a0 05 00 	mov    0x5a0(%rsp),%rax
  10994d:	00 
  10994e:	f3 0f 10 0d 4a 5e 0e 	movss  0xe5e4a(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  109955:	00 
  109956:	4c 8b b4 24 00 06 00 	mov    0x600(%rsp),%r14
  10995d:	00 
  10995e:	48 8b bc 24 20 06 00 	mov    0x620(%rsp),%rdi
  109965:	00 
  109966:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  10996b:	48 8b 84 24 80 06 00 	mov    0x680(%rsp),%rax
  109972:	00 
  109973:	4c 8b 8c 24 40 06 00 	mov    0x640(%rsp),%r9
  10997a:	00 
  10997b:	4c 8b 84 24 60 06 00 	mov    0x660(%rsp),%r8
  109982:	00 
  109983:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
  109988:	48 8b 84 24 a0 06 00 	mov    0x6a0(%rsp),%rax
  10998f:	00 
  109990:	4c 8b a4 24 80 07 00 	mov    0x780(%rsp),%r12
  109997:	00 
  109998:	f3 0f 10 05 ec 5d 0e 	movss  0xe5dec(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  10999f:	00 
  1099a0:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  1099a7:	00 
  1099a8:	48 8b 8c 24 50 01 00 	mov    0x150(%rsp),%rcx
  1099af:	00 
  1099b0:	f3 44 0f 10 05 c7 e5 	movss  0xee5c7(%rip),%xmm8        # 1f7f80 <cuda::std::__4::in_place+0x33>
  1099b7:	0e 00 
  1099b9:	e9 48 01 00 00       	jmp    109b06 <synreal::SolverNewton::precompute_matrices()+0x5796>
  1099be:	48 8d 14 52          	lea    (%rdx,%rdx,2),%rdx
  1099c2:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  1099c6:	45 0f 28 e0          	movaps %xmm8,%xmm12
  1099ca:	4c 8b bc 24 d0 00 00 	mov    0xd0(%rsp),%r15
  1099d1:	00 
  1099d2:	49 8d 14 94          	lea    (%r12,%rdx,4),%rdx
  1099d6:	49 8d 04 84          	lea    (%r12,%rax,4),%rax
  1099da:	f3 44 0f 5c 72 04    	subss  0x4(%rdx),%xmm14
  1099e0:	f3 0f 5c 1a          	subss  (%rdx),%xmm3
  1099e4:	f3 44 0f 5c 6a 08    	subss  0x8(%rdx),%xmm13
  1099ea:	45 0f 28 fe          	movaps %xmm14,%xmm15
  1099ee:	44 0f 14 e3          	unpcklps %xmm3,%xmm12
  1099f2:	f3 0f 10 58 08       	movss  0x8(%rax),%xmm3
  1099f7:	45 0f 28 f0          	movaps %xmm8,%xmm14
  1099fb:	45 0f 14 fd          	unpcklps %xmm13,%xmm15
  1099ff:	f3 44 0f 10 28       	movss  (%rax),%xmm13
  109a04:	45 0f 16 e7          	movlhps %xmm15,%xmm12
  109a08:	f3 0f 5c f3          	subss  %xmm3,%xmm6
  109a0c:	f3 44 0f 10 7a 08    	movss  0x8(%rdx),%xmm15
  109a12:	47 0f 11 24 17       	movups %xmm12,(%r15,%r10,1)
  109a17:	f3 44 0f 10 60 04    	movss  0x4(%rax),%xmm12
  109a1d:	f3 45 0f 5c dd       	subss  %xmm13,%xmm11
  109a22:	f3 45 0f 5c d7       	subss  %xmm15,%xmm10
  109a27:	f3 41 0f 5c e7       	subss  %xmm15,%xmm4
  109a2c:	66 44 0f 6e fb       	movd   %ebx,%xmm15
  109a31:	f3 46 0f 11 04 11    	movss  %xmm8,(%rcx,%r10,1)
  109a37:	f3 41 0f 5c fc       	subss  %xmm12,%xmm7
  109a3c:	f3 42 0f 11 74 11 0c 	movss  %xmm6,0xc(%rcx,%r10,1)
  109a43:	f3 0f 10 32          	movss  (%rdx),%xmm6
  109a47:	f3 46 0f 11 5c 11 04 	movss  %xmm11,0x4(%rcx,%r10,1)
  109a4e:	66 44 0f 6e de       	movd   %esi,%xmm11
  109a53:	f3 44 0f 5c ce       	subss  %xmm6,%xmm9
  109a58:	f3 44 0f 5c fe       	subss  %xmm6,%xmm15
  109a5d:	f3 42 0f 11 7c 11 08 	movss  %xmm7,0x8(%rcx,%r10,1)
  109a64:	f3 0f 10 7a 04       	movss  0x4(%rdx),%xmm7
  109a69:	f3 0f 5c ef          	subss  %xmm7,%xmm5
  109a6d:	f3 44 0f 5c df       	subss  %xmm7,%xmm11
  109a72:	41 0f 28 f8          	movaps %xmm8,%xmm7
  109a76:	0f 28 f7             	movaps %xmm7,%xmm6
  109a79:	41 0f 14 ea          	unpcklps %xmm10,%xmm5
  109a7d:	44 0f 14 dc          	unpcklps %xmm4,%xmm11
  109a81:	48 83 c5 01          	add    $0x1,%rbp
  109a85:	48 8b 84 24 48 01 00 	mov    0x148(%rsp),%rax
  109a8c:	00 
  109a8d:	41 0f 14 f1          	unpcklps %xmm9,%xmm6
  109a91:	41 0f 14 ff          	unpcklps %xmm15,%xmm7
  109a95:	49 83 c3 0c          	add    $0xc,%r11
  109a99:	f3 0f 10 64 24 48    	movss  0x48(%rsp),%xmm4
  109a9f:	0f 16 f5             	movlhps %xmm5,%xmm6
  109aa2:	41 0f 16 fb          	movlhps %xmm11,%xmm7
  109aa6:	42 0f 11 34 10       	movups %xmm6,(%rax,%r10,1)
  109aab:	48 8b 84 24 40 01 00 	mov    0x140(%rsp),%rax
  109ab2:	00 
  109ab3:	f3 41 0f 5c e5       	subss  %xmm13,%xmm4
  109ab8:	42 0f 11 3c 10       	movups %xmm7,(%rax,%r10,1)
  109abd:	48 8b 84 24 28 01 00 	mov    0x128(%rsp),%rax
  109ac4:	00 
  109ac5:	f3 42 0f 11 64 10 04 	movss  %xmm4,0x4(%rax,%r10,1)
  109acc:	f3 0f 10 24 24       	movss  (%rsp),%xmm4
  109ad1:	f3 46 0f 11 34 10    	movss  %xmm14,(%rax,%r10,1)
  109ad7:	f3 41 0f 5c e4       	subss  %xmm12,%xmm4
  109adc:	f3 42 0f 11 64 10 08 	movss  %xmm4,0x8(%rax,%r10,1)
  109ae3:	f3 0f 10 64 24 18    	movss  0x18(%rsp),%xmm4
  109ae9:	f3 0f 5c e3          	subss  %xmm3,%xmm4
  109aed:	f3 42 0f 11 64 10 0c 	movss  %xmm4,0xc(%rax,%r10,1)
  109af4:	49 83 c2 10          	add    $0x10,%r10
  109af8:	48 39 ac 24 b8 00 00 	cmp    %rbp,0xb8(%rsp)
  109aff:	00 
  109b00:	0f 84 e6 25 00 00    	je     10c0ec <synreal::SolverNewton::precompute_matrices()+0x7d7c>
  109b06:	48 8b 5c 24 58       	mov    0x58(%rsp),%rbx
  109b0b:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  109b10:	83 3c ab 01          	cmpl   $0x1,(%rbx,%rbp,4)
  109b14:	48 63 14 e8          	movslq (%rax,%rbp,8),%rdx
  109b18:	48 63 44 e8 04       	movslq 0x4(%rax,%rbp,8),%rax
  109b1d:	0f 87 66 ef f6 ff    	ja     78a89 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x15e7>
  109b23:	85 c0                	test   %eax,%eax
  109b25:	0f 88 5e ef f6 ff    	js     78a89 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x15e7>
  109b2b:	83 fa ff             	cmp    $0xffffffff,%edx
  109b2e:	0f 8c 55 ef f6 ff    	jl     78a89 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x15e7>
  109b34:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
  109b39:	8b 9b 98 03 00 00    	mov    0x398(%rbx),%ebx
  109b3f:	74 0c                	je     109b4d <synreal::SolverNewton::precompute_matrices()+0x57dd>
  109b41:	48 63 f2             	movslq %edx,%rsi
  109b44:	48 39 de             	cmp    %rbx,%rsi
  109b47:	0f 83 3c ef f6 ff    	jae    78a89 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x15e7>
  109b4d:	48 39 d8             	cmp    %rbx,%rax
  109b50:	0f 83 33 ef f6 ff    	jae    78a89 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x15e7>
  109b56:	48 8b 5c 24 78       	mov    0x78(%rsp),%rbx
  109b5b:	8b 34 ab             	mov    (%rbx,%rbp,4),%esi
  109b5e:	85 f6                	test   %esi,%esi
  109b60:	0f 88 63 2f 00 00    	js     10cac9 <synreal::SolverNewton::precompute_matrices()+0x8759>
  109b66:	48 63 de             	movslq %esi,%rbx
  109b69:	48 3b 5c 24 20       	cmp    0x20(%rsp),%rbx
  109b6e:	0f 83 64 de f6 ff    	jae    779d8 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x536>
  109b74:	48 8b b4 24 a0 00 00 	mov    0xa0(%rsp),%rsi
  109b7b:	00 
  109b7c:	48 63 34 ae          	movslq (%rsi,%rbp,4),%rsi
  109b80:	85 f6                	test   %esi,%esi
  109b82:	0f 88 50 de f6 ff    	js     779d8 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x536>
  109b88:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  109b8d:	45 8b bf dc 05 00 00 	mov    0x5dc(%r15),%r15d
  109b94:	4c 39 fe             	cmp    %r15,%rsi
  109b97:	0f 83 3b de f6 ff    	jae    779d8 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x536>
  109b9d:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  109ba2:	41 0f b6 b7 98 32 00 	movzbl 0x3298(%r15),%esi
  109ba9:	00 
  109baa:	40 84 f6             	test   %sil,%sil
  109bad:	75 11                	jne    109bc0 <synreal::SolverNewton::precompute_matrices()+0x5850>
  109baf:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
  109bb4:	f3 0f 10 1c 9e       	movss  (%rsi,%rbx,4),%xmm3
  109bb9:	0f 2f da             	comiss %xmm2,%xmm3
  109bbc:	40 0f 97 c6          	seta   %sil
  109bc0:	f3 43 0f 10 5c 1d 00 	movss  0x0(%r13,%r11,1),%xmm3
  109bc7:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
  109bcc:	f3 47 0f 10 74 1d 04 	movss  0x4(%r13,%r11,1),%xmm14
  109bd3:	f3 47 0f 10 6c 1d 08 	movss  0x8(%r13,%r11,1),%xmm13
  109bda:	0f 28 e3             	movaps %xmm3,%xmm4
  109bdd:	40 88 b3 98 32 00 00 	mov    %sil,0x3298(%rbx)
  109be4:	0f 54 e1             	andps  %xmm1,%xmm4
  109be7:	0f 2e c4             	ucomiss %xmm4,%xmm0
  109bea:	0f 82 ed ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109bf0:	41 0f 28 e6          	movaps %xmm14,%xmm4
  109bf4:	0f 54 e1             	andps  %xmm1,%xmm4
  109bf7:	0f 2e c4             	ucomiss %xmm4,%xmm0
  109bfa:	0f 82 dd ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109c00:	41 0f 28 e5          	movaps %xmm13,%xmm4
  109c04:	0f 54 e1             	andps  %xmm1,%xmm4
  109c07:	0f 2e c4             	ucomiss %xmm4,%xmm0
  109c0a:	0f 82 cd ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109c10:	f3 47 0f 10 1c 1e    	movss  (%r14,%r11,1),%xmm11
  109c16:	f3 43 0f 10 7c 1e 04 	movss  0x4(%r14,%r11,1),%xmm7
  109c1d:	f3 43 0f 10 74 1e 08 	movss  0x8(%r14,%r11,1),%xmm6
  109c24:	41 0f 28 e3          	movaps %xmm11,%xmm4
  109c28:	0f 54 e1             	andps  %xmm1,%xmm4
  109c2b:	0f 2e c4             	ucomiss %xmm4,%xmm0
  109c2e:	0f 82 a9 ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109c34:	0f 28 e7             	movaps %xmm7,%xmm4
  109c37:	0f 54 e1             	andps  %xmm1,%xmm4
  109c3a:	0f 2e c4             	ucomiss %xmm4,%xmm0
  109c3d:	0f 82 9a ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109c43:	0f 28 e6             	movaps %xmm6,%xmm4
  109c46:	0f 54 e1             	andps  %xmm1,%xmm4
  109c49:	0f 2e c4             	ucomiss %xmm4,%xmm0
  109c4c:	0f 82 8b ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109c52:	f3 46 0f 10 0c 1f    	movss  (%rdi,%r11,1),%xmm9
  109c58:	f3 42 0f 10 6c 1f 04 	movss  0x4(%rdi,%r11,1),%xmm5
  109c5f:	f3 46 0f 10 54 1f 08 	movss  0x8(%rdi,%r11,1),%xmm10
  109c66:	41 0f 28 e1          	movaps %xmm9,%xmm4
  109c6a:	0f 54 e1             	andps  %xmm1,%xmm4
  109c6d:	0f 2e c4             	ucomiss %xmm4,%xmm0
  109c70:	0f 82 67 ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109c76:	0f 28 e5             	movaps %xmm5,%xmm4
  109c79:	0f 54 e1             	andps  %xmm1,%xmm4
  109c7c:	0f 2e c4             	ucomiss %xmm4,%xmm0
  109c7f:	0f 82 58 ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109c85:	41 0f 28 e2          	movaps %xmm10,%xmm4
  109c89:	0f 54 e1             	andps  %xmm1,%xmm4
  109c8c:	0f 2e c4             	ucomiss %xmm4,%xmm0
  109c8f:	0f 82 48 ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109c95:	43 8b 1c 19          	mov    (%r9,%r11,1),%ebx
  109c99:	43 8b 74 19 04       	mov    0x4(%r9,%r11,1),%esi
  109c9e:	f3 43 0f 10 64 19 08 	movss  0x8(%r9,%r11,1),%xmm4
  109ca5:	66 44 0f 6e e3       	movd   %ebx,%xmm12
  109caa:	44 0f 54 e1          	andps  %xmm1,%xmm12
  109cae:	41 0f 2e c4          	ucomiss %xmm12,%xmm0
  109cb2:	0f 82 25 ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109cb8:	66 44 0f 6e e6       	movd   %esi,%xmm12
  109cbd:	44 0f 54 e1          	andps  %xmm1,%xmm12
  109cc1:	41 0f 2e c4          	ucomiss %xmm12,%xmm0
  109cc5:	0f 82 12 ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109ccb:	44 0f 28 e4          	movaps %xmm4,%xmm12
  109ccf:	44 0f 54 e1          	andps  %xmm1,%xmm12
  109cd3:	41 0f 2e c4          	ucomiss %xmm12,%xmm0
  109cd7:	0f 82 00 ea f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109cdd:	f3 47 0f 10 3c 18    	movss  (%r8,%r11,1),%xmm15
  109ce3:	f3 47 0f 10 64 18 04 	movss  0x4(%r8,%r11,1),%xmm12
  109cea:	f3 44 0f 11 7c 24 48 	movss  %xmm15,0x48(%rsp)
  109cf1:	44 0f 54 f9          	andps  %xmm1,%xmm15
  109cf5:	41 0f 2e c7          	ucomiss %xmm15,%xmm0
  109cf9:	f3 44 0f 11 24 24    	movss  %xmm12,(%rsp)
  109cff:	f3 47 0f 10 64 18 08 	movss  0x8(%r8,%r11,1),%xmm12
  109d06:	f3 44 0f 11 64 24 18 	movss  %xmm12,0x18(%rsp)
  109d0d:	0f 82 ca e9 f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109d13:	f3 44 0f 10 24 24    	movss  (%rsp),%xmm12
  109d19:	44 0f 54 e1          	andps  %xmm1,%xmm12
  109d1d:	41 0f 2e c4          	ucomiss %xmm12,%xmm0
  109d21:	0f 82 b6 e9 f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109d27:	f3 44 0f 10 64 24 18 	movss  0x18(%rsp),%xmm12
  109d2e:	44 0f 54 e1          	andps  %xmm1,%xmm12
  109d32:	41 0f 2e c4          	ucomiss %xmm12,%xmm0
  109d36:	0f 82 a1 e9 f6 ff    	jb     786dd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x123b>
  109d3c:	83 fa ff             	cmp    $0xffffffff,%edx
  109d3f:	0f 85 79 fc ff ff    	jne    1099be <synreal::SolverNewton::precompute_matrices()+0x564e>
  109d45:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  109d49:	48 8b 9c 24 d0 00 00 	mov    0xd0(%rsp),%rbx
  109d50:	00 
  109d51:	66 0f ef ed          	pxor   %xmm5,%xmm5
  109d55:	45 0f 28 f0          	movaps %xmm8,%xmm14
  109d59:	49 8d 04 84          	lea    (%r12,%rax,4),%rax
  109d5d:	44 0f 28 ca          	movaps %xmm2,%xmm9
  109d61:	44 0f 28 d2          	movaps %xmm2,%xmm10
  109d65:	f3 44 0f 10 28       	movss  (%rax),%xmm13
  109d6a:	f3 44 0f 10 60 04    	movss  0x4(%rax),%xmm12
  109d70:	42 0f 11 2c 13       	movups %xmm5,(%rbx,%r10,1)
  109d75:	0f 28 e2             	movaps %xmm2,%xmm4
  109d78:	f3 0f 10 58 08       	movss  0x8(%rax),%xmm3
  109d7d:	0f 28 ea             	movaps %xmm2,%xmm5
  109d80:	44 0f 28 fa          	movaps %xmm2,%xmm15
  109d84:	f3 46 0f 11 04 11    	movss  %xmm8,(%rcx,%r10,1)
  109d8a:	f3 45 0f 5c dd       	subss  %xmm13,%xmm11
  109d8f:	f3 41 0f 5c fc       	subss  %xmm12,%xmm7
  109d94:	f3 0f 5c f3          	subss  %xmm3,%xmm6
  109d98:	f3 46 0f 11 5c 11 04 	movss  %xmm11,0x4(%rcx,%r10,1)
  109d9f:	44 0f 28 da          	movaps %xmm2,%xmm11
  109da3:	f3 42 0f 11 7c 11 08 	movss  %xmm7,0x8(%rcx,%r10,1)
  109daa:	0f 28 fa             	movaps %xmm2,%xmm7
  109dad:	f3 42 0f 11 74 11 0c 	movss  %xmm6,0xc(%rcx,%r10,1)
  109db4:	e9 bd fc ff ff       	jmp    109a76 <synreal::SolverNewton::precompute_matrices()+0x5706>
  109db9:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  109dbe:	41 89 c6             	mov    %eax,%r14d
  109dc1:	48 8d bc 24 80 06 00 	lea    0x680(%rsp),%rdi
  109dc8:	00 
  109dc9:	4c 8d 05 c6 13 0e 00 	lea    0xe13c6(%rip),%r8        # 1eb196 <_fini+0x5a52>
  109dd0:	4c 89 f1             	mov    %r14,%rcx
  109dd3:	4c 89 b4 24 b8 00 00 	mov    %r14,0xb8(%rsp)
  109dda:	00 
  109ddb:	41 8b 87 6c 05 00 00 	mov    0x56c(%r15),%eax
  109de2:	49 8b b7 70 05 00 00 	mov    0x570(%r15),%rsi
  109de9:	49 8b 97 78 05 00 00 	mov    0x578(%r15),%rdx
  109df0:	49 29 c6             	sub    %rax,%r14
  109df3:	4c 89 74 24 38       	mov    %r14,0x38(%rsp)
  109df8:	49 89 ce             	mov    %rcx,%r14
  109dfb:	e8 10 33 f6 ff       	call   6d110 <std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<2, int, (glm::qualifier)0> >(synreal::Span<glm::vec<2, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  109e00:	49 8b b7 80 05 00 00 	mov    0x580(%r15),%rsi
  109e07:	49 8b 97 88 05 00 00 	mov    0x588(%r15),%rdx
  109e0e:	4c 89 f1             	mov    %r14,%rcx
  109e11:	48 8d bc 24 a0 06 00 	lea    0x6a0(%rsp),%rdi
  109e18:	00 
  109e19:	4c 8d 05 8e 13 0e 00 	lea    0xe138e(%rip),%r8        # 1eb1ae <_fini+0x5a6a>
  109e20:	e8 8b 2f f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  109e25:	49 8b b7 90 05 00 00 	mov    0x590(%r15),%rsi
  109e2c:	49 8b 97 98 05 00 00 	mov    0x598(%r15),%rdx
  109e33:	4c 89 f1             	mov    %r14,%rcx
  109e36:	48 8d bc 24 c0 06 00 	lea    0x6c0(%rsp),%rdi
  109e3d:	00 
  109e3e:	4c 8d 05 80 13 0e 00 	lea    0xe1380(%rip),%r8        # 1eb1c5 <_fini+0x5a81>
  109e45:	e8 66 2f f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  109e4a:	49 8b b7 a0 05 00 00 	mov    0x5a0(%r15),%rsi
  109e51:	49 8b 97 a8 05 00 00 	mov    0x5a8(%r15),%rdx
  109e58:	4c 89 f1             	mov    %r14,%rcx
  109e5b:	48 8d bc 24 e0 06 00 	lea    0x6e0(%rsp),%rdi
  109e62:	00 
  109e63:	4c 8d 05 76 13 0e 00 	lea    0xe1376(%rip),%r8        # 1eb1e0 <_fini+0x5a9c>
  109e6a:	e8 41 2f f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  109e6f:	49 8b b7 b0 05 00 00 	mov    0x5b0(%r15),%rsi
  109e76:	49 8b 97 b8 05 00 00 	mov    0x5b8(%r15),%rdx
  109e7d:	4c 89 f1             	mov    %r14,%rcx
  109e80:	48 8d bc 24 00 07 00 	lea    0x700(%rsp),%rdi
  109e87:	00 
  109e88:	4c 8d 05 6c 13 0e 00 	lea    0xe136c(%rip),%r8        # 1eb1fb <_fini+0x5ab7>
  109e8f:	e8 2c 3e f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  109e94:	49 8b b7 c0 05 00 00 	mov    0x5c0(%r15),%rsi
  109e9b:	49 8b 97 c8 05 00 00 	mov    0x5c8(%r15),%rdx
  109ea2:	4c 89 f1             	mov    %r14,%rcx
  109ea5:	48 8d bc 24 20 07 00 	lea    0x720(%rsp),%rdi
  109eac:	00 
  109ead:	4c 8d 05 63 13 0e 00 	lea    0xe1363(%rip),%r8        # 1eb217 <_fini+0x5ad3>
  109eb4:	e8 07 3e f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  109eb9:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  109ec0:	00 
  109ec1:	41 8b 8f 98 03 00 00 	mov    0x398(%r15),%ecx
  109ec8:	49 8b b7 d0 03 00 00 	mov    0x3d0(%r15),%rsi
  109ecf:	4c 8d 05 f7 10 0e 00 	lea    0xe10f7(%rip),%r8        # 1eafcd <_fini+0x5889>
  109ed6:	49 8b 97 d8 03 00 00 	mov    0x3d8(%r15),%rdx
  109edd:	4c 89 ef             	mov    %r13,%rdi
  109ee0:	e8 0b 57 f6 ff       	call   6f5f0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  109ee5:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  109eec:	00 
  109eed:	41 8b 8f 98 03 00 00 	mov    0x398(%r15),%ecx
  109ef4:	49 8b b7 e0 03 00 00 	mov    0x3e0(%r15),%rsi
  109efb:	4c 8d 05 ef 10 0e 00 	lea    0xe10ef(%rip),%r8        # 1eaff1 <_fini+0x58ad>
  109f02:	49 8b 97 e8 03 00 00 	mov    0x3e8(%r15),%rdx
  109f09:	4c 89 f7             	mov    %r14,%rdi
  109f0c:	e8 9f 2e f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  109f11:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
  109f18:	00 00 
  109f1a:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
  109f21:	00 00 
  109f23:	48 8b 84 24 80 06 00 	mov    0x680(%rsp),%rax
  109f2a:	00 
  109f2b:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  109f30:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
  109f34:	8b 10                	mov    (%rax),%edx
  109f36:	44 8b 60 04          	mov    0x4(%rax),%r12d
  109f3a:	85 d2                	test   %edx,%edx
  109f3c:	0f 88 d4 e8 f6 ff    	js     78816 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1374>
  109f42:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
  109f47:	48 63 c2             	movslq %edx,%rax
  109f4a:	8b 8f 98 03 00 00    	mov    0x398(%rdi),%ecx
  109f50:	48 39 c8             	cmp    %rcx,%rax
  109f53:	0f 83 bd e8 f6 ff    	jae    78816 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1374>
  109f59:	41 83 fc ff          	cmp    $0xffffffff,%r12d
  109f5d:	0f 8c b3 e8 f6 ff    	jl     78816 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1374>
  109f63:	74 15                	je     109f7a <synreal::SolverNewton::precompute_matrices()+0x5c0a>
  109f65:	49 63 f4             	movslq %r12d,%rsi
  109f68:	48 39 f1             	cmp    %rsi,%rcx
  109f6b:	0f 86 a5 e8 f6 ff    	jbe    78816 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1374>
  109f71:	44 39 e2             	cmp    %r12d,%edx
  109f74:	0f 84 4f e8 f6 ff    	je     787c9 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1327>
  109f7a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  109f7f:	f3 0f 10 05 05 58 0e 	movss  0xe5805(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  109f86:	00 
  109f87:	48 8d 14 49          	lea    (%rcx,%rcx,2),%rdx
  109f8b:	48 8b 8c 24 a0 06 00 	mov    0x6a0(%rsp),%rcx
  109f92:	00 
  109f93:	48 01 d1             	add    %rdx,%rcx
  109f96:	f3 44 0f 10 09       	movss  (%rcx),%xmm9
  109f9b:	f3 44 0f 10 51 04    	movss  0x4(%rcx),%xmm10
  109fa1:	f3 44 0f 10 59 08    	movss  0x8(%rcx),%xmm11
  109fa7:	41 0f 28 c9          	movaps %xmm9,%xmm1
  109fab:	0f 54 0d ee 57 0e 00 	andps  0xe57ee(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  109fb2:	0f 2e c1             	ucomiss %xmm1,%xmm0
  109fb5:	0f 82 dc e7 f6 ff    	jb     78797 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x12f5>
  109fbb:	41 0f 28 ca          	movaps %xmm10,%xmm1
  109fbf:	0f 54 0d da 57 0e 00 	andps  0xe57da(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  109fc6:	0f 2e c1             	ucomiss %xmm1,%xmm0
  109fc9:	0f 82 c8 e7 f6 ff    	jb     78797 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x12f5>
  109fcf:	41 0f 28 cb          	movaps %xmm11,%xmm1
  109fd3:	0f 54 0d c6 57 0e 00 	andps  0xe57c6(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  109fda:	0f 2e c1             	ucomiss %xmm1,%xmm0
  109fdd:	0f 82 b4 e7 f6 ff    	jb     78797 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x12f5>
  109fe3:	48 8b 8c 24 c0 06 00 	mov    0x6c0(%rsp),%rcx
  109fea:	00 
  109feb:	48 01 d1             	add    %rdx,%rcx
  109fee:	f3 0f 10 31          	movss  (%rcx),%xmm6
  109ff2:	f3 0f 10 79 04       	movss  0x4(%rcx),%xmm7
  109ff7:	f3 44 0f 10 41 08    	movss  0x8(%rcx),%xmm8
  109ffd:	0f 28 ce             	movaps %xmm6,%xmm1
  10a000:	0f 54 0d 99 57 0e 00 	andps  0xe5799(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10a007:	0f 2e c1             	ucomiss %xmm1,%xmm0
  10a00a:	0f 82 87 e7 f6 ff    	jb     78797 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x12f5>
  10a010:	0f 28 cf             	movaps %xmm7,%xmm1
  10a013:	0f 54 0d 86 57 0e 00 	andps  0xe5786(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10a01a:	0f 2e c1             	ucomiss %xmm1,%xmm0
  10a01d:	0f 82 74 e7 f6 ff    	jb     78797 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x12f5>
  10a023:	41 0f 28 c8          	movaps %xmm8,%xmm1
  10a027:	0f 54 0d 72 57 0e 00 	andps  0xe5772(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10a02e:	0f 2e c1             	ucomiss %xmm1,%xmm0
  10a031:	0f 82 60 e7 f6 ff    	jb     78797 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x12f5>
  10a037:	48 03 94 24 e0 06 00 	add    0x6e0(%rsp),%rdx
  10a03e:	00 
  10a03f:	f3 0f 10 12          	movss  (%rdx),%xmm2
  10a043:	f3 0f 10 5a 04       	movss  0x4(%rdx),%xmm3
  10a048:	f3 0f 10 62 08       	movss  0x8(%rdx),%xmm4
  10a04d:	0f 28 ca             	movaps %xmm2,%xmm1
  10a050:	0f 54 0d 49 57 0e 00 	andps  0xe5749(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10a057:	0f 2e c1             	ucomiss %xmm1,%xmm0
  10a05a:	0f 82 37 e7 f6 ff    	jb     78797 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x12f5>
  10a060:	0f 28 cb             	movaps %xmm3,%xmm1
  10a063:	0f 54 0d 36 57 0e 00 	andps  0xe5736(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10a06a:	0f 2e c1             	ucomiss %xmm1,%xmm0
  10a06d:	0f 82 24 e7 f6 ff    	jb     78797 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x12f5>
  10a073:	0f 28 cc             	movaps %xmm4,%xmm1
  10a076:	0f 54 0d 23 57 0e 00 	andps  0xe5723(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10a07d:	0f 2e c1             	ucomiss %xmm1,%xmm0
  10a080:	0f 82 11 e7 f6 ff    	jb     78797 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x12f5>
  10a086:	0f 28 cb             	movaps %xmm3,%xmm1
  10a089:	0f 28 ea             	movaps %xmm2,%xmm5
  10a08c:	f3 0f 5c cf          	subss  %xmm7,%xmm1
  10a090:	f3 0f 5c ee          	subss  %xmm6,%xmm5
  10a094:	f3 0f 59 c9          	mulss  %xmm1,%xmm1
  10a098:	f3 0f 59 ed          	mulss  %xmm5,%xmm5
  10a09c:	f3 0f 58 cd          	addss  %xmm5,%xmm1
  10a0a0:	0f 28 ec             	movaps %xmm4,%xmm5
  10a0a3:	f3 41 0f 5c e8       	subss  %xmm8,%xmm5
  10a0a8:	f3 0f 59 ed          	mulss  %xmm5,%xmm5
  10a0ac:	f3 0f 58 cd          	addss  %xmm5,%xmm1
  10a0b0:	66 0f ef ed          	pxor   %xmm5,%xmm5
  10a0b4:	f3 0f 11 6c 24 48    	movss  %xmm5,0x48(%rsp)
  10a0ba:	0f 2f e9             	comiss %xmm1,%xmm5
  10a0bd:	0f 83 b2 29 00 00    	jae    10ca75 <synreal::SolverNewton::precompute_matrices()+0x8705>
  10a0c3:	48 8b 94 24 00 07 00 	mov    0x700(%rsp),%rdx
  10a0ca:	00 
  10a0cb:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  10a0d0:	f3 0f 10 0c 0a       	movss  (%rdx,%rcx,1),%xmm1
  10a0d5:	0f 28 e9             	movaps %xmm1,%xmm5
  10a0d8:	0f 54 2d c1 56 0e 00 	andps  0xe56c1(%rip),%xmm5        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10a0df:	0f 2e c5             	ucomiss %xmm5,%xmm0
  10a0e2:	0f 82 42 e6 f6 ff    	jb     7872a <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1288>
  10a0e8:	f3 0f 10 6c 24 48    	movss  0x48(%rsp),%xmm5
  10a0ee:	0f 2f e9             	comiss %xmm1,%xmm5
  10a0f1:	0f 87 33 e6 f6 ff    	ja     7872a <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1288>
  10a0f7:	48 8b 94 24 20 07 00 	mov    0x720(%rsp),%rdx
  10a0fe:	00 
  10a0ff:	f3 0f 10 0c 0a       	movss  (%rdx,%rcx,1),%xmm1
  10a104:	0f 28 e9             	movaps %xmm1,%xmm5
  10a107:	0f 54 2d 92 56 0e 00 	andps  0xe5692(%rip),%xmm5        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10a10e:	0f 2e c5             	ucomiss %xmm5,%xmm0
  10a111:	0f 82 ac 25 00 00    	jb     10c6c3 <synreal::SolverNewton::precompute_matrices()+0x8353>
  10a117:	f3 0f 10 6c 24 48    	movss  0x48(%rsp),%xmm5
  10a11d:	0f 2f e9             	comiss %xmm1,%xmm5
  10a120:	0f 87 cb db f6 ff    	ja     77cf1 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x84f>
  10a126:	48 8b 8c 24 60 07 00 	mov    0x760(%rsp),%rcx
  10a12d:	00 
  10a12e:	48 8d 14 40          	lea    (%rax,%rax,2),%rdx
  10a132:	48 8d 14 91          	lea    (%rcx,%rdx,4),%rdx
  10a136:	f3 44 0f 5c 5a 08    	subss  0x8(%rdx),%xmm11
  10a13c:	f3 44 0f 5c 52 04    	subss  0x4(%rdx),%xmm10
  10a142:	f3 44 0f 5c 0a       	subss  (%rdx),%xmm9
  10a147:	f3 44 0f 11 5c 24 58 	movss  %xmm11,0x58(%rsp)
  10a14e:	f3 44 0f 11 54 24 60 	movss  %xmm10,0x60(%rsp)
  10a155:	66 45 0f 7e ce       	movd   %xmm9,%r14d
  10a15a:	41 83 fc ff          	cmp    $0xffffffff,%r12d
  10a15e:	0f 84 a1 09 00 00    	je     10ab05 <synreal::SolverNewton::precompute_matrices()+0x6795>
  10a164:	49 63 d4             	movslq %r12d,%rdx
  10a167:	f3 0f 10 2d 11 de 0e 	movss  0xede11(%rip),%xmm5        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10a16e:	00 
  10a16f:	48 8d 14 52          	lea    (%rdx,%rdx,2),%rdx
  10a173:	48 8d 14 91          	lea    (%rcx,%rdx,4),%rdx
  10a177:	44 0f 28 f5          	movaps %xmm5,%xmm14
  10a17b:	f3 0f 11 6c 24 48    	movss  %xmm5,0x48(%rsp)
  10a181:	f3 0f 10 4a 04       	movss  0x4(%rdx),%xmm1
  10a186:	f3 0f 10 02          	movss  (%rdx),%xmm0
  10a18a:	f3 44 0f 10 4a 08    	movss  0x8(%rdx),%xmm9
  10a190:	f3 0f 5c d9          	subss  %xmm1,%xmm3
  10a194:	f3 0f 5c f9          	subss  %xmm1,%xmm7
  10a198:	f3 0f 5c f0          	subss  %xmm0,%xmm6
  10a19c:	f3 0f 5c d0          	subss  %xmm0,%xmm2
  10a1a0:	41 0f 28 c6          	movaps %xmm14,%xmm0
  10a1a4:	f3 45 0f 5c c1       	subss  %xmm9,%xmm8
  10a1a9:	f3 41 0f 5c e1       	subss  %xmm9,%xmm4
  10a1ae:	0f 28 cb             	movaps %xmm3,%xmm1
  10a1b1:	f3 0f 58 df          	addss  %xmm7,%xmm3
  10a1b5:	44 0f 28 d7          	movaps %xmm7,%xmm10
  10a1b9:	0f 14 c2             	unpcklps %xmm2,%xmm0
  10a1bc:	f3 0f 58 d6          	addss  %xmm6,%xmm2
  10a1c0:	0f 14 ee             	unpcklps %xmm6,%xmm5
  10a1c3:	0f 14 cc             	unpcklps %xmm4,%xmm1
  10a1c6:	f3 41 0f 58 e0       	addss  %xmm8,%xmm4
  10a1cb:	45 0f 14 d0          	unpcklps %xmm8,%xmm10
  10a1cf:	0f 16 c1             	movlhps %xmm1,%xmm0
  10a1d2:	f3 0f 10 0d ae dd 0e 	movss  0xeddae(%rip),%xmm1        # 1f7f88 <cuda::std::__4::in_place+0x3b>
  10a1d9:	00 
  10a1da:	41 0f 16 ea          	movlhps %xmm10,%xmm5
  10a1de:	41 0f 28 fe          	movaps %xmm14,%xmm7
  10a1e2:	f3 0f 59 e1          	mulss  %xmm1,%xmm4
  10a1e6:	f3 0f 59 d9          	mulss  %xmm1,%xmm3
  10a1ea:	f3 0f 59 d1          	mulss  %xmm1,%xmm2
  10a1ee:	f3 0f 11 64 24 78    	movss  %xmm4,0x78(%rsp)
  10a1f4:	f3 0f 11 9c 24 a0 00 	movss  %xmm3,0xa0(%rsp)
  10a1fb:	00 00 
  10a1fd:	f3 0f 11 94 24 a8 00 	movss  %xmm2,0xa8(%rsp)
  10a204:	00 00 
  10a206:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
  10a20b:	48 8b 8c 24 08 01 00 	mov    0x108(%rsp),%rcx
  10a212:	00 
  10a213:	31 ed                	xor    %ebp,%ebp
  10a215:	4c 8d bc 24 88 07 00 	lea    0x788(%rsp),%r15
  10a21c:	00 
  10a21d:	48 8b b4 24 10 01 00 	mov    0x110(%rsp),%rsi
  10a224:	00 
  10a225:	48 c1 e0 04          	shl    $0x4,%rax
  10a229:	f3 0f 10 74 24 60    	movss  0x60(%rsp),%xmm6
  10a22f:	c7 84 24 88 07 00 00 	movl   $0x0,0x788(%rsp)
  10a236:	00 00 00 00 
  10a23a:	0f 11 2c b9          	movups %xmm5,(%rcx,%rdi,4)
  10a23e:	48 8b 8c 24 f0 00 00 	mov    0xf0(%rsp),%rcx
  10a245:	00 
  10a246:	48 03 84 24 40 07 00 	add    0x740(%rsp),%rax
  10a24d:	00 
  10a24e:	4c 8d 2d 1e d4 0e 00 	lea    0xed41e(%rip),%r13        # 1f7673 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7773>
  10a255:	f3 0f 11 3c be       	movss  %xmm7,(%rsi,%rdi,4)
  10a25a:	f3 0f 10 7c 24 58    	movss  0x58(%rsp),%xmm7
  10a260:	f3 0f 11 74 be 08    	movss  %xmm6,0x8(%rsi,%rdi,4)
  10a266:	0f 11 04 b9          	movups %xmm0,(%rcx,%rdi,4)
  10a26a:	f3 0f 6f 30          	movdqu (%rax),%xmm6
  10a26e:	44 89 74 be 04       	mov    %r14d,0x4(%rsi,%rdi,4)
  10a273:	48 c7 84 24 90 07 00 	movq   $0x0,0x790(%rsp)
  10a27a:	00 00 00 00 00 
  10a27f:	4c 89 bc 24 98 07 00 	mov    %r15,0x798(%rsp)
  10a286:	00 
  10a287:	4c 89 bc 24 a0 07 00 	mov    %r15,0x7a0(%rsp)
  10a28e:	00 
  10a28f:	48 c7 84 24 a8 07 00 	movq   $0x0,0x7a8(%rsp)
  10a296:	00 00 00 00 00 
  10a29b:	f3 0f 11 84 24 c0 00 	movss  %xmm0,0xc0(%rsp)
  10a2a2:	00 00 
  10a2a4:	f3 0f 11 7c be 0c    	movss  %xmm7,0xc(%rsi,%rdi,4)
  10a2aa:	0f 29 b4 24 40 06 00 	movaps %xmm6,0x640(%rsp)
  10a2b1:	00 
  10a2b2:	83 fd 02             	cmp    $0x2,%ebp
  10a2b5:	0f 84 d2 06 00 00    	je     10a98d <synreal::SolverNewton::precompute_matrices()+0x661d>
  10a2bb:	83 fd 03             	cmp    $0x3,%ebp
  10a2be:	0f 84 bd 06 00 00    	je     10a981 <synreal::SolverNewton::precompute_matrices()+0x6611>
  10a2c4:	83 fd 01             	cmp    $0x1,%ebp
  10a2c7:	0f 84 a8 06 00 00    	je     10a975 <synreal::SolverNewton::precompute_matrices()+0x6605>
  10a2cd:	8b bc 24 40 06 00 00 	mov    0x640(%rsp),%edi
  10a2d4:	4c 89 ea             	mov    %r13,%rdx
  10a2d7:	48 89 de             	mov    %rbx,%rsi
  10a2da:	e8 c1 0f f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10a2df:	83 fd 02             	cmp    $0x2,%ebp
  10a2e2:	0f 84 75 06 00 00    	je     10a95d <synreal::SolverNewton::precompute_matrices()+0x65ed>
  10a2e8:	83 fd 03             	cmp    $0x3,%ebp
  10a2eb:	0f 84 54 06 00 00    	je     10a945 <synreal::SolverNewton::precompute_matrices()+0x65d5>
  10a2f1:	83 fd 01             	cmp    $0x1,%ebp
  10a2f4:	0f 84 26 06 00 00    	je     10a920 <synreal::SolverNewton::precompute_matrices()+0x65b0>
  10a2fa:	f3 0f 10 74 24 48    	movss  0x48(%rsp),%xmm6
  10a300:	4c 8d 84 24 40 06 00 	lea    0x640(%rsp),%r8
  10a307:	00 
  10a308:	f3 0f 11 34 24       	movss  %xmm6,(%rsp)
  10a30d:	48 8b 84 24 90 07 00 	mov    0x790(%rsp),%rax
  10a314:	00 
  10a315:	48 85 c0             	test   %rax,%rax
  10a318:	0f 84 1f 06 00 00    	je     10a93d <synreal::SolverNewton::precompute_matrices()+0x65cd>
  10a31e:	41 8b 38             	mov    (%r8),%edi
  10a321:	4c 89 fe             	mov    %r15,%rsi
  10a324:	0f 1f 40 00          	nopl   0x0(%rax)
  10a328:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10a32c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10a330:	39 78 20             	cmp    %edi,0x20(%rax)
  10a333:	7c 18                	jl     10a34d <synreal::SolverNewton::precompute_matrices()+0x5fdd>
  10a335:	48 89 c6             	mov    %rax,%rsi
  10a338:	48 85 d2             	test   %rdx,%rdx
  10a33b:	74 1a                	je     10a357 <synreal::SolverNewton::precompute_matrices()+0x5fe7>
  10a33d:	48 89 d0             	mov    %rdx,%rax
  10a340:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10a344:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10a348:	39 78 20             	cmp    %edi,0x20(%rax)
  10a34b:	7d e8                	jge    10a335 <synreal::SolverNewton::precompute_matrices()+0x5fc5>
  10a34d:	48 85 c9             	test   %rcx,%rcx
  10a350:	74 05                	je     10a357 <synreal::SolverNewton::precompute_matrices()+0x5fe7>
  10a352:	48 89 c8             	mov    %rcx,%rax
  10a355:	eb d1                	jmp    10a328 <synreal::SolverNewton::precompute_matrices()+0x5fb8>
  10a357:	4c 39 fe             	cmp    %r15,%rsi
  10a35a:	74 05                	je     10a361 <synreal::SolverNewton::precompute_matrices()+0x5ff1>
  10a35c:	3b 7e 20             	cmp    0x20(%rsi),%edi
  10a35f:	7d 20                	jge    10a381 <synreal::SolverNewton::precompute_matrices()+0x6011>
  10a361:	48 8d 94 24 c0 03 00 	lea    0x3c0(%rsp),%rdx
  10a368:	00 
  10a369:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  10a370:	00 
  10a371:	4c 89 84 24 c0 03 00 	mov    %r8,0x3c0(%rsp)
  10a378:	00 
  10a379:	e8 02 67 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10a37e:	48 89 c6             	mov    %rax,%rsi
  10a381:	f3 0f 10 46 24       	movss  0x24(%rsi),%xmm0
  10a386:	f3 0f 5c 04 24       	subss  (%rsp),%xmm0
  10a38b:	83 c5 01             	add    $0x1,%ebp
  10a38e:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  10a393:	83 fd 04             	cmp    $0x4,%ebp
  10a396:	0f 85 16 ff ff ff    	jne    10a2b2 <synreal::SolverNewton::precompute_matrices()+0x5f42>
  10a39c:	41 83 fc ff          	cmp    $0xffffffff,%r12d
  10a3a0:	0f 85 f3 05 00 00    	jne    10a999 <synreal::SolverNewton::precompute_matrices()+0x6629>
  10a3a6:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  10a3ab:	48 8b 84 24 80 00 00 	mov    0x80(%rsp),%rax
  10a3b2:	00 
  10a3b3:	48 39 7c 24 38       	cmp    %rdi,0x38(%rsp)
  10a3b8:	4c 8b b4 24 98 07 00 	mov    0x798(%rsp),%r14
  10a3bf:	00 
  10a3c0:	48 0f 46 84 24 f8 00 	cmovbe 0xf8(%rsp),%rax
  10a3c7:	00 00 
  10a3c9:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  10a3ce:	48 8d 84 24 0c 03 00 	lea    0x30c(%rsp),%rax
  10a3d5:	00 
  10a3d6:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
  10a3db:	4d 39 fe             	cmp    %r15,%r14
  10a3de:	0f 84 f8 03 00 00    	je     10a7dc <synreal::SolverNewton::precompute_matrices()+0x646c>
  10a3e4:	0f 1f 40 00          	nopl   0x0(%rax)
  10a3e8:	48 8b 94 24 00 07 00 	mov    0x700(%rsp),%rdx
  10a3ef:	00 
  10a3f0:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
  10a3f5:	f3 41 0f 10 4e 24    	movss  0x24(%r14),%xmm1
  10a3fb:	49 63 46 20          	movslq 0x20(%r14),%rax
  10a3ff:	f3 0f 10 04 3a       	movss  (%rdx,%rdi,1),%xmm0
  10a404:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
  10a409:	4c 89 f7             	mov    %r14,%rdi
  10a40c:	48 89 14 24          	mov    %rdx,(%rsp)
  10a410:	49 89 c4             	mov    %rax,%r12
  10a413:	f3 0f 59 c1          	mulss  %xmm1,%xmm0
  10a417:	48 8d 04 86          	lea    (%rsi,%rax,4),%rax
  10a41b:	f3 0f 59 c1          	mulss  %xmm1,%xmm0
  10a41f:	f3 0f 58 00          	addss  (%rax),%xmm0
  10a423:	f3 0f 11 00          	movss  %xmm0,(%rax)
  10a427:	e8 44 22 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  10a42c:	48 8b 14 24          	mov    (%rsp),%rdx
  10a430:	4c 39 f8             	cmp    %r15,%rax
  10a433:	48 89 c5             	mov    %rax,%rbp
  10a436:	0f 84 8c 03 00 00    	je     10a7c8 <synreal::SolverNewton::precompute_matrices()+0x6458>
  10a43c:	0f 1f 40 00          	nopl   0x0(%rax)
  10a440:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  10a445:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  10a44a:	f3 0f 10 04 02       	movss  (%rdx,%rax,1),%xmm0
  10a44f:	f3 41 0f 59 46 24    	mulss  0x24(%r14),%xmm0
  10a455:	f3 0f 59 45 24       	mulss  0x24(%rbp),%xmm0
  10a45a:	8b 45 20             	mov    0x20(%rbp),%eax
  10a45d:	f3 0f 11 04 24       	movss  %xmm0,(%rsp)
  10a462:	48 39 7c 24 38       	cmp    %rdi,0x38(%rsp)
  10a467:	0f 87 93 00 00 00    	ja     10a500 <synreal::SolverNewton::precompute_matrices()+0x6190>
  10a46d:	4c 89 ea             	mov    %r13,%rdx
  10a470:	48 89 de             	mov    %rbx,%rsi
  10a473:	44 89 e7             	mov    %r12d,%edi
  10a476:	89 84 24 00 03 00 00 	mov    %eax,0x300(%rsp)
  10a47d:	e8 1e 0e f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10a482:	8b bc 24 00 03 00 00 	mov    0x300(%rsp),%edi
  10a489:	4c 89 ea             	mov    %r13,%rdx
  10a48c:	48 89 de             	mov    %rbx,%rsi
  10a48f:	e8 0c 0e f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10a494:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
  10a499:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  10a49d:	48 c1 e0 04          	shl    $0x4,%rax
  10a4a1:	4c 8d 0c 06          	lea    (%rsi,%rax,1),%r9
  10a4a5:	49 8b 41 10          	mov    0x10(%r9),%rax
  10a4a9:	4d 8d 41 08          	lea    0x8(%r9),%r8
  10a4ad:	48 85 c0             	test   %rax,%rax
  10a4b0:	0f 84 52 04 00 00    	je     10a908 <synreal::SolverNewton::precompute_matrices()+0x6598>
  10a4b6:	8b bc 24 00 03 00 00 	mov    0x300(%rsp),%edi
  10a4bd:	4c 89 c6             	mov    %r8,%rsi
  10a4c0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10a4c4:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10a4c8:	39 78 20             	cmp    %edi,0x20(%rax)
  10a4cb:	7c 1c                	jl     10a4e9 <synreal::SolverNewton::precompute_matrices()+0x6179>
  10a4cd:	48 89 c6             	mov    %rax,%rsi
  10a4d0:	48 85 d2             	test   %rdx,%rdx
  10a4d3:	0f 84 e7 01 00 00    	je     10a6c0 <synreal::SolverNewton::precompute_matrices()+0x6350>
  10a4d9:	48 89 d0             	mov    %rdx,%rax
  10a4dc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10a4e0:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10a4e4:	39 78 20             	cmp    %edi,0x20(%rax)
  10a4e7:	7d e4                	jge    10a4cd <synreal::SolverNewton::precompute_matrices()+0x615d>
  10a4e9:	48 85 c9             	test   %rcx,%rcx
  10a4ec:	0f 84 ce 01 00 00    	je     10a6c0 <synreal::SolverNewton::precompute_matrices()+0x6350>
  10a4f2:	48 89 c8             	mov    %rcx,%rax
  10a4f5:	eb c9                	jmp    10a4c0 <synreal::SolverNewton::precompute_matrices()+0x6150>
  10a4f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10a4fe:	00 00 
  10a500:	4c 89 ea             	mov    %r13,%rdx
  10a503:	48 89 de             	mov    %rbx,%rsi
  10a506:	44 89 e7             	mov    %r12d,%edi
  10a509:	89 84 24 08 03 00 00 	mov    %eax,0x308(%rsp)
  10a510:	e8 8b 0d f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10a515:	8b bc 24 08 03 00 00 	mov    0x308(%rsp),%edi
  10a51c:	4c 89 ea             	mov    %r13,%rdx
  10a51f:	48 89 de             	mov    %rbx,%rsi
  10a522:	e8 79 0d f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10a527:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  10a52c:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  10a530:	48 c1 e0 04          	shl    $0x4,%rax
  10a534:	4c 8d 0c 06          	lea    (%rsi,%rax,1),%r9
  10a538:	49 8b 41 10          	mov    0x10(%r9),%rax
  10a53c:	4d 8d 41 08          	lea    0x8(%r9),%r8
  10a540:	48 85 c0             	test   %rax,%rax
  10a543:	0f 84 b7 03 00 00    	je     10a900 <synreal::SolverNewton::precompute_matrices()+0x6590>
  10a549:	8b bc 24 08 03 00 00 	mov    0x308(%rsp),%edi
  10a550:	4c 89 c6             	mov    %r8,%rsi
  10a553:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10a558:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10a55c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10a560:	39 78 20             	cmp    %edi,0x20(%rax)
  10a563:	7c 18                	jl     10a57d <synreal::SolverNewton::precompute_matrices()+0x620d>
  10a565:	48 89 c6             	mov    %rax,%rsi
  10a568:	48 85 d2             	test   %rdx,%rdx
  10a56b:	74 23                	je     10a590 <synreal::SolverNewton::precompute_matrices()+0x6220>
  10a56d:	48 89 d0             	mov    %rdx,%rax
  10a570:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10a574:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10a578:	39 78 20             	cmp    %edi,0x20(%rax)
  10a57b:	7d e8                	jge    10a565 <synreal::SolverNewton::precompute_matrices()+0x61f5>
  10a57d:	48 85 c9             	test   %rcx,%rcx
  10a580:	74 0e                	je     10a590 <synreal::SolverNewton::precompute_matrices()+0x6220>
  10a582:	48 89 c8             	mov    %rcx,%rax
  10a585:	eb d1                	jmp    10a558 <synreal::SolverNewton::precompute_matrices()+0x61e8>
  10a587:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10a58e:	00 00 
  10a590:	4c 39 c6             	cmp    %r8,%rsi
  10a593:	74 05                	je     10a59a <synreal::SolverNewton::precompute_matrices()+0x622a>
  10a595:	3b 7e 20             	cmp    0x20(%rsi),%edi
  10a598:	7d 23                	jge    10a5bd <synreal::SolverNewton::precompute_matrices()+0x624d>
  10a59a:	48 8d 84 24 08 03 00 	lea    0x308(%rsp),%rax
  10a5a1:	00 
  10a5a2:	48 8d 94 24 a0 05 00 	lea    0x5a0(%rsp),%rdx
  10a5a9:	00 
  10a5aa:	4c 89 cf             	mov    %r9,%rdi
  10a5ad:	48 89 84 24 a0 05 00 	mov    %rax,0x5a0(%rsp)
  10a5b4:	00 
  10a5b5:	e8 c6 64 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10a5ba:	48 89 c6             	mov    %rax,%rsi
  10a5bd:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  10a5c2:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  10a5c7:	4c 89 ea             	mov    %r13,%rdx
  10a5ca:	4c 63 65 20          	movslq 0x20(%rbp),%r12
  10a5ce:	41 8b 46 20          	mov    0x20(%r14),%eax
  10a5d2:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  10a5d7:	44 89 e7             	mov    %r12d,%edi
  10a5da:	48 89 de             	mov    %rbx,%rsi
  10a5dd:	89 84 24 0c 03 00 00 	mov    %eax,0x30c(%rsp)
  10a5e4:	e8 b7 0c f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10a5e9:	8b bc 24 0c 03 00 00 	mov    0x30c(%rsp),%edi
  10a5f0:	4c 89 ea             	mov    %r13,%rdx
  10a5f3:	48 89 de             	mov    %rbx,%rsi
  10a5f6:	e8 a5 0c f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10a5fb:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  10a600:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  10a604:	48 c1 e0 04          	shl    $0x4,%rax
  10a608:	4c 8d 0c 07          	lea    (%rdi,%rax,1),%r9
  10a60c:	49 8b 41 10          	mov    0x10(%r9),%rax
  10a610:	4d 8d 41 08          	lea    0x8(%r9),%r8
  10a614:	48 85 c0             	test   %rax,%rax
  10a617:	0f 84 fb 02 00 00    	je     10a918 <synreal::SolverNewton::precompute_matrices()+0x65a8>
  10a61d:	8b bc 24 0c 03 00 00 	mov    0x30c(%rsp),%edi
  10a624:	4c 89 c6             	mov    %r8,%rsi
  10a627:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10a62e:	00 00 
  10a630:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10a634:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10a638:	3b 78 20             	cmp    0x20(%rax),%edi
  10a63b:	7f 18                	jg     10a655 <synreal::SolverNewton::precompute_matrices()+0x62e5>
  10a63d:	48 89 c6             	mov    %rax,%rsi
  10a640:	48 85 d2             	test   %rdx,%rdx
  10a643:	74 1b                	je     10a660 <synreal::SolverNewton::precompute_matrices()+0x62f0>
  10a645:	48 89 d0             	mov    %rdx,%rax
  10a648:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10a64c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10a650:	3b 78 20             	cmp    0x20(%rax),%edi
  10a653:	7e e8                	jle    10a63d <synreal::SolverNewton::precompute_matrices()+0x62cd>
  10a655:	48 85 c9             	test   %rcx,%rcx
  10a658:	74 06                	je     10a660 <synreal::SolverNewton::precompute_matrices()+0x62f0>
  10a65a:	48 89 c8             	mov    %rcx,%rax
  10a65d:	eb d1                	jmp    10a630 <synreal::SolverNewton::precompute_matrices()+0x62c0>
  10a65f:	90                   	nop
  10a660:	4c 39 c6             	cmp    %r8,%rsi
  10a663:	74 05                	je     10a66a <synreal::SolverNewton::precompute_matrices()+0x62fa>
  10a665:	3b 7e 20             	cmp    0x20(%rsi),%edi
  10a668:	7d 20                	jge    10a68a <synreal::SolverNewton::precompute_matrices()+0x631a>
  10a66a:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
  10a66f:	48 8d 94 24 c0 05 00 	lea    0x5c0(%rsp),%rdx
  10a676:	00 
  10a677:	4c 89 cf             	mov    %r9,%rdi
  10a67a:	48 89 84 24 c0 05 00 	mov    %rax,0x5c0(%rsp)
  10a681:	00 
  10a682:	e8 f9 63 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10a687:	48 89 c6             	mov    %rax,%rsi
  10a68a:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  10a68f:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  10a694:	48 89 ef             	mov    %rbp,%rdi
  10a697:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  10a69c:	e8 cf 1f f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  10a6a1:	48 89 c5             	mov    %rax,%rbp
  10a6a4:	4c 39 f8             	cmp    %r15,%rax
  10a6a7:	0f 84 1b 01 00 00    	je     10a7c8 <synreal::SolverNewton::precompute_matrices()+0x6458>
  10a6ad:	48 8b 94 24 00 07 00 	mov    0x700(%rsp),%rdx
  10a6b4:	00 
  10a6b5:	4d 63 66 20          	movslq 0x20(%r14),%r12
  10a6b9:	e9 82 fd ff ff       	jmp    10a440 <synreal::SolverNewton::precompute_matrices()+0x60d0>
  10a6be:	66 90                	xchg   %ax,%ax
  10a6c0:	4c 39 c6             	cmp    %r8,%rsi
  10a6c3:	74 05                	je     10a6ca <synreal::SolverNewton::precompute_matrices()+0x635a>
  10a6c5:	3b 7e 20             	cmp    0x20(%rsi),%edi
  10a6c8:	7d 23                	jge    10a6ed <synreal::SolverNewton::precompute_matrices()+0x637d>
  10a6ca:	48 8d 84 24 00 03 00 	lea    0x300(%rsp),%rax
  10a6d1:	00 
  10a6d2:	48 8d 94 24 d0 03 00 	lea    0x3d0(%rsp),%rdx
  10a6d9:	00 
  10a6da:	4c 89 cf             	mov    %r9,%rdi
  10a6dd:	48 89 84 24 d0 03 00 	mov    %rax,0x3d0(%rsp)
  10a6e4:	00 
  10a6e5:	e8 96 63 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10a6ea:	48 89 c6             	mov    %rax,%rsi
  10a6ed:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  10a6f2:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  10a6f7:	4c 89 ea             	mov    %r13,%rdx
  10a6fa:	4c 63 65 20          	movslq 0x20(%rbp),%r12
  10a6fe:	41 8b 46 20          	mov    0x20(%r14),%eax
  10a702:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  10a707:	44 89 e7             	mov    %r12d,%edi
  10a70a:	48 89 de             	mov    %rbx,%rsi
  10a70d:	89 84 24 04 03 00 00 	mov    %eax,0x304(%rsp)
  10a714:	e8 87 0b f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10a719:	8b bc 24 04 03 00 00 	mov    0x304(%rsp),%edi
  10a720:	4c 89 ea             	mov    %r13,%rdx
  10a723:	48 89 de             	mov    %rbx,%rsi
  10a726:	e8 75 0b f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10a72b:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
  10a730:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  10a734:	48 c1 e0 04          	shl    $0x4,%rax
  10a738:	4c 8d 0c 07          	lea    (%rdi,%rax,1),%r9
  10a73c:	49 8b 41 10          	mov    0x10(%r9),%rax
  10a740:	4d 8d 41 08          	lea    0x8(%r9),%r8
  10a744:	48 85 c0             	test   %rax,%rax
  10a747:	0f 84 c3 01 00 00    	je     10a910 <synreal::SolverNewton::precompute_matrices()+0x65a0>
  10a74d:	8b bc 24 04 03 00 00 	mov    0x304(%rsp),%edi
  10a754:	4c 89 c6             	mov    %r8,%rsi
  10a757:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10a75e:	00 00 
  10a760:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10a764:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10a768:	3b 78 20             	cmp    0x20(%rax),%edi
  10a76b:	7f 18                	jg     10a785 <synreal::SolverNewton::precompute_matrices()+0x6415>
  10a76d:	48 89 c6             	mov    %rax,%rsi
  10a770:	48 85 d2             	test   %rdx,%rdx
  10a773:	74 1b                	je     10a790 <synreal::SolverNewton::precompute_matrices()+0x6420>
  10a775:	48 89 d0             	mov    %rdx,%rax
  10a778:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10a77c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10a780:	3b 78 20             	cmp    0x20(%rax),%edi
  10a783:	7e e8                	jle    10a76d <synreal::SolverNewton::precompute_matrices()+0x63fd>
  10a785:	48 85 c9             	test   %rcx,%rcx
  10a788:	74 06                	je     10a790 <synreal::SolverNewton::precompute_matrices()+0x6420>
  10a78a:	48 89 c8             	mov    %rcx,%rax
  10a78d:	eb d1                	jmp    10a760 <synreal::SolverNewton::precompute_matrices()+0x63f0>
  10a78f:	90                   	nop
  10a790:	4c 39 c6             	cmp    %r8,%rsi
  10a793:	74 09                	je     10a79e <synreal::SolverNewton::precompute_matrices()+0x642e>
  10a795:	3b 7e 20             	cmp    0x20(%rsi),%edi
  10a798:	0f 8d ec fe ff ff    	jge    10a68a <synreal::SolverNewton::precompute_matrices()+0x631a>
  10a79e:	48 8d 84 24 04 03 00 	lea    0x304(%rsp),%rax
  10a7a5:	00 
  10a7a6:	48 8d 94 24 d8 03 00 	lea    0x3d8(%rsp),%rdx
  10a7ad:	00 
  10a7ae:	4c 89 cf             	mov    %r9,%rdi
  10a7b1:	48 89 84 24 d8 03 00 	mov    %rax,0x3d8(%rsp)
  10a7b8:	00 
  10a7b9:	e8 c2 62 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10a7be:	e9 c4 fe ff ff       	jmp    10a687 <synreal::SolverNewton::precompute_matrices()+0x6317>
  10a7c3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10a7c8:	4c 89 f7             	mov    %r14,%rdi
  10a7cb:	e8 a0 1e f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  10a7d0:	49 89 c6             	mov    %rax,%r14
  10a7d3:	4c 39 f8             	cmp    %r15,%rax
  10a7d6:	0f 85 0c fc ff ff    	jne    10a3e8 <synreal::SolverNewton::precompute_matrices()+0x6078>
  10a7dc:	48 8b bc 24 90 07 00 	mov    0x790(%rsp),%rdi
  10a7e3:	00 
  10a7e4:	e8 07 5e fe ff       	call   f05f0 <std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, float> >*) [clone .isra.0]>
  10a7e9:	48 83 44 24 20 01    	addq   $0x1,0x20(%rsp)
  10a7ef:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  10a7f4:	48 83 44 24 18 04    	addq   $0x4,0x18(%rsp)
  10a7fa:	48 39 84 24 b8 00 00 	cmp    %rax,0xb8(%rsp)
  10a801:	00 
  10a802:	0f 85 1b f7 ff ff    	jne    109f23 <synreal::SolverNewton::precompute_matrices()+0x5bb3>
  10a808:	48 8b bc 24 60 07 00 	mov    0x760(%rsp),%rdi
  10a80f:	00 
  10a810:	48 85 ff             	test   %rdi,%rdi
  10a813:	74 10                	je     10a825 <synreal::SolverNewton::precompute_matrices()+0x64b5>
  10a815:	48 8b b4 24 70 07 00 	mov    0x770(%rsp),%rsi
  10a81c:	00 
  10a81d:	48 29 fe             	sub    %rdi,%rsi
  10a820:	e8 8b 29 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10a825:	48 8b bc 24 40 07 00 	mov    0x740(%rsp),%rdi
  10a82c:	00 
  10a82d:	48 85 ff             	test   %rdi,%rdi
  10a830:	74 10                	je     10a842 <synreal::SolverNewton::precompute_matrices()+0x64d2>
  10a832:	48 8b b4 24 50 07 00 	mov    0x750(%rsp),%rsi
  10a839:	00 
  10a83a:	48 29 fe             	sub    %rdi,%rsi
  10a83d:	e8 6e 29 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10a842:	48 8b bc 24 20 07 00 	mov    0x720(%rsp),%rdi
  10a849:	00 
  10a84a:	48 85 ff             	test   %rdi,%rdi
  10a84d:	74 10                	je     10a85f <synreal::SolverNewton::precompute_matrices()+0x64ef>
  10a84f:	48 8b b4 24 30 07 00 	mov    0x730(%rsp),%rsi
  10a856:	00 
  10a857:	48 29 fe             	sub    %rdi,%rsi
  10a85a:	e8 51 29 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10a85f:	48 8b bc 24 00 07 00 	mov    0x700(%rsp),%rdi
  10a866:	00 
  10a867:	48 85 ff             	test   %rdi,%rdi
  10a86a:	74 10                	je     10a87c <synreal::SolverNewton::precompute_matrices()+0x650c>
  10a86c:	48 8b b4 24 10 07 00 	mov    0x710(%rsp),%rsi
  10a873:	00 
  10a874:	48 29 fe             	sub    %rdi,%rsi
  10a877:	e8 34 29 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10a87c:	48 8b bc 24 e0 06 00 	mov    0x6e0(%rsp),%rdi
  10a883:	00 
  10a884:	48 85 ff             	test   %rdi,%rdi
  10a887:	74 10                	je     10a899 <synreal::SolverNewton::precompute_matrices()+0x6529>
  10a889:	48 8b b4 24 f0 06 00 	mov    0x6f0(%rsp),%rsi
  10a890:	00 
  10a891:	48 29 fe             	sub    %rdi,%rsi
  10a894:	e8 17 29 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10a899:	48 8b bc 24 c0 06 00 	mov    0x6c0(%rsp),%rdi
  10a8a0:	00 
  10a8a1:	48 85 ff             	test   %rdi,%rdi
  10a8a4:	74 10                	je     10a8b6 <synreal::SolverNewton::precompute_matrices()+0x6546>
  10a8a6:	48 8b b4 24 d0 06 00 	mov    0x6d0(%rsp),%rsi
  10a8ad:	00 
  10a8ae:	48 29 fe             	sub    %rdi,%rsi
  10a8b1:	e8 fa 28 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10a8b6:	48 8b bc 24 a0 06 00 	mov    0x6a0(%rsp),%rdi
  10a8bd:	00 
  10a8be:	48 85 ff             	test   %rdi,%rdi
  10a8c1:	74 10                	je     10a8d3 <synreal::SolverNewton::precompute_matrices()+0x6563>
  10a8c3:	48 8b b4 24 b0 06 00 	mov    0x6b0(%rsp),%rsi
  10a8ca:	00 
  10a8cb:	48 29 fe             	sub    %rdi,%rsi
  10a8ce:	e8 dd 28 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10a8d3:	48 8b bc 24 80 06 00 	mov    0x680(%rsp),%rdi
  10a8da:	00 
  10a8db:	48 85 ff             	test   %rdi,%rdi
  10a8de:	0f 84 d2 ad ff ff    	je     1056b6 <synreal::SolverNewton::precompute_matrices()+0x1346>
  10a8e4:	48 8b b4 24 90 06 00 	mov    0x690(%rsp),%rsi
  10a8eb:	00 
  10a8ec:	48 29 fe             	sub    %rdi,%rsi
  10a8ef:	e8 bc 28 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10a8f4:	e9 bd ad ff ff       	jmp    1056b6 <synreal::SolverNewton::precompute_matrices()+0x1346>
  10a8f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10a900:	4c 89 c6             	mov    %r8,%rsi
  10a903:	e9 92 fc ff ff       	jmp    10a59a <synreal::SolverNewton::precompute_matrices()+0x622a>
  10a908:	4c 89 c6             	mov    %r8,%rsi
  10a90b:	e9 ba fd ff ff       	jmp    10a6ca <synreal::SolverNewton::precompute_matrices()+0x635a>
  10a910:	4c 89 c6             	mov    %r8,%rsi
  10a913:	e9 86 fe ff ff       	jmp    10a79e <synreal::SolverNewton::precompute_matrices()+0x642e>
  10a918:	4c 89 c6             	mov    %r8,%rsi
  10a91b:	e9 4a fd ff ff       	jmp    10a66a <synreal::SolverNewton::precompute_matrices()+0x62fa>
  10a920:	48 8b 84 24 90 07 00 	mov    0x790(%rsp),%rax
  10a927:	00 
  10a928:	44 89 34 24          	mov    %r14d,(%rsp)
  10a92c:	4c 8d 84 24 44 06 00 	lea    0x644(%rsp),%r8
  10a933:	00 
  10a934:	48 85 c0             	test   %rax,%rax
  10a937:	0f 85 e1 f9 ff ff    	jne    10a31e <synreal::SolverNewton::precompute_matrices()+0x5fae>
  10a93d:	4c 89 fe             	mov    %r15,%rsi
  10a940:	e9 1c fa ff ff       	jmp    10a361 <synreal::SolverNewton::precompute_matrices()+0x5ff1>
  10a945:	f3 0f 10 7c 24 58    	movss  0x58(%rsp),%xmm7
  10a94b:	4c 8d 84 24 4c 06 00 	lea    0x64c(%rsp),%r8
  10a952:	00 
  10a953:	f3 0f 11 3c 24       	movss  %xmm7,(%rsp)
  10a958:	e9 b0 f9 ff ff       	jmp    10a30d <synreal::SolverNewton::precompute_matrices()+0x5f9d>
  10a95d:	f3 0f 10 7c 24 60    	movss  0x60(%rsp),%xmm7
  10a963:	4c 8d 84 24 48 06 00 	lea    0x648(%rsp),%r8
  10a96a:	00 
  10a96b:	f3 0f 11 3c 24       	movss  %xmm7,(%rsp)
  10a970:	e9 98 f9 ff ff       	jmp    10a30d <synreal::SolverNewton::precompute_matrices()+0x5f9d>
  10a975:	8b bc 24 44 06 00 00 	mov    0x644(%rsp),%edi
  10a97c:	e9 53 f9 ff ff       	jmp    10a2d4 <synreal::SolverNewton::precompute_matrices()+0x5f64>
  10a981:	8b bc 24 4c 06 00 00 	mov    0x64c(%rsp),%edi
  10a988:	e9 47 f9 ff ff       	jmp    10a2d4 <synreal::SolverNewton::precompute_matrices()+0x5f64>
  10a98d:	8b bc 24 48 06 00 00 	mov    0x648(%rsp),%edi
  10a994:	e9 3b f9 ff ff       	jmp    10a2d4 <synreal::SolverNewton::precompute_matrices()+0x5f64>
  10a999:	49 63 c4             	movslq %r12d,%rax
  10a99c:	31 ed                	xor    %ebp,%ebp
  10a99e:	48 c1 e0 04          	shl    $0x4,%rax
  10a9a2:	48 03 84 24 40 07 00 	add    0x740(%rsp),%rax
  10a9a9:	00 
  10a9aa:	f3 0f 6f 28          	movdqu (%rax),%xmm5
  10a9ae:	0f 29 ac 24 60 06 00 	movaps %xmm5,0x660(%rsp)
  10a9b5:	00 
  10a9b6:	83 fd 02             	cmp    $0x2,%ebp
  10a9b9:	0f 84 e6 00 00 00    	je     10aaa5 <synreal::SolverNewton::precompute_matrices()+0x6735>
  10a9bf:	83 fd 03             	cmp    $0x3,%ebp
  10a9c2:	0f 84 31 01 00 00    	je     10aaf9 <synreal::SolverNewton::precompute_matrices()+0x6789>
  10a9c8:	83 fd 01             	cmp    $0x1,%ebp
  10a9cb:	0f 84 1c 01 00 00    	je     10aaed <synreal::SolverNewton::precompute_matrices()+0x677d>
  10a9d1:	8b bc 24 60 06 00 00 	mov    0x660(%rsp),%edi
  10a9d8:	4c 89 ea             	mov    %r13,%rdx
  10a9db:	48 89 de             	mov    %rbx,%rsi
  10a9de:	e8 bd 08 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10a9e3:	83 fd 02             	cmp    $0x2,%ebp
  10a9e6:	0f 84 ec 00 00 00    	je     10aad8 <synreal::SolverNewton::precompute_matrices()+0x6768>
  10a9ec:	83 fd 03             	cmp    $0x3,%ebp
  10a9ef:	0f 84 bc 00 00 00    	je     10aab1 <synreal::SolverNewton::precompute_matrices()+0x6741>
  10a9f5:	83 fd 01             	cmp    $0x1,%ebp
  10a9f8:	0f 84 c5 00 00 00    	je     10aac3 <synreal::SolverNewton::precompute_matrices()+0x6753>
  10a9fe:	44 8b a4 24 c0 00 00 	mov    0xc0(%rsp),%r12d
  10aa05:	00 
  10aa06:	4c 8d 84 24 60 06 00 	lea    0x660(%rsp),%r8
  10aa0d:	00 
  10aa0e:	48 8b 84 24 90 07 00 	mov    0x790(%rsp),%rax
  10aa15:	00 
  10aa16:	48 85 c0             	test   %rax,%rax
  10aa19:	0f 84 1e 01 00 00    	je     10ab3d <synreal::SolverNewton::precompute_matrices()+0x67cd>
  10aa1f:	41 8b 38             	mov    (%r8),%edi
  10aa22:	4c 89 fe             	mov    %r15,%rsi
  10aa25:	0f 1f 00             	nopl   (%rax)
  10aa28:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10aa2c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10aa30:	39 78 20             	cmp    %edi,0x20(%rax)
  10aa33:	7c 18                	jl     10aa4d <synreal::SolverNewton::precompute_matrices()+0x66dd>
  10aa35:	48 89 c6             	mov    %rax,%rsi
  10aa38:	48 85 d2             	test   %rdx,%rdx
  10aa3b:	74 1a                	je     10aa57 <synreal::SolverNewton::precompute_matrices()+0x66e7>
  10aa3d:	48 89 d0             	mov    %rdx,%rax
  10aa40:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10aa44:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10aa48:	39 78 20             	cmp    %edi,0x20(%rax)
  10aa4b:	7d e8                	jge    10aa35 <synreal::SolverNewton::precompute_matrices()+0x66c5>
  10aa4d:	48 85 c9             	test   %rcx,%rcx
  10aa50:	74 05                	je     10aa57 <synreal::SolverNewton::precompute_matrices()+0x66e7>
  10aa52:	48 89 c8             	mov    %rcx,%rax
  10aa55:	eb d1                	jmp    10aa28 <synreal::SolverNewton::precompute_matrices()+0x66b8>
  10aa57:	4c 39 fe             	cmp    %r15,%rsi
  10aa5a:	74 05                	je     10aa61 <synreal::SolverNewton::precompute_matrices()+0x66f1>
  10aa5c:	3b 7e 20             	cmp    0x20(%rsi),%edi
  10aa5f:	7d 20                	jge    10aa81 <synreal::SolverNewton::precompute_matrices()+0x6711>
  10aa61:	48 8d 94 24 c8 03 00 	lea    0x3c8(%rsp),%rdx
  10aa68:	00 
  10aa69:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  10aa70:	00 
  10aa71:	4c 89 84 24 c8 03 00 	mov    %r8,0x3c8(%rsp)
  10aa78:	00 
  10aa79:	e8 02 60 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10aa7e:	48 89 c6             	mov    %rax,%rsi
  10aa81:	66 41 0f 6e c4       	movd   %r12d,%xmm0
  10aa86:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  10aa8b:	83 c5 01             	add    $0x1,%ebp
  10aa8e:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  10aa93:	83 fd 04             	cmp    $0x4,%ebp
  10aa96:	0f 84 0a f9 ff ff    	je     10a3a6 <synreal::SolverNewton::precompute_matrices()+0x6036>
  10aa9c:	83 fd 02             	cmp    $0x2,%ebp
  10aa9f:	0f 85 1a ff ff ff    	jne    10a9bf <synreal::SolverNewton::precompute_matrices()+0x664f>
  10aaa5:	8b bc 24 68 06 00 00 	mov    0x668(%rsp),%edi
  10aaac:	e9 27 ff ff ff       	jmp    10a9d8 <synreal::SolverNewton::precompute_matrices()+0x6668>
  10aab1:	44 8b 64 24 78       	mov    0x78(%rsp),%r12d
  10aab6:	4c 8d 84 24 6c 06 00 	lea    0x66c(%rsp),%r8
  10aabd:	00 
  10aabe:	e9 4b ff ff ff       	jmp    10aa0e <synreal::SolverNewton::precompute_matrices()+0x669e>
  10aac3:	44 8b a4 24 a8 00 00 	mov    0xa8(%rsp),%r12d
  10aaca:	00 
  10aacb:	4c 8d 84 24 64 06 00 	lea    0x664(%rsp),%r8
  10aad2:	00 
  10aad3:	e9 36 ff ff ff       	jmp    10aa0e <synreal::SolverNewton::precompute_matrices()+0x669e>
  10aad8:	44 8b a4 24 a0 00 00 	mov    0xa0(%rsp),%r12d
  10aadf:	00 
  10aae0:	4c 8d 84 24 68 06 00 	lea    0x668(%rsp),%r8
  10aae7:	00 
  10aae8:	e9 21 ff ff ff       	jmp    10aa0e <synreal::SolverNewton::precompute_matrices()+0x669e>
  10aaed:	8b bc 24 64 06 00 00 	mov    0x664(%rsp),%edi
  10aaf4:	e9 df fe ff ff       	jmp    10a9d8 <synreal::SolverNewton::precompute_matrices()+0x6668>
  10aaf9:	8b bc 24 6c 06 00 00 	mov    0x66c(%rsp),%edi
  10ab00:	e9 d3 fe ff ff       	jmp    10a9d8 <synreal::SolverNewton::precompute_matrices()+0x6668>
  10ab05:	0f 28 f5             	movaps %xmm5,%xmm6
  10ab08:	66 0f ef ed          	pxor   %xmm5,%xmm5
  10ab0c:	f3 0f 11 b4 24 a8 00 	movss  %xmm6,0xa8(%rsp)
  10ab13:	00 00 
  10ab15:	0f 28 c5             	movaps %xmm5,%xmm0
  10ab18:	f3 0f 11 b4 24 a0 00 	movss  %xmm6,0xa0(%rsp)
  10ab1f:	00 00 
  10ab21:	f3 0f 11 74 24 78    	movss  %xmm6,0x78(%rsp)
  10ab27:	f3 0f 10 35 51 d4 0e 	movss  0xed451(%rip),%xmm6        # 1f7f80 <cuda::std::__4::in_place+0x33>
  10ab2e:	00 
  10ab2f:	f3 0f 11 74 24 48    	movss  %xmm6,0x48(%rsp)
  10ab35:	0f 28 fe             	movaps %xmm6,%xmm7
  10ab38:	e9 c9 f6 ff ff       	jmp    10a206 <synreal::SolverNewton::precompute_matrices()+0x5e96>
  10ab3d:	4c 89 fe             	mov    %r15,%rsi
  10ab40:	e9 1c ff ff ff       	jmp    10aa61 <synreal::SolverNewton::precompute_matrices()+0x66f1>
  10ab45:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  10ab4a:	41 89 c6             	mov    %eax,%r14d
  10ab4d:	48 8d bc 24 80 06 00 	lea    0x680(%rsp),%rdi
  10ab54:	00 
  10ab55:	4c 8d 05 c4 d1 0d 00 	lea    0xdd1c4(%rip),%r8        # 1e7d20 <_fini+0x25dc>
  10ab5c:	4c 89 f1             	mov    %r14,%rcx
  10ab5f:	4c 89 b4 24 a0 00 00 	mov    %r14,0xa0(%rsp)
  10ab66:	00 
  10ab67:	49 8b b7 f8 04 00 00 	mov    0x4f8(%r15),%rsi
  10ab6e:	49 8b 97 00 05 00 00 	mov    0x500(%r15),%rdx
  10ab75:	e8 96 25 f6 ff       	call   6d110 <std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<2, int, (glm::qualifier)0> >(synreal::Span<glm::vec<2, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10ab7a:	49 8b b7 08 05 00 00 	mov    0x508(%r15),%rsi
  10ab81:	49 8b 97 10 05 00 00 	mov    0x510(%r15),%rdx
  10ab88:	4c 89 f1             	mov    %r14,%rcx
  10ab8b:	48 8d bc 24 a0 06 00 	lea    0x6a0(%rsp),%rdi
  10ab92:	00 
  10ab93:	4c 8d 05 06 d2 0d 00 	lea    0xdd206(%rip),%r8        # 1e7da0 <_fini+0x265c>
  10ab9a:	e8 11 22 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10ab9f:	49 8b b7 18 05 00 00 	mov    0x518(%r15),%rsi
  10aba6:	49 8b 97 20 05 00 00 	mov    0x520(%r15),%rdx
  10abad:	4c 89 f1             	mov    %r14,%rcx
  10abb0:	48 8d bc 24 c0 06 00 	lea    0x6c0(%rsp),%rdi
  10abb7:	00 
  10abb8:	4c 8d 05 61 d2 0d 00 	lea    0xdd261(%rip),%r8        # 1e7e20 <_fini+0x26dc>
  10abbf:	e8 ec 21 f6 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10abc4:	49 8b b7 28 05 00 00 	mov    0x528(%r15),%rsi
  10abcb:	49 8b 97 30 05 00 00 	mov    0x530(%r15),%rdx
  10abd2:	4c 89 f1             	mov    %r14,%rcx
  10abd5:	48 8d bc 24 e0 06 00 	lea    0x6e0(%rsp),%rdi
  10abdc:	00 
  10abdd:	4c 8d 05 cc d2 0d 00 	lea    0xdd2cc(%rip),%r8        # 1e7eb0 <_fini+0x276c>
  10abe4:	e8 67 35 f6 ff       	call   6e150 <std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, float, (glm::qualifier)0> >(synreal::Span<glm::vec<4, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10abe9:	49 8b b7 38 05 00 00 	mov    0x538(%r15),%rsi
  10abf0:	49 8b 97 40 05 00 00 	mov    0x540(%r15),%rdx
  10abf7:	4c 89 f1             	mov    %r14,%rcx
  10abfa:	48 8d bc 24 00 07 00 	lea    0x700(%rsp),%rdi
  10ac01:	00 
  10ac02:	4c 8d 05 37 d3 0d 00 	lea    0xdd337(%rip),%r8        # 1e7f40 <_fini+0x27fc>
  10ac09:	e8 42 35 f6 ff       	call   6e150 <std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, float, (glm::qualifier)0> >(synreal::Span<glm::vec<4, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10ac0e:	49 8b b7 48 05 00 00 	mov    0x548(%r15),%rsi
  10ac15:	49 8b 97 50 05 00 00 	mov    0x550(%r15),%rdx
  10ac1c:	4c 89 f1             	mov    %r14,%rcx
  10ac1f:	48 8d bc 24 20 07 00 	lea    0x720(%rsp),%rdi
  10ac26:	00 
  10ac27:	4c 8d 05 92 d3 0d 00 	lea    0xdd392(%rip),%r8        # 1e7fc0 <_fini+0x287c>
  10ac2e:	e8 8d 30 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10ac33:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  10ac3a:	00 
  10ac3b:	49 8b b7 58 05 00 00 	mov    0x558(%r15),%rsi
  10ac42:	4c 89 f1             	mov    %r14,%rcx
  10ac45:	49 8b 97 60 05 00 00 	mov    0x560(%r15),%rdx
  10ac4c:	4c 8d 05 dd d3 0d 00 	lea    0xdd3dd(%rip),%r8        # 1e8030 <_fini+0x28ec>
  10ac53:	4c 89 ef             	mov    %r13,%rdi
  10ac56:	e8 65 30 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10ac5b:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  10ac62:	00 
  10ac63:	41 8b 8f 98 03 00 00 	mov    0x398(%r15),%ecx
  10ac6a:	49 8b b7 d0 03 00 00 	mov    0x3d0(%r15),%rsi
  10ac71:	4c 8d 05 55 03 0e 00 	lea    0xe0355(%rip),%r8        # 1eafcd <_fini+0x5889>
  10ac78:	49 8b 97 d8 03 00 00 	mov    0x3d8(%r15),%rdx
  10ac7f:	4c 89 f7             	mov    %r14,%rdi
  10ac82:	e8 69 49 f6 ff       	call   6f5f0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10ac87:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
  10ac8e:	00 00 
  10ac90:	45 31 f6             	xor    %r14d,%r14d
  10ac93:	48 8b 84 24 80 06 00 	mov    0x680(%rsp),%rax
  10ac9a:	00 
  10ac9b:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  10aca0:	48 8d 14 c8          	lea    (%rax,%rcx,8),%rdx
  10aca4:	48 63 02             	movslq (%rdx),%rax
  10aca7:	44 8b 6a 04          	mov    0x4(%rdx),%r13d
  10acab:	83 f8 ff             	cmp    $0xffffffff,%eax
  10acae:	0f 8c 89 dc f6 ff    	jl     7893d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x149b>
  10acb4:	41 83 fd ff          	cmp    $0xffffffff,%r13d
  10acb8:	0f 8c 7f dc f6 ff    	jl     7893d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x149b>
  10acbe:	83 f8 ff             	cmp    $0xffffffff,%eax
  10acc1:	0f 84 c7 08 00 00    	je     10b58e <synreal::SolverNewton::precompute_matrices()+0x721e>
  10acc7:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
  10accc:	48 63 c8             	movslq %eax,%rcx
  10accf:	8b 97 98 03 00 00    	mov    0x398(%rdi),%edx
  10acd5:	48 39 d1             	cmp    %rdx,%rcx
  10acd8:	0f 83 fa 1d 00 00    	jae    10cad8 <synreal::SolverNewton::precompute_matrices()+0x8768>
  10acde:	41 83 fd ff          	cmp    $0xffffffff,%r13d
  10ace2:	74 0c                	je     10acf0 <synreal::SolverNewton::precompute_matrices()+0x6980>
  10ace4:	49 63 cd             	movslq %r13d,%rcx
  10ace7:	48 39 d1             	cmp    %rdx,%rcx
  10acea:	0f 83 4d dc f6 ff    	jae    7893d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x149b>
  10acf0:	48 8b 8c 24 a0 06 00 	mov    0x6a0(%rsp),%rcx
  10acf7:	00 
  10acf8:	4b 8d 14 76          	lea    (%r14,%r14,2),%rdx
  10acfc:	f3 0f 10 05 88 4a 0e 	movss  0xe4a88(%rip),%xmm0        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  10ad03:	00 
  10ad04:	48 01 d1             	add    %rdx,%rcx
  10ad07:	f3 0f 10 19          	movss  (%rcx),%xmm3
  10ad0b:	0f 54 1d 8e 4a 0e 00 	andps  0xe4a8e(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10ad12:	f3 0f 10 51 04       	movss  0x4(%rcx),%xmm2
  10ad17:	f3 0f 10 49 08       	movss  0x8(%rcx),%xmm1
  10ad1c:	0f 2e c3             	ucomiss %xmm3,%xmm0
  10ad1f:	0f 82 d4 db f6 ff    	jb     788f9 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1457>
  10ad25:	0f 54 15 74 4a 0e 00 	andps  0xe4a74(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10ad2c:	0f 2e c2             	ucomiss %xmm2,%xmm0
  10ad2f:	0f 82 c4 db f6 ff    	jb     788f9 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1457>
  10ad35:	0f 54 0d 64 4a 0e 00 	andps  0xe4a64(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10ad3c:	0f 2e c1             	ucomiss %xmm1,%xmm0
  10ad3f:	0f 82 b4 db f6 ff    	jb     788f9 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1457>
  10ad45:	48 03 94 24 c0 06 00 	add    0x6c0(%rsp),%rdx
  10ad4c:	00 
  10ad4d:	f3 0f 10 1a          	movss  (%rdx),%xmm3
  10ad51:	0f 54 1d 48 4a 0e 00 	andps  0xe4a48(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10ad58:	f3 0f 10 52 04       	movss  0x4(%rdx),%xmm2
  10ad5d:	f3 0f 10 4a 08       	movss  0x8(%rdx),%xmm1
  10ad62:	0f 2e c3             	ucomiss %xmm3,%xmm0
  10ad65:	0f 82 8e db f6 ff    	jb     788f9 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1457>
  10ad6b:	0f 54 15 2e 4a 0e 00 	andps  0xe4a2e(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10ad72:	0f 2e c2             	ucomiss %xmm2,%xmm0
  10ad75:	0f 82 7e db f6 ff    	jb     788f9 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1457>
  10ad7b:	0f 54 0d 1e 4a 0e 00 	andps  0xe4a1e(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10ad82:	0f 2e c1             	ucomiss %xmm1,%xmm0
  10ad85:	0f 82 6e db f6 ff    	jb     788f9 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1457>
  10ad8b:	48 8b 94 24 20 07 00 	mov    0x720(%rsp),%rdx
  10ad92:	00 
  10ad93:	66 0f ef d2          	pxor   %xmm2,%xmm2
  10ad97:	f3 42 0f 10 0c 32    	movss  (%rdx,%r14,1),%xmm1
  10ad9d:	0f 2f ca             	comiss %xmm2,%xmm1
  10ada0:	0f 86 2d 1d 00 00    	jbe    10cad3 <synreal::SolverNewton::precompute_matrices()+0x8763>
  10ada6:	0f 54 0d f3 49 0e 00 	andps  0xe49f3(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10adad:	0f 2e c1             	ucomiss %xmm1,%xmm0
  10adb0:	0f 82 11 db f6 ff    	jb     788c7 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1425>
  10adb6:	48 8b 94 24 40 07 00 	mov    0x740(%rsp),%rdx
  10adbd:	00 
  10adbe:	f3 42 0f 10 0c 32    	movss  (%rdx,%r14,1),%xmm1
  10adc4:	0f 28 d9             	movaps %xmm1,%xmm3
  10adc7:	0f 54 1d d2 49 0e 00 	andps  0xe49d2(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10adce:	0f 2e c3             	ucomiss %xmm3,%xmm0
  10add1:	0f 82 f7 1c 00 00    	jb     10cace <synreal::SolverNewton::precompute_matrices()+0x875e>
  10add7:	0f 2f d1             	comiss %xmm1,%xmm2
  10adda:	0f 87 8a d0 f6 ff    	ja     77e6a <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x9c8>
  10ade0:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
  10ade5:	48 8b 8c 24 e0 06 00 	mov    0x6e0(%rsp),%rcx
  10adec:	00 
  10aded:	48 c1 e2 04          	shl    $0x4,%rdx
  10adf1:	0f 10 14 11          	movups (%rcx,%rdx,1),%xmm2
  10adf5:	f3 0f 10 6c 11 0c    	movss  0xc(%rcx,%rdx,1),%xmm5
  10adfb:	f3 0f 10 74 11 08    	movss  0x8(%rcx,%rdx,1),%xmm6
  10ae01:	f3 0f 10 7c 11 04    	movss  0x4(%rcx,%rdx,1),%xmm7
  10ae07:	0f 28 da             	movaps %xmm2,%xmm3
  10ae0a:	0f 54 1d 8f 49 0e 00 	andps  0xe498f(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10ae11:	48 8b 8c 24 00 07 00 	mov    0x700(%rsp),%rcx
  10ae18:	00 
  10ae19:	f3 0f 11 6c 24 18    	movss  %xmm5,0x18(%rsp)
  10ae1f:	f3 0f 11 74 24 38    	movss  %xmm6,0x38(%rsp)
  10ae25:	0f 2e c3             	ucomiss %xmm3,%xmm0
  10ae28:	f3 0f 10 6c 11 0c    	movss  0xc(%rcx,%rdx,1),%xmm5
  10ae2e:	0f 10 0c 11          	movups (%rcx,%rdx,1),%xmm1
  10ae32:	f3 0f 11 7c 24 48    	movss  %xmm7,0x48(%rsp)
  10ae38:	f3 0f 10 74 11 08    	movss  0x8(%rcx,%rdx,1),%xmm6
  10ae3e:	f3 0f 10 7c 11 04    	movss  0x4(%rcx,%rdx,1),%xmm7
  10ae44:	f3 0f 11 94 24 a8 00 	movss  %xmm2,0xa8(%rsp)
  10ae4b:	00 00 
  10ae4d:	f3 0f 11 6c 24 58    	movss  %xmm5,0x58(%rsp)
  10ae53:	f3 0f 11 74 24 60    	movss  %xmm6,0x60(%rsp)
  10ae59:	f3 0f 11 7c 24 78    	movss  %xmm7,0x78(%rsp)
  10ae5f:	f3 0f 11 8c 24 b8 00 	movss  %xmm1,0xb8(%rsp)
  10ae66:	00 00 
  10ae68:	0f 82 66 18 00 00    	jb     10c6d4 <synreal::SolverNewton::precompute_matrices()+0x8364>
  10ae6e:	f3 0f 10 5c 24 48    	movss  0x48(%rsp),%xmm3
  10ae74:	0f 54 1d 25 49 0e 00 	andps  0xe4925(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10ae7b:	0f 2e c3             	ucomiss %xmm3,%xmm0
  10ae7e:	0f 82 b3 ce f6 ff    	jb     77d37 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x895>
  10ae84:	f3 0f 10 5c 24 38    	movss  0x38(%rsp),%xmm3
  10ae8a:	0f 54 1d 0f 49 0e 00 	andps  0xe490f(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10ae91:	0f 2e c3             	ucomiss %xmm3,%xmm0
  10ae94:	0f 82 9d ce f6 ff    	jb     77d37 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x895>
  10ae9a:	f3 0f 10 5c 24 18    	movss  0x18(%rsp),%xmm3
  10aea0:	0f 54 1d f9 48 0e 00 	andps  0xe48f9(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10aea7:	0f 2e c3             	ucomiss %xmm3,%xmm0
  10aeaa:	0f 82 87 ce f6 ff    	jb     77d37 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x895>
  10aeb0:	0f 28 d9             	movaps %xmm1,%xmm3
  10aeb3:	0f 54 1d e6 48 0e 00 	andps  0xe48e6(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10aeba:	0f 2e c3             	ucomiss %xmm3,%xmm0
  10aebd:	0f 82 74 ce f6 ff    	jb     77d37 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x895>
  10aec3:	0f 28 df             	movaps %xmm7,%xmm3
  10aec6:	0f 54 1d d3 48 0e 00 	andps  0xe48d3(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10aecd:	0f 2e c3             	ucomiss %xmm3,%xmm0
  10aed0:	0f 82 61 ce f6 ff    	jb     77d37 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x895>
  10aed6:	0f 28 de             	movaps %xmm6,%xmm3
  10aed9:	0f 54 1d c0 48 0e 00 	andps  0xe48c0(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10aee0:	0f 2e c3             	ucomiss %xmm3,%xmm0
  10aee3:	0f 82 4e ce f6 ff    	jb     77d37 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x895>
  10aee9:	0f 28 dd             	movaps %xmm5,%xmm3
  10aeec:	0f 54 1d ad 48 0e 00 	andps  0xe48ad(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10aef3:	0f 2e c3             	ucomiss %xmm3,%xmm0
  10aef6:	0f 82 3b ce f6 ff    	jb     77d37 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x895>
  10aefc:	48 8b bc 24 18 01 00 	mov    0x118(%rsp),%rdi
  10af03:	00 
  10af04:	48 8b 8c 24 e8 00 00 	mov    0xe8(%rsp),%rcx
  10af0b:	00 
  10af0c:	4c 8d bc 24 88 07 00 	lea    0x788(%rsp),%r15
  10af13:	00 
  10af14:	c7 84 24 88 07 00 00 	movl   $0x0,0x788(%rsp)
  10af1b:	00 00 00 00 
  10af1f:	48 c7 84 24 90 07 00 	movq   $0x0,0x790(%rsp)
  10af26:	00 00 00 00 00 
  10af2b:	4c 89 bc 24 98 07 00 	mov    %r15,0x798(%rsp)
  10af32:	00 
  10af33:	4c 89 bc 24 a0 07 00 	mov    %r15,0x7a0(%rsp)
  10af3a:	00 
  10af3b:	48 c7 84 24 a8 07 00 	movq   $0x0,0x7a8(%rsp)
  10af42:	00 00 00 00 00 
  10af47:	42 0f 11 14 b7       	movups %xmm2,(%rdi,%r14,4)
  10af4c:	42 0f 11 0c b1       	movups %xmm1,(%rcx,%r14,4)
  10af51:	83 f8 ff             	cmp    $0xffffffff,%eax
  10af54:	0f 85 7e 04 00 00    	jne    10b3d8 <synreal::SolverNewton::precompute_matrices()+0x7068>
  10af5a:	4c 8d 25 f9 c6 0e 00 	lea    0xec6f9(%rip),%r12        # 1f765a <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x775a>
  10af61:	31 ff                	xor    %edi,%edi
  10af63:	41 83 fd ff          	cmp    $0xffffffff,%r13d
  10af67:	0f 84 0f 03 00 00    	je     10b27c <synreal::SolverNewton::precompute_matrices()+0x6f0c>
  10af6d:	49 63 c5             	movslq %r13d,%rax
  10af70:	31 ed                	xor    %ebp,%ebp
  10af72:	48 c1 e0 04          	shl    $0x4,%rax
  10af76:	48 03 84 24 60 07 00 	add    0x760(%rsp),%rax
  10af7d:	00 
  10af7e:	f3 0f 6f 38          	movdqu (%rax),%xmm7
  10af82:	0f 29 bc 24 60 06 00 	movaps %xmm7,0x660(%rsp)
  10af89:	00 
  10af8a:	83 fd 02             	cmp    $0x2,%ebp
  10af8d:	0f 84 39 04 00 00    	je     10b3cc <synreal::SolverNewton::precompute_matrices()+0x705c>
  10af93:	83 fd 03             	cmp    $0x3,%ebp
  10af96:	0f 84 e6 05 00 00    	je     10b582 <synreal::SolverNewton::precompute_matrices()+0x7212>
  10af9c:	83 fd 01             	cmp    $0x1,%ebp
  10af9f:	0f 84 d1 05 00 00    	je     10b576 <synreal::SolverNewton::precompute_matrices()+0x7206>
  10afa5:	8b bc 24 60 06 00 00 	mov    0x660(%rsp),%edi
  10afac:	4c 89 e2             	mov    %r12,%rdx
  10afaf:	48 89 de             	mov    %rbx,%rsi
  10afb2:	e8 e9 02 f6 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10afb7:	83 fd 02             	cmp    $0x2,%ebp
  10afba:	0f 84 a4 05 00 00    	je     10b564 <synreal::SolverNewton::precompute_matrices()+0x71f4>
  10afc0:	83 fd 03             	cmp    $0x3,%ebp
  10afc3:	0f 84 f1 03 00 00    	je     10b3ba <synreal::SolverNewton::precompute_matrices()+0x704a>
  10afc9:	83 fd 01             	cmp    $0x1,%ebp
  10afcc:	0f 84 d6 03 00 00    	je     10b3a8 <synreal::SolverNewton::precompute_matrices()+0x7038>
  10afd2:	44 8b ac 24 b8 00 00 	mov    0xb8(%rsp),%r13d
  10afd9:	00 
  10afda:	4c 8d 84 24 60 06 00 	lea    0x660(%rsp),%r8
  10afe1:	00 
  10afe2:	48 8b 84 24 90 07 00 	mov    0x790(%rsp),%rax
  10afe9:	00 
  10afea:	48 85 c0             	test   %rax,%rax
  10afed:	0f 84 bd 05 00 00    	je     10b5b0 <synreal::SolverNewton::precompute_matrices()+0x7240>
  10aff3:	41 8b 38             	mov    (%r8),%edi
  10aff6:	4c 89 fe             	mov    %r15,%rsi
  10aff9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10b000:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10b004:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10b008:	3b 78 20             	cmp    0x20(%rax),%edi
  10b00b:	7f 18                	jg     10b025 <synreal::SolverNewton::precompute_matrices()+0x6cb5>
  10b00d:	48 89 c6             	mov    %rax,%rsi
  10b010:	48 85 d2             	test   %rdx,%rdx
  10b013:	74 1a                	je     10b02f <synreal::SolverNewton::precompute_matrices()+0x6cbf>
  10b015:	48 89 d0             	mov    %rdx,%rax
  10b018:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10b01c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10b020:	3b 78 20             	cmp    0x20(%rax),%edi
  10b023:	7e e8                	jle    10b00d <synreal::SolverNewton::precompute_matrices()+0x6c9d>
  10b025:	48 85 c9             	test   %rcx,%rcx
  10b028:	74 05                	je     10b02f <synreal::SolverNewton::precompute_matrices()+0x6cbf>
  10b02a:	48 89 c8             	mov    %rcx,%rax
  10b02d:	eb d1                	jmp    10b000 <synreal::SolverNewton::precompute_matrices()+0x6c90>
  10b02f:	4c 39 fe             	cmp    %r15,%rsi
  10b032:	74 05                	je     10b039 <synreal::SolverNewton::precompute_matrices()+0x6cc9>
  10b034:	3b 7e 20             	cmp    0x20(%rsi),%edi
  10b037:	7d 20                	jge    10b059 <synreal::SolverNewton::precompute_matrices()+0x6ce9>
  10b039:	48 8d 94 24 a8 03 00 	lea    0x3a8(%rsp),%rdx
  10b040:	00 
  10b041:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  10b048:	00 
  10b049:	4c 89 84 24 a8 03 00 	mov    %r8,0x3a8(%rsp)
  10b050:	00 
  10b051:	e8 2a 5a fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10b056:	48 89 c6             	mov    %rax,%rsi
  10b059:	66 41 0f 6e c5       	movd   %r13d,%xmm0
  10b05e:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  10b063:	83 c5 01             	add    $0x1,%ebp
  10b066:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  10b06b:	83 fd 04             	cmp    $0x4,%ebp
  10b06e:	0f 85 16 ff ff ff    	jne    10af8a <synreal::SolverNewton::precompute_matrices()+0x6c1a>
  10b074:	4c 8b a4 24 98 07 00 	mov    0x798(%rsp),%r12
  10b07b:	00 
  10b07c:	4d 39 fc             	cmp    %r15,%r12
  10b07f:	0f 84 ef 01 00 00    	je     10b274 <synreal::SolverNewton::precompute_matrices()+0x6f04>
  10b085:	4c 8d ac 24 b0 03 00 	lea    0x3b0(%rsp),%r13
  10b08c:	00 
  10b08d:	0f 1f 00             	nopl   (%rax)
  10b090:	48 8b 8c 24 20 07 00 	mov    0x720(%rsp),%rcx
  10b097:	00 
  10b098:	f3 41 0f 10 4c 24 24 	movss  0x24(%r12),%xmm1
  10b09f:	4c 89 e7             	mov    %r12,%rdi
  10b0a2:	49 63 54 24 20       	movslq 0x20(%r12),%rdx
  10b0a7:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  10b0ac:	f3 42 0f 10 04 31    	movss  (%rcx,%r14,1),%xmm0
  10b0b2:	48 89 0c 24          	mov    %rcx,(%rsp)
  10b0b6:	48 8d 04 90          	lea    (%rax,%rdx,4),%rax
  10b0ba:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
  10b0bf:	f3 0f 59 c1          	mulss  %xmm1,%xmm0
  10b0c3:	f3 0f 59 c1          	mulss  %xmm1,%xmm0
  10b0c7:	f3 0f 58 00          	addss  (%rax),%xmm0
  10b0cb:	f3 0f 11 00          	movss  %xmm0,(%rax)
  10b0cf:	e8 9c 15 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  10b0d4:	48 8b 0c 24          	mov    (%rsp),%rcx
  10b0d8:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
  10b0dd:	4c 39 f8             	cmp    %r15,%rax
  10b0e0:	48 89 c5             	mov    %rax,%rbp
  10b0e3:	0f 84 77 01 00 00    	je     10b260 <synreal::SolverNewton::precompute_matrices()+0x6ef0>
  10b0e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10b0f0:	f3 42 0f 10 04 31    	movss  (%rcx,%r14,1),%xmm0
  10b0f6:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  10b0fb:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
  10b0ff:	f3 41 0f 59 44 24 24 	mulss  0x24(%r12),%xmm0
  10b106:	48 c1 e0 04          	shl    $0x4,%rax
  10b10a:	f3 0f 59 45 24       	mulss  0x24(%rbp),%xmm0
  10b10f:	4c 8d 0c 06          	lea    (%rsi,%rax,1),%r9
  10b113:	49 8b 41 10          	mov    0x10(%r9),%rax
  10b117:	49 8d 79 08          	lea    0x8(%r9),%rdi
  10b11b:	f3 0f 11 04 24       	movss  %xmm0,(%rsp)
  10b120:	48 85 c0             	test   %rax,%rax
  10b123:	0f 84 77 02 00 00    	je     10b3a0 <synreal::SolverNewton::precompute_matrices()+0x7030>
  10b129:	48 63 75 20          	movslq 0x20(%rbp),%rsi
  10b12d:	49 89 f8             	mov    %rdi,%r8
  10b130:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10b134:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10b138:	3b 70 20             	cmp    0x20(%rax),%esi
  10b13b:	7f 18                	jg     10b155 <synreal::SolverNewton::precompute_matrices()+0x6de5>
  10b13d:	49 89 c0             	mov    %rax,%r8
  10b140:	48 85 d2             	test   %rdx,%rdx
  10b143:	74 1b                	je     10b160 <synreal::SolverNewton::precompute_matrices()+0x6df0>
  10b145:	48 89 d0             	mov    %rdx,%rax
  10b148:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10b14c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10b150:	3b 70 20             	cmp    0x20(%rax),%esi
  10b153:	7e e8                	jle    10b13d <synreal::SolverNewton::precompute_matrices()+0x6dcd>
  10b155:	48 85 c9             	test   %rcx,%rcx
  10b158:	74 06                	je     10b160 <synreal::SolverNewton::precompute_matrices()+0x6df0>
  10b15a:	48 89 c8             	mov    %rcx,%rax
  10b15d:	eb d1                	jmp    10b130 <synreal::SolverNewton::precompute_matrices()+0x6dc0>
  10b15f:	90                   	nop
  10b160:	49 39 f8             	cmp    %rdi,%r8
  10b163:	74 06                	je     10b16b <synreal::SolverNewton::precompute_matrices()+0x6dfb>
  10b165:	41 3b 70 20          	cmp    0x20(%r8),%esi
  10b169:	7d 21                	jge    10b18c <synreal::SolverNewton::precompute_matrices()+0x6e1c>
  10b16b:	48 8d 45 20          	lea    0x20(%rbp),%rax
  10b16f:	4c 89 ea             	mov    %r13,%rdx
  10b172:	4c 89 c6             	mov    %r8,%rsi
  10b175:	4c 89 cf             	mov    %r9,%rdi
  10b178:	48 89 84 24 b0 03 00 	mov    %rax,0x3b0(%rsp)
  10b17f:	00 
  10b180:	e8 fb 58 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10b185:	48 63 75 20          	movslq 0x20(%rbp),%rsi
  10b189:	49 89 c0             	mov    %rax,%r8
  10b18c:	48 8d 04 76          	lea    (%rsi,%rsi,2),%rax
  10b190:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  10b195:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  10b19a:	48 c1 e0 04          	shl    $0x4,%rax
  10b19e:	f3 41 0f 58 40 24    	addss  0x24(%r8),%xmm0
  10b1a4:	4c 8d 0c 06          	lea    (%rsi,%rax,1),%r9
  10b1a8:	49 8b 41 10          	mov    0x10(%r9),%rax
  10b1ac:	f3 41 0f 11 40 24    	movss  %xmm0,0x24(%r8)
  10b1b2:	4d 8d 41 08          	lea    0x8(%r9),%r8
  10b1b6:	48 85 c0             	test   %rax,%rax
  10b1b9:	0f 84 d1 01 00 00    	je     10b390 <synreal::SolverNewton::precompute_matrices()+0x7020>
  10b1bf:	41 8b 7c 24 20       	mov    0x20(%r12),%edi
  10b1c4:	4c 89 c6             	mov    %r8,%rsi
  10b1c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10b1ce:	00 00 
  10b1d0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10b1d4:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10b1d8:	39 78 20             	cmp    %edi,0x20(%rax)
  10b1db:	7c 18                	jl     10b1f5 <synreal::SolverNewton::precompute_matrices()+0x6e85>
  10b1dd:	48 89 c6             	mov    %rax,%rsi
  10b1e0:	48 85 d2             	test   %rdx,%rdx
  10b1e3:	74 1b                	je     10b200 <synreal::SolverNewton::precompute_matrices()+0x6e90>
  10b1e5:	48 89 d0             	mov    %rdx,%rax
  10b1e8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10b1ec:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10b1f0:	39 78 20             	cmp    %edi,0x20(%rax)
  10b1f3:	7d e8                	jge    10b1dd <synreal::SolverNewton::precompute_matrices()+0x6e6d>
  10b1f5:	48 85 c9             	test   %rcx,%rcx
  10b1f8:	74 06                	je     10b200 <synreal::SolverNewton::precompute_matrices()+0x6e90>
  10b1fa:	48 89 c8             	mov    %rcx,%rax
  10b1fd:	eb d1                	jmp    10b1d0 <synreal::SolverNewton::precompute_matrices()+0x6e60>
  10b1ff:	90                   	nop
  10b200:	49 39 f0             	cmp    %rsi,%r8
  10b203:	74 05                	je     10b20a <synreal::SolverNewton::precompute_matrices()+0x6e9a>
  10b205:	3b 7e 20             	cmp    0x20(%rsi),%edi
  10b208:	7d 20                	jge    10b22a <synreal::SolverNewton::precompute_matrices()+0x6eba>
  10b20a:	49 8d 44 24 20       	lea    0x20(%r12),%rax
  10b20f:	48 8d 94 24 b8 03 00 	lea    0x3b8(%rsp),%rdx
  10b216:	00 
  10b217:	4c 89 cf             	mov    %r9,%rdi
  10b21a:	48 89 84 24 b8 03 00 	mov    %rax,0x3b8(%rsp)
  10b221:	00 
  10b222:	e8 59 58 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10b227:	48 89 c6             	mov    %rax,%rsi
  10b22a:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
  10b22f:	f3 0f 58 46 24       	addss  0x24(%rsi),%xmm0
  10b234:	48 89 ef             	mov    %rbp,%rdi
  10b237:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  10b23c:	e8 2f 14 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  10b241:	48 89 c5             	mov    %rax,%rbp
  10b244:	4c 39 f8             	cmp    %r15,%rax
  10b247:	74 17                	je     10b260 <synreal::SolverNewton::precompute_matrices()+0x6ef0>
  10b249:	48 8b 8c 24 20 07 00 	mov    0x720(%rsp),%rcx
  10b250:	00 
  10b251:	49 63 54 24 20       	movslq 0x20(%r12),%rdx
  10b256:	e9 95 fe ff ff       	jmp    10b0f0 <synreal::SolverNewton::precompute_matrices()+0x6d80>
  10b25b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10b260:	4c 89 e7             	mov    %r12,%rdi
  10b263:	e8 08 14 f6 ff       	call   6c670 <std::_Rb_tree_increment(std::_Rb_tree_node_base*)@plt>
  10b268:	49 89 c4             	mov    %rax,%r12
  10b26b:	4c 39 f8             	cmp    %r15,%rax
  10b26e:	0f 85 1c fe ff ff    	jne    10b090 <synreal::SolverNewton::precompute_matrices()+0x6d20>
  10b274:	48 8b bc 24 90 07 00 	mov    0x790(%rsp),%rdi
  10b27b:	00 
  10b27c:	e8 6f 53 fe ff       	call   f05f0 <std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, float> >*) [clone .isra.0]>
  10b281:	49 83 c6 04          	add    $0x4,%r14
  10b285:	48 83 44 24 20 01    	addq   $0x1,0x20(%rsp)
  10b28b:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  10b290:	48 39 84 24 a0 00 00 	cmp    %rax,0xa0(%rsp)
  10b297:	00 
  10b298:	0f 85 f5 f9 ff ff    	jne    10ac93 <synreal::SolverNewton::precompute_matrices()+0x6923>
  10b29e:	48 8b bc 24 60 07 00 	mov    0x760(%rsp),%rdi
  10b2a5:	00 
  10b2a6:	48 85 ff             	test   %rdi,%rdi
  10b2a9:	74 10                	je     10b2bb <synreal::SolverNewton::precompute_matrices()+0x6f4b>
  10b2ab:	48 8b b4 24 70 07 00 	mov    0x770(%rsp),%rsi
  10b2b2:	00 
  10b2b3:	48 29 fe             	sub    %rdi,%rsi
  10b2b6:	e8 f5 1e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b2bb:	48 8b bc 24 40 07 00 	mov    0x740(%rsp),%rdi
  10b2c2:	00 
  10b2c3:	48 85 ff             	test   %rdi,%rdi
  10b2c6:	74 10                	je     10b2d8 <synreal::SolverNewton::precompute_matrices()+0x6f68>
  10b2c8:	48 8b b4 24 50 07 00 	mov    0x750(%rsp),%rsi
  10b2cf:	00 
  10b2d0:	48 29 fe             	sub    %rdi,%rsi
  10b2d3:	e8 d8 1e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b2d8:	48 8b bc 24 20 07 00 	mov    0x720(%rsp),%rdi
  10b2df:	00 
  10b2e0:	48 85 ff             	test   %rdi,%rdi
  10b2e3:	74 10                	je     10b2f5 <synreal::SolverNewton::precompute_matrices()+0x6f85>
  10b2e5:	48 8b b4 24 30 07 00 	mov    0x730(%rsp),%rsi
  10b2ec:	00 
  10b2ed:	48 29 fe             	sub    %rdi,%rsi
  10b2f0:	e8 bb 1e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b2f5:	48 8b bc 24 00 07 00 	mov    0x700(%rsp),%rdi
  10b2fc:	00 
  10b2fd:	48 85 ff             	test   %rdi,%rdi
  10b300:	74 10                	je     10b312 <synreal::SolverNewton::precompute_matrices()+0x6fa2>
  10b302:	48 8b b4 24 10 07 00 	mov    0x710(%rsp),%rsi
  10b309:	00 
  10b30a:	48 29 fe             	sub    %rdi,%rsi
  10b30d:	e8 9e 1e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b312:	48 8b bc 24 e0 06 00 	mov    0x6e0(%rsp),%rdi
  10b319:	00 
  10b31a:	48 85 ff             	test   %rdi,%rdi
  10b31d:	74 10                	je     10b32f <synreal::SolverNewton::precompute_matrices()+0x6fbf>
  10b31f:	48 8b b4 24 f0 06 00 	mov    0x6f0(%rsp),%rsi
  10b326:	00 
  10b327:	48 29 fe             	sub    %rdi,%rsi
  10b32a:	e8 81 1e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b32f:	48 8b bc 24 c0 06 00 	mov    0x6c0(%rsp),%rdi
  10b336:	00 
  10b337:	48 85 ff             	test   %rdi,%rdi
  10b33a:	74 10                	je     10b34c <synreal::SolverNewton::precompute_matrices()+0x6fdc>
  10b33c:	48 8b b4 24 d0 06 00 	mov    0x6d0(%rsp),%rsi
  10b343:	00 
  10b344:	48 29 fe             	sub    %rdi,%rsi
  10b347:	e8 64 1e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b34c:	48 8b bc 24 a0 06 00 	mov    0x6a0(%rsp),%rdi
  10b353:	00 
  10b354:	48 85 ff             	test   %rdi,%rdi
  10b357:	74 10                	je     10b369 <synreal::SolverNewton::precompute_matrices()+0x6ff9>
  10b359:	48 8b b4 24 b0 06 00 	mov    0x6b0(%rsp),%rsi
  10b360:	00 
  10b361:	48 29 fe             	sub    %rdi,%rsi
  10b364:	e8 47 1e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b369:	48 8b bc 24 80 06 00 	mov    0x680(%rsp),%rdi
  10b370:	00 
  10b371:	48 85 ff             	test   %rdi,%rdi
  10b374:	0f 84 29 a3 ff ff    	je     1056a3 <synreal::SolverNewton::precompute_matrices()+0x1333>
  10b37a:	48 8b b4 24 90 06 00 	mov    0x690(%rsp),%rsi
  10b381:	00 
  10b382:	48 29 fe             	sub    %rdi,%rsi
  10b385:	e8 26 1e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b38a:	e9 14 a3 ff ff       	jmp    1056a3 <synreal::SolverNewton::precompute_matrices()+0x1333>
  10b38f:	90                   	nop
  10b390:	4c 89 c6             	mov    %r8,%rsi
  10b393:	e9 72 fe ff ff       	jmp    10b20a <synreal::SolverNewton::precompute_matrices()+0x6e9a>
  10b398:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10b39f:	00 
  10b3a0:	49 89 f8             	mov    %rdi,%r8
  10b3a3:	e9 c3 fd ff ff       	jmp    10b16b <synreal::SolverNewton::precompute_matrices()+0x6dfb>
  10b3a8:	44 8b 6c 24 78       	mov    0x78(%rsp),%r13d
  10b3ad:	4c 8d 84 24 64 06 00 	lea    0x664(%rsp),%r8
  10b3b4:	00 
  10b3b5:	e9 28 fc ff ff       	jmp    10afe2 <synreal::SolverNewton::precompute_matrices()+0x6c72>
  10b3ba:	44 8b 6c 24 58       	mov    0x58(%rsp),%r13d
  10b3bf:	4c 8d 84 24 6c 06 00 	lea    0x66c(%rsp),%r8
  10b3c6:	00 
  10b3c7:	e9 16 fc ff ff       	jmp    10afe2 <synreal::SolverNewton::precompute_matrices()+0x6c72>
  10b3cc:	8b bc 24 68 06 00 00 	mov    0x668(%rsp),%edi
  10b3d3:	e9 d4 fb ff ff       	jmp    10afac <synreal::SolverNewton::precompute_matrices()+0x6c3c>
  10b3d8:	48 c1 e0 04          	shl    $0x4,%rax
  10b3dc:	48 03 84 24 60 07 00 	add    0x760(%rsp),%rax
  10b3e3:	00 
  10b3e4:	31 ed                	xor    %ebp,%ebp
  10b3e6:	f3 0f 6f 28          	movdqu (%rax),%xmm5
  10b3ea:	4c 8d 25 69 c2 0e 00 	lea    0xec269(%rip),%r12        # 1f765a <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x775a>
  10b3f1:	0f 29 ac 24 60 06 00 	movaps %xmm5,0x660(%rsp)
  10b3f8:	00 
  10b3f9:	83 fd 02             	cmp    $0x2,%ebp
  10b3fc:	0f 84 56 01 00 00    	je     10b558 <synreal::SolverNewton::precompute_matrices()+0x71e8>
  10b402:	83 fd 03             	cmp    $0x3,%ebp
  10b405:	0f 84 41 01 00 00    	je     10b54c <synreal::SolverNewton::precompute_matrices()+0x71dc>
  10b40b:	83 fd 01             	cmp    $0x1,%ebp
  10b40e:	0f 84 2c 01 00 00    	je     10b540 <synreal::SolverNewton::precompute_matrices()+0x71d0>
  10b414:	8b bc 24 60 06 00 00 	mov    0x660(%rsp),%edi
  10b41b:	4c 89 e2             	mov    %r12,%rdx
  10b41e:	48 89 de             	mov    %rbx,%rsi
  10b421:	e8 7a fe f5 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10b426:	83 fd 02             	cmp    $0x2,%ebp
  10b429:	0f 84 f9 00 00 00    	je     10b528 <synreal::SolverNewton::precompute_matrices()+0x71b8>
  10b42f:	83 fd 03             	cmp    $0x3,%ebp
  10b432:	0f 84 d8 00 00 00    	je     10b510 <synreal::SolverNewton::precompute_matrices()+0x71a0>
  10b438:	83 fd 01             	cmp    $0x1,%ebp
  10b43b:	0f 84 b7 00 00 00    	je     10b4f8 <synreal::SolverNewton::precompute_matrices()+0x7188>
  10b441:	f3 0f 10 b4 24 a8 00 	movss  0xa8(%rsp),%xmm6
  10b448:	00 00 
  10b44a:	4c 8d 84 24 60 06 00 	lea    0x660(%rsp),%r8
  10b451:	00 
  10b452:	f3 0f 11 34 24       	movss  %xmm6,(%rsp)
  10b457:	48 8b 84 24 90 07 00 	mov    0x790(%rsp),%rax
  10b45e:	00 
  10b45f:	48 85 c0             	test   %rax,%rax
  10b462:	0f 84 40 01 00 00    	je     10b5a8 <synreal::SolverNewton::precompute_matrices()+0x7238>
  10b468:	41 8b 38             	mov    (%r8),%edi
  10b46b:	4c 89 fe             	mov    %r15,%rsi
  10b46e:	66 90                	xchg   %ax,%ax
  10b470:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10b474:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10b478:	3b 78 20             	cmp    0x20(%rax),%edi
  10b47b:	7f 18                	jg     10b495 <synreal::SolverNewton::precompute_matrices()+0x7125>
  10b47d:	48 89 c6             	mov    %rax,%rsi
  10b480:	48 85 d2             	test   %rdx,%rdx
  10b483:	74 1a                	je     10b49f <synreal::SolverNewton::precompute_matrices()+0x712f>
  10b485:	48 89 d0             	mov    %rdx,%rax
  10b488:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10b48c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  10b490:	3b 78 20             	cmp    0x20(%rax),%edi
  10b493:	7e e8                	jle    10b47d <synreal::SolverNewton::precompute_matrices()+0x710d>
  10b495:	48 85 c9             	test   %rcx,%rcx
  10b498:	74 05                	je     10b49f <synreal::SolverNewton::precompute_matrices()+0x712f>
  10b49a:	48 89 c8             	mov    %rcx,%rax
  10b49d:	eb d1                	jmp    10b470 <synreal::SolverNewton::precompute_matrices()+0x7100>
  10b49f:	4c 39 fe             	cmp    %r15,%rsi
  10b4a2:	74 05                	je     10b4a9 <synreal::SolverNewton::precompute_matrices()+0x7139>
  10b4a4:	3b 7e 20             	cmp    0x20(%rsi),%edi
  10b4a7:	7d 20                	jge    10b4c9 <synreal::SolverNewton::precompute_matrices()+0x7159>
  10b4a9:	48 8d 94 24 a0 03 00 	lea    0x3a0(%rsp),%rdx
  10b4b0:	00 
  10b4b1:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  10b4b8:	00 
  10b4b9:	4c 89 84 24 a0 03 00 	mov    %r8,0x3a0(%rsp)
  10b4c0:	00 
  10b4c1:	e8 ba 55 fe ff       	call   f0a80 <std::_Rb_tree_iterator<std::pair<int const, float> > std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<int const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<int const, float> >, std::piecewise_construct_t const&, std::tuple<int const&>&&, std::tuple<>&&) [clone .isra.0]>
  10b4c6:	48 89 c6             	mov    %rax,%rsi
  10b4c9:	f3 0f 10 46 24       	movss  0x24(%rsi),%xmm0
  10b4ce:	f3 0f 5c 04 24       	subss  (%rsp),%xmm0
  10b4d3:	83 c5 01             	add    $0x1,%ebp
  10b4d6:	f3 0f 11 46 24       	movss  %xmm0,0x24(%rsi)
  10b4db:	83 fd 04             	cmp    $0x4,%ebp
  10b4de:	0f 85 15 ff ff ff    	jne    10b3f9 <synreal::SolverNewton::precompute_matrices()+0x7089>
  10b4e4:	41 83 fd ff          	cmp    $0xffffffff,%r13d
  10b4e8:	0f 84 86 fb ff ff    	je     10b074 <synreal::SolverNewton::precompute_matrices()+0x6d04>
  10b4ee:	e9 7a fa ff ff       	jmp    10af6d <synreal::SolverNewton::precompute_matrices()+0x6bfd>
  10b4f3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10b4f8:	f3 0f 10 74 24 48    	movss  0x48(%rsp),%xmm6
  10b4fe:	4c 8d 84 24 64 06 00 	lea    0x664(%rsp),%r8
  10b505:	00 
  10b506:	f3 0f 11 34 24       	movss  %xmm6,(%rsp)
  10b50b:	e9 47 ff ff ff       	jmp    10b457 <synreal::SolverNewton::precompute_matrices()+0x70e7>
  10b510:	f3 0f 10 6c 24 18    	movss  0x18(%rsp),%xmm5
  10b516:	4c 8d 84 24 6c 06 00 	lea    0x66c(%rsp),%r8
  10b51d:	00 
  10b51e:	f3 0f 11 2c 24       	movss  %xmm5,(%rsp)
  10b523:	e9 2f ff ff ff       	jmp    10b457 <synreal::SolverNewton::precompute_matrices()+0x70e7>
  10b528:	f3 0f 10 7c 24 38    	movss  0x38(%rsp),%xmm7
  10b52e:	4c 8d 84 24 68 06 00 	lea    0x668(%rsp),%r8
  10b535:	00 
  10b536:	f3 0f 11 3c 24       	movss  %xmm7,(%rsp)
  10b53b:	e9 17 ff ff ff       	jmp    10b457 <synreal::SolverNewton::precompute_matrices()+0x70e7>
  10b540:	8b bc 24 64 06 00 00 	mov    0x664(%rsp),%edi
  10b547:	e9 cf fe ff ff       	jmp    10b41b <synreal::SolverNewton::precompute_matrices()+0x70ab>
  10b54c:	8b bc 24 6c 06 00 00 	mov    0x66c(%rsp),%edi
  10b553:	e9 c3 fe ff ff       	jmp    10b41b <synreal::SolverNewton::precompute_matrices()+0x70ab>
  10b558:	8b bc 24 68 06 00 00 	mov    0x668(%rsp),%edi
  10b55f:	e9 b7 fe ff ff       	jmp    10b41b <synreal::SolverNewton::precompute_matrices()+0x70ab>
  10b564:	44 8b 6c 24 60       	mov    0x60(%rsp),%r13d
  10b569:	4c 8d 84 24 68 06 00 	lea    0x668(%rsp),%r8
  10b570:	00 
  10b571:	e9 6c fa ff ff       	jmp    10afe2 <synreal::SolverNewton::precompute_matrices()+0x6c72>
  10b576:	8b bc 24 64 06 00 00 	mov    0x664(%rsp),%edi
  10b57d:	e9 2a fa ff ff       	jmp    10afac <synreal::SolverNewton::precompute_matrices()+0x6c3c>
  10b582:	8b bc 24 6c 06 00 00 	mov    0x66c(%rsp),%edi
  10b589:	e9 1e fa ff ff       	jmp    10afac <synreal::SolverNewton::precompute_matrices()+0x6c3c>
  10b58e:	41 83 fd ff          	cmp    $0xffffffff,%r13d
  10b592:	0f 84 8d 15 00 00    	je     10cb25 <synreal::SolverNewton::precompute_matrices()+0x87b5>
  10b598:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
  10b59d:	8b 91 98 03 00 00    	mov    0x398(%rcx),%edx
  10b5a3:	e9 3c f7 ff ff       	jmp    10ace4 <synreal::SolverNewton::precompute_matrices()+0x6974>
  10b5a8:	4c 89 fe             	mov    %r15,%rsi
  10b5ab:	e9 f9 fe ff ff       	jmp    10b4a9 <synreal::SolverNewton::precompute_matrices()+0x7139>
  10b5b0:	4c 89 fe             	mov    %r15,%rsi
  10b5b3:	e9 81 fa ff ff       	jmp    10b039 <synreal::SolverNewton::precompute_matrices()+0x6cc9>
  10b5b8:	41 8b 87 a8 00 00 00 	mov    0xa8(%r15),%eax
  10b5bf:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
  10b5c4:	48 85 c0             	test   %rax,%rax
  10b5c7:	0f 85 c4 b5 ff ff    	jne    106b91 <synreal::SolverNewton::precompute_matrices()+0x2821>
  10b5cd:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  10b5d4:	00 
  10b5d5:	45 31 e4             	xor    %r12d,%r12d
  10b5d8:	48 c7 84 24 90 01 00 	movq   $0x0,0x190(%rsp)
  10b5df:	00 00 00 00 00 
  10b5e4:	48 c7 84 24 98 00 00 	movq   $0x0,0x98(%rsp)
  10b5eb:	00 00 00 00 00 
  10b5f0:	e9 00 b6 ff ff       	jmp    106bf5 <synreal::SolverNewton::precompute_matrices()+0x2885>
  10b5f5:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  10b5fa:	48 8b 96 a0 2d 00 00 	mov    0x2da0(%rsi),%rdx
  10b601:	4c 8d 04 c2          	lea    (%rdx,%rax,8),%r8
  10b605:	48 8d 34 0a          	lea    (%rdx,%rcx,1),%rsi
  10b609:	4c 89 c2             	mov    %r8,%rdx
  10b60c:	e8 ff 1b f6 ff       	call   6d210 <thrust::THRUST_200302_520_NS::detail::vector_base<synreal::NonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::NonZeroEntry> >::erase(thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<synreal::NonZeroEntry> >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<synreal::NonZeroEntry> >)@plt>
  10b611:	e9 53 b7 ff ff       	jmp    106d69 <synreal::SolverNewton::precompute_matrices()+0x29f9>
  10b616:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
  10b61b:	48 8b b1 a0 2d 00 00 	mov    0x2da0(%rcx),%rsi
  10b622:	48 8d 14 c6          	lea    (%rsi,%rax,8),%rdx
  10b626:	e8 e5 1b f6 ff       	call   6d210 <thrust::THRUST_200302_520_NS::detail::vector_base<synreal::NonZeroEntry, thrust::THRUST_200302_520_NS::device_allocator<synreal::NonZeroEntry> >::erase(thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<synreal::NonZeroEntry> >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<synreal::NonZeroEntry> >)@plt>
  10b62b:	e9 39 b7 ff ff       	jmp    106d69 <synreal::SolverNewton::precompute_matrices()+0x29f9>
  10b630:	48 c7 84 24 30 07 00 	movq   $0x0,0x730(%rsp)
  10b637:	00 00 00 00 00 
  10b63c:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10b640:	0f 29 84 24 20 07 00 	movaps %xmm0,0x720(%rsp)
  10b647:	00 
  10b648:	48 85 c9             	test   %rcx,%rcx
  10b64b:	0f 84 99 0d 00 00    	je     10c3ea <synreal::SolverNewton::precompute_matrices()+0x807a>
  10b651:	4c 8d 24 8d 00 00 00 	lea    0x0(,%rcx,4),%r12
  10b658:	00 
  10b659:	4c 89 e7             	mov    %r12,%rdi
  10b65c:	e8 ef 1a f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  10b661:	4a 8d 2c 20          	lea    (%rax,%r12,1),%rbp
  10b665:	48 89 c7             	mov    %rax,%rdi
  10b668:	4c 89 e2             	mov    %r12,%rdx
  10b66b:	31 f6                	xor    %esi,%esi
  10b66d:	48 89 84 24 20 07 00 	mov    %rax,0x720(%rsp)
  10b674:	00 
  10b675:	48 89 ac 24 30 07 00 	mov    %rbp,0x730(%rsp)
  10b67c:	00 
  10b67d:	e8 9e 0a f6 ff       	call   6c120 <memset@plt>
  10b682:	48 89 ac 24 28 07 00 	mov    %rbp,0x728(%rsp)
  10b689:	00 
  10b68a:	41 8b 8e d8 05 00 00 	mov    0x5d8(%r14),%ecx
  10b691:	e9 f6 df ff ff       	jmp    10968c <synreal::SolverNewton::precompute_matrices()+0x531c>
  10b696:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10b69d:	00 00 00 
  10b6a0:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
  10b6a4:	48 8b bc 24 80 00 00 	mov    0x80(%rsp),%rdi
  10b6ab:	00 
  10b6ac:	48 8d 04 87          	lea    (%rdi,%rax,4),%rax
  10b6b0:	f3 0f 10 00          	movss  (%rax),%xmm0
  10b6b4:	f3 0f 58 c6          	addss  %xmm6,%xmm0
  10b6b8:	f3 0f 11 00          	movss  %xmm0,(%rax)
  10b6bc:	e9 0a a5 ff ff       	jmp    105bcb <synreal::SolverNewton::precompute_matrices()+0x185b>
  10b6c1:	49 89 c0             	mov    %rax,%r8
  10b6c4:	e9 73 ba ff ff       	jmp    10713c <synreal::SolverNewton::precompute_matrices()+0x2dcc>
  10b6c9:	48 89 c6             	mov    %rax,%rsi
  10b6cc:	e9 02 a4 ff ff       	jmp    105ad3 <synreal::SolverNewton::precompute_matrices()+0x1763>
  10b6d1:	48 89 c6             	mov    %rax,%rsi
  10b6d4:	e9 b9 a4 ff ff       	jmp    105b92 <synreal::SolverNewton::precompute_matrices()+0x1822>
  10b6d9:	4c 89 c7             	mov    %r8,%rdi
  10b6dc:	be 28 00 00 00       	mov    $0x28,%esi
  10b6e1:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  10b6e8:	00 
  10b6e9:	e8 c2 1a f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b6ee:	48 8b 84 24 a8 07 00 	mov    0x7a8(%rsp),%rax
  10b6f5:	00 
  10b6f6:	4c 8b 84 24 b8 00 00 	mov    0xb8(%rsp),%r8
  10b6fd:	00 
  10b6fe:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  10b703:	e9 ed ba ff ff       	jmp    1071f5 <synreal::SolverNewton::precompute_matrices()+0x2e85>
  10b708:	4d 89 f8             	mov    %r15,%r8
  10b70b:	e9 3b ba ff ff       	jmp    10714b <synreal::SolverNewton::precompute_matrices()+0x2ddb>
  10b710:	48 8b 4c 24 68       	mov    0x68(%rsp),%rcx
  10b715:	b8 01 00 00 00       	mov    $0x1,%eax
  10b71a:	48 85 c9             	test   %rcx,%rcx
  10b71d:	48 0f 44 c8          	cmove  %rax,%rcx
  10b721:	49 89 cf             	mov    %rcx,%r15
  10b724:	48 c7 44 24 78 01 00 	movq   $0x1,0x78(%rsp)
  10b72b:	00 00 
  10b72d:	48 85 db             	test   %rbx,%rbx
  10b730:	74 0e                	je     10b740 <synreal::SolverNewton::precompute_matrices()+0x73d0>
  10b732:	48 8b 04 24          	mov    (%rsp),%rax
  10b736:	31 d2                	xor    %edx,%edx
  10b738:	48 f7 f3             	div    %rbx
  10b73b:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
  10b740:	48 83 3c 24 00       	cmpq   $0x0,(%rsp)
  10b745:	0f 84 80 0d 00 00    	je     10c4cb <synreal::SolverNewton::precompute_matrices()+0x815b>
  10b74b:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
  10b750:	e8 fb 19 f6 ff       	call   6d150 <operator new(unsigned long)@plt>
  10b755:	49 89 c4             	mov    %rax,%r12
  10b758:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10b75d:	48 83 3c 24 01       	cmpq   $0x1,(%rsp)
  10b762:	41 b9 01 00 00 00    	mov    $0x1,%r9d
  10b768:	41 c7 04 24 00 00 00 	movl   $0x0,(%r12)
  10b76f:	00 
  10b770:	49 8d 7c 24 04       	lea    0x4(%r12),%rdi
  10b775:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
  10b779:	48 89 74 24 68       	mov    %rsi,0x68(%rsp)
  10b77e:	74 1c                	je     10b79c <synreal::SolverNewton::precompute_matrices()+0x742c>
  10b780:	48 39 fe             	cmp    %rdi,%rsi
  10b783:	74 17                	je     10b79c <synreal::SolverNewton::precompute_matrices()+0x742c>
  10b785:	48 8d 50 fc          	lea    -0x4(%rax),%rdx
  10b789:	31 f6                	xor    %esi,%esi
  10b78b:	e8 90 09 f6 ff       	call   6c120 <memset@plt>
  10b790:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10b795:	48 c1 f8 02          	sar    $0x2,%rax
  10b799:	49 89 c1             	mov    %rax,%r9
  10b79c:	44 89 fe             	mov    %r15d,%esi
  10b79f:	31 c9                	xor    %ecx,%ecx
  10b7a1:	48 89 c8             	mov    %rcx,%rax
  10b7a4:	31 d2                	xor    %edx,%edx
  10b7a6:	48 f7 f3             	div    %rbx
  10b7a9:	0f af c6             	imul   %esi,%eax
  10b7ac:	03 44 95 00          	add    0x0(%rbp,%rdx,4),%eax
  10b7b0:	41 89 04 8c          	mov    %eax,(%r12,%rcx,4)
  10b7b4:	48 83 c1 01          	add    $0x1,%rcx
  10b7b8:	48 3b 0c 24          	cmp    (%rsp),%rcx
  10b7bc:	75 e3                	jne    10b7a1 <synreal::SolverNewton::precompute_matrices()+0x7431>
  10b7be:	4c 8b 44 24 78       	mov    0x78(%rsp),%r8
  10b7c3:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
  10b7c8:	4c 89 e2             	mov    %r12,%rdx
  10b7cb:	4c 89 c9             	mov    %r9,%rcx
  10b7ce:	48 8b 34 24          	mov    (%rsp),%rsi
  10b7d2:	4d 0f af c7          	imul   %r15,%r8
  10b7d6:	48 81 c7 d8 07 00 00 	add    $0x7d8,%rdi
  10b7dd:	e8 5e 26 f6 ff       	call   6de40 <synreal::PcgSolver::initialize(unsigned long, synreal::Span<int const>, unsigned long)@plt>
  10b7e2:	4d 85 e4             	test   %r12,%r12
  10b7e5:	74 10                	je     10b7f7 <synreal::SolverNewton::precompute_matrices()+0x7487>
  10b7e7:	48 8b 74 24 68       	mov    0x68(%rsp),%rsi
  10b7ec:	4c 89 e7             	mov    %r12,%rdi
  10b7ef:	4c 29 e6             	sub    %r12,%rsi
  10b7f2:	e8 b9 19 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b7f7:	48 8b bc 24 90 07 00 	mov    0x790(%rsp),%rdi
  10b7fe:	00 
  10b7ff:	e8 3c 47 fe ff       	call   eff40 <std::_Rb_tree<int, std::pair<int const, int>, std::_Select1st<std::pair<int const, int> >, std::less<int>, std::allocator<std::pair<int const, int> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, int> >*) [clone .isra.0]>
  10b804:	48 85 ed             	test   %rbp,%rbp
  10b807:	74 10                	je     10b819 <synreal::SolverNewton::precompute_matrices()+0x74a9>
  10b809:	48 8b 74 24 60       	mov    0x60(%rsp),%rsi
  10b80e:	48 89 ef             	mov    %rbp,%rdi
  10b811:	48 29 ee             	sub    %rbp,%rsi
  10b814:	e8 97 19 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b819:	48 8b 84 24 98 00 00 	mov    0x98(%rsp),%rax
  10b820:	00 
  10b821:	48 85 c0             	test   %rax,%rax
  10b824:	74 10                	je     10b836 <synreal::SolverNewton::precompute_matrices()+0x74c6>
  10b826:	48 8b b4 24 90 01 00 	mov    0x190(%rsp),%rsi
  10b82d:	00 
  10b82e:	48 89 c7             	mov    %rax,%rdi
  10b831:	e8 7a 19 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b836:	48 8b ac 24 60 07 00 	mov    0x760(%rsp),%rbp
  10b83d:	00 
  10b83e:	4c 8b a4 24 68 07 00 	mov    0x768(%rsp),%r12
  10b845:	00 
  10b846:	48 89 eb             	mov    %rbp,%rbx
  10b849:	49 39 ec             	cmp    %rbp,%r12
  10b84c:	74 21                	je     10b86f <synreal::SolverNewton::precompute_matrices()+0x74ff>
  10b84e:	48 8b 3b             	mov    (%rbx),%rdi
  10b851:	48 85 ff             	test   %rdi,%rdi
  10b854:	0f 84 52 08 00 00    	je     10c0ac <synreal::SolverNewton::precompute_matrices()+0x7d3c>
  10b85a:	48 8b 73 10          	mov    0x10(%rbx),%rsi
  10b85e:	48 83 c3 18          	add    $0x18,%rbx
  10b862:	48 29 fe             	sub    %rdi,%rsi
  10b865:	e8 46 19 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b86a:	49 39 dc             	cmp    %rbx,%r12
  10b86d:	75 df                	jne    10b84e <synreal::SolverNewton::precompute_matrices()+0x74de>
  10b86f:	48 85 ed             	test   %rbp,%rbp
  10b872:	74 13                	je     10b887 <synreal::SolverNewton::precompute_matrices()+0x7517>
  10b874:	48 8b b4 24 70 07 00 	mov    0x770(%rsp),%rsi
  10b87b:	00 
  10b87c:	48 89 ef             	mov    %rbp,%rdi
  10b87f:	48 29 ee             	sub    %rbp,%rsi
  10b882:	e8 29 19 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b887:	48 8b ac 24 40 07 00 	mov    0x740(%rsp),%rbp
  10b88e:	00 
  10b88f:	4c 8b a4 24 48 07 00 	mov    0x748(%rsp),%r12
  10b896:	00 
  10b897:	48 89 eb             	mov    %rbp,%rbx
  10b89a:	49 39 ec             	cmp    %rbp,%r12
  10b89d:	74 21                	je     10b8c0 <synreal::SolverNewton::precompute_matrices()+0x7550>
  10b89f:	48 8b 3b             	mov    (%rbx),%rdi
  10b8a2:	48 85 ff             	test   %rdi,%rdi
  10b8a5:	0f 84 dd 07 00 00    	je     10c088 <synreal::SolverNewton::precompute_matrices()+0x7d18>
  10b8ab:	48 8b 73 10          	mov    0x10(%rbx),%rsi
  10b8af:	48 83 c3 18          	add    $0x18,%rbx
  10b8b3:	48 29 fe             	sub    %rdi,%rsi
  10b8b6:	e8 f5 18 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b8bb:	4c 39 e3             	cmp    %r12,%rbx
  10b8be:	75 df                	jne    10b89f <synreal::SolverNewton::precompute_matrices()+0x752f>
  10b8c0:	48 85 ed             	test   %rbp,%rbp
  10b8c3:	74 13                	je     10b8d8 <synreal::SolverNewton::precompute_matrices()+0x7568>
  10b8c5:	48 8b b4 24 50 07 00 	mov    0x750(%rsp),%rsi
  10b8cc:	00 
  10b8cd:	48 89 ef             	mov    %rbp,%rdi
  10b8d0:	48 29 ee             	sub    %rbp,%rsi
  10b8d3:	e8 d8 18 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b8d8:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  10b8dd:	48 85 ff             	test   %rdi,%rdi
  10b8e0:	74 10                	je     10b8f2 <synreal::SolverNewton::precompute_matrices()+0x7582>
  10b8e2:	48 8b b4 24 d8 01 00 	mov    0x1d8(%rsp),%rsi
  10b8e9:	00 
  10b8ea:	48 29 fe             	sub    %rdi,%rsi
  10b8ed:	e8 be 18 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b8f2:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  10b8f7:	48 85 ff             	test   %rdi,%rdi
  10b8fa:	74 10                	je     10b90c <synreal::SolverNewton::precompute_matrices()+0x759c>
  10b8fc:	48 8b b4 24 e0 01 00 	mov    0x1e0(%rsp),%rsi
  10b903:	00 
  10b904:	48 29 fe             	sub    %rdi,%rsi
  10b907:	e8 a4 18 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b90c:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
  10b911:	48 85 ff             	test   %rdi,%rdi
  10b914:	74 10                	je     10b926 <synreal::SolverNewton::precompute_matrices()+0x75b6>
  10b916:	48 8b b4 24 a0 01 00 	mov    0x1a0(%rsp),%rsi
  10b91d:	00 
  10b91e:	48 29 fe             	sub    %rdi,%rsi
  10b921:	e8 8a 18 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b926:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  10b92b:	48 85 ff             	test   %rdi,%rdi
  10b92e:	74 10                	je     10b940 <synreal::SolverNewton::precompute_matrices()+0x75d0>
  10b930:	48 8b b4 24 f8 01 00 	mov    0x1f8(%rsp),%rsi
  10b937:	00 
  10b938:	48 29 fe             	sub    %rdi,%rsi
  10b93b:	e8 70 18 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b940:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
  10b945:	48 85 ff             	test   %rdi,%rdi
  10b948:	74 10                	je     10b95a <synreal::SolverNewton::precompute_matrices()+0x75ea>
  10b94a:	48 8b b4 24 88 01 00 	mov    0x188(%rsp),%rsi
  10b951:	00 
  10b952:	48 29 fe             	sub    %rdi,%rsi
  10b955:	e8 56 18 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b95a:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
  10b95f:	48 85 ff             	test   %rdi,%rdi
  10b962:	74 10                	je     10b974 <synreal::SolverNewton::precompute_matrices()+0x7604>
  10b964:	48 8b b4 24 80 01 00 	mov    0x180(%rsp),%rsi
  10b96b:	00 
  10b96c:	48 29 fe             	sub    %rdi,%rsi
  10b96f:	e8 3c 18 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b974:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  10b979:	48 85 ff             	test   %rdi,%rdi
  10b97c:	74 10                	je     10b98e <synreal::SolverNewton::precompute_matrices()+0x761e>
  10b97e:	48 8b b4 24 f0 01 00 	mov    0x1f0(%rsp),%rsi
  10b985:	00 
  10b986:	48 29 fe             	sub    %rdi,%rsi
  10b989:	e8 22 18 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b98e:	48 8b bc 24 a8 00 00 	mov    0xa8(%rsp),%rdi
  10b995:	00 
  10b996:	48 85 ff             	test   %rdi,%rdi
  10b999:	74 10                	je     10b9ab <synreal::SolverNewton::precompute_matrices()+0x763b>
  10b99b:	48 8b b4 24 a8 01 00 	mov    0x1a8(%rsp),%rsi
  10b9a2:	00 
  10b9a3:	48 29 fe             	sub    %rdi,%rsi
  10b9a6:	e8 05 18 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b9ab:	48 8b 84 24 a0 00 00 	mov    0xa0(%rsp),%rax
  10b9b2:	00 
  10b9b3:	48 89 c3             	mov    %rax,%rbx
  10b9b6:	48 39 84 24 00 01 00 	cmp    %rax,0x100(%rsp)
  10b9bd:	00 
  10b9be:	74 36                	je     10b9f6 <synreal::SolverNewton::precompute_matrices()+0x7686>
  10b9c0:	48 8b 6b 10          	mov    0x10(%rbx),%rbp
  10b9c4:	48 85 ed             	test   %rbp,%rbp
  10b9c7:	74 1f                	je     10b9e8 <synreal::SolverNewton::precompute_matrices()+0x7678>
  10b9c9:	48 8b 7d 18          	mov    0x18(%rbp),%rdi
  10b9cd:	e8 3e 47 fe ff       	call   f0110 <std::_Rb_tree<int, std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues>, std::_Select1st<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >, std::less<int>, std::allocator<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, synreal::SolverNewton::precompute_matrices()::MatrixValues> >*) [clone .isra.0]>
  10b9d2:	48 89 ef             	mov    %rbp,%rdi
  10b9d5:	48 8b 6d 10          	mov    0x10(%rbp),%rbp
  10b9d9:	be 40 00 00 00       	mov    $0x40,%esi
  10b9de:	e8 cd 17 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10b9e3:	48 85 ed             	test   %rbp,%rbp
  10b9e6:	75 e1                	jne    10b9c9 <synreal::SolverNewton::precompute_matrices()+0x7659>
  10b9e8:	48 83 c3 30          	add    $0x30,%rbx
  10b9ec:	48 39 9c 24 00 01 00 	cmp    %rbx,0x100(%rsp)
  10b9f3:	00 
  10b9f4:	75 ca                	jne    10b9c0 <synreal::SolverNewton::precompute_matrices()+0x7650>
  10b9f6:	48 83 bc 24 a0 00 00 	cmpq   $0x0,0xa0(%rsp)
  10b9fd:	00 00 
  10b9ff:	74 18                	je     10ba19 <synreal::SolverNewton::precompute_matrices()+0x76a9>
  10ba01:	48 8b b4 24 00 01 00 	mov    0x100(%rsp),%rsi
  10ba08:	00 
  10ba09:	48 8b bc 24 a0 00 00 	mov    0xa0(%rsp),%rdi
  10ba10:	00 
  10ba11:	48 29 fe             	sub    %rdi,%rsi
  10ba14:	e8 97 17 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ba19:	48 8b bc 24 90 00 00 	mov    0x90(%rsp),%rdi
  10ba20:	00 
  10ba21:	48 85 ff             	test   %rdi,%rdi
  10ba24:	74 10                	je     10ba36 <synreal::SolverNewton::precompute_matrices()+0x76c6>
  10ba26:	48 8b b4 24 d0 01 00 	mov    0x1d0(%rsp),%rsi
  10ba2d:	00 
  10ba2e:	48 29 fe             	sub    %rdi,%rsi
  10ba31:	e8 7a 17 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ba36:	48 8b 84 24 20 01 00 	mov    0x120(%rsp),%rax
  10ba3d:	00 
  10ba3e:	48 85 c0             	test   %rax,%rax
  10ba41:	74 10                	je     10ba53 <synreal::SolverNewton::precompute_matrices()+0x76e3>
  10ba43:	48 8b b4 24 88 02 00 	mov    0x288(%rsp),%rsi
  10ba4a:	00 
  10ba4b:	48 89 c7             	mov    %rax,%rdi
  10ba4e:	e8 5d 17 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ba53:	48 8b 84 24 28 01 00 	mov    0x128(%rsp),%rax
  10ba5a:	00 
  10ba5b:	48 85 c0             	test   %rax,%rax
  10ba5e:	74 10                	je     10ba70 <synreal::SolverNewton::precompute_matrices()+0x7700>
  10ba60:	48 8b b4 24 80 02 00 	mov    0x280(%rsp),%rsi
  10ba67:	00 
  10ba68:	48 89 c7             	mov    %rax,%rdi
  10ba6b:	e8 40 17 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ba70:	48 8b 84 24 40 01 00 	mov    0x140(%rsp),%rax
  10ba77:	00 
  10ba78:	48 85 c0             	test   %rax,%rax
  10ba7b:	74 10                	je     10ba8d <synreal::SolverNewton::precompute_matrices()+0x771d>
  10ba7d:	48 8b b4 24 d8 02 00 	mov    0x2d8(%rsp),%rsi
  10ba84:	00 
  10ba85:	48 89 c7             	mov    %rax,%rdi
  10ba88:	e8 23 17 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ba8d:	48 8b 84 24 48 01 00 	mov    0x148(%rsp),%rax
  10ba94:	00 
  10ba95:	48 85 c0             	test   %rax,%rax
  10ba98:	74 10                	je     10baaa <synreal::SolverNewton::precompute_matrices()+0x773a>
  10ba9a:	48 8b b4 24 c0 02 00 	mov    0x2c0(%rsp),%rsi
  10baa1:	00 
  10baa2:	48 89 c7             	mov    %rax,%rdi
  10baa5:	e8 06 17 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10baaa:	48 8b 84 24 50 01 00 	mov    0x150(%rsp),%rax
  10bab1:	00 
  10bab2:	48 85 c0             	test   %rax,%rax
  10bab5:	74 10                	je     10bac7 <synreal::SolverNewton::precompute_matrices()+0x7757>
  10bab7:	48 8b b4 24 c8 02 00 	mov    0x2c8(%rsp),%rsi
  10babe:	00 
  10babf:	48 89 c7             	mov    %rax,%rdi
  10bac2:	e8 e9 16 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bac7:	48 8b 84 24 d0 00 00 	mov    0xd0(%rsp),%rax
  10bace:	00 
  10bacf:	48 85 c0             	test   %rax,%rax
  10bad2:	74 10                	je     10bae4 <synreal::SolverNewton::precompute_matrices()+0x7774>
  10bad4:	48 8b b4 24 d0 02 00 	mov    0x2d0(%rsp),%rsi
  10badb:	00 
  10badc:	48 89 c7             	mov    %rax,%rdi
  10badf:	e8 cc 16 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bae4:	48 8b 84 24 f0 00 00 	mov    0xf0(%rsp),%rax
  10baeb:	00 
  10baec:	48 85 c0             	test   %rax,%rax
  10baef:	74 10                	je     10bb01 <synreal::SolverNewton::precompute_matrices()+0x7791>
  10baf1:	48 8b b4 24 78 02 00 	mov    0x278(%rsp),%rsi
  10baf8:	00 
  10baf9:	48 89 c7             	mov    %rax,%rdi
  10bafc:	e8 af 16 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bb01:	48 8b 84 24 08 01 00 	mov    0x108(%rsp),%rax
  10bb08:	00 
  10bb09:	48 85 c0             	test   %rax,%rax
  10bb0c:	74 10                	je     10bb1e <synreal::SolverNewton::precompute_matrices()+0x77ae>
  10bb0e:	48 8b b4 24 b8 02 00 	mov    0x2b8(%rsp),%rsi
  10bb15:	00 
  10bb16:	48 89 c7             	mov    %rax,%rdi
  10bb19:	e8 92 16 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bb1e:	48 8b 84 24 10 01 00 	mov    0x110(%rsp),%rax
  10bb25:	00 
  10bb26:	48 85 c0             	test   %rax,%rax
  10bb29:	74 10                	je     10bb3b <synreal::SolverNewton::precompute_matrices()+0x77cb>
  10bb2b:	48 8b b4 24 b0 02 00 	mov    0x2b0(%rsp),%rsi
  10bb32:	00 
  10bb33:	48 89 c7             	mov    %rax,%rdi
  10bb36:	e8 75 16 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bb3b:	48 8b 84 24 e8 00 00 	mov    0xe8(%rsp),%rax
  10bb42:	00 
  10bb43:	48 85 c0             	test   %rax,%rax
  10bb46:	74 10                	je     10bb58 <synreal::SolverNewton::precompute_matrices()+0x77e8>
  10bb48:	48 8b b4 24 70 02 00 	mov    0x270(%rsp),%rsi
  10bb4f:	00 
  10bb50:	48 89 c7             	mov    %rax,%rdi
  10bb53:	e8 58 16 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bb58:	48 8b 84 24 18 01 00 	mov    0x118(%rsp),%rax
  10bb5f:	00 
  10bb60:	48 85 c0             	test   %rax,%rax
  10bb63:	74 10                	je     10bb75 <synreal::SolverNewton::precompute_matrices()+0x7805>
  10bb65:	48 8b b4 24 a0 02 00 	mov    0x2a0(%rsp),%rsi
  10bb6c:	00 
  10bb6d:	48 89 c7             	mov    %rax,%rdi
  10bb70:	e8 3b 16 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bb75:	48 8b 84 24 e0 00 00 	mov    0xe0(%rsp),%rax
  10bb7c:	00 
  10bb7d:	48 85 c0             	test   %rax,%rax
  10bb80:	74 10                	je     10bb92 <synreal::SolverNewton::precompute_matrices()+0x7822>
  10bb82:	48 8b b4 24 40 02 00 	mov    0x240(%rsp),%rsi
  10bb89:	00 
  10bb8a:	48 89 c7             	mov    %rax,%rdi
  10bb8d:	e8 1e 16 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bb92:	48 8b 84 24 38 01 00 	mov    0x138(%rsp),%rax
  10bb99:	00 
  10bb9a:	48 85 c0             	test   %rax,%rax
  10bb9d:	74 10                	je     10bbaf <synreal::SolverNewton::precompute_matrices()+0x783f>
  10bb9f:	48 8b b4 24 a8 02 00 	mov    0x2a8(%rsp),%rsi
  10bba6:	00 
  10bba7:	48 89 c7             	mov    %rax,%rdi
  10bbaa:	e8 01 16 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bbaf:	48 8b ac 24 80 05 00 	mov    0x580(%rsp),%rbp
  10bbb6:	00 
  10bbb7:	4c 8b a4 24 88 05 00 	mov    0x588(%rsp),%r12
  10bbbe:	00 
  10bbbf:	48 89 eb             	mov    %rbp,%rbx
  10bbc2:	49 39 ec             	cmp    %rbp,%r12
  10bbc5:	74 31                	je     10bbf8 <synreal::SolverNewton::precompute_matrices()+0x7888>
  10bbc7:	4c 8b 6b 10          	mov    0x10(%rbx),%r13
  10bbcb:	4d 85 ed             	test   %r13,%r13
  10bbce:	74 1f                	je     10bbef <synreal::SolverNewton::precompute_matrices()+0x787f>
  10bbd0:	49 8b 7d 18          	mov    0x18(%r13),%rdi
  10bbd4:	e8 17 4a fe ff       	call   f05f0 <std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, float> >*) [clone .isra.0]>
  10bbd9:	4c 89 ef             	mov    %r13,%rdi
  10bbdc:	4d 8b 6d 10          	mov    0x10(%r13),%r13
  10bbe0:	be 28 00 00 00       	mov    $0x28,%esi
  10bbe5:	e8 c6 15 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bbea:	4d 85 ed             	test   %r13,%r13
  10bbed:	75 e1                	jne    10bbd0 <synreal::SolverNewton::precompute_matrices()+0x7860>
  10bbef:	48 83 c3 30          	add    $0x30,%rbx
  10bbf3:	49 39 dc             	cmp    %rbx,%r12
  10bbf6:	75 cf                	jne    10bbc7 <synreal::SolverNewton::precompute_matrices()+0x7857>
  10bbf8:	48 85 ed             	test   %rbp,%rbp
  10bbfb:	74 13                	je     10bc10 <synreal::SolverNewton::precompute_matrices()+0x78a0>
  10bbfd:	48 8b b4 24 90 05 00 	mov    0x590(%rsp),%rsi
  10bc04:	00 
  10bc05:	48 89 ef             	mov    %rbp,%rdi
  10bc08:	48 29 ee             	sub    %rbp,%rsi
  10bc0b:	e8 a0 15 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bc10:	48 8b ac 24 60 05 00 	mov    0x560(%rsp),%rbp
  10bc17:	00 
  10bc18:	4c 8b a4 24 68 05 00 	mov    0x568(%rsp),%r12
  10bc1f:	00 
  10bc20:	48 89 eb             	mov    %rbp,%rbx
  10bc23:	49 39 ec             	cmp    %rbp,%r12
  10bc26:	74 31                	je     10bc59 <synreal::SolverNewton::precompute_matrices()+0x78e9>
  10bc28:	4c 8b 6b 10          	mov    0x10(%rbx),%r13
  10bc2c:	4d 85 ed             	test   %r13,%r13
  10bc2f:	74 1f                	je     10bc50 <synreal::SolverNewton::precompute_matrices()+0x78e0>
  10bc31:	49 8b 7d 18          	mov    0x18(%r13),%rdi
  10bc35:	e8 b6 49 fe ff       	call   f05f0 <std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, float> >*) [clone .isra.0]>
  10bc3a:	4c 89 ef             	mov    %r13,%rdi
  10bc3d:	4d 8b 6d 10          	mov    0x10(%r13),%r13
  10bc41:	be 28 00 00 00       	mov    $0x28,%esi
  10bc46:	e8 65 15 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bc4b:	4d 85 ed             	test   %r13,%r13
  10bc4e:	75 e1                	jne    10bc31 <synreal::SolverNewton::precompute_matrices()+0x78c1>
  10bc50:	48 83 c3 30          	add    $0x30,%rbx
  10bc54:	49 39 dc             	cmp    %rbx,%r12
  10bc57:	75 cf                	jne    10bc28 <synreal::SolverNewton::precompute_matrices()+0x78b8>
  10bc59:	48 85 ed             	test   %rbp,%rbp
  10bc5c:	74 13                	je     10bc71 <synreal::SolverNewton::precompute_matrices()+0x7901>
  10bc5e:	48 8b b4 24 70 05 00 	mov    0x570(%rsp),%rsi
  10bc65:	00 
  10bc66:	48 89 ef             	mov    %rbp,%rdi
  10bc69:	48 29 ee             	sub    %rbp,%rsi
  10bc6c:	e8 3f 15 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bc71:	48 8b ac 24 40 05 00 	mov    0x540(%rsp),%rbp
  10bc78:	00 
  10bc79:	4c 8b a4 24 48 05 00 	mov    0x548(%rsp),%r12
  10bc80:	00 
  10bc81:	48 89 eb             	mov    %rbp,%rbx
  10bc84:	49 39 ec             	cmp    %rbp,%r12
  10bc87:	74 31                	je     10bcba <synreal::SolverNewton::precompute_matrices()+0x794a>
  10bc89:	4c 8b 6b 10          	mov    0x10(%rbx),%r13
  10bc8d:	4d 85 ed             	test   %r13,%r13
  10bc90:	74 1f                	je     10bcb1 <synreal::SolverNewton::precompute_matrices()+0x7941>
  10bc92:	49 8b 7d 18          	mov    0x18(%r13),%rdi
  10bc96:	e8 55 49 fe ff       	call   f05f0 <std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, float> >*) [clone .isra.0]>
  10bc9b:	4c 89 ef             	mov    %r13,%rdi
  10bc9e:	4d 8b 6d 10          	mov    0x10(%r13),%r13
  10bca2:	be 28 00 00 00       	mov    $0x28,%esi
  10bca7:	e8 04 15 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bcac:	4d 85 ed             	test   %r13,%r13
  10bcaf:	75 e1                	jne    10bc92 <synreal::SolverNewton::precompute_matrices()+0x7922>
  10bcb1:	48 83 c3 30          	add    $0x30,%rbx
  10bcb5:	49 39 dc             	cmp    %rbx,%r12
  10bcb8:	75 cf                	jne    10bc89 <synreal::SolverNewton::precompute_matrices()+0x7919>
  10bcba:	48 85 ed             	test   %rbp,%rbp
  10bcbd:	74 13                	je     10bcd2 <synreal::SolverNewton::precompute_matrices()+0x7962>
  10bcbf:	48 8b b4 24 50 05 00 	mov    0x550(%rsp),%rsi
  10bcc6:	00 
  10bcc7:	48 89 ef             	mov    %rbp,%rdi
  10bcca:	48 29 ee             	sub    %rbp,%rsi
  10bccd:	e8 de 14 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bcd2:	48 8b ac 24 20 05 00 	mov    0x520(%rsp),%rbp
  10bcd9:	00 
  10bcda:	4c 8b a4 24 28 05 00 	mov    0x528(%rsp),%r12
  10bce1:	00 
  10bce2:	48 89 eb             	mov    %rbp,%rbx
  10bce5:	49 39 ec             	cmp    %rbp,%r12
  10bce8:	74 21                	je     10bd0b <synreal::SolverNewton::precompute_matrices()+0x799b>
  10bcea:	48 8b 3b             	mov    (%rbx),%rdi
  10bced:	48 85 ff             	test   %rdi,%rdi
  10bcf0:	0f 84 a4 03 00 00    	je     10c09a <synreal::SolverNewton::precompute_matrices()+0x7d2a>
  10bcf6:	48 8b 73 10          	mov    0x10(%rbx),%rsi
  10bcfa:	48 83 c3 18          	add    $0x18,%rbx
  10bcfe:	48 29 fe             	sub    %rdi,%rsi
  10bd01:	e8 aa 14 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bd06:	4c 39 e3             	cmp    %r12,%rbx
  10bd09:	75 df                	jne    10bcea <synreal::SolverNewton::precompute_matrices()+0x797a>
  10bd0b:	48 85 ed             	test   %rbp,%rbp
  10bd0e:	74 13                	je     10bd23 <synreal::SolverNewton::precompute_matrices()+0x79b3>
  10bd10:	48 8b b4 24 30 05 00 	mov    0x530(%rsp),%rsi
  10bd17:	00 
  10bd18:	48 89 ef             	mov    %rbp,%rdi
  10bd1b:	48 29 ee             	sub    %rbp,%rsi
  10bd1e:	e8 8d 14 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bd23:	48 8b ac 24 00 05 00 	mov    0x500(%rsp),%rbp
  10bd2a:	00 
  10bd2b:	4c 8b a4 24 08 05 00 	mov    0x508(%rsp),%r12
  10bd32:	00 
  10bd33:	48 89 eb             	mov    %rbp,%rbx
  10bd36:	49 39 ec             	cmp    %rbp,%r12
  10bd39:	74 4b                	je     10bd86 <synreal::SolverNewton::precompute_matrices()+0x7a16>
  10bd3b:	4c 8b 6b 10          	mov    0x10(%rbx),%r13
  10bd3f:	4d 85 ed             	test   %r13,%r13
  10bd42:	74 39                	je     10bd7d <synreal::SolverNewton::precompute_matrices()+0x7a0d>
  10bd44:	49 8b 7d 18          	mov    0x18(%r13),%rdi
  10bd48:	e8 93 45 fe ff       	call   f02e0 <std::_Rb_tree<int, std::pair<int const, std::vector<int, std::allocator<int> > >, std::_Select1st<std::pair<int const, std::vector<int, std::allocator<int> > > >, std::less<int>, std::allocator<std::pair<int const, std::vector<int, std::allocator<int> > > > >::_M_erase(std::_Rb_tree_node<std::pair<int const, std::vector<int, std::allocator<int> > > >*) [clone .isra.0]>
  10bd4d:	49 8b 7d 28          	mov    0x28(%r13),%rdi
  10bd51:	4d 8b 75 10          	mov    0x10(%r13),%r14
  10bd55:	48 85 ff             	test   %rdi,%rdi
  10bd58:	74 0c                	je     10bd66 <synreal::SolverNewton::precompute_matrices()+0x79f6>
  10bd5a:	49 8b 75 38          	mov    0x38(%r13),%rsi
  10bd5e:	48 29 fe             	sub    %rdi,%rsi
  10bd61:	e8 4a 14 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bd66:	be 40 00 00 00       	mov    $0x40,%esi
  10bd6b:	4c 89 ef             	mov    %r13,%rdi
  10bd6e:	e8 3d 14 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bd73:	4d 85 f6             	test   %r14,%r14
  10bd76:	74 05                	je     10bd7d <synreal::SolverNewton::precompute_matrices()+0x7a0d>
  10bd78:	4d 89 f5             	mov    %r14,%r13
  10bd7b:	eb c7                	jmp    10bd44 <synreal::SolverNewton::precompute_matrices()+0x79d4>
  10bd7d:	48 83 c3 30          	add    $0x30,%rbx
  10bd81:	49 39 dc             	cmp    %rbx,%r12
  10bd84:	75 b5                	jne    10bd3b <synreal::SolverNewton::precompute_matrices()+0x79cb>
  10bd86:	48 85 ed             	test   %rbp,%rbp
  10bd89:	74 13                	je     10bd9e <synreal::SolverNewton::precompute_matrices()+0x7a2e>
  10bd8b:	48 8b b4 24 10 05 00 	mov    0x510(%rsp),%rsi
  10bd92:	00 
  10bd93:	48 89 ef             	mov    %rbp,%rdi
  10bd96:	48 29 ee             	sub    %rbp,%rsi
  10bd99:	e8 12 14 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bd9e:	48 8b ac 24 e0 04 00 	mov    0x4e0(%rsp),%rbp
  10bda5:	00 
  10bda6:	4c 8b a4 24 e8 04 00 	mov    0x4e8(%rsp),%r12
  10bdad:	00 
  10bdae:	48 89 eb             	mov    %rbp,%rbx
  10bdb1:	49 39 ec             	cmp    %rbp,%r12
  10bdb4:	74 4b                	je     10be01 <synreal::SolverNewton::precompute_matrices()+0x7a91>
  10bdb6:	4c 8b 6b 10          	mov    0x10(%rbx),%r13
  10bdba:	4d 85 ed             	test   %r13,%r13
  10bdbd:	74 39                	je     10bdf8 <synreal::SolverNewton::precompute_matrices()+0x7a88>
  10bdbf:	49 8b 7d 18          	mov    0x18(%r13),%rdi
  10bdc3:	e8 18 45 fe ff       	call   f02e0 <std::_Rb_tree<int, std::pair<int const, std::vector<int, std::allocator<int> > >, std::_Select1st<std::pair<int const, std::vector<int, std::allocator<int> > > >, std::less<int>, std::allocator<std::pair<int const, std::vector<int, std::allocator<int> > > > >::_M_erase(std::_Rb_tree_node<std::pair<int const, std::vector<int, std::allocator<int> > > >*) [clone .isra.0]>
  10bdc8:	49 8b 7d 28          	mov    0x28(%r13),%rdi
  10bdcc:	4d 8b 75 10          	mov    0x10(%r13),%r14
  10bdd0:	48 85 ff             	test   %rdi,%rdi
  10bdd3:	74 0c                	je     10bde1 <synreal::SolverNewton::precompute_matrices()+0x7a71>
  10bdd5:	49 8b 75 38          	mov    0x38(%r13),%rsi
  10bdd9:	48 29 fe             	sub    %rdi,%rsi
  10bddc:	e8 cf 13 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bde1:	be 40 00 00 00       	mov    $0x40,%esi
  10bde6:	4c 89 ef             	mov    %r13,%rdi
  10bde9:	e8 c2 13 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bdee:	4d 85 f6             	test   %r14,%r14
  10bdf1:	74 05                	je     10bdf8 <synreal::SolverNewton::precompute_matrices()+0x7a88>
  10bdf3:	4d 89 f5             	mov    %r14,%r13
  10bdf6:	eb c7                	jmp    10bdbf <synreal::SolverNewton::precompute_matrices()+0x7a4f>
  10bdf8:	48 83 c3 30          	add    $0x30,%rbx
  10bdfc:	49 39 dc             	cmp    %rbx,%r12
  10bdff:	75 b5                	jne    10bdb6 <synreal::SolverNewton::precompute_matrices()+0x7a46>
  10be01:	48 85 ed             	test   %rbp,%rbp
  10be04:	74 13                	je     10be19 <synreal::SolverNewton::precompute_matrices()+0x7aa9>
  10be06:	48 8b b4 24 f0 04 00 	mov    0x4f0(%rsp),%rsi
  10be0d:	00 
  10be0e:	48 89 ef             	mov    %rbp,%rdi
  10be11:	48 29 ee             	sub    %rbp,%rsi
  10be14:	e8 97 13 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10be19:	48 8b ac 24 c0 04 00 	mov    0x4c0(%rsp),%rbp
  10be20:	00 
  10be21:	4c 8b a4 24 c8 04 00 	mov    0x4c8(%rsp),%r12
  10be28:	00 
  10be29:	48 89 eb             	mov    %rbp,%rbx
  10be2c:	49 39 ec             	cmp    %rbp,%r12
  10be2f:	74 31                	je     10be62 <synreal::SolverNewton::precompute_matrices()+0x7af2>
  10be31:	4c 8b 6b 10          	mov    0x10(%rbx),%r13
  10be35:	4d 85 ed             	test   %r13,%r13
  10be38:	74 1f                	je     10be59 <synreal::SolverNewton::precompute_matrices()+0x7ae9>
  10be3a:	49 8b 7d 18          	mov    0x18(%r13),%rdi
  10be3e:	e8 ad 47 fe ff       	call   f05f0 <std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, float> >*) [clone .isra.0]>
  10be43:	4c 89 ef             	mov    %r13,%rdi
  10be46:	4d 8b 6d 10          	mov    0x10(%r13),%r13
  10be4a:	be 28 00 00 00       	mov    $0x28,%esi
  10be4f:	e8 5c 13 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10be54:	4d 85 ed             	test   %r13,%r13
  10be57:	75 e1                	jne    10be3a <synreal::SolverNewton::precompute_matrices()+0x7aca>
  10be59:	48 83 c3 30          	add    $0x30,%rbx
  10be5d:	49 39 dc             	cmp    %rbx,%r12
  10be60:	75 cf                	jne    10be31 <synreal::SolverNewton::precompute_matrices()+0x7ac1>
  10be62:	48 85 ed             	test   %rbp,%rbp
  10be65:	74 13                	je     10be7a <synreal::SolverNewton::precompute_matrices()+0x7b0a>
  10be67:	48 8b b4 24 d0 04 00 	mov    0x4d0(%rsp),%rsi
  10be6e:	00 
  10be6f:	48 89 ef             	mov    %rbp,%rdi
  10be72:	48 29 ee             	sub    %rbp,%rsi
  10be75:	e8 36 13 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10be7a:	48 8b ac 24 a0 04 00 	mov    0x4a0(%rsp),%rbp
  10be81:	00 
  10be82:	4c 8b a4 24 a8 04 00 	mov    0x4a8(%rsp),%r12
  10be89:	00 
  10be8a:	48 89 eb             	mov    %rbp,%rbx
  10be8d:	49 39 ec             	cmp    %rbp,%r12
  10be90:	74 31                	je     10bec3 <synreal::SolverNewton::precompute_matrices()+0x7b53>
  10be92:	4c 8b 6b 10          	mov    0x10(%rbx),%r13
  10be96:	4d 85 ed             	test   %r13,%r13
  10be99:	74 1f                	je     10beba <synreal::SolverNewton::precompute_matrices()+0x7b4a>
  10be9b:	49 8b 7d 18          	mov    0x18(%r13),%rdi
  10be9f:	e8 4c 47 fe ff       	call   f05f0 <std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, float> >*) [clone .isra.0]>
  10bea4:	4c 89 ef             	mov    %r13,%rdi
  10bea7:	4d 8b 6d 10          	mov    0x10(%r13),%r13
  10beab:	be 28 00 00 00       	mov    $0x28,%esi
  10beb0:	e8 fb 12 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10beb5:	4d 85 ed             	test   %r13,%r13
  10beb8:	75 e1                	jne    10be9b <synreal::SolverNewton::precompute_matrices()+0x7b2b>
  10beba:	48 83 c3 30          	add    $0x30,%rbx
  10bebe:	49 39 dc             	cmp    %rbx,%r12
  10bec1:	75 cf                	jne    10be92 <synreal::SolverNewton::precompute_matrices()+0x7b22>
  10bec3:	48 85 ed             	test   %rbp,%rbp
  10bec6:	74 13                	je     10bedb <synreal::SolverNewton::precompute_matrices()+0x7b6b>
  10bec8:	48 8b b4 24 b0 04 00 	mov    0x4b0(%rsp),%rsi
  10becf:	00 
  10bed0:	48 89 ef             	mov    %rbp,%rdi
  10bed3:	48 29 ee             	sub    %rbp,%rsi
  10bed6:	e8 d5 12 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bedb:	48 8b ac 24 80 04 00 	mov    0x480(%rsp),%rbp
  10bee2:	00 
  10bee3:	4c 8b a4 24 88 04 00 	mov    0x488(%rsp),%r12
  10beea:	00 
  10beeb:	48 89 eb             	mov    %rbp,%rbx
  10beee:	49 39 ec             	cmp    %rbp,%r12
  10bef1:	74 31                	je     10bf24 <synreal::SolverNewton::precompute_matrices()+0x7bb4>
  10bef3:	4c 8b 6b 10          	mov    0x10(%rbx),%r13
  10bef7:	4d 85 ed             	test   %r13,%r13
  10befa:	74 1f                	je     10bf1b <synreal::SolverNewton::precompute_matrices()+0x7bab>
  10befc:	49 8b 7d 18          	mov    0x18(%r13),%rdi
  10bf00:	e8 eb 46 fe ff       	call   f05f0 <std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, float> >*) [clone .isra.0]>
  10bf05:	4c 89 ef             	mov    %r13,%rdi
  10bf08:	4d 8b 6d 10          	mov    0x10(%r13),%r13
  10bf0c:	be 28 00 00 00       	mov    $0x28,%esi
  10bf11:	e8 9a 12 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bf16:	4d 85 ed             	test   %r13,%r13
  10bf19:	75 e1                	jne    10befc <synreal::SolverNewton::precompute_matrices()+0x7b8c>
  10bf1b:	48 83 c3 30          	add    $0x30,%rbx
  10bf1f:	49 39 dc             	cmp    %rbx,%r12
  10bf22:	75 cf                	jne    10bef3 <synreal::SolverNewton::precompute_matrices()+0x7b83>
  10bf24:	48 85 ed             	test   %rbp,%rbp
  10bf27:	74 13                	je     10bf3c <synreal::SolverNewton::precompute_matrices()+0x7bcc>
  10bf29:	48 8b b4 24 90 04 00 	mov    0x490(%rsp),%rsi
  10bf30:	00 
  10bf31:	48 89 ef             	mov    %rbp,%rdi
  10bf34:	48 29 ee             	sub    %rbp,%rsi
  10bf37:	e8 74 12 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bf3c:	48 8b ac 24 60 04 00 	mov    0x460(%rsp),%rbp
  10bf43:	00 
  10bf44:	4c 8b a4 24 68 04 00 	mov    0x468(%rsp),%r12
  10bf4b:	00 
  10bf4c:	48 89 eb             	mov    %rbp,%rbx
  10bf4f:	49 39 ec             	cmp    %rbp,%r12
  10bf52:	74 31                	je     10bf85 <synreal::SolverNewton::precompute_matrices()+0x7c15>
  10bf54:	4c 8b 6b 10          	mov    0x10(%rbx),%r13
  10bf58:	4d 85 ed             	test   %r13,%r13
  10bf5b:	74 1f                	je     10bf7c <synreal::SolverNewton::precompute_matrices()+0x7c0c>
  10bf5d:	49 8b 7d 18          	mov    0x18(%r13),%rdi
  10bf61:	e8 8a 46 fe ff       	call   f05f0 <std::_Rb_tree<int, std::pair<int const, float>, std::_Select1st<std::pair<int const, float> >, std::less<int>, std::allocator<std::pair<int const, float> > >::_M_erase(std::_Rb_tree_node<std::pair<int const, float> >*) [clone .isra.0]>
  10bf66:	4c 89 ef             	mov    %r13,%rdi
  10bf69:	4d 8b 6d 10          	mov    0x10(%r13),%r13
  10bf6d:	be 28 00 00 00       	mov    $0x28,%esi
  10bf72:	e8 39 12 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bf77:	4d 85 ed             	test   %r13,%r13
  10bf7a:	75 e1                	jne    10bf5d <synreal::SolverNewton::precompute_matrices()+0x7bed>
  10bf7c:	48 83 c3 30          	add    $0x30,%rbx
  10bf80:	49 39 dc             	cmp    %rbx,%r12
  10bf83:	75 cf                	jne    10bf54 <synreal::SolverNewton::precompute_matrices()+0x7be4>
  10bf85:	48 85 ed             	test   %rbp,%rbp
  10bf88:	74 13                	je     10bf9d <synreal::SolverNewton::precompute_matrices()+0x7c2d>
  10bf8a:	48 8b b4 24 70 04 00 	mov    0x470(%rsp),%rsi
  10bf91:	00 
  10bf92:	48 89 ef             	mov    %rbp,%rdi
  10bf95:	48 29 ee             	sub    %rbp,%rsi
  10bf98:	e8 13 12 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bf9d:	48 8b 7c 24 70       	mov    0x70(%rsp),%rdi
  10bfa2:	48 85 ff             	test   %rdi,%rdi
  10bfa5:	74 10                	je     10bfb7 <synreal::SolverNewton::precompute_matrices()+0x7c47>
  10bfa7:	48 8b b4 24 b8 01 00 	mov    0x1b8(%rsp),%rsi
  10bfae:	00 
  10bfaf:	48 29 fe             	sub    %rdi,%rsi
  10bfb2:	e8 f9 11 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bfb7:	48 8b 7c 24 58       	mov    0x58(%rsp),%rdi
  10bfbc:	48 85 ff             	test   %rdi,%rdi
  10bfbf:	74 10                	je     10bfd1 <synreal::SolverNewton::precompute_matrices()+0x7c61>
  10bfc1:	48 8b b4 24 50 04 00 	mov    0x450(%rsp),%rsi
  10bfc8:	00 
  10bfc9:	48 29 fe             	sub    %rdi,%rsi
  10bfcc:	e8 df 11 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bfd1:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
  10bfd6:	48 85 ff             	test   %rdi,%rdi
  10bfd9:	74 10                	je     10bfeb <synreal::SolverNewton::precompute_matrices()+0x7c7b>
  10bfdb:	48 8b b4 24 30 04 00 	mov    0x430(%rsp),%rsi
  10bfe2:	00 
  10bfe3:	48 29 fe             	sub    %rdi,%rsi
  10bfe6:	e8 c5 11 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10bfeb:	48 8b bc 24 b0 00 00 	mov    0xb0(%rsp),%rdi
  10bff2:	00 
  10bff3:	48 85 ff             	test   %rdi,%rdi
  10bff6:	74 10                	je     10c008 <synreal::SolverNewton::precompute_matrices()+0x7c98>
  10bff8:	48 8b b4 24 68 01 00 	mov    0x168(%rsp),%rsi
  10bfff:	00 
  10c000:	48 29 fe             	sub    %rdi,%rsi
  10c003:	e8 a8 11 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c008:	48 8b bc 24 88 00 00 	mov    0x88(%rsp),%rdi
  10c00f:	00 
  10c010:	48 85 ff             	test   %rdi,%rdi
  10c013:	74 10                	je     10c025 <synreal::SolverNewton::precompute_matrices()+0x7cb5>
  10c015:	48 8b b4 24 60 01 00 	mov    0x160(%rsp),%rsi
  10c01c:	00 
  10c01d:	48 29 fe             	sub    %rdi,%rsi
  10c020:	e8 8b 11 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c025:	48 8b bc 24 80 00 00 	mov    0x80(%rsp),%rdi
  10c02c:	00 
  10c02d:	48 85 ff             	test   %rdi,%rdi
  10c030:	74 10                	je     10c042 <synreal::SolverNewton::precompute_matrices()+0x7cd2>
  10c032:	48 8b b4 24 10 04 00 	mov    0x410(%rsp),%rsi
  10c039:	00 
  10c03a:	48 29 fe             	sub    %rdi,%rsi
  10c03d:	e8 6e 11 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c042:	48 8b bc 24 e0 03 00 	mov    0x3e0(%rsp),%rdi
  10c049:	00 
  10c04a:	48 85 ff             	test   %rdi,%rdi
  10c04d:	74 10                	je     10c05f <synreal::SolverNewton::precompute_matrices()+0x7cef>
  10c04f:	48 8b b4 24 f0 03 00 	mov    0x3f0(%rsp),%rsi
  10c056:	00 
  10c057:	48 29 fe             	sub    %rdi,%rsi
  10c05a:	e8 51 11 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c05f:	48 8b 84 24 e8 07 00 	mov    0x7e8(%rsp),%rax
  10c066:	00 
  10c067:	64 48 2b 04 25 28 00 	sub    %fs:0x28,%rax
  10c06e:	00 00 
  10c070:	0f 85 fb 04 00 00    	jne    10c571 <synreal::SolverNewton::precompute_matrices()+0x8201>
  10c076:	48 81 c4 f8 07 00 00 	add    $0x7f8,%rsp
  10c07d:	5b                   	pop    %rbx
  10c07e:	5d                   	pop    %rbp
  10c07f:	41 5c                	pop    %r12
  10c081:	41 5d                	pop    %r13
  10c083:	41 5e                	pop    %r14
  10c085:	41 5f                	pop    %r15
  10c087:	c3                   	ret    
  10c088:	48 83 c3 18          	add    $0x18,%rbx
  10c08c:	49 39 dc             	cmp    %rbx,%r12
  10c08f:	0f 85 0a f8 ff ff    	jne    10b89f <synreal::SolverNewton::precompute_matrices()+0x752f>
  10c095:	e9 26 f8 ff ff       	jmp    10b8c0 <synreal::SolverNewton::precompute_matrices()+0x7550>
  10c09a:	48 83 c3 18          	add    $0x18,%rbx
  10c09e:	49 39 dc             	cmp    %rbx,%r12
  10c0a1:	0f 85 43 fc ff ff    	jne    10bcea <synreal::SolverNewton::precompute_matrices()+0x797a>
  10c0a7:	e9 5f fc ff ff       	jmp    10bd0b <synreal::SolverNewton::precompute_matrices()+0x799b>
  10c0ac:	48 83 c3 18          	add    $0x18,%rbx
  10c0b0:	49 39 dc             	cmp    %rbx,%r12
  10c0b3:	0f 85 95 f7 ff ff    	jne    10b84e <synreal::SolverNewton::precompute_matrices()+0x74de>
  10c0b9:	e9 b1 f7 ff ff       	jmp    10b86f <synreal::SolverNewton::precompute_matrices()+0x74ff>
  10c0be:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
  10c0c3:	48 89 97 58 2b 00 00 	mov    %rdx,0x2b58(%rdi)
  10c0ca:	48 8b 8f b0 2d 00 00 	mov    0x2db0(%rdi),%rcx
  10c0d1:	48 89 87 60 2b 00 00 	mov    %rax,0x2b60(%rdi)
  10c0d8:	48 8b b7 a0 2d 00 00 	mov    0x2da0(%rdi),%rsi
  10c0df:	48 89 d8             	mov    %rbx,%rax
  10c0e2:	48 8b 54 24 78       	mov    0x78(%rsp),%rdx
  10c0e7:	e9 d6 ae ff ff       	jmp    106fc2 <synreal::SolverNewton::precompute_matrices()+0x2c52>
  10c0ec:	48 8b 9c 24 a8 00 00 	mov    0xa8(%rsp),%rbx
  10c0f3:	00 
  10c0f4:	4d 85 e4             	test   %r12,%r12
  10c0f7:	74 13                	je     10c10c <synreal::SolverNewton::precompute_matrices()+0x7d9c>
  10c0f9:	48 8b b4 24 90 07 00 	mov    0x790(%rsp),%rsi
  10c100:	00 
  10c101:	4c 89 e7             	mov    %r12,%rdi
  10c104:	4c 29 e6             	sub    %r12,%rsi
  10c107:	e8 a4 10 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c10c:	48 8b bc 24 60 07 00 	mov    0x760(%rsp),%rdi
  10c113:	00 
  10c114:	48 85 ff             	test   %rdi,%rdi
  10c117:	74 10                	je     10c129 <synreal::SolverNewton::precompute_matrices()+0x7db9>
  10c119:	48 8b b4 24 70 07 00 	mov    0x770(%rsp),%rsi
  10c120:	00 
  10c121:	48 29 fe             	sub    %rdi,%rsi
  10c124:	e8 87 10 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c129:	48 8b bc 24 40 07 00 	mov    0x740(%rsp),%rdi
  10c130:	00 
  10c131:	48 85 ff             	test   %rdi,%rdi
  10c134:	74 10                	je     10c146 <synreal::SolverNewton::precompute_matrices()+0x7dd6>
  10c136:	48 8b b4 24 50 07 00 	mov    0x750(%rsp),%rsi
  10c13d:	00 
  10c13e:	48 29 fe             	sub    %rdi,%rsi
  10c141:	e8 6a 10 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c146:	48 8b bc 24 20 07 00 	mov    0x720(%rsp),%rdi
  10c14d:	00 
  10c14e:	48 85 ff             	test   %rdi,%rdi
  10c151:	74 10                	je     10c163 <synreal::SolverNewton::precompute_matrices()+0x7df3>
  10c153:	48 8b b4 24 30 07 00 	mov    0x730(%rsp),%rsi
  10c15a:	00 
  10c15b:	48 29 fe             	sub    %rdi,%rsi
  10c15e:	e8 4d 10 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c163:	48 8b bc 24 00 07 00 	mov    0x700(%rsp),%rdi
  10c16a:	00 
  10c16b:	48 85 ff             	test   %rdi,%rdi
  10c16e:	74 10                	je     10c180 <synreal::SolverNewton::precompute_matrices()+0x7e10>
  10c170:	48 8b b4 24 10 07 00 	mov    0x710(%rsp),%rsi
  10c177:	00 
  10c178:	48 29 fe             	sub    %rdi,%rsi
  10c17b:	e8 30 10 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c180:	48 8b bc 24 e0 06 00 	mov    0x6e0(%rsp),%rdi
  10c187:	00 
  10c188:	48 85 ff             	test   %rdi,%rdi
  10c18b:	74 10                	je     10c19d <synreal::SolverNewton::precompute_matrices()+0x7e2d>
  10c18d:	48 8b b4 24 f0 06 00 	mov    0x6f0(%rsp),%rsi
  10c194:	00 
  10c195:	48 29 fe             	sub    %rdi,%rsi
  10c198:	e8 13 10 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c19d:	48 8b bc 24 c0 06 00 	mov    0x6c0(%rsp),%rdi
  10c1a4:	00 
  10c1a5:	48 85 ff             	test   %rdi,%rdi
  10c1a8:	74 10                	je     10c1ba <synreal::SolverNewton::precompute_matrices()+0x7e4a>
  10c1aa:	48 8b b4 24 d0 06 00 	mov    0x6d0(%rsp),%rsi
  10c1b1:	00 
  10c1b2:	48 29 fe             	sub    %rdi,%rsi
  10c1b5:	e8 f6 0f f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c1ba:	48 8b bc 24 a0 06 00 	mov    0x6a0(%rsp),%rdi
  10c1c1:	00 
  10c1c2:	48 85 ff             	test   %rdi,%rdi
  10c1c5:	74 10                	je     10c1d7 <synreal::SolverNewton::precompute_matrices()+0x7e67>
  10c1c7:	48 8b b4 24 b0 06 00 	mov    0x6b0(%rsp),%rsi
  10c1ce:	00 
  10c1cf:	48 29 fe             	sub    %rdi,%rsi
  10c1d2:	e8 d9 0f f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c1d7:	48 8b bc 24 80 06 00 	mov    0x680(%rsp),%rdi
  10c1de:	00 
  10c1df:	48 85 ff             	test   %rdi,%rdi
  10c1e2:	74 10                	je     10c1f4 <synreal::SolverNewton::precompute_matrices()+0x7e84>
  10c1e4:	48 8b b4 24 90 06 00 	mov    0x690(%rsp),%rsi
  10c1eb:	00 
  10c1ec:	48 29 fe             	sub    %rdi,%rsi
  10c1ef:	e8 bc 0f f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c1f4:	48 8b bc 24 60 06 00 	mov    0x660(%rsp),%rdi
  10c1fb:	00 
  10c1fc:	48 85 ff             	test   %rdi,%rdi
  10c1ff:	74 10                	je     10c211 <synreal::SolverNewton::precompute_matrices()+0x7ea1>
  10c201:	48 8b b4 24 70 06 00 	mov    0x670(%rsp),%rsi
  10c208:	00 
  10c209:	48 29 fe             	sub    %rdi,%rsi
  10c20c:	e8 9f 0f f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c211:	48 8b bc 24 40 06 00 	mov    0x640(%rsp),%rdi
  10c218:	00 
  10c219:	48 85 ff             	test   %rdi,%rdi
  10c21c:	74 10                	je     10c22e <synreal::SolverNewton::precompute_matrices()+0x7ebe>
  10c21e:	48 8b b4 24 50 06 00 	mov    0x650(%rsp),%rsi
  10c225:	00 
  10c226:	48 29 fe             	sub    %rdi,%rsi
  10c229:	e8 82 0f f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c22e:	48 8b bc 24 20 06 00 	mov    0x620(%rsp),%rdi
  10c235:	00 
  10c236:	48 85 ff             	test   %rdi,%rdi
  10c239:	74 10                	je     10c24b <synreal::SolverNewton::precompute_matrices()+0x7edb>
  10c23b:	48 8b b4 24 30 06 00 	mov    0x630(%rsp),%rsi
  10c242:	00 
  10c243:	48 29 fe             	sub    %rdi,%rsi
  10c246:	e8 65 0f f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c24b:	48 8b bc 24 00 06 00 	mov    0x600(%rsp),%rdi
  10c252:	00 
  10c253:	48 85 ff             	test   %rdi,%rdi
  10c256:	74 10                	je     10c268 <synreal::SolverNewton::precompute_matrices()+0x7ef8>
  10c258:	48 8b b4 24 10 06 00 	mov    0x610(%rsp),%rsi
  10c25f:	00 
  10c260:	48 29 fe             	sub    %rdi,%rsi
  10c263:	e8 48 0f f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c268:	48 8b bc 24 e0 05 00 	mov    0x5e0(%rsp),%rdi
  10c26f:	00 
  10c270:	48 85 ff             	test   %rdi,%rdi
  10c273:	74 10                	je     10c285 <synreal::SolverNewton::precompute_matrices()+0x7f15>
  10c275:	48 8b b4 24 f0 05 00 	mov    0x5f0(%rsp),%rsi
  10c27c:	00 
  10c27d:	48 29 fe             	sub    %rdi,%rsi
  10c280:	e8 2b 0f f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c285:	48 8b bc 24 c0 05 00 	mov    0x5c0(%rsp),%rdi
  10c28c:	00 
  10c28d:	48 85 ff             	test   %rdi,%rdi
  10c290:	74 10                	je     10c2a2 <synreal::SolverNewton::precompute_matrices()+0x7f32>
  10c292:	48 8b b4 24 d0 05 00 	mov    0x5d0(%rsp),%rsi
  10c299:	00 
  10c29a:	48 29 fe             	sub    %rdi,%rsi
  10c29d:	e8 0e 0f f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c2a2:	48 8b bc 24 a0 05 00 	mov    0x5a0(%rsp),%rdi
  10c2a9:	00 
  10c2aa:	48 85 ff             	test   %rdi,%rdi
  10c2ad:	0f 84 1d 94 ff ff    	je     1056d0 <synreal::SolverNewton::precompute_matrices()+0x1360>
  10c2b3:	48 8b b4 24 b0 05 00 	mov    0x5b0(%rsp),%rsi
  10c2ba:	00 
  10c2bb:	48 29 fe             	sub    %rdi,%rsi
  10c2be:	e8 ed 0e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c2c3:	e9 08 94 ff ff       	jmp    1056d0 <synreal::SolverNewton::precompute_matrices()+0x1360>
  10c2c8:	31 ed                	xor    %ebp,%ebp
  10c2ca:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  10c2cf:	49 89 ec             	mov    %rbp,%r12
  10c2d2:	48 83 b8 10 01 00 00 	cmpq   $0x0,0x110(%rax)
  10c2d9:	00 
  10c2da:	0f 84 3c 02 00 00    	je     10c51c <synreal::SolverNewton::precompute_matrices()+0x81ac>
  10c2e0:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  10c2e5:	48 8d bc 24 80 07 00 	lea    0x780(%rsp),%rdi
  10c2ec:	00 
  10c2ed:	4c 8d 05 b7 e8 0d 00 	lea    0xde8b7(%rip),%r8        # 1eabab <_fini+0x5467>
  10c2f4:	48 89 d9             	mov    %rbx,%rcx
  10c2f7:	48 8b b0 08 01 00 00 	mov    0x108(%rax),%rsi
  10c2fe:	48 8b 90 10 01 00 00 	mov    0x110(%rax),%rdx
  10c305:	e8 26 15 f6 ff       	call   6d830 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  10c30a:	48 8b 84 24 80 07 00 	mov    0x780(%rsp),%rax
  10c311:	00 
  10c312:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10c316:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  10c31b:	48 8b 84 24 88 07 00 	mov    0x788(%rsp),%rax
  10c322:	00 
  10c323:	0f 29 84 24 80 07 00 	movaps %xmm0,0x780(%rsp)
  10c32a:	00 
  10c32b:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
  10c330:	48 8b 84 24 90 07 00 	mov    0x790(%rsp),%rax
  10c337:	00 
  10c338:	48 c7 84 24 90 07 00 	movq   $0x0,0x790(%rsp)
  10c33f:	00 00 00 00 00 
  10c344:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  10c349:	48 85 ed             	test   %rbp,%rbp
  10c34c:	74 2b                	je     10c379 <synreal::SolverNewton::precompute_matrices()+0x8009>
  10c34e:	4c 89 e6             	mov    %r12,%rsi
  10c351:	48 89 ef             	mov    %rbp,%rdi
  10c354:	48 29 ee             	sub    %rbp,%rsi
  10c357:	e8 54 0e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c35c:	48 8b bc 24 80 07 00 	mov    0x780(%rsp),%rdi
  10c363:	00 
  10c364:	48 8b b4 24 90 07 00 	mov    0x790(%rsp),%rsi
  10c36b:	00 
  10c36c:	48 29 fe             	sub    %rdi,%rsi
  10c36f:	48 85 ff             	test   %rdi,%rdi
  10c372:	74 05                	je     10c379 <synreal::SolverNewton::precompute_matrices()+0x8009>
  10c374:	e8 37 0e f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10c379:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
  10c37e:	48 8b 7c 24 78       	mov    0x78(%rsp),%rdi
  10c383:	4c 8d bc 24 88 07 00 	lea    0x788(%rsp),%r15
  10c38a:	00 
  10c38b:	c7 84 24 88 07 00 00 	movl   $0x0,0x788(%rsp)
  10c392:	00 00 00 00 
  10c396:	48 c7 84 24 90 07 00 	movq   $0x0,0x790(%rsp)
  10c39d:	00 00 00 00 00 
  10c3a2:	4c 89 bc 24 98 07 00 	mov    %r15,0x798(%rsp)
  10c3a9:	00 
  10c3aa:	4c 89 bc 24 a0 07 00 	mov    %r15,0x7a0(%rsp)
  10c3b1:	00 
  10c3b2:	48 c7 84 24 a8 07 00 	movq   $0x0,0x7a8(%rsp)
  10c3b9:	00 00 00 00 00 
  10c3be:	48 39 f8             	cmp    %rdi,%rax
  10c3c1:	0f 84 b0 02 00 00    	je     10c677 <synreal::SolverNewton::precompute_matrices()+0x8307>
  10c3c7:	48 89 c5             	mov    %rax,%rbp
  10c3ca:	e9 19 ad ff ff       	jmp    1070e8 <synreal::SolverNewton::precompute_matrices()+0x2d78>
  10c3cf:	31 ff                	xor    %edi,%edi
  10c3d1:	3b 4a 20             	cmp    0x20(%rdx),%ecx
  10c3d4:	40 0f 9c c7          	setl   %dil
  10c3d8:	e9 e4 ad ff ff       	jmp    1071c1 <synreal::SolverNewton::precompute_matrices()+0x2e51>
  10c3dd:	48 89 bc 24 68 02 00 	mov    %rdi,0x268(%rsp)
  10c3e4:	00 
  10c3e5:	e9 f8 8b ff ff       	jmp    104fe2 <synreal::SolverNewton::precompute_matrices()+0xc72>
  10c3ea:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  10c3ef:	48 c7 84 24 20 07 00 	movq   $0x0,0x720(%rsp)
  10c3f6:	00 00 00 00 00 
  10c3fb:	48 c7 84 24 30 07 00 	movq   $0x0,0x730(%rsp)
  10c402:	00 00 00 00 00 
  10c407:	48 83 b8 a8 06 00 00 	cmpq   $0x0,0x6a8(%rax)
  10c40e:	00 
  10c40f:	48 c7 84 24 28 07 00 	movq   $0x0,0x728(%rsp)
  10c416:	00 00 00 00 00 
  10c41b:	75 78                	jne    10c495 <synreal::SolverNewton::precompute_matrices()+0x8125>
  10c41d:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  10c422:	48 c7 84 24 40 07 00 	movq   $0x0,0x740(%rsp)
  10c429:	00 00 00 00 00 
  10c42e:	48 c7 84 24 50 07 00 	movq   $0x0,0x750(%rsp)
  10c435:	00 00 00 00 00 
  10c43a:	48 83 b8 98 06 00 00 	cmpq   $0x0,0x698(%rax)
  10c441:	00 
  10c442:	48 c7 84 24 48 07 00 	movq   $0x0,0x748(%rsp)
  10c449:	00 00 00 00 00 
  10c44e:	0f 84 a9 00 00 00    	je     10c4fd <synreal::SolverNewton::precompute_matrices()+0x818d>
  10c454:	31 c9                	xor    %ecx,%ecx
  10c456:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  10c45b:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  10c462:	00 
  10c463:	4c 8d 05 88 ee 0d 00 	lea    0xdee88(%rip),%r8        # 1eb2f2 <_fini+0x5bae>
  10c46a:	4c 89 f7             	mov    %r14,%rdi
  10c46d:	48 8b b0 90 06 00 00 	mov    0x690(%rax),%rsi
  10c474:	48 8b 90 98 06 00 00 	mov    0x698(%rax),%rdx
  10c47b:	e8 b0 13 f6 ff       	call   6d830 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  10c480:	e9 54 d3 ff ff       	jmp    1097d9 <synreal::SolverNewton::precompute_matrices()+0x5469>
  10c485:	4c 89 c6             	mov    %r8,%rsi
  10c488:	e9 e1 c4 ff ff       	jmp    10896e <synreal::SolverNewton::precompute_matrices()+0x45fe>
  10c48d:	4c 89 c6             	mov    %r8,%rsi
  10c490:	e9 82 c5 ff ff       	jmp    108a17 <synreal::SolverNewton::precompute_matrices()+0x46a7>
  10c495:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
  10c49a:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  10c4a1:	00 
  10c4a2:	4c 8d 05 5c ee 0d 00 	lea    0xdee5c(%rip),%r8        # 1eb305 <_fini+0x5bc1>
  10c4a9:	4c 89 ef             	mov    %r13,%rdi
  10c4ac:	49 8b b6 a0 06 00 00 	mov    0x6a0(%r14),%rsi
  10c4b3:	49 8b 96 a8 06 00 00 	mov    0x6a8(%r14),%rdx
  10c4ba:	e8 01 18 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10c4bf:	41 8b 8e d8 05 00 00 	mov    0x5d8(%r14),%ecx
  10c4c6:	e9 35 d2 ff ff       	jmp    109700 <synreal::SolverNewton::precompute_matrices()+0x5390>
  10c4cb:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10c4d0:	45 31 c9             	xor    %r9d,%r9d
  10c4d3:	45 31 e4             	xor    %r12d,%r12d
  10c4d6:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  10c4db:	e9 de f2 ff ff       	jmp    10b7be <synreal::SolverNewton::precompute_matrices()+0x744e>
  10c4e0:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
  10c4e5:	48 89 d9             	mov    %rbx,%rcx
  10c4e8:	e9 7a 83 ff ff       	jmp    104867 <synreal::SolverNewton::precompute_matrices()+0x4f7>
  10c4ed:	4c 89 c6             	mov    %r8,%rsi
  10c4f0:	e9 e8 95 ff ff       	jmp    105add <synreal::SolverNewton::precompute_matrices()+0x176d>
  10c4f5:	4c 89 c6             	mov    %r8,%rsi
  10c4f8:	e9 9f 96 ff ff       	jmp    105b9c <synreal::SolverNewton::precompute_matrices()+0x182c>
  10c4fd:	48 c7 84 24 60 07 00 	movq   $0x0,0x760(%rsp)
  10c504:	00 00 00 00 00 
  10c509:	31 ff                	xor    %edi,%edi
  10c50b:	48 c7 84 24 70 07 00 	movq   $0x0,0x770(%rsp)
  10c512:	00 00 00 00 00 
  10c517:	e9 b5 d2 ff ff       	jmp    1097d1 <synreal::SolverNewton::precompute_matrices()+0x5461>
  10c51c:	48 8d 84 24 88 07 00 	lea    0x788(%rsp),%rax
  10c523:	00 
  10c524:	c7 84 24 88 07 00 00 	movl   $0x0,0x788(%rsp)
  10c52b:	00 00 00 00 
  10c52f:	41 bf 01 00 00 00    	mov    $0x1,%r15d
  10c535:	48 c7 84 24 90 07 00 	movq   $0x0,0x790(%rsp)
  10c53c:	00 00 00 00 00 
  10c541:	48 89 84 24 98 07 00 	mov    %rax,0x798(%rsp)
  10c548:	00 
  10c549:	48 89 84 24 a0 07 00 	mov    %rax,0x7a0(%rsp)
  10c550:	00 
  10c551:	48 c7 84 24 a8 07 00 	movq   $0x0,0x7a8(%rsp)
  10c558:	00 00 00 00 00 
  10c55d:	48 89 6c 24 60       	mov    %rbp,0x60(%rsp)
  10c562:	e9 bd f1 ff ff       	jmp    10b724 <synreal::SolverNewton::precompute_matrices()+0x73b4>
  10c567:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
  10c56c:	e9 6f fd ff ff       	jmp    10c2e0 <synreal::SolverNewton::precompute_matrices()+0x7f70>
  10c571:	e8 4a 10 f6 ff       	call   6d5c0 <__stack_chk_fail@plt>
  10c576:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10c57d:	00 00 00 
  10c580:	31 c0                	xor    %eax,%eax
  10c582:	e9 5d a5 ff ff       	jmp    106ae4 <synreal::SolverNewton::precompute_matrices()+0x2774>
  10c587:	31 c0                	xor    %eax,%eax
  10c589:	e9 91 a4 ff ff       	jmp    106a1f <synreal::SolverNewton::precompute_matrices()+0x26af>
  10c58e:	48 89 ef             	mov    %rbp,%rdi
  10c591:	48 89 c2             	mov    %rax,%rdx
  10c594:	e9 f6 a0 ff ff       	jmp    10668f <synreal::SolverNewton::precompute_matrices()+0x231f>
  10c599:	48 c7 84 24 60 07 00 	movq   $0x0,0x760(%rsp)
  10c5a0:	00 00 00 00 00 
  10c5a5:	31 c0                	xor    %eax,%eax
  10c5a7:	31 f6                	xor    %esi,%esi
  10c5a9:	48 c7 84 24 70 07 00 	movq   $0x0,0x770(%rsp)
  10c5b0:	00 00 00 00 00 
  10c5b5:	e9 f6 a0 ff ff       	jmp    1066b0 <synreal::SolverNewton::precompute_matrices()+0x2340>
  10c5ba:	48 8d 3d 6f 06 0e 00 	lea    0xe066f(%rip),%rdi        # 1ecc30 <_fini+0x74ec>
  10c5c1:	e8 aa fa f5 ff       	call   6c070 <std::__throw_length_error(char const*)@plt>
  10c5c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10c5cd:	00 00 00 
  10c5d0:	48 89 ee             	mov    %rbp,%rsi
  10c5d3:	4c 89 e0             	mov    %r12,%rax
  10c5d6:	e9 b7 9f ff ff       	jmp    106592 <synreal::SolverNewton::precompute_matrices()+0x2222>
  10c5db:	48 c7 84 24 40 07 00 	movq   $0x0,0x740(%rsp)
  10c5e2:	00 00 00 00 00 
  10c5e7:	45 31 e4             	xor    %r12d,%r12d
  10c5ea:	31 c9                	xor    %ecx,%ecx
  10c5ec:	48 c7 84 24 50 07 00 	movq   $0x0,0x750(%rsp)
  10c5f3:	00 00 00 00 00 
  10c5f8:	e9 b6 9f ff ff       	jmp    1065b3 <synreal::SolverNewton::precompute_matrices()+0x2243>
  10c5fd:	48 8d 3d 2c 06 0e 00 	lea    0xe062c(%rip),%rdi        # 1ecc30 <_fini+0x74ec>
  10c604:	e8 67 fa f5 ff       	call   6c070 <std::__throw_length_error(char const*)@plt>
  10c609:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10c610:	48 89 ac 24 d8 01 00 	mov    %rbp,0x1d8(%rsp)
  10c617:	00 
  10c618:	e9 9e 9e ff ff       	jmp    1064bb <synreal::SolverNewton::precompute_matrices()+0x214b>
  10c61d:	48 89 8c 24 e0 01 00 	mov    %rcx,0x1e0(%rsp)
  10c624:	00 
  10c625:	e9 45 9e ff ff       	jmp    10646f <synreal::SolverNewton::precompute_matrices()+0x20ff>
  10c62a:	48 89 8c 24 a0 01 00 	mov    %rcx,0x1a0(%rsp)
  10c631:	00 
  10c632:	e9 eb 9d ff ff       	jmp    106422 <synreal::SolverNewton::precompute_matrices()+0x20b2>
  10c637:	48 89 8c 24 f8 01 00 	mov    %rcx,0x1f8(%rsp)
  10c63e:	00 
  10c63f:	e9 91 9d ff ff       	jmp    1063d5 <synreal::SolverNewton::precompute_matrices()+0x2065>
  10c644:	48 89 8c 24 88 01 00 	mov    %rcx,0x188(%rsp)
  10c64b:	00 
  10c64c:	e9 37 9d ff ff       	jmp    106388 <synreal::SolverNewton::precompute_matrices()+0x2018>
  10c651:	48 89 bc 24 80 01 00 	mov    %rdi,0x180(%rsp)
  10c658:	00 
  10c659:	e9 dd 9c ff ff       	jmp    10633b <synreal::SolverNewton::precompute_matrices()+0x1fcb>
  10c65e:	48 89 8c 24 f0 01 00 	mov    %rcx,0x1f0(%rsp)
  10c665:	00 
  10c666:	e9 83 9c ff ff       	jmp    1062ee <synreal::SolverNewton::precompute_matrices()+0x1f7e>
  10c66b:	48 8d 3d be 05 0e 00 	lea    0xe05be(%rip),%rdi        # 1ecc30 <_fini+0x74ec>
  10c672:	e8 f9 f9 f5 ff       	call   6c070 <std::__throw_length_error(char const*)@plt>
  10c677:	48 8b 6c 24 68       	mov    0x68(%rsp),%rbp
  10c67c:	41 bf 01 00 00 00    	mov    $0x1,%r15d
  10c682:	e9 9d f0 ff ff       	jmp    10b724 <synreal::SolverNewton::precompute_matrices()+0x73b4>
  10c687:	f3 0f 1e fa          	endbr64 
  10c68b:	48 89 c5             	mov    %rax,%rbp
  10c68e:	e9 0f ae f6 ff       	jmp    774a2 <synreal::SolverNewton::precompute_matrices() [clone .cold]>
  10c693:	f3 0f 1e fa          	endbr64 
  10c697:	48 89 c3             	mov    %rax,%rbx
  10c69a:	e9 6e ae f6 ff       	jmp    7750d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x6b>
  10c69f:	f3 0f 1e fa          	endbr64 
  10c6a3:	48 89 c3             	mov    %rax,%rbx
  10c6a6:	e9 bd b3 f6 ff       	jmp    77a68 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x5c6>
  10c6ab:	f3 0f 1e fa          	endbr64 
  10c6af:	48 89 c3             	mov    %rax,%rbx
  10c6b2:	e9 19 b6 f6 ff       	jmp    77cd0 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x82e>
  10c6b7:	f3 0f 1e fa          	endbr64 
  10c6bb:	48 89 c3             	mov    %rax,%rbx
  10c6be:	e9 01 b5 f6 ff       	jmp    77bc4 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x722>
  10c6c3:	e9 29 b6 f6 ff       	jmp    77cf1 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x84f>
  10c6c8:	f3 0f 1e fa          	endbr64 
  10c6cc:	48 89 c3             	mov    %rax,%rbx
  10c6cf:	e9 95 b6 f6 ff       	jmp    77d69 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x8c7>
  10c6d4:	e9 5e b6 f6 ff       	jmp    77d37 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x895>
  10c6d9:	e9 f6 b7 f6 ff       	jmp    77ed4 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xa32>
  10c6de:	e9 bf b7 f6 ff       	jmp    77ea2 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xa00>
  10c6e3:	e9 30 b8 f6 ff       	jmp    77f18 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xa76>
  10c6e8:	e9 8f b8 f6 ff       	jmp    77f7c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xada>
  10c6ed:	e9 d7 b8 f6 ff       	jmp    77fc9 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xb27>
  10c6f2:	e9 26 ba f6 ff       	jmp    7811d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc7b>
  10c6f7:	f3 0f 1e fa          	endbr64 
  10c6fb:	48 89 c3             	mov    %rax,%rbx
  10c6fe:	e9 1c b9 f6 ff       	jmp    7801f <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xb7d>
  10c703:	f3 0f 1e fa          	endbr64 
  10c707:	48 89 c3             	mov    %rax,%rbx
  10c70a:	e9 2d b9 f6 ff       	jmp    7803c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xb9a>
  10c70f:	f3 0f 1e fa          	endbr64 
  10c713:	48 89 c3             	mov    %rax,%rbx
  10c716:	e9 3e b9 f6 ff       	jmp    78059 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xbb7>
  10c71b:	e9 fd b9 f6 ff       	jmp    7811d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc7b>
  10c720:	f3 0f 1e fa          	endbr64 
  10c724:	48 89 c3             	mov    %rax,%rbx
  10c727:	e9 84 b9 f6 ff       	jmp    780b0 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc0e>
  10c72c:	f3 0f 1e fa          	endbr64 
  10c730:	48 89 c3             	mov    %rax,%rbx
  10c733:	e9 3e b9 f6 ff       	jmp    78076 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xbd4>
  10c738:	f3 0f 1e fa          	endbr64 
  10c73c:	48 89 c3             	mov    %rax,%rbx
  10c73f:	e9 4f b9 f6 ff       	jmp    78093 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xbf1>
  10c744:	f3 0f 1e fa          	endbr64 
  10c748:	48 89 c3             	mov    %rax,%rbx
  10c74b:	e9 6c ba f6 ff       	jmp    781bc <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xd1a>
  10c750:	f3 0f 1e fa          	endbr64 
  10c754:	48 89 c5             	mov    %rax,%rbp
  10c757:	e9 26 ae f6 ff       	jmp    77582 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xe0>
  10c75c:	f3 0f 1e fa          	endbr64 
  10c760:	48 89 c5             	mov    %rax,%rbp
  10c763:	e9 37 ae f6 ff       	jmp    7759f <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xfd>
  10c768:	f3 0f 1e fa          	endbr64 
  10c76c:	48 89 c5             	mov    %rax,%rbp
  10c76f:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  10c776:	00 
  10c777:	e9 e1 ad f6 ff       	jmp    7755d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xbb>
  10c77c:	f3 0f 1e fa          	endbr64 
  10c780:	48 89 c5             	mov    %rax,%rbp
  10c783:	e9 dd ad f6 ff       	jmp    77565 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xc3>
  10c788:	f3 0f 1e fa          	endbr64 
  10c78c:	48 89 c5             	mov    %rax,%rbp
  10c78f:	e9 62 ae f6 ff       	jmp    775f6 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x154>
  10c794:	f3 0f 1e fa          	endbr64 
  10c798:	48 89 c5             	mov    %rax,%rbp
  10c79b:	e9 73 ae f6 ff       	jmp    77613 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x171>
  10c7a0:	f3 0f 1e fa          	endbr64 
  10c7a4:	48 89 c5             	mov    %rax,%rbp
  10c7a7:	e9 10 ae f6 ff       	jmp    775bc <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x11a>
  10c7ac:	f3 0f 1e fa          	endbr64 
  10c7b0:	48 89 c5             	mov    %rax,%rbp
  10c7b3:	e9 21 ae f6 ff       	jmp    775d9 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x137>
  10c7b8:	f3 0f 1e fa          	endbr64 
  10c7bc:	e9 52 ba f6 ff       	jmp    78213 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xd71>
  10c7c1:	f3 0f 1e fa          	endbr64 
  10c7c5:	48 89 c3             	mov    %rax,%rbx
  10c7c8:	e9 e3 ba f6 ff       	jmp    782b0 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xe0e>
  10c7cd:	f3 0f 1e fa          	endbr64 
  10c7d1:	e9 ff ba f6 ff       	jmp    782d5 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xe33>
  10c7d6:	f3 0f 1e fa          	endbr64 
  10c7da:	48 89 c3             	mov    %rax,%rbx
  10c7dd:	e9 94 ba f6 ff       	jmp    78276 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xdd4>
  10c7e2:	f3 0f 1e fa          	endbr64 
  10c7e6:	48 89 c3             	mov    %rax,%rbx
  10c7e9:	e9 a5 ba f6 ff       	jmp    78293 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xdf1>
  10c7ee:	f3 0f 1e fa          	endbr64 
  10c7f2:	e9 94 b9 f6 ff       	jmp    7818b <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xce9>
  10c7f7:	f3 0f 1e fa          	endbr64 
  10c7fb:	e9 86 bb f6 ff       	jmp    78386 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xee4>
  10c800:	e9 89 bb f6 ff       	jmp    7838e <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xeec>
  10c805:	e9 29 bc f6 ff       	jmp    78433 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xf91>
  10c80a:	e9 91 bc f6 ff       	jmp    784a0 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xffe>
  10c80f:	f3 0f 1e fa          	endbr64 
  10c813:	48 89 c3             	mov    %rax,%rbx
  10c816:	e9 41 bd f6 ff       	jmp    7855c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x10ba>
  10c81b:	f3 0f 1e fa          	endbr64 
  10c81f:	48 89 c3             	mov    %rax,%rbx
  10c822:	e9 d7 bc f6 ff       	jmp    784fe <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x105c>
  10c827:	f3 0f 1e fa          	endbr64 
  10c82b:	48 89 c3             	mov    %rax,%rbx
  10c82e:	e9 df bb f6 ff       	jmp    78412 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xf70>
  10c833:	e9 48 bd f6 ff       	jmp    78580 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x10de>
  10c838:	f3 0f 1e fa          	endbr64 
  10c83c:	48 89 c3             	mov    %rax,%rbx
  10c83f:	e9 db ac f6 ff       	jmp    7751f <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x7d>
  10c844:	f3 0f 1e fa          	endbr64 
  10c848:	48 89 c3             	mov    %rax,%rbx
  10c84b:	e9 64 ae f6 ff       	jmp    776b4 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x212>
  10c850:	f3 0f 1e fa          	endbr64 
  10c854:	48 89 c3             	mov    %rax,%rbx
  10c857:	e9 5f bd f6 ff       	jmp    785bb <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1119>
  10c85c:	f3 0f 1e fa          	endbr64 
  10c860:	48 89 c3             	mov    %rax,%rbx
  10c863:	e9 5b bd f6 ff       	jmp    785c3 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1121>
  10c868:	f3 0f 1e fa          	endbr64 
  10c86c:	48 89 c3             	mov    %rax,%rbx
  10c86f:	e9 48 b9 f6 ff       	jmp    781bc <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xd1a>
  10c874:	f3 0f 1e fa          	endbr64 
  10c878:	e9 84 bd f6 ff       	jmp    78601 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x115f>
  10c87d:	f3 0f 1e fa          	endbr64 
  10c881:	48 89 c3             	mov    %rax,%rbx
  10c884:	e9 0b ae f6 ff       	jmp    77694 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1f2>
  10c889:	f3 0f 1e fa          	endbr64 
  10c88d:	48 89 c3             	mov    %rax,%rbx
  10c890:	e9 88 bd f6 ff       	jmp    7861d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x117b>
  10c895:	f3 0f 1e fa          	endbr64 
  10c899:	48 89 c3             	mov    %rax,%rbx
  10c89c:	e9 84 bd f6 ff       	jmp    78625 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1183>
  10c8a1:	f3 0f 1e fa          	endbr64 
  10c8a5:	48 89 c3             	mov    %rax,%rbx
  10c8a8:	e9 bb ae f6 ff       	jmp    77768 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x2c6>
  10c8ad:	f3 0f 1e fa          	endbr64 
  10c8b1:	48 89 c3             	mov    %rax,%rbx
  10c8b4:	e9 7c bd f6 ff       	jmp    78635 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1193>
  10c8b9:	f3 0f 1e fa          	endbr64 
  10c8bd:	48 89 c3             	mov    %rax,%rbx
  10c8c0:	e9 68 bd f6 ff       	jmp    7862d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x118b>
  10c8c5:	f3 0f 1e fa          	endbr64 
  10c8c9:	48 89 c3             	mov    %rax,%rbx
  10c8cc:	e9 6c bd f6 ff       	jmp    7863d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x119b>
  10c8d1:	f3 0f 1e fa          	endbr64 
  10c8d5:	48 89 c3             	mov    %rax,%rbx
  10c8d8:	e9 f5 ae f6 ff       	jmp    777d2 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x330>
  10c8dd:	f3 0f 1e fa          	endbr64 
  10c8e1:	48 89 c3             	mov    %rax,%rbx
  10c8e4:	e9 2e af f6 ff       	jmp    77817 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x375>
  10c8e9:	f3 0f 1e fa          	endbr64 
  10c8ed:	48 89 c3             	mov    %rax,%rbx
  10c8f0:	e9 50 bd f6 ff       	jmp    78645 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x11a3>
  10c8f5:	f3 0f 1e fa          	endbr64 
  10c8f9:	48 89 c3             	mov    %rax,%rbx
  10c8fc:	e9 5c bd f6 ff       	jmp    7865d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x11bb>
  10c901:	f3 0f 1e fa          	endbr64 
  10c905:	48 89 c3             	mov    %rax,%rbx
  10c908:	e9 5a bd f6 ff       	jmp    78667 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x11c5>
  10c90d:	f3 0f 1e fa          	endbr64 
  10c911:	48 89 c3             	mov    %rax,%rbx
  10c914:	e9 58 bd f6 ff       	jmp    78671 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x11cf>
  10c919:	f3 0f 1e fa          	endbr64 
  10c91d:	48 89 c3             	mov    %rax,%rbx
  10c920:	e9 70 b0 f6 ff       	jmp    77995 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x4f3>
  10c925:	f3 0f 1e fa          	endbr64 
  10c929:	48 89 c3             	mov    %rax,%rbx
  10c92c:	e9 58 bd f6 ff       	jmp    78689 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x11e7>
  10c931:	f3 0f 1e fa          	endbr64 
  10c935:	48 89 c3             	mov    %rax,%rbx
  10c938:	e9 64 bd f6 ff       	jmp    786a1 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x11ff>
  10c93d:	f3 0f 1e fa          	endbr64 
  10c941:	48 89 c3             	mov    %rax,%rbx
  10c944:	e9 7f af f6 ff       	jmp    778c8 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x426>
  10c949:	f3 0f 1e fa          	endbr64 
  10c94d:	48 89 c3             	mov    %rax,%rbx
  10c950:	e9 66 af f6 ff       	jmp    778bb <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x419>
  10c955:	f3 0f 1e fa          	endbr64 
  10c959:	48 89 c3             	mov    %rax,%rbx
  10c95c:	e9 4d af f6 ff       	jmp    778ae <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x40c>
  10c961:	f3 0f 1e fa          	endbr64 
  10c965:	48 89 c3             	mov    %rax,%rbx
  10c968:	e9 34 af f6 ff       	jmp    778a1 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x3ff>
  10c96d:	f3 0f 1e fa          	endbr64 
  10c971:	48 89 c3             	mov    %rax,%rbx
  10c974:	e9 1b af f6 ff       	jmp    77894 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x3f2>
  10c979:	f3 0f 1e fa          	endbr64 
  10c97d:	48 89 c3             	mov    %rax,%rbx
  10c980:	e9 f5 ae f6 ff       	jmp    7787a <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x3d8>
  10c985:	f3 0f 1e fa          	endbr64 
  10c989:	48 89 c3             	mov    %rax,%rbx
  10c98c:	e9 dc ae f6 ff       	jmp    7786d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x3cb>
  10c991:	f3 0f 1e fa          	endbr64 
  10c995:	48 89 c3             	mov    %rax,%rbx
  10c998:	e9 ea ae f6 ff       	jmp    77887 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x3e5>
  10c99d:	f3 0f 1e fa          	endbr64 
  10c9a1:	48 89 c3             	mov    %rax,%rbx
  10c9a4:	e9 1a b0 f6 ff       	jmp    779c3 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x521>
  10c9a9:	f3 0f 1e fa          	endbr64 
  10c9ad:	48 89 c3             	mov    %rax,%rbx
  10c9b0:	e9 43 ab f6 ff       	jmp    774f8 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x56>
  10c9b5:	f3 0f 1e fa          	endbr64 
  10c9b9:	48 89 c3             	mov    %rax,%rbx
  10c9bc:	e9 92 ae f6 ff       	jmp    77853 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x3b1>
  10c9c1:	f3 0f 1e fa          	endbr64 
  10c9c5:	48 89 c3             	mov    %rax,%rbx
  10c9c8:	e9 4b bd f6 ff       	jmp    78718 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1276>
  10c9cd:	f3 0f 1e fa          	endbr64 
  10c9d1:	48 89 c3             	mov    %rax,%rbx
  10c9d4:	e9 c9 b0 f6 ff       	jmp    77aa2 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x600>
  10c9d9:	f3 0f 1e fa          	endbr64 
  10c9dd:	48 89 c3             	mov    %rax,%rbx
  10c9e0:	e9 da b0 f6 ff       	jmp    77abf <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x61d>
  10c9e5:	f3 0f 1e fa          	endbr64 
  10c9e9:	48 89 c3             	mov    %rax,%rbx
  10c9ec:	e9 88 b2 f6 ff       	jmp    77c79 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x7d7>
  10c9f1:	f3 0f 1e fa          	endbr64 
  10c9f5:	48 89 c3             	mov    %rax,%rbx
  10c9f8:	e9 99 b2 f6 ff       	jmp    77c96 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x7f4>
  10c9fd:	f3 0f 1e fa          	endbr64 
  10ca01:	48 89 c3             	mov    %rax,%rbx
  10ca04:	e9 aa b2 f6 ff       	jmp    77cb3 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x811>
  10ca09:	f3 0f 1e fa          	endbr64 
  10ca0d:	48 89 c3             	mov    %rax,%rbx
  10ca10:	e9 bb b2 f6 ff       	jmp    77cd0 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x82e>
  10ca15:	f3 0f 1e fa          	endbr64 
  10ca19:	48 89 c3             	mov    %rax,%rbx
  10ca1c:	e9 bb b0 f6 ff       	jmp    77adc <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x63a>
  10ca21:	f3 0f 1e fa          	endbr64 
  10ca25:	48 89 c3             	mov    %rax,%rbx
  10ca28:	e9 cc b0 f6 ff       	jmp    77af9 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x657>
  10ca2d:	f3 0f 1e fa          	endbr64 
  10ca31:	48 89 c3             	mov    %rax,%rbx
  10ca34:	e9 dd b0 f6 ff       	jmp    77b16 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x674>
  10ca39:	f3 0f 1e fa          	endbr64 
  10ca3d:	48 89 c3             	mov    %rax,%rbx
  10ca40:	e9 ee b0 f6 ff       	jmp    77b33 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x691>
  10ca45:	f3 0f 1e fa          	endbr64 
  10ca49:	48 89 c3             	mov    %rax,%rbx
  10ca4c:	e9 ff b0 f6 ff       	jmp    77b50 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x6ae>
  10ca51:	f3 0f 1e fa          	endbr64 
  10ca55:	48 89 c3             	mov    %rax,%rbx
  10ca58:	e9 10 b1 f6 ff       	jmp    77b6d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x6cb>
  10ca5d:	f3 0f 1e fa          	endbr64 
  10ca61:	48 89 c3             	mov    %rax,%rbx
  10ca64:	e9 21 b1 f6 ff       	jmp    77b8a <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x6e8>
  10ca69:	f3 0f 1e fa          	endbr64 
  10ca6d:	48 89 c3             	mov    %rax,%rbx
  10ca70:	e9 32 b1 f6 ff       	jmp    77ba7 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x705>
  10ca75:	e9 eb bc f6 ff       	jmp    78765 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x12c3>
  10ca7a:	f3 0f 1e fa          	endbr64 
  10ca7e:	48 89 c3             	mov    %rax,%rbx
  10ca81:	e9 9c b1 f6 ff       	jmp    77c22 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x780>
  10ca86:	f3 0f 1e fa          	endbr64 
  10ca8a:	48 89 c3             	mov    %rax,%rbx
  10ca8d:	e9 ad b1 f6 ff       	jmp    77c3f <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x79d>
  10ca92:	f3 0f 1e fa          	endbr64 
  10ca96:	48 89 c3             	mov    %rax,%rbx
  10ca99:	e9 be b1 f6 ff       	jmp    77c5c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x7ba>
  10ca9e:	f3 0f 1e fa          	endbr64 
  10caa2:	e9 1d b9 f6 ff       	jmp    783c4 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xf22>
  10caa7:	f3 0f 1e fa          	endbr64 
  10caab:	48 89 c3             	mov    %rax,%rbx
  10caae:	e9 42 b9 f6 ff       	jmp    783f5 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xf53>
  10cab3:	f3 0f 1e fa          	endbr64 
  10cab7:	48 89 c3             	mov    %rax,%rbx
  10caba:	e9 53 b9 f6 ff       	jmp    78412 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xf70>
  10cabf:	e9 c8 bd f6 ff       	jmp    7888c <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x13ea>
  10cac4:	e9 e2 bb f6 ff       	jmp    786ab <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1209>
  10cac9:	e9 0a af f6 ff       	jmp    779d8 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x536>
  10cace:	e9 97 b3 f6 ff       	jmp    77e6a <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x9c8>
  10cad3:	e9 ef bd f6 ff       	jmp    788c7 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1425>
  10cad8:	e9 60 be f6 ff       	jmp    7893d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x149b>
  10cadd:	f3 0f 1e fa          	endbr64 
  10cae1:	48 89 c3             	mov    %rax,%rbx
  10cae4:	e9 aa b2 f6 ff       	jmp    77d93 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x8f1>
  10cae9:	f3 0f 1e fa          	endbr64 
  10caed:	48 89 c3             	mov    %rax,%rbx
  10caf0:	e9 bb b2 f6 ff       	jmp    77db0 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x90e>
  10caf5:	f3 0f 1e fa          	endbr64 
  10caf9:	48 89 c3             	mov    %rax,%rbx
  10cafc:	e9 cc b2 f6 ff       	jmp    77dcd <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x92b>
  10cb01:	f3 0f 1e fa          	endbr64 
  10cb05:	48 89 c3             	mov    %rax,%rbx
  10cb08:	e9 dd b2 f6 ff       	jmp    77dea <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x948>
  10cb0d:	f3 0f 1e fa          	endbr64 
  10cb11:	48 89 c3             	mov    %rax,%rbx
  10cb14:	e9 ee b2 f6 ff       	jmp    77e07 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x965>
  10cb19:	f3 0f 1e fa          	endbr64 
  10cb1d:	48 89 c3             	mov    %rax,%rbx
  10cb20:	e9 ff b2 f6 ff       	jmp    77e24 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x982>
  10cb25:	e9 13 be f6 ff       	jmp    7893d <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x149b>
  10cb2a:	f3 0f 1e fa          	endbr64 
  10cb2e:	48 89 c3             	mov    %rax,%rbx
  10cb31:	e9 2a ad f6 ff       	jmp    77860 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x3be>
  10cb36:	f3 0f 1e fa          	endbr64 
  10cb3a:	48 89 c3             	mov    %rax,%rbx
  10cb3d:	e9 f0 a9 f6 ff       	jmp    77532 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x90>
  10cb42:	e9 31 be f6 ff       	jmp    78978 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x14d6>
  10cb47:	f3 0f 1e fa          	endbr64 
  10cb4b:	48 89 c3             	mov    %rax,%rbx
  10cb4e:	e9 32 af f6 ff       	jmp    77a85 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x5e3>
  10cb53:	f3 0f 1e fa          	endbr64 
  10cb57:	48 89 c3             	mov    %rax,%rbx
  10cb5a:	4c 8d b4 24 60 07 00 	lea    0x760(%rsp),%r14
  10cb61:	00 
  10cb62:	4c 8d ac 24 40 07 00 	lea    0x740(%rsp),%r13
  10cb69:	00 
  10cb6a:	e9 e3 a9 f6 ff       	jmp    77552 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xb0>
  10cb6f:	f3 0f 1e fa          	endbr64 
  10cb73:	48 89 c5             	mov    %rax,%rbp
  10cb76:	e9 39 a9 f6 ff       	jmp    774b4 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x12>
  10cb7b:	f3 0f 1e fa          	endbr64 
  10cb7f:	48 89 c3             	mov    %rax,%rbx
  10cb82:	e9 29 b7 f6 ff       	jmp    782b0 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0xe0e>
  10cb87:	f3 0f 1e fa          	endbr64 
  10cb8b:	48 89 c3             	mov    %rax,%rbx
  10cb8e:	e9 96 be f6 ff       	jmp    78a29 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x1587>
  10cb93:	f3 0f 1e fa          	endbr64 
  10cb97:	48 89 c3             	mov    %rax,%rbx
  10cb9a:	e9 a7 be f6 ff       	jmp    78a46 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x15a4>
  10cb9f:	f3 0f 1e fa          	endbr64 
  10cba3:	48 89 c3             	mov    %rax,%rbx
  10cba6:	e9 b8 be f6 ff       	jmp    78a63 <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x15c1>
  10cbab:	f3 0f 1e fa          	endbr64 
  10cbaf:	48 89 c3             	mov    %rax,%rbx
  10cbb2:	e9 77 ae f6 ff       	jmp    77a2e <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x58c>
  10cbb7:	f3 0f 1e fa          	endbr64 
  10cbbb:	48 89 c3             	mov    %rax,%rbx
  10cbbe:	e9 88 ae f6 ff       	jmp    77a4b <synreal::SolverNewton::precompute_matrices() [clone .cold]+0x5a9>
  10cbc3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  10cbca:	00 00 00 00 
  10cbce:	66 90                	xchg   %ax,%ax

000000000010cbd0 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long) [clone .isra.0]>:
  10cbd0:	48 85 ff             	test   %rdi,%rdi
  10cbd3:	75 0b                	jne    10cbe0 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long) [clone .isra.0]+0x10>
  10cbd5:	c3                   	ret    
  10cbd6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10cbdd:	00 00 00 
  10cbe0:	41 54                	push   %r12
  10cbe2:	be 01 00 00 00       	mov    $0x1,%esi
  10cbe7:	55                   	push   %rbp
  10cbe8:	53                   	push   %rbx
  10cbe9:	48 83 ec 08          	sub    $0x8,%rsp
  10cbed:	ff 74 24 38          	push   0x38(%rsp)
  10cbf1:	ff 74 24 38          	push   0x38(%rsp)
  10cbf5:	ff 74 24 38          	push   0x38(%rsp)
  10cbf9:	e8 42 23 f6 ff       	call   6ef40 <cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long>(unsigned long, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, CUstream_st*)@plt>
  10cbfe:	48 83 c4 20          	add    $0x20,%rsp
  10cc02:	89 c3                	mov    %eax,%ebx
  10cc04:	e8 87 fc f5 ff       	call   6c890 <cudaGetLastError@plt>
  10cc09:	85 db                	test   %ebx,%ebx
  10cc0b:	0f 85 b3 be f6 ff    	jne    78ac4 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long) [clone .isra.0] [clone .cold]>
  10cc11:	bf 01 00 00 00       	mov    $0x1,%edi
  10cc16:	e8 25 05 f6 ff       	call   6d140 <cudaStreamSynchronize@plt>
  10cc1b:	89 c3                	mov    %eax,%ebx
  10cc1d:	e8 6e fc f5 ff       	call   6c890 <cudaGetLastError@plt>
  10cc22:	89 c5                	mov    %eax,%ebp
  10cc24:	85 db                	test   %ebx,%ebx
  10cc26:	75 08                	jne    10cc30 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long) [clone .isra.0]+0x60>
  10cc28:	85 c0                	test   %eax,%eax
  10cc2a:	0f 85 02 bf f6 ff    	jne    78b32 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long) [clone .isra.0] [clone .cold]+0x6e>
  10cc30:	e8 5b fc f5 ff       	call   6c890 <cudaGetLastError@plt>
  10cc35:	85 db                	test   %ebx,%ebx
  10cc37:	0f 85 fc be f6 ff    	jne    78b39 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, float, (glm::qualifier)0> >, glm::vec<3, float, (glm::qualifier)0> >, unsigned long) [clone .isra.0] [clone .cold]+0x75>
  10cc3d:	5b                   	pop    %rbx
  10cc3e:	5d                   	pop    %rbp
  10cc3f:	41 5c                	pop    %r12
  10cc41:	c3                   	ret    
  10cc42:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  10cc49:	00 00 00 00 
  10cc4d:	0f 1f 00             	nopl   (%rax)

000000000010cc50 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long) [clone .isra.0]>:
  10cc50:	48 85 d2             	test   %rdx,%rdx
  10cc53:	75 0b                	jne    10cc60 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long) [clone .isra.0]+0x10>
  10cc55:	c3                   	ret    
  10cc56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10cc5d:	00 00 00 
  10cc60:	41 54                	push   %r12
  10cc62:	49 89 f9             	mov    %rdi,%r9
  10cc65:	49 89 f0             	mov    %rsi,%r8
  10cc68:	48 89 d7             	mov    %rdx,%rdi
  10cc6b:	55                   	push   %rbp
  10cc6c:	b9 01 00 00 00       	mov    $0x1,%ecx
  10cc71:	4c 89 ce             	mov    %r9,%rsi
  10cc74:	4c 89 c2             	mov    %r8,%rdx
  10cc77:	53                   	push   %rbx
  10cc78:	e8 93 15 f6 ff       	call   6e210 <cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long>(unsigned long, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, CUstream_st*)@plt>
  10cc7d:	89 c3                	mov    %eax,%ebx
  10cc7f:	e8 0c fc f5 ff       	call   6c890 <cudaGetLastError@plt>
  10cc84:	85 db                	test   %ebx,%ebx
  10cc86:	0f 85 49 bf f6 ff    	jne    78bd5 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long) [clone .isra.0] [clone .cold]>
  10cc8c:	bf 01 00 00 00       	mov    $0x1,%edi
  10cc91:	e8 aa 04 f6 ff       	call   6d140 <cudaStreamSynchronize@plt>
  10cc96:	89 c3                	mov    %eax,%ebx
  10cc98:	e8 f3 fb f5 ff       	call   6c890 <cudaGetLastError@plt>
  10cc9d:	89 c5                	mov    %eax,%ebp
  10cc9f:	85 db                	test   %ebx,%ebx
  10cca1:	75 08                	jne    10ccab <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long) [clone .isra.0]+0x5b>
  10cca3:	85 c0                	test   %eax,%eax
  10cca5:	0f 85 98 bf f6 ff    	jne    78c43 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long) [clone .isra.0] [clone .cold]+0x6e>
  10ccab:	e8 e0 fb f5 ff       	call   6c890 <cudaGetLastError@plt>
  10ccb0:	85 db                	test   %ebx,%ebx
  10ccb2:	0f 85 92 bf f6 ff    	jne    78c4a <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<int>, int>, unsigned long) [clone .isra.0] [clone .cold]+0x75>
  10ccb8:	5b                   	pop    %rbx
  10ccb9:	5d                   	pop    %rbp
  10ccba:	41 5c                	pop    %r12
  10ccbc:	c3                   	ret    
  10ccbd:	0f 1f 00             	nopl   (%rax)

000000000010ccc0 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long) [clone .isra.0]>:
  10ccc0:	48 85 f6             	test   %rsi,%rsi
  10ccc3:	75 0b                	jne    10ccd0 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long) [clone .isra.0]+0x10>
  10ccc5:	c3                   	ret    
  10ccc6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10cccd:	00 00 00 
  10ccd0:	41 54                	push   %r12
  10ccd2:	49 89 f8             	mov    %rdi,%r8
  10ccd5:	ba 01 00 00 00       	mov    $0x1,%edx
  10ccda:	48 89 f7             	mov    %rsi,%rdi
  10ccdd:	55                   	push   %rbp
  10ccde:	4c 89 c6             	mov    %r8,%rsi
  10cce1:	53                   	push   %rbx
  10cce2:	e8 69 17 f6 ff       	call   6e450 <cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long>(unsigned long, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, CUstream_st*)@plt>
  10cce7:	89 c3                	mov    %eax,%ebx
  10cce9:	e8 a2 fb f5 ff       	call   6c890 <cudaGetLastError@plt>
  10ccee:	85 db                	test   %ebx,%ebx
  10ccf0:	0f 85 f0 bf f6 ff    	jne    78ce6 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long) [clone .isra.0] [clone .cold]>
  10ccf6:	bf 01 00 00 00       	mov    $0x1,%edi
  10ccfb:	e8 40 04 f6 ff       	call   6d140 <cudaStreamSynchronize@plt>
  10cd00:	89 c3                	mov    %eax,%ebx
  10cd02:	e8 89 fb f5 ff       	call   6c890 <cudaGetLastError@plt>
  10cd07:	89 c5                	mov    %eax,%ebp
  10cd09:	85 db                	test   %ebx,%ebx
  10cd0b:	75 08                	jne    10cd15 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long) [clone .isra.0]+0x55>
  10cd0d:	85 c0                	test   %eax,%eax
  10cd0f:	0f 85 3f c0 f6 ff    	jne    78d54 <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long) [clone .isra.0] [clone .cold]+0x6e>
  10cd15:	e8 76 fb f5 ff       	call   6c890 <cudaGetLastError@plt>
  10cd1a:	85 db                	test   %ebx,%ebx
  10cd1c:	0f 85 39 c0 f6 ff    	jne    78d5b <void thrust::THRUST_200302_520_NS::cuda_cub::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<float>, float>, unsigned long) [clone .isra.0] [clone .cold]+0x75>
  10cd22:	5b                   	pop    %rbx
  10cd23:	5d                   	pop    %rbp
  10cd24:	41 5c                	pop    %r12
  10cd26:	c3                   	ret    
  10cd27:	90                   	nop
  10cd28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10cd2f:	00 
