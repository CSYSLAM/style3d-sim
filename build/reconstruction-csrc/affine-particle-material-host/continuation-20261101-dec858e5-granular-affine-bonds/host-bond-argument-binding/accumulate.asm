
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

00000000001269c0 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)>:
  1269c0:	endbr64 
  1269c4:	push   %r15
  1269c6:	movaps %xmm0,%xmm4
  1269c9:	push   %r14
  1269cb:	push   %r13
  1269cd:	push   %r12
  1269cf:	push   %rbp
  1269d0:	push   %rbx
  1269d1:	sub    $0x138,%rsp
  1269d8:	movss  0xc8dac(%rip),%xmm1        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  1269e0:	movss  %xmm0,0xc(%rsp)
  1269e6:	andps  0xc8db3(%rip),%xmm0        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1269ed:	ucomiss %xmm0,%xmm1
  1269f0:	jb     7b0fe <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) [clone .cold]>
  1269f6:	pxor   %xmm0,%xmm0
  1269fa:	comiss %xmm4,%xmm0
  1269fd:	jae    7b0fe <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) [clone .cold]>
  126a03:	mov    %rdx,%r14
  126a06:	movslq 0x750(%rdi),%rdx
  126a0d:	mov    %rdi,%rbx
  126a10:	mov    %rsi,%r13
  126a13:	movss  %xmm4,0x760(%rdi)
  126a1b:	mov    0x770(%rdi),%rdi
  126a22:	mov    %rcx,%r15
  126a25:	mov    %r8,%rcx
  126a28:	shl    $0x2,%rdx
  126a2c:	mov    $0xff,%esi
  126a31:	mov    %r8,%rbp
  126a34:	call   6e930 <cudaMemsetAsync@plt>
  126a39:	mov    %eax,%edi
  126a3b:	call   6d030 <synreal::(anonymous namespace)::check(cudaError)@plt>
  126a40:	movslq 0x74c(%rbx),%rax
  126a47:	xor    %esi,%esi
  126a49:	mov    %rbp,%rcx
  126a4c:	mov    0x8d0(%rbx),%rdi
  126a53:	lea    (%rax,%rax,8),%rdx
  126a57:	shl    $0x2,%rdx
  126a5b:	call   6e930 <cudaMemsetAsync@plt>
  126a60:	mov    %eax,%edi
  126a62:	call   6d030 <synreal::(anonymous namespace)::check(cudaError)@plt>
  126a67:	mov    0x748(%rbx),%edx
  126a6d:	mov    %rbp,%r9
  126a70:	mov    0xd22d1(%rip),%r12        # 1f8d48 <thrust::THRUST_200302_520_NS::system::detail::sequential::seq+0x7>
  126a77:	mov    $0x1,%ecx
  126a7c:	movl   $0x1,0x28(%rsp)
  126a84:	lea    0xfe(%rdx),%eax
  126a8a:	add    $0x7f,%edx
  126a8d:	mov    %r12,0x20(%rsp)
  126a92:	cmovns %edx,%eax
  126a95:	xor    %r8d,%r8d
  126a98:	movabs $0x100000080,%rdx
  126aa2:	sar    $0x7,%eax
  126aa5:	mov    %eax,0xb0(%rsp)
  126aac:	movabs $0x100000001,%rax
  126ab6:	mov    %rax,0xb4(%rsp)
  126abe:	mov    0xb0(%rsp),%rdi
  126ac6:	mov    0xb8(%rsp),%esi
  126acd:	call   6efb0 <__cudaPushCallConfiguration@plt>
  126ad2:	test   %eax,%eax
  126ad4:	je     126b70 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x1b0>
  126ada:	mov    0x748(%rbx),%ecx
  126ae0:	mov    %r12,%rdx
  126ae3:	mov    %rbp,%r9
  126ae6:	mov    %r12,0x10(%rsp)
  126aeb:	movl   $0x1,0x18(%rsp)
  126af3:	lea    0xfe(%rcx),%eax
  126af9:	add    $0x7f,%ecx
  126afc:	cmovns %ecx,%eax
  126aff:	xor    %r8d,%r8d
  126b02:	mov    $0x1,%ecx
  126b07:	sar    $0x7,%eax
  126b0a:	mov    %eax,0x20(%rsp)
  126b0e:	movabs $0x100000001,%rax
  126b18:	mov    %rax,0x24(%rsp)
  126b1d:	mov    0x20(%rsp),%rdi
  126b22:	mov    0x28(%rsp),%esi
  126b26:	call   6efb0 <__cudaPushCallConfiguration@plt>
  126b2b:	test   %eax,%eax
  126b2d:	je     126ed0 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x510>
  126b33:	mov    0x754(%rbx),%eax
  126b39:	test   %eax,%eax
  126b3b:	jne    126e00 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x440>
  126b41:	mov    0x758(%rbx),%eax
  126b47:	test   %eax,%eax
  126b49:	jne    126d30 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x370>
  126b4f:	call   6c890 <cudaGetLastError@plt>
  126b54:	add    $0x138,%rsp
  126b5b:	pop    %rbx
  126b5c:	mov    %eax,%edi
  126b5e:	pop    %rbp
  126b5f:	pop    %r12
  126b61:	pop    %r13
  126b63:	pop    %r14
  126b65:	pop    %r15
  126b67:	jmp    6d030 <synreal::(anonymous namespace)::check(cudaError)@plt>
  126b6c:	nopl   0x0(%rax)
  126b70:	movdqu 0x790(%rbx),%xmm6
  126b78:	movdqu 0x770(%rbx),%xmm1
  126b80:	mov    $0xe9,%ecx
  126b85:	mov    %rbx,%rsi
  126b88:	movdqu 0x7d0(%rbx),%xmm7
  126b90:	movdqu 0x890(%rbx),%xmm5
  126b98:	punpcklqdq %xmm6,%xmm1
  126b9c:	movdqu 0x870(%rbx),%xmm0
  126ba4:	movdqu 0x850(%rbx),%xmm6
  126bac:	movaps %xmm1,0x30(%rsp)
  126bb1:	movdqu 0x7b0(%rbx),%xmm1
  126bb9:	movss  0x128(%rbx),%xmm2
  126bc1:	punpcklqdq %xmm5,%xmm0
  126bc5:	movdqu 0x810(%rbx),%xmm5
  126bcd:	mov    0x8b0(%rbx),%rax
  126bd4:	punpcklqdq %xmm7,%xmm1
  126bd8:	movaps %xmm0,0x70(%rsp)
  126bdd:	movd   0x750(%rbx),%xmm7
  126be5:	movd   0x748(%rbx),%xmm0
  126bed:	movaps %xmm1,0x40(%rsp)
  126bf2:	movdqu 0x7f0(%rbx),%xmm1
  126bfa:	movq   %xmm5,%rdx
  126bff:	mov    0x830(%rbx),%r10
  126c06:	punpckldq %xmm7,%xmm0
  126c0a:	mov    %rax,0x80(%rsp)
  126c12:	mov    0x790(%rbx),%rax
  126c19:	movq   %xmm0,0x88(%rsp)
  126c22:	punpcklqdq %xmm5,%xmm1
  126c26:	movss  0x130(%rbx),%xmm0
  126c2e:	movaps %xmm1,0x50(%rsp)
  126c33:	movdqu 0x830(%rbx),%xmm1
  126c3b:	punpcklqdq %xmm6,%xmm1
  126c3f:	movaps %xmm1,0x60(%rsp)
  126c44:	movss  0x12c(%rbx),%xmm1
  126c4c:	unpcklps %xmm0,%xmm1
  126c4f:	movss  0x75c(%rbx),%xmm0
  126c57:	unpcklps %xmm2,%xmm0
  126c5a:	movlhps %xmm1,%xmm0
  126c5d:	movaps %xmm0,0x90(%rsp)
  126c65:	movss  0x760(%rbx),%xmm0
  126c6d:	movss  %xmm0,0xa0(%rsp)
  126c76:	push   %rax
  126c77:	mov    0x770(%rbx),%rax
  126c7e:	push   %rax
  126c7f:	mov    0x7f0(%rbx),%rax
  126c86:	push   %rax
  126c87:	mov    0x7d0(%rbx),%rax
  126c8e:	push   %rax
  126c8f:	push   0xc0(%rsp)
  126c96:	push   0xc0(%rsp)
  126c9d:	push   0xc0(%rsp)
  126ca4:	push   0xc0(%rsp)
  126cab:	push   0xc0(%rsp)
  126cb2:	push   0xc0(%rsp)
  126cb9:	push   0xc0(%rsp)
  126cc0:	push   0xc0(%rsp)
  126cc7:	push   0xc0(%rsp)
  126cce:	push   0xc0(%rsp)
  126cd5:	push   0xc0(%rsp)
  126cdc:	push   0xc0(%rsp)
  126ce3:	push   0xc0(%rsp)
  126cea:	push   0xc0(%rsp)
  126cf1:	push   0xc0(%rsp)
  126cf8:	sub    $0x748,%rsp
  126cff:	mov    %rsp,%rdi
  126d02:	rep movsq %ds:(%rsi),%es:(%rdi)
  126d05:	mov    %r10,%rcx
  126d08:	mov    %r14,%rsi
  126d0b:	mov    %r13,%rdi
  126d0e:	mov    0x7b0(%rbx),%r9
  126d15:	mov    0x850(%rbx),%r8
  126d1c:	call   6acb0 <synreal::granular_kernel::build_grid(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, int*, int*, glm::vec<3, int, (glm::qualifier)0>*, int*, int*)@plt>
  126d21:	add    $0x7e0,%rsp
  126d28:	jmp    126ada <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x11a>
  126d2d:	nopl   (%rax)
  126d30:	lea    0xfe(%rax),%edx
  126d36:	add    $0x7f,%eax
  126d39:	mov    %rbp,%r9
  126d3c:	mov    $0x1,%ecx
  126d41:	cmovs  %edx,%eax
  126d44:	xor    %r8d,%r8d
  126d47:	mov    %r12,%rdx
  126d4a:	mov    %r12,0x10(%rsp)
  126d4f:	movl   $0x1,0x18(%rsp)
  126d57:	sar    $0x7,%eax
  126d5a:	mov    %eax,0x20(%rsp)
  126d5e:	movabs $0x100000001,%rax
  126d68:	mov    %rax,0x24(%rsp)
  126d6d:	mov    0x20(%rsp),%rdi
  126d72:	mov    0x28(%rsp),%esi
  126d76:	call   6efb0 <__cudaPushCallConfiguration@plt>
  126d7b:	test   %eax,%eax
  126d7d:	jne    126b4f <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x18f>
  126d83:	sub    $0x8,%rsp
  126d87:	mov    0xa10(%rbx),%r10
  126d8e:	mov    $0xe9,%ecx
  126d93:	mov    %rbx,%rsi
  126d96:	mov    0x9f0(%rbx),%rdx
  126d9d:	push   0xa70(%rbx)
  126da3:	push   0x8d0(%rbx)
  126da9:	push   %r15
  126dab:	mov    0x758(%rbx),%eax
  126db1:	push   %rax
  126db2:	sub    $0x748,%rsp
  126db9:	mov    %rsp,%rdi
  126dbc:	rep movsq %ds:(%rsi),%es:(%rdi)
  126dbf:	mov    %r10,%rcx
  126dc2:	mov    %r14,%rsi
  126dc5:	mov    %r13,%rdi
  126dc8:	movss  0x77c(%rsp),%xmm0
  126dd1:	movss  0x148(%rbx),%xmm1
  126dd9:	mov    0xa50(%rbx),%r9
  126de0:	mov    0xa30(%rbx),%r8
  126de7:	call   6aa30 <synreal::granular_kernel::accumulate_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, int const*, int, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  126dec:	add    $0x770,%rsp
  126df3:	jmp    126b4f <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x18f>
  126df8:	nopl   0x0(%rax,%rax,1)
  126e00:	lea    0xfe(%rax),%ecx
  126e06:	add    $0x7f,%eax
  126e09:	mov    %r12,%rdx
  126e0c:	mov    %rbp,%r9
  126e0f:	cmovs  %ecx,%eax
  126e12:	xor    %r8d,%r8d
  126e15:	mov    $0x1,%ecx
  126e1a:	mov    %r12,0x10(%rsp)
  126e1f:	movl   $0x1,0x18(%rsp)
  126e27:	sar    $0x7,%eax
  126e2a:	mov    %eax,0x20(%rsp)
  126e2e:	movabs $0x100000001,%rax
  126e38:	mov    %rax,0x24(%rsp)
  126e3d:	mov    0x20(%rsp),%rdi
  126e42:	mov    0x28(%rsp),%esi
  126e46:	call   6efb0 <__cudaPushCallConfiguration@plt>
  126e4b:	test   %eax,%eax
  126e4d:	jne    126b41 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x181>
  126e53:	sub    $0x8,%rsp
  126e57:	mov    0x930(%rbx),%r10
  126e5e:	mov    $0xe9,%ecx
  126e63:	mov    %rbx,%rsi
  126e66:	mov    0x910(%rbx),%rdx
  126e6d:	push   0x8f0(%rbx)
  126e73:	push   0x8d0(%rbx)
  126e79:	push   %r15
  126e7b:	mov    0x754(%rbx),%eax
  126e81:	push   %rax
  126e82:	sub    $0x748,%rsp
  126e89:	mov    %rsp,%rdi
  126e8c:	rep movsq %ds:(%rsi),%es:(%rdi)
  126e8f:	mov    %r10,%rcx
  126e92:	mov    %r14,%rsi
  126e95:	mov    %r13,%rdi
  126e98:	movss  0x77c(%rsp),%xmm0
  126ea1:	movss  0x134(%rbx),%xmm1
  126ea9:	mov    0x970(%rbx),%r9
  126eb0:	mov    0x950(%rbx),%r8
  126eb7:	call   6aa30 <synreal::granular_kernel::accumulate_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, int const*, int, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  126ebc:	add    $0x770,%rsp
  126ec3:	jmp    126b41 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x181>
  126ec8:	nopl   0x0(%rax,%rax,1)
  126ed0:	movdqu 0x7d0(%rbx),%xmm5
  126ed8:	movdqu 0x7b0(%rbx),%xmm2
  126ee0:	sub    $0x8,%rsp
  126ee4:	mov    %r15,%rdi
  126ee7:	movdqu 0x850(%rbx),%xmm7
  126eef:	movdqu 0x830(%rbx),%xmm0
  126ef7:	movdqu 0x770(%rbx),%xmm3
  126eff:	punpcklqdq %xmm5,%xmm2
  126f03:	movdqu 0x790(%rbx),%xmm5
  126f0b:	punpcklqdq %xmm7,%xmm0
  126f0f:	movdqu 0x810(%rbx),%xmm6
  126f17:	movdqu 0x7f0(%rbx),%xmm1
  126f1f:	movaps %xmm2,0xc8(%rsp)
  126f27:	punpcklqdq %xmm5,%xmm3
  126f2b:	movaps %xmm0,0xe8(%rsp)
  126f33:	movdqu 0x870(%rbx),%xmm0
  126f3b:	movss  0x128(%rbx),%xmm2
  126f43:	movaps %xmm3,0xb8(%rsp)
  126f4b:	movdqu 0x890(%rbx),%xmm3
  126f53:	punpcklqdq %xmm6,%xmm1
  126f57:	movd   0x750(%rbx),%xmm6
  126f5f:	movaps %xmm1,0xd8(%rsp)
  126f67:	movss  0x12c(%rbx),%xmm1
  126f6f:	mov    0x8b0(%rbx),%r8
  126f76:	punpcklqdq %xmm3,%xmm0
  126f7a:	mov    0x8d0(%rbx),%rsi
  126f81:	movq   %xmm3,%rcx
  126f86:	mov    0x870(%rbx),%rdx
  126f8d:	movaps %xmm0,0xf8(%rsp)
  126f95:	movd   0x748(%rbx),%xmm0
  126f9d:	mov    %r8,0x108(%rsp)
  126fa5:	punpckldq %xmm6,%xmm0
  126fa9:	movq   %xmm0,0x110(%rsp)
  126fb2:	movss  0x130(%rbx),%xmm0
  126fba:	unpcklps %xmm0,%xmm1
  126fbd:	movss  0x75c(%rbx),%xmm0
  126fc5:	unpcklps %xmm2,%xmm0
  126fc8:	movlhps %xmm1,%xmm0
  126fcb:	movaps %xmm0,0x118(%rsp)
  126fd3:	movss  0x760(%rbx),%xmm0
  126fdb:	movss  %xmm0,0x128(%rsp)
  126fe4:	push   0x128(%rsp)
  126feb:	push   0x128(%rsp)
  126ff2:	push   0x128(%rsp)
  126ff9:	push   0x128(%rsp)
  127000:	push   0x128(%rsp)
  127007:	push   0x128(%rsp)
  12700e:	push   0x128(%rsp)
  127015:	push   0x128(%rsp)
  12701c:	push   0x128(%rsp)
  127023:	push   0x128(%rsp)
  12702a:	push   0x128(%rsp)
  127031:	push   0x128(%rsp)
  127038:	push   0x128(%rsp)
  12703f:	push   0x128(%rsp)
  127046:	push   0x128(%rsp)
  12704d:	call   6aef0 <synreal::granular_kernel::accumulate_contacts(synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, int*, int*, glm::vec<4, float, (glm::qualifier)0>*)@plt>
  127052:	sub    $0xffffffffffffff80,%rsp
  127056:	jmp    126b33 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x173>
