
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

0000000000127710 <synreal::Granular::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const>:
  127710:	endbr64 
  127714:	push   %r14
  127716:	mov    %rcx,%r9
  127719:	mov    %rcx,%r14
  12771c:	mov    $0x1,%ecx
  127721:	push   %r13
  127723:	push   %r12
  127725:	mov    %rdx,%r12
  127728:	push   %rbp
  127729:	mov    %rsi,%rbp
  12772c:	push   %rbx
  12772d:	mov    %rdi,%rbx
  127730:	sub    $0xa0,%rsp
  127737:	mov    0x748(%rdi),%edx
  12773d:	mov    0xd1604(%rip),%r13        # 1f8d48 <thrust::THRUST_200302_520_NS::system::detail::sequential::seq+0x7>
  127744:	movl   $0x1,0x10(%rsp)
  12774c:	lea    0xfe(%rdx),%eax
  127752:	add    $0x7f,%edx
  127755:	mov    %r13,0x8(%rsp)
  12775a:	cmovns %edx,%eax
  12775d:	xor    %r8d,%r8d
  127760:	movabs $0x100000080,%rdx
  12776a:	sar    $0x7,%eax
  12776d:	mov    %eax,0x14(%rsp)
  127771:	movabs $0x100000001,%rax
  12777b:	mov    %rax,0x18(%rsp)
  127780:	mov    0x14(%rsp),%rdi
  127785:	mov    0x1c(%rsp),%esi
  127789:	call   6efb0 <__cudaPushCallConfiguration@plt>
  12778e:	test   %eax,%eax
  127790:	je     1277d0 <synreal::Granular::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const+0xc0>
  127792:	mov    0x754(%rbx),%eax
  127798:	test   %eax,%eax
  12779a:	jne    127942 <synreal::Granular::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const+0x232>
  1277a0:	mov    0x758(%rbx),%eax
  1277a6:	test   %eax,%eax
  1277a8:	jne    1279d0 <synreal::Granular::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const+0x2c0>
  1277ae:	call   6c890 <cudaGetLastError@plt>
  1277b3:	add    $0xa0,%rsp
  1277ba:	pop    %rbx
  1277bb:	mov    %eax,%edi
  1277bd:	pop    %rbp
  1277be:	pop    %r12
  1277c0:	pop    %r13
  1277c2:	pop    %r14
  1277c4:	jmp    6d030 <synreal::(anonymous namespace)::check(cudaError)@plt>
  1277c9:	nopl   0x0(%rax)
  1277d0:	movdqu 0x7d0(%rbx),%xmm5
  1277d8:	movdqu 0x7b0(%rbx),%xmm3
  1277e0:	sub    $0x8,%rsp
  1277e4:	mov    %r12,%rsi
  1277e7:	movdqu 0x870(%rbx),%xmm0
  1277ef:	movdqu 0x850(%rbx),%xmm7
  1277f7:	mov    %rbp,%rdi
  1277fa:	punpcklqdq %xmm5,%xmm3
  1277fe:	movdqu 0x890(%rbx),%xmm5
  127806:	movdqu 0x830(%rbx),%xmm1
  12780e:	movdqu 0x810(%rbx),%xmm6
  127816:	movdqu 0x7f0(%rbx),%xmm2
  12781e:	movaps %xmm3,0x38(%rsp)
  127823:	punpcklqdq %xmm5,%xmm0
  127827:	punpcklqdq %xmm7,%xmm1
  12782b:	movd   0x750(%rbx),%xmm7
  127833:	movdqu 0x770(%rbx),%xmm4
  12783b:	movaps %xmm0,0x68(%rsp)
  127840:	movd   0x748(%rbx),%xmm0
  127848:	punpcklqdq %xmm6,%xmm2
  12784c:	movdqu 0x790(%rbx),%xmm6
  127854:	movaps %xmm1,0x58(%rsp)
  127859:	movss  0x12c(%rbx),%xmm1
  127861:	mov    0x8b0(%rbx),%rax
  127868:	punpckldq %xmm7,%xmm0
  12786c:	movaps %xmm2,0x48(%rsp)
  127871:	punpcklqdq %xmm6,%xmm4
  127875:	movss  0x128(%rbx),%xmm2
  12787d:	movq   %xmm0,0x80(%rsp)
  127886:	movss  0x130(%rbx),%xmm0
  12788e:	mov    %rax,0x78(%rsp)
  127893:	unpcklps %xmm0,%xmm1
  127896:	movss  0x75c(%rbx),%xmm0
  12789e:	movaps %xmm4,0x28(%rsp)
  1278a3:	unpcklps %xmm2,%xmm0
  1278a6:	movlhps %xmm1,%xmm0
  1278a9:	movaps %xmm0,0x88(%rsp)
  1278b1:	movss  0x760(%rbx),%xmm0
  1278b9:	movss  %xmm0,0x98(%rsp)
  1278c2:	push   0x98(%rsp)
  1278c9:	push   0x98(%rsp)
  1278d0:	push   0x98(%rsp)
  1278d7:	push   0x98(%rsp)
  1278de:	push   0x98(%rsp)
  1278e5:	push   0x98(%rsp)
  1278ec:	push   0x98(%rsp)
  1278f3:	push   0x98(%rsp)
  1278fa:	push   0x98(%rsp)
  127901:	push   0x98(%rsp)
  127908:	push   0x98(%rsp)
  12790f:	push   0x98(%rsp)
  127916:	push   0x98(%rsp)
  12791d:	push   0x98(%rsp)
  127924:	push   0x98(%rsp)
  12792b:	call   6a970 <synreal::granular_kernel::multiply_contacts(synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*)@plt>
  127930:	mov    0x754(%rbx),%eax
  127936:	sub    $0xffffffffffffff80,%rsp
  12793a:	test   %eax,%eax
  12793c:	je     1277a0 <synreal::Granular::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const+0x90>
  127942:	lea    0xfe(%rax),%ecx
  127948:	add    $0x7f,%eax
  12794b:	mov    %r13,%rdx
  12794e:	mov    %r14,%r9
  127951:	cmovs  %ecx,%eax
  127954:	xor    %r8d,%r8d
  127957:	mov    $0x1,%ecx
  12795c:	mov    %r13,0x8(%rsp)
  127961:	movl   $0x1,0x10(%rsp)
  127969:	sar    $0x7,%eax
  12796c:	mov    %eax,0x14(%rsp)
  127970:	movabs $0x100000001,%rax
  12797a:	mov    %rax,0x18(%rsp)
  12797f:	mov    0x14(%rsp),%rdi
  127984:	mov    0x1c(%rsp),%esi
  127988:	call   6efb0 <__cudaPushCallConfiguration@plt>
  12798d:	test   %eax,%eax
  12798f:	jne    1277a0 <synreal::Granular::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const+0x90>
  127995:	mov    0x754(%rbx),%ecx
  12799b:	mov    %r12,%r9
  12799e:	mov    %rbp,%r8
  1279a1:	mov    0x8f0(%rbx),%rdx
  1279a8:	mov    0x970(%rbx),%rsi
  1279af:	mov    0x910(%rbx),%rdi
  1279b6:	call   6a800 <synreal::granular_kernel::multiply_bonds(glm::vec<2, int, (glm::qualifier)0> const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*)@plt>
  1279bb:	mov    0x758(%rbx),%eax
  1279c1:	test   %eax,%eax
  1279c3:	je     1277ae <synreal::Granular::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const+0x9e>
  1279c9:	nopl   0x0(%rax)
  1279d0:	lea    0xfe(%rax),%edx
  1279d6:	add    $0x7f,%eax
  1279d9:	mov    %r14,%r9
  1279dc:	mov    $0x1,%ecx
  1279e1:	cmovs  %edx,%eax
  1279e4:	xor    %r8d,%r8d
  1279e7:	mov    %r13,%rdx
  1279ea:	mov    %r13,0x8(%rsp)
  1279ef:	movl   $0x1,0x10(%rsp)
  1279f7:	sar    $0x7,%eax
  1279fa:	mov    %eax,0x14(%rsp)
  1279fe:	movabs $0x100000001,%rax
  127a08:	mov    %rax,0x18(%rsp)
  127a0d:	mov    0x14(%rsp),%rdi
  127a12:	mov    0x1c(%rsp),%esi
  127a16:	call   6efb0 <__cudaPushCallConfiguration@plt>
  127a1b:	test   %eax,%eax
  127a1d:	jne    1277ae <synreal::Granular::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const+0x9e>
  127a23:	mov    0x758(%rbx),%ecx
  127a29:	mov    %r12,%r9
  127a2c:	mov    %rbp,%r8
  127a2f:	mov    0xa70(%rbx),%rdx
  127a36:	mov    0xa50(%rbx),%rsi
  127a3d:	mov    0x9f0(%rbx),%rdi
  127a44:	call   6a800 <synreal::granular_kernel::multiply_bonds(glm::vec<2, int, (glm::qualifier)0> const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*)@plt>
  127a49:	jmp    1277ae <synreal::Granular::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const+0x9e>
