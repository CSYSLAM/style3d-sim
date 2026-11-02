
../_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

0000000000126550 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)>:
  126550:	endbr64 
  126554:	push   %r15
  126556:	movaps %xmm0,%xmm4
  126559:	push   %r14
  12655b:	push   %r13
  12655d:	push   %r12
  12655f:	push   %rbp
  126560:	push   %rbx
  126561:	sub    $0x138,%rsp
  126568:	movss  0xce21c(%rip),%xmm1        # 1f478c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  126570:	movss  %xmm0,0xc(%rsp)
  126576:	andps  0xce223(%rip),%xmm0        # 1f47a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  12657d:	ucomiss %xmm0,%xmm1
  126580:	jb     7b10e <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) [clone .cold]>
  126586:	pxor   %xmm0,%xmm0
  12658a:	comiss %xmm4,%xmm0
  12658d:	jae    7b10e <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) [clone .cold]>
  126593:	mov    %rdx,%r14
  126596:	movslq 0x750(%rdi),%rdx
  12659d:	mov    %rdi,%rbx
  1265a0:	mov    %rsi,%r13
  1265a3:	movss  %xmm4,0x760(%rdi)
  1265ab:	mov    0x770(%rdi),%rdi
  1265b2:	mov    %rcx,%r15
  1265b5:	mov    %r8,%rcx
  1265b8:	shl    $0x2,%rdx
  1265bc:	mov    $0xff,%esi
  1265c1:	mov    %r8,%rbp
  1265c4:	call   6e9d0 <cudaMemsetAsync@plt>
  1265c9:	mov    %eax,%edi
  1265cb:	call   6d0a0 <synreal::(anonymous namespace)::check(cudaError)@plt>
  1265d0:	movslq 0x74c(%rbx),%rax
  1265d7:	xor    %esi,%esi
  1265d9:	mov    %rbp,%rcx
  1265dc:	mov    0x8d0(%rbx),%rdi
  1265e3:	lea    (%rax,%rax,8),%rdx
  1265e7:	shl    $0x2,%rdx
  1265eb:	call   6e9d0 <cudaMemsetAsync@plt>
  1265f0:	mov    %eax,%edi
  1265f2:	call   6d0a0 <synreal::(anonymous namespace)::check(cudaError)@plt>
  1265f7:	mov    0x748(%rbx),%edx
  1265fd:	mov    %rbp,%r9
  126600:	mov    0xd7741(%rip),%r12        # 1fdd48 <thrust::THRUST_200302_520_NS::system::detail::sequential::seq+0x7>
  126607:	mov    $0x1,%ecx
  12660c:	movl   $0x1,0x28(%rsp)
  126614:	lea    0xfe(%rdx),%eax
  12661a:	add    $0x7f,%edx
  12661d:	mov    %r12,0x20(%rsp)
  126622:	cmovns %edx,%eax
  126625:	xor    %r8d,%r8d
  126628:	movabs $0x100000080,%rdx
  126632:	sar    $0x7,%eax
  126635:	mov    %eax,0xb0(%rsp)
  12663c:	movabs $0x100000001,%rax
  126646:	mov    %rax,0xb4(%rsp)
  12664e:	mov    0xb0(%rsp),%rdi
  126656:	mov    0xb8(%rsp),%esi
  12665d:	call   6f040 <__cudaPushCallConfiguration@plt>
  126662:	test   %eax,%eax
  126664:	je     126700 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x1b0>
  12666a:	mov    0x748(%rbx),%ecx
  126670:	mov    %r12,%rdx
  126673:	mov    %rbp,%r9
  126676:	mov    %r12,0x10(%rsp)
  12667b:	movl   $0x1,0x18(%rsp)
  126683:	lea    0xfe(%rcx),%eax
  126689:	add    $0x7f,%ecx
  12668c:	cmovns %ecx,%eax
  12668f:	xor    %r8d,%r8d
  126692:	mov    $0x1,%ecx
  126697:	sar    $0x7,%eax
  12669a:	mov    %eax,0x20(%rsp)
  12669e:	movabs $0x100000001,%rax
  1266a8:	mov    %rax,0x24(%rsp)
  1266ad:	mov    0x20(%rsp),%rdi
  1266b2:	mov    0x28(%rsp),%esi
  1266b6:	call   6f040 <__cudaPushCallConfiguration@plt>
  1266bb:	test   %eax,%eax
  1266bd:	je     126a60 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x510>
  1266c3:	mov    0x754(%rbx),%eax
  1266c9:	test   %eax,%eax
  1266cb:	jne    126990 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x440>
  1266d1:	mov    0x758(%rbx),%eax
  1266d7:	test   %eax,%eax
  1266d9:	jne    1268c0 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x370>
  1266df:	call   6c900 <cudaGetLastError@plt>
  1266e4:	add    $0x138,%rsp
  1266eb:	pop    %rbx
  1266ec:	mov    %eax,%edi
  1266ee:	pop    %rbp
  1266ef:	pop    %r12
  1266f1:	pop    %r13
  1266f3:	pop    %r14
  1266f5:	pop    %r15
  1266f7:	jmp    6d0a0 <synreal::(anonymous namespace)::check(cudaError)@plt>
  1266fc:	nopl   0x0(%rax)
  126700:	movdqu 0x790(%rbx),%xmm6
  126708:	movdqu 0x770(%rbx),%xmm1
  126710:	mov    $0xe9,%ecx
  126715:	mov    %rbx,%rsi
  126718:	movdqu 0x7d0(%rbx),%xmm7
  126720:	movdqu 0x890(%rbx),%xmm5
  126728:	punpcklqdq %xmm6,%xmm1
  12672c:	movdqu 0x870(%rbx),%xmm0
  126734:	movdqu 0x850(%rbx),%xmm6
  12673c:	movaps %xmm1,0x30(%rsp)
  126741:	movdqu 0x7b0(%rbx),%xmm1
  126749:	movss  0x128(%rbx),%xmm2
  126751:	punpcklqdq %xmm5,%xmm0
  126755:	movdqu 0x810(%rbx),%xmm5
  12675d:	mov    0x8b0(%rbx),%rax
  126764:	punpcklqdq %xmm7,%xmm1
  126768:	movaps %xmm0,0x70(%rsp)
  12676d:	movd   0x750(%rbx),%xmm7
  126775:	movd   0x748(%rbx),%xmm0
  12677d:	movaps %xmm1,0x40(%rsp)
  126782:	movdqu 0x7f0(%rbx),%xmm1
  12678a:	movq   %xmm5,%rdx
  12678f:	mov    0x830(%rbx),%r10
  126796:	punpckldq %xmm7,%xmm0
  12679a:	mov    %rax,0x80(%rsp)
  1267a2:	mov    0x790(%rbx),%rax
  1267a9:	movq   %xmm0,0x88(%rsp)
  1267b2:	punpcklqdq %xmm5,%xmm1
  1267b6:	movss  0x130(%rbx),%xmm0
  1267be:	movaps %xmm1,0x50(%rsp)
  1267c3:	movdqu 0x830(%rbx),%xmm1
  1267cb:	punpcklqdq %xmm6,%xmm1
  1267cf:	movaps %xmm1,0x60(%rsp)
  1267d4:	movss  0x12c(%rbx),%xmm1
  1267dc:	unpcklps %xmm0,%xmm1
  1267df:	movss  0x75c(%rbx),%xmm0
  1267e7:	unpcklps %xmm2,%xmm0
  1267ea:	movlhps %xmm1,%xmm0
  1267ed:	movaps %xmm0,0x90(%rsp)
  1267f5:	movss  0x760(%rbx),%xmm0
  1267fd:	movss  %xmm0,0xa0(%rsp)
  126806:	push   %rax
  126807:	mov    0x770(%rbx),%rax
  12680e:	push   %rax
  12680f:	mov    0x7f0(%rbx),%rax
  126816:	push   %rax
  126817:	mov    0x7d0(%rbx),%rax
  12681e:	push   %rax
  12681f:	push   0xc0(%rsp)
  126826:	push   0xc0(%rsp)
  12682d:	push   0xc0(%rsp)
  126834:	push   0xc0(%rsp)
  12683b:	push   0xc0(%rsp)
  126842:	push   0xc0(%rsp)
  126849:	push   0xc0(%rsp)
  126850:	push   0xc0(%rsp)
  126857:	push   0xc0(%rsp)
  12685e:	push   0xc0(%rsp)
  126865:	push   0xc0(%rsp)
  12686c:	push   0xc0(%rsp)
  126873:	push   0xc0(%rsp)
  12687a:	push   0xc0(%rsp)
  126881:	push   0xc0(%rsp)
  126888:	sub    $0x748,%rsp
  12688f:	mov    %rsp,%rdi
  126892:	rep movsq %ds:(%rsi),%es:(%rdi)
  126895:	mov    %r10,%rcx
  126898:	mov    %r14,%rsi
  12689b:	mov    %r13,%rdi
  12689e:	mov    0x7b0(%rbx),%r9
  1268a5:	mov    0x850(%rbx),%r8
  1268ac:	call   6ace0 <synreal::granular_kernel::build_grid(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, int*, int*, glm::vec<3, int, (glm::qualifier)0>*, int*, int*)@plt>
  1268b1:	add    $0x7e0,%rsp
  1268b8:	jmp    12666a <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x11a>
  1268bd:	nopl   (%rax)
  1268c0:	lea    0xfe(%rax),%edx
  1268c6:	add    $0x7f,%eax
  1268c9:	mov    %rbp,%r9
  1268cc:	mov    $0x1,%ecx
  1268d1:	cmovs  %edx,%eax
  1268d4:	xor    %r8d,%r8d
  1268d7:	mov    %r12,%rdx
  1268da:	mov    %r12,0x10(%rsp)
  1268df:	movl   $0x1,0x18(%rsp)
  1268e7:	sar    $0x7,%eax
  1268ea:	mov    %eax,0x20(%rsp)
  1268ee:	movabs $0x100000001,%rax
  1268f8:	mov    %rax,0x24(%rsp)
  1268fd:	mov    0x20(%rsp),%rdi
  126902:	mov    0x28(%rsp),%esi
  126906:	call   6f040 <__cudaPushCallConfiguration@plt>
  12690b:	test   %eax,%eax
  12690d:	jne    1266df <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x18f>
  126913:	sub    $0x8,%rsp
  126917:	mov    0xa10(%rbx),%r10
  12691e:	mov    $0xe9,%ecx
  126923:	mov    %rbx,%rsi
  126926:	mov    0x9f0(%rbx),%rdx
  12692d:	push   0xa70(%rbx)
  126933:	push   0x8d0(%rbx)
  126939:	push   %r15
  12693b:	mov    0x758(%rbx),%eax
  126941:	push   %rax
  126942:	sub    $0x748,%rsp
  126949:	mov    %rsp,%rdi
  12694c:	rep movsq %ds:(%rsi),%es:(%rdi)
  12694f:	mov    %r10,%rcx
  126952:	mov    %r14,%rsi
  126955:	mov    %r13,%rdi
  126958:	movss  0x77c(%rsp),%xmm0
  126961:	movss  0x148(%rbx),%xmm1
  126969:	mov    0xa50(%rbx),%r9
  126970:	mov    0xa30(%rbx),%r8
  126977:	call   6aa50 <synreal::granular_kernel::accumulate_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, int const*, int, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  12697c:	add    $0x770,%rsp
  126983:	jmp    1266df <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x18f>
  126988:	nopl   0x0(%rax,%rax,1)
  126990:	lea    0xfe(%rax),%ecx
  126996:	add    $0x7f,%eax
  126999:	mov    %r12,%rdx
  12699c:	mov    %rbp,%r9
  12699f:	cmovs  %ecx,%eax
  1269a2:	xor    %r8d,%r8d
  1269a5:	mov    $0x1,%ecx
  1269aa:	mov    %r12,0x10(%rsp)
  1269af:	movl   $0x1,0x18(%rsp)
  1269b7:	sar    $0x7,%eax
  1269ba:	mov    %eax,0x20(%rsp)
  1269be:	movabs $0x100000001,%rax
  1269c8:	mov    %rax,0x24(%rsp)
  1269cd:	mov    0x20(%rsp),%rdi
  1269d2:	mov    0x28(%rsp),%esi
  1269d6:	call   6f040 <__cudaPushCallConfiguration@plt>
  1269db:	test   %eax,%eax
  1269dd:	jne    1266d1 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x181>
  1269e3:	sub    $0x8,%rsp
  1269e7:	mov    0x930(%rbx),%r10
  1269ee:	mov    $0xe9,%ecx
  1269f3:	mov    %rbx,%rsi
  1269f6:	mov    0x910(%rbx),%rdx
  1269fd:	push   0x8f0(%rbx)
  126a03:	push   0x8d0(%rbx)
  126a09:	push   %r15
  126a0b:	mov    0x754(%rbx),%eax
  126a11:	push   %rax
  126a12:	sub    $0x748,%rsp
  126a19:	mov    %rsp,%rdi
  126a1c:	rep movsq %ds:(%rsi),%es:(%rdi)
  126a1f:	mov    %r10,%rcx
  126a22:	mov    %r14,%rsi
  126a25:	mov    %r13,%rdi
  126a28:	movss  0x77c(%rsp),%xmm0
  126a31:	movss  0x134(%rbx),%xmm1
  126a39:	mov    0x970(%rbx),%r9
  126a40:	mov    0x950(%rbx),%r8
  126a47:	call   6aa50 <synreal::granular_kernel::accumulate_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, int const*, int, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  126a4c:	add    $0x770,%rsp
  126a53:	jmp    1266d1 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x181>
  126a58:	nopl   0x0(%rax,%rax,1)
  126a60:	movdqu 0x7d0(%rbx),%xmm5
  126a68:	movdqu 0x7b0(%rbx),%xmm2
  126a70:	sub    $0x8,%rsp
  126a74:	mov    %r15,%rdi
  126a77:	movdqu 0x850(%rbx),%xmm7
  126a7f:	movdqu 0x830(%rbx),%xmm0
  126a87:	movdqu 0x770(%rbx),%xmm3
  126a8f:	punpcklqdq %xmm5,%xmm2
  126a93:	movdqu 0x790(%rbx),%xmm5
  126a9b:	punpcklqdq %xmm7,%xmm0
  126a9f:	movdqu 0x810(%rbx),%xmm6
  126aa7:	movdqu 0x7f0(%rbx),%xmm1
  126aaf:	movaps %xmm2,0xc8(%rsp)
  126ab7:	punpcklqdq %xmm5,%xmm3
  126abb:	movaps %xmm0,0xe8(%rsp)
  126ac3:	movdqu 0x870(%rbx),%xmm0
  126acb:	movss  0x128(%rbx),%xmm2
  126ad3:	movaps %xmm3,0xb8(%rsp)
  126adb:	movdqu 0x890(%rbx),%xmm3
  126ae3:	punpcklqdq %xmm6,%xmm1
  126ae7:	movd   0x750(%rbx),%xmm6
  126aef:	movaps %xmm1,0xd8(%rsp)
  126af7:	movss  0x12c(%rbx),%xmm1
  126aff:	mov    0x8b0(%rbx),%r8
  126b06:	punpcklqdq %xmm3,%xmm0
  126b0a:	mov    0x8d0(%rbx),%rsi
  126b11:	movq   %xmm3,%rcx
  126b16:	mov    0x870(%rbx),%rdx
  126b1d:	movaps %xmm0,0xf8(%rsp)
  126b25:	movd   0x748(%rbx),%xmm0
  126b2d:	mov    %r8,0x108(%rsp)
  126b35:	punpckldq %xmm6,%xmm0
  126b39:	movq   %xmm0,0x110(%rsp)
  126b42:	movss  0x130(%rbx),%xmm0
  126b4a:	unpcklps %xmm0,%xmm1
  126b4d:	movss  0x75c(%rbx),%xmm0
  126b55:	unpcklps %xmm2,%xmm0
  126b58:	movlhps %xmm1,%xmm0
  126b5b:	movaps %xmm0,0x118(%rsp)
  126b63:	movss  0x760(%rbx),%xmm0
  126b6b:	movss  %xmm0,0x128(%rsp)
  126b74:	push   0x128(%rsp)
  126b7b:	push   0x128(%rsp)
  126b82:	push   0x128(%rsp)
  126b89:	push   0x128(%rsp)
  126b90:	push   0x128(%rsp)
  126b97:	push   0x128(%rsp)
  126b9e:	push   0x128(%rsp)
  126ba5:	push   0x128(%rsp)
  126bac:	push   0x128(%rsp)
  126bb3:	push   0x128(%rsp)
  126bba:	push   0x128(%rsp)
  126bc1:	push   0x128(%rsp)
  126bc8:	push   0x128(%rsp)
  126bcf:	push   0x128(%rsp)
  126bd6:	push   0x128(%rsp)
  126bdd:	call   6af20 <synreal::granular_kernel::accumulate_contacts(synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, int*, int*, glm::vec<4, float, (glm::qualifier)0>*)@plt>
  126be2:	sub    $0xffffffffffffff80,%rsp
  126be6:	jmp    1266c3 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x173>
  126beb:	nop
  126bec:	nopl   0x0(%rax)

0000000000126bf0 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)>:
  126bf0:	endbr64 
  126bf4:	push   %r14
  126bf6:	push   %r13
  126bf8:	mov    %rdx,%r13
  126bfb:	push   %r12
  126bfd:	mov    %rsi,%r12
  126c00:	push   %rbp
  126c01:	mov    %rcx,%rbp
  126c04:	push   %rbx
  126c05:	mov    %rdi,%rbx
  126c08:	sub    $0x130,%rsp
  126c0f:	mov    0x754(%rdi),%eax
  126c15:	test   %eax,%eax
  126c17:	jne    126c27 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x37>
  126c19:	mov    0x758(%rdi),%edx
  126c1f:	test   %edx,%edx
  126c21:	je     127070 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x480>
  126c27:	movss  0xcdb5d(%rip),%xmm2        # 1f478c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  126c2f:	movaps %xmm0,%xmm1
  126c32:	andps  0xcdb67(%rip),%xmm1        # 1f47a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  126c39:	ucomiss %xmm1,%xmm2
  126c3c:	jb     7b158 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*) [clone .cold]>
  126c42:	pxor   %xmm1,%xmm1
  126c46:	comiss %xmm0,%xmm1
  126c49:	jae    7b158 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*) [clone .cold]>
  126c4f:	test   %eax,%eax
  126c51:	jne    126f98 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x3a8>
  126c57:	mov    0x758(%rbx),%eax
  126c5d:	test   %eax,%eax
  126c5f:	jne    126c80 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x90>
  126c61:	call   6c900 <cudaGetLastError@plt>
  126c66:	add    $0x130,%rsp
  126c6d:	pop    %rbx
  126c6e:	mov    %eax,%edi
  126c70:	pop    %rbp
  126c71:	pop    %r12
  126c73:	pop    %r13
  126c75:	pop    %r14
  126c77:	jmp    6d0a0 <synreal::(anonymous namespace)::check(cudaError)@plt>
  126c7c:	nopl   0x0(%rax)
  126c80:	lea    0xfe(%rax),%edx
  126c86:	add    $0x7f,%eax
  126c89:	mov    0xd70b8(%rip),%r14        # 1fdd48 <thrust::THRUST_200302_520_NS::system::detail::sequential::seq+0x7>
  126c90:	mov    %rbp,%r9
  126c93:	cmovs  %edx,%eax
  126c96:	mov    $0x1,%ecx
  126c9b:	xor    %r8d,%r8d
  126c9e:	movss  %xmm0,0x760(%rbx)
  126ca6:	movabs $0x100000080,%rdx
  126cb0:	mov    %r14,0x30(%rsp)
  126cb5:	sar    $0x7,%eax
  126cb8:	movl   $0x1,0x38(%rsp)
  126cc0:	mov    %eax,0xb0(%rsp)
  126cc7:	movabs $0x100000001,%rax
  126cd1:	mov    %rax,0xb4(%rsp)
  126cd9:	mov    0xb0(%rsp),%rdi
  126ce1:	mov    0xb8(%rsp),%esi
  126ce8:	call   6f040 <__cudaPushCallConfiguration@plt>
  126ced:	test   %eax,%eax
  126cef:	je     127240 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x650>
  126cf5:	movslq 0x750(%rbx),%rdx
  126cfc:	mov    0x770(%rbx),%rdi
  126d03:	mov    %rbp,%rcx
  126d06:	mov    $0xff,%esi
  126d0b:	shl    $0x2,%rdx
  126d0f:	call   6e9d0 <cudaMemsetAsync@plt>
  126d14:	mov    %eax,%edi
  126d16:	call   6d0a0 <synreal::(anonymous namespace)::check(cudaError)@plt>
  126d1b:	mov    %r14,%rdx
  126d1e:	mov    %rbp,%r9
  126d21:	mov    %r14,0x20(%rsp)
  126d26:	mov    0x748(%rbx),%ecx
  126d2c:	movl   $0x1,0x28(%rsp)
  126d34:	lea    0xfe(%rcx),%eax
  126d3a:	add    $0x7f,%ecx
  126d3d:	cmovns %ecx,%eax
  126d40:	xor    %r8d,%r8d
  126d43:	mov    $0x1,%ecx
  126d48:	sar    $0x7,%eax
  126d4b:	mov    %eax,0xb0(%rsp)
  126d52:	movabs $0x100000001,%rax
  126d5c:	mov    %rax,0xb4(%rsp)
  126d64:	mov    0xb0(%rsp),%rdi
  126d6c:	mov    0xb8(%rsp),%esi
  126d73:	call   6f040 <__cudaPushCallConfiguration@plt>
  126d78:	test   %eax,%eax
  126d7a:	je     127080 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x490>
  126d80:	mov    0x748(%rbx),%ecx
  126d86:	mov    %r14,%rdx
  126d89:	mov    %rbp,%r9
  126d8c:	lea    0xfe(%rcx),%eax
  126d92:	add    $0x7f,%ecx
  126d95:	cmovns %ecx,%eax
  126d98:	xor    %r8d,%r8d
  126d9b:	mov    $0x1,%ecx
  126da0:	sar    $0x7,%eax
  126da3:	mov    %eax,0x20(%rsp)
  126da7:	movabs $0x100000001,%rax
  126db1:	mov    %rax,0x24(%rsp)
  126db6:	mov    0x20(%rsp),%rdi
  126dbb:	mov    0x28(%rsp),%esi
  126dbf:	call   6f040 <__cudaPushCallConfiguration@plt>
  126dc4:	test   %eax,%eax
  126dc6:	jne    126c61 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x71>
  126dcc:	movdqu 0x7d0(%rbx),%xmm5
  126dd4:	movdqu 0x890(%rbx),%xmm4
  126ddc:	sub    $0x8,%rsp
  126de0:	mov    $0xe9,%ecx
  126de5:	movdqu 0x7b0(%rbx),%xmm3
  126ded:	movdqu 0x870(%rbx),%xmm0
  126df5:	mov    %rbx,%rsi
  126df8:	movdqu 0x850(%rbx),%xmm7
  126e00:	movdqu 0x830(%rbx),%xmm1
  126e08:	punpcklqdq %xmm5,%xmm3
  126e0c:	punpcklqdq %xmm4,%xmm0
  126e10:	movdqu 0x810(%rbx),%xmm6
  126e18:	movdqu 0x7f0(%rbx),%xmm2
  126e20:	movaps %xmm3,0xc8(%rsp)
  126e28:	movd   0x750(%rbx),%xmm3
  126e30:	punpcklqdq %xmm7,%xmm1
  126e34:	movdqu 0x790(%rbx),%xmm5
  126e3c:	movaps %xmm0,0xf8(%rsp)
  126e44:	movd   0x748(%rbx),%xmm0
  126e4c:	punpcklqdq %xmm6,%xmm2
  126e50:	movdqu 0x770(%rbx),%xmm4
  126e58:	movaps %xmm1,0xe8(%rsp)
  126e60:	movss  0x12c(%rbx),%xmm1
  126e68:	mov    0x8b0(%rbx),%rax
  126e6f:	punpckldq %xmm3,%xmm0
  126e73:	movaps %xmm2,0xd8(%rsp)
  126e7b:	movss  0x128(%rbx),%xmm2
  126e83:	punpcklqdq %xmm5,%xmm4
  126e87:	movaps %xmm4,0xb8(%rsp)
  126e8f:	mov    0x9b0(%rbx),%r11
  126e96:	mov    0x990(%rbx),%r10
  126e9d:	mov    %rax,0x108(%rsp)
  126ea5:	mov    0x9f0(%rbx),%r12
  126eac:	movq   %xmm0,0x110(%rsp)
  126eb5:	movss  0x130(%rbx),%xmm0
  126ebd:	mov    0x9d0(%rbx),%rdx
  126ec4:	unpcklps %xmm0,%xmm1
  126ec7:	movss  0x75c(%rbx),%xmm0
  126ecf:	unpcklps %xmm2,%xmm0
  126ed2:	movlhps %xmm1,%xmm0
  126ed5:	movaps %xmm0,0x118(%rsp)
  126edd:	movss  0x760(%rbx),%xmm0
  126ee5:	movss  %xmm0,0x128(%rsp)
  126eee:	push   0xa50(%rbx)
  126ef4:	push   0x130(%rsp)
  126efb:	push   0x130(%rsp)
  126f02:	push   0x130(%rsp)
  126f09:	push   0x130(%rsp)
  126f10:	push   0x130(%rsp)
  126f17:	push   0x130(%rsp)
  126f1e:	push   0x130(%rsp)
  126f25:	push   0x130(%rsp)
  126f2c:	push   0x130(%rsp)
  126f33:	push   0x130(%rsp)
  126f3a:	push   0x130(%rsp)
  126f41:	push   0x130(%rsp)
  126f48:	push   0x130(%rsp)
  126f4f:	push   0x130(%rsp)
  126f56:	push   0x130(%rsp)
  126f5d:	sub    $0x748,%rsp
  126f64:	mov    %rsp,%rdi
  126f67:	rep movsq %ds:(%rsi),%es:(%rdi)
  126f6a:	mov    0xa30(%rbx),%r9
  126f71:	mov    %r12,%rcx
  126f74:	mov    %r11,%rsi
  126f77:	mov    0xa10(%rbx),%r8
  126f7e:	mov    %r10,%rdi
  126f81:	call   6a9f0 <synreal::granular_kernel::form_bonds(synreal::Model, synreal::granular_kernel::View, int const*, int const*, int*, glm::vec<2, int, (glm::qualifier)0>*, float*, float*, int*)@plt>
  126f86:	add    $0x7d0,%rsp
  126f8d:	jmp    126c61 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x71>
  126f92:	nopw   0x0(%rax,%rax,1)
  126f98:	mov    0xd6da9(%rip),%rdx        # 1fdd48 <thrust::THRUST_200302_520_NS::system::detail::sequential::seq+0x7>
  126f9f:	mov    %rbp,%r9
  126fa2:	mov    $0x1,%ecx
  126fa7:	movss  %xmm0,0xc(%rsp)
  126fad:	movl   $0x1,0x38(%rsp)
  126fb5:	mov    %rdx,0x30(%rsp)
  126fba:	lea    0xfe(%rax),%edx
  126fc0:	add    $0x7f,%eax
  126fc3:	cmovs  %edx,%eax
  126fc6:	xor    %r8d,%r8d
  126fc9:	movabs $0x100000080,%rdx
  126fd3:	sar    $0x7,%eax
  126fd6:	mov    %eax,0xb0(%rsp)
  126fdd:	movabs $0x100000001,%rax
  126fe7:	mov    %rax,0xb4(%rsp)
  126fef:	mov    0xb0(%rsp),%rdi
  126ff7:	mov    0xb8(%rsp),%esi
  126ffe:	call   6f040 <__cudaPushCallConfiguration@plt>
  127003:	movss  0xc(%rsp),%xmm0
  127009:	test   %eax,%eax
  12700b:	jne    126c57 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x67>
  127011:	sub    $0x750,%rsp
  127018:	mov    $0xe9,%ecx
  12701d:	mov    %rbx,%rsi
  127020:	mov    0x950(%rbx),%r11
  127027:	mov    0x910(%rbx),%r10
  12702e:	mov    %rsp,%rdi
  127031:	mov    0x930(%rbx),%rdx
  127038:	rep movsq %ds:(%rsi),%es:(%rdi)
  12703b:	mov    %r11,%rcx
  12703e:	mov    %r12,%rdi
  127041:	mov    %r10,%rsi
  127044:	mov    0x754(%rbx),%r9d
  12704b:	mov    0x970(%rbx),%r8
  127052:	call   6ab30 <synreal::granular_kernel::commit_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float*, int*, int)@plt>
  127057:	add    $0x750,%rsp
  12705e:	movss  0xc(%rsp),%xmm0
  127064:	jmp    126c57 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x67>
  127069:	nopl   0x0(%rax)
  127070:	add    $0x130,%rsp
  127077:	pop    %rbx
  127078:	pop    %rbp
  127079:	pop    %r12
  12707b:	pop    %r13
  12707d:	pop    %r14
  12707f:	ret    
  127080:	movdqu 0x790(%rbx),%xmm6
  127088:	movdqu 0x770(%rbx),%xmm1
  127090:	mov    $0xe9,%ecx
  127095:	mov    %rbx,%rsi
  127098:	movdqu 0x7d0(%rbx),%xmm7
  1270a0:	movdqu 0x890(%rbx),%xmm5
  1270a8:	punpcklqdq %xmm6,%xmm1
  1270ac:	movdqu 0x870(%rbx),%xmm0
  1270b4:	movdqu 0x850(%rbx),%xmm6
  1270bc:	movaps %xmm1,0x30(%rsp)
  1270c1:	movdqu 0x7b0(%rbx),%xmm1
  1270c9:	movss  0x128(%rbx),%xmm2
  1270d1:	punpcklqdq %xmm5,%xmm0
  1270d5:	movdqu 0x810(%rbx),%xmm5
  1270dd:	mov    0x8b0(%rbx),%rax
  1270e4:	punpcklqdq %xmm7,%xmm1
  1270e8:	movaps %xmm0,0x70(%rsp)
  1270ed:	movd   0x750(%rbx),%xmm7
  1270f5:	movd   0x748(%rbx),%xmm0
  1270fd:	movaps %xmm1,0x40(%rsp)
  127102:	movdqu 0x7f0(%rbx),%xmm1
  12710a:	movq   %xmm5,%rdx
  12710f:	mov    0x830(%rbx),%r10
  127116:	punpckldq %xmm7,%xmm0
  12711a:	mov    %rax,0x80(%rsp)
  127122:	mov    0x790(%rbx),%rax
  127129:	movq   %xmm0,0x88(%rsp)
  127132:	punpcklqdq %xmm5,%xmm1
  127136:	movss  0x130(%rbx),%xmm0
  12713e:	movaps %xmm1,0x50(%rsp)
  127143:	movdqu 0x830(%rbx),%xmm1
  12714b:	punpcklqdq %xmm6,%xmm1
  12714f:	movaps %xmm1,0x60(%rsp)
  127154:	movss  0x12c(%rbx),%xmm1
  12715c:	unpcklps %xmm0,%xmm1
  12715f:	movss  0x75c(%rbx),%xmm0
  127167:	unpcklps %xmm2,%xmm0
  12716a:	movlhps %xmm1,%xmm0
  12716d:	movaps %xmm0,0x90(%rsp)
  127175:	movss  0x760(%rbx),%xmm0
  12717d:	movss  %xmm0,0xa0(%rsp)
  127186:	push   %rax
  127187:	mov    0x770(%rbx),%rax
  12718e:	push   %rax
  12718f:	mov    0x7f0(%rbx),%rax
  127196:	push   %rax
  127197:	mov    0x7d0(%rbx),%rax
  12719e:	push   %rax
  12719f:	push   0xc0(%rsp)
  1271a6:	push   0xc0(%rsp)
  1271ad:	push   0xc0(%rsp)
  1271b4:	push   0xc0(%rsp)
  1271bb:	push   0xc0(%rsp)
  1271c2:	push   0xc0(%rsp)
  1271c9:	push   0xc0(%rsp)
  1271d0:	push   0xc0(%rsp)
  1271d7:	push   0xc0(%rsp)
  1271de:	push   0xc0(%rsp)
  1271e5:	push   0xc0(%rsp)
  1271ec:	push   0xc0(%rsp)
  1271f3:	push   0xc0(%rsp)
  1271fa:	push   0xc0(%rsp)
  127201:	push   0xc0(%rsp)
  127208:	sub    $0x748,%rsp
  12720f:	mov    %rsp,%rdi
  127212:	rep movsq %ds:(%rsi),%es:(%rdi)
  127215:	mov    %r10,%rcx
  127218:	mov    %r13,%rsi
  12721b:	mov    %r12,%rdi
  12721e:	mov    0x7b0(%rbx),%r9
  127225:	mov    0x850(%rbx),%r8
  12722c:	call   6ace0 <synreal::granular_kernel::build_grid(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, int*, int*, glm::vec<3, int, (glm::qualifier)0>*, int*, int*)@plt>
  127231:	add    $0x7e0,%rsp
  127238:	jmp    126d80 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x190>
  12723d:	nopl   (%rax)
  127240:	sub    $0x750,%rsp
  127247:	mov    $0xe9,%ecx
  12724c:	mov    %rbx,%rsi
  12724f:	mov    0xa30(%rbx),%r11
  127256:	mov    0x9f0(%rbx),%r10
  12725d:	mov    0xa10(%rbx),%rdx
  127264:	mov    %rsp,%rdi
  127267:	rep movsq %ds:(%rsi),%es:(%rdi)
  12726a:	mov    %r11,%rcx
  12726d:	mov    %r12,%rdi
  127270:	mov    %r10,%rsi
  127273:	mov    0x758(%rbx),%r9d
  12727a:	mov    0xa50(%rbx),%r8
  127281:	call   6ab30 <synreal::granular_kernel::commit_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float*, int*, int)@plt>
  127286:	add    $0x750,%rsp
  12728d:	jmp    126cf5 <synreal::Granular::commit(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, CUstream_st*)+0x105>
  127292:	data16 cs nopw 0x0(%rax,%rax,1)
  12729d:	nopl   (%rax)
