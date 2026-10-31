
../_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

00000000001207c0 <synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)>:
  1207c0:	endbr64 
  1207c4:	push   %r15
  1207c6:	mov    %rsi,%r15
  1207c9:	mov    $0xff,%esi
  1207ce:	push   %r14
  1207d0:	mov    %rcx,%r14
  1207d3:	mov    %r8,%rcx
  1207d6:	push   %r13
  1207d8:	mov    %rdx,%r13
  1207db:	push   %r12
  1207dd:	push   %rbp
  1207de:	mov    %r8,%rbp
  1207e1:	push   %rbx
  1207e2:	mov    %rdi,%rbx
  1207e5:	sub    $0x108,%rsp
  1207ec:	movslq 0x754(%rdi),%rdx
  1207f3:	movss  %xmm0,0x760(%rdi)
  1207fb:	mov    0x770(%rdi),%rdi
  120802:	shl    $0x2,%rdx
  120806:	call   6e9d0 <cudaMemsetAsync@plt>
  12080b:	mov    %eax,%edi
  12080d:	call   6b600 <synreal::(anonymous namespace)::check(cudaError)@plt>
  120812:	movslq 0x758(%rbx),%rax
  120819:	xor    %esi,%esi
  12081b:	mov    %rbp,%rcx
  12081e:	mov    0x8d0(%rbx),%rdi
  120825:	lea    (%rax,%rax,8),%rdx
  120829:	shl    $0x2,%rdx
  12082d:	call   6e9d0 <cudaMemsetAsync@plt>
  120832:	mov    %eax,%edi
  120834:	call   6b600 <synreal::(anonymous namespace)::check(cudaError)@plt>
  120839:	mov    0x74c(%rbx),%edx
  12083f:	mov    %rbp,%r9
  120842:	mov    0xdd4ff(%rip),%r12        # 1fdd48 <thrust::THRUST_200302_520_NS::system::detail::sequential::seq+0x7>
  120849:	mov    $0x1,%ecx
  12084e:	movl   $0x1,0x28(%rsp)
  120856:	lea    0xfe(%rdx),%eax
  12085c:	add    $0x7f,%edx
  12085f:	mov    %r12,0x20(%rsp)
  120864:	cmovns %edx,%eax
  120867:	xor    %r8d,%r8d
  12086a:	movabs $0x100000080,%rdx
  120874:	sar    $0x7,%eax
  120877:	mov    %eax,0x90(%rsp)
  12087e:	movabs $0x100000001,%rax
  120888:	mov    %rax,0x94(%rsp)
  120890:	mov    0x90(%rsp),%rdi
  120898:	mov    0x98(%rsp),%esi
  12089f:	call   6f040 <__cudaPushCallConfiguration@plt>
  1208a4:	test   %eax,%eax
  1208a6:	je     120980 <synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x1c0>
  1208ac:	mov    0x750(%rbx),%ecx
  1208b2:	mov    %r12,%rdx
  1208b5:	mov    %rbp,%r9
  1208b8:	mov    %r12,0x10(%rsp)
  1208bd:	movl   $0x1,0x18(%rsp)
  1208c5:	lea    0xfe(%rcx),%eax
  1208cb:	add    $0x7f,%ecx
  1208ce:	cmovns %ecx,%eax
  1208d1:	xor    %r8d,%r8d
  1208d4:	mov    $0x1,%ecx
  1208d9:	sar    $0x7,%eax
  1208dc:	mov    %eax,0x90(%rsp)
  1208e3:	movabs $0x100000001,%rax
  1208ed:	mov    %rax,0x94(%rsp)
  1208f5:	mov    0x90(%rsp),%rdi
  1208fd:	mov    0x98(%rsp),%esi
  120904:	call   6f040 <__cudaPushCallConfiguration@plt>
  120909:	test   %eax,%eax
  12090b:	je     120b50 <synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x390>
  120911:	mov    0x750(%rbx),%ecx
  120917:	mov    %r12,%rdx
  12091a:	mov    %rbp,%r9
  12091d:	lea    0xfe(%rcx),%eax
  120923:	add    $0x7f,%ecx
  120926:	cmovns %ecx,%eax
  120929:	xor    %r8d,%r8d
  12092c:	mov    $0x1,%ecx
  120931:	sar    $0x7,%eax
  120934:	mov    %eax,0x10(%rsp)
  120938:	movabs $0x100000001,%rax
  120942:	mov    %rax,0x14(%rsp)
  120947:	mov    0x10(%rsp),%rdi
  12094c:	mov    0x18(%rsp),%esi
  120950:	call   6f040 <__cudaPushCallConfiguration@plt>
  120955:	test   %eax,%eax
  120957:	je     1209f0 <synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x230>
  12095d:	call   6c900 <cudaGetLastError@plt>
  120962:	add    $0x108,%rsp
  120969:	pop    %rbx
  12096a:	mov    %eax,%edi
  12096c:	pop    %rbp
  12096d:	pop    %r12
  12096f:	pop    %r13
  120971:	pop    %r14
  120973:	pop    %r15
  120975:	jmp    6b600 <synreal::(anonymous namespace)::check(cudaError)@plt>
  12097a:	nopw   0x0(%rax,%rax,1)
  120980:	mov    0x754(%rbx),%eax
  120986:	sub    $0x8,%rsp
  12098a:	mov    0x7b0(%rbx),%r11
  120991:	mov    $0xe9,%ecx
  120996:	mov    0x810(%rbx),%r10
  12099d:	mov    0x850(%rbx),%rdx
  1209a4:	mov    %rbx,%rsi
  1209a7:	push   %rax
  1209a8:	mov    0x74c(%rbx),%eax
  1209ae:	push   %rax
  1209af:	push   0x790(%rbx)
  1209b5:	push   0x770(%rbx)
  1209bb:	sub    $0x748,%rsp
  1209c2:	mov    %rsp,%rdi
  1209c5:	rep movsq %ds:(%rsi),%es:(%rdi)
  1209c8:	mov    %r11,%rcx
  1209cb:	mov    %r10,%rsi
  1209ce:	mov    %r15,%rdi
  1209d1:	mov    0x7f0(%rbx),%r9
  1209d8:	mov    0x7d0(%rbx),%r8
  1209df:	call   6ab70 <synreal::fluid_kernel::build_grid(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float*, int*, int*, glm::vec<3, int, (glm::qualifier)0>*, int*, int*, int, int)@plt>
  1209e4:	add    $0x770,%rsp
  1209eb:	jmp    1208ac <synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0xec>
  1209f0:	movq   0x850(%rbx),%xmm1
  1209f8:	sub    $0x20,%rsp
  1209fc:	movq   0x910(%rbx),%xmm0
  120a04:	mov    %r14,%r8
  120a07:	movd   0x750(%rbx),%xmm7
  120a0f:	mov    0x890(%rbx),%rdx
  120a16:	mov    %r13,%rcx
  120a19:	movhps 0x8f0(%rbx),%xmm1
  120a20:	movhps 0x930(%rbx),%xmm0
  120a27:	movd   0x748(%rbx),%xmm5
  120a2f:	movq   0x7f0(%rbx),%xmm2
  120a37:	movaps %xmm1,0xe0(%rsp)
  120a3f:	mov    0x870(%rbx),%rsi
  120a46:	movd   0xc0(%rbx),%xmm1
  120a4e:	movaps %xmm0,0xf0(%rsp)
  120a56:	movhps 0x810(%rbx),%xmm2
  120a5d:	movd   0x754(%rbx),%xmm0
  120a65:	movq   0x7b0(%rbx),%xmm3
  120a6d:	punpckldq %xmm7,%xmm1
  120a71:	movaps %xmm2,0xd0(%rsp)
  120a79:	movss  0xe4(%rbx),%xmm2
  120a81:	movq   0x770(%rbx),%xmm4
  120a89:	punpckldq %xmm5,%xmm0
  120a8d:	movhps 0x7d0(%rbx),%xmm3
  120a94:	mov    0x830(%rbx),%rdi
  120a9b:	punpcklqdq %xmm1,%xmm0
  120a9f:	movss  0x760(%rbx),%xmm1
  120aa7:	movaps %xmm3,0xc0(%rsp)
  120aaf:	movss  0xe0(%rbx),%xmm3
  120ab7:	movhps 0x790(%rbx),%xmm4
  120abe:	movaps %xmm0,0x100(%rsp)
  120ac6:	unpcklps %xmm1,%xmm2
  120ac9:	movss  0xdc(%rbx),%xmm1
  120ad1:	movaps %xmm4,0xb0(%rsp)
  120ad9:	unpcklps %xmm3,%xmm1
  120adc:	movlhps %xmm2,%xmm1
  120adf:	movaps %xmm1,0x110(%rsp)
  120ae7:	movups %xmm1,0x10(%rsp)
  120aec:	movups %xmm0,(%rsp)
  120af0:	push   0xf8(%rsp)
  120af7:	push   0xf8(%rsp)
  120afe:	mov    0x8d0(%rbx),%r9
  120b05:	push   0xf8(%rsp)
  120b0c:	push   0xf8(%rsp)
  120b13:	push   0xf8(%rsp)
  120b1a:	push   0xf8(%rsp)
  120b21:	push   0xf8(%rsp)
  120b28:	push   0xf8(%rsp)
  120b2f:	push   0xf8(%rsp)
  120b36:	push   0xf8(%rsp)
  120b3d:	call   6afb0 <synreal::fluid_kernel::accumulate_rows(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*)@plt>
  120b42:	add    $0x70,%rsp
  120b46:	jmp    12095d <synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x19d>
  120b4b:	nopl   0x0(%rax,%rax,1)
  120b50:	movq   0x850(%rbx),%xmm0
  120b58:	movd   0x750(%rbx),%xmm5
  120b60:	sub    $0x20,%rsp
  120b64:	movq   0x7f0(%rbx),%xmm1
  120b6c:	mov    0x890(%rbx),%rdx
  120b73:	movhps 0x8f0(%rbx),%xmm0
  120b7a:	mov    0x870(%rbx),%rsi
  120b81:	movd   0x748(%rbx),%xmm6
  120b89:	movaps %xmm0,0x70(%rsp)
  120b8e:	movhps 0x810(%rbx),%xmm1
  120b95:	movq   0x910(%rbx),%xmm0
  120b9d:	movq   0x7b0(%rbx),%xmm2
  120ba5:	movaps %xmm1,0x60(%rsp)
  120baa:	movd   0xc0(%rbx),%xmm1
  120bb2:	movq   0x770(%rbx),%xmm3
  120bba:	movhps 0x930(%rbx),%xmm0
  120bc1:	movhps 0x7d0(%rbx),%xmm2
  120bc8:	mov    0x830(%rbx),%rdi
  120bcf:	punpckldq %xmm5,%xmm1
  120bd3:	movaps %xmm0,0x80(%rsp)
  120bdb:	movd   0x754(%rbx),%xmm0
  120be3:	movhps 0x790(%rbx),%xmm3
  120bea:	movaps %xmm2,0x50(%rsp)
  120bef:	movss  0xe4(%rbx),%xmm2
  120bf7:	punpckldq %xmm6,%xmm0
  120bfb:	movaps %xmm3,0x40(%rsp)
  120c00:	movss  0xe0(%rbx),%xmm3
  120c08:	punpcklqdq %xmm1,%xmm0
  120c0c:	movss  0x760(%rbx),%xmm1
  120c14:	movaps %xmm0,0x90(%rsp)
  120c1c:	unpcklps %xmm1,%xmm2
  120c1f:	movss  0xdc(%rbx),%xmm1
  120c27:	unpcklps %xmm3,%xmm1
  120c2a:	movlhps %xmm2,%xmm1
  120c2d:	movaps %xmm1,0xa0(%rsp)
  120c35:	movups %xmm1,0x10(%rsp)
  120c3a:	movups %xmm0,(%rsp)
  120c3e:	push   0x88(%rsp)
  120c45:	push   0x88(%rsp)
  120c4c:	mov    0x930(%rbx),%r9
  120c53:	push   0x88(%rsp)
  120c5a:	mov    0x910(%rbx),%r8
  120c61:	push   0x88(%rsp)
  120c68:	mov    0x8f0(%rbx),%rcx
  120c6f:	push   0x88(%rsp)
  120c76:	push   0x88(%rsp)
  120c7d:	push   0x88(%rsp)
  120c84:	push   0x88(%rsp)
  120c8b:	push   0x88(%rsp)
  120c92:	push   0x88(%rsp)
  120c99:	call   6aed0 <synreal::fluid_kernel::evaluate_rows(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, float*, float*, int*, int*, glm::vec<4, float, (glm::qualifier)0>*)@plt>
  120c9e:	add    $0x70,%rsp
  120ca2:	jmp    120911 <synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)+0x151>
  120ca7:	nop
  120ca8:	nopl   0x0(%rax,%rax,1)

0000000000120cb0 <synreal::Fluid::limit_step(glm::vec<3, float, (glm::qualifier)0>*, float, float, CUstream_st*)>:
  120cb0:	endbr64 
  120cb4:	push   %r14
  120cb6:	mov    $0x1,%ecx
  120cbb:	movd   %xmm0,%r14d
  120cc0:	push   %r13
  120cc2:	push   %r12
  120cc4:	mov    %rsi,%r12
  120cc7:	push   %rbp
  120cc8:	mov    %rdx,%rbp
  120ccb:	push   %rbx
  120ccc:	mov    %rdi,%rbx
  120ccf:	mov    %rbp,%r9
  120cd2:	sub    $0xa0,%rsp
  120cd9:	mov    0x75c(%rdi),%edx
  120cdf:	mov    0xdd062(%rip),%r13        # 1fdd48 <thrust::THRUST_200302_520_NS::system::detail::sequential::seq+0x7>
  120ce6:	movl   $0x1,0x28(%rsp)
  120cee:	lea    0xfe(%rdx),%eax
  120cf4:	add    $0x7f,%edx
  120cf7:	mov    %r13,0x20(%rsp)
  120cfc:	cmovns %edx,%eax
  120cff:	xor    %r8d,%r8d
  120d02:	movss  %xmm1,0xc(%rsp)
  120d08:	movabs $0x100000080,%rdx
  120d12:	sar    $0x7,%eax
  120d15:	mov    %eax,0x30(%rsp)
  120d19:	movabs $0x100000001,%rax
  120d23:	mov    %rax,0x34(%rsp)
  120d28:	mov    0x30(%rsp),%rdi
  120d2d:	mov    0x38(%rsp),%esi
  120d31:	call   6f040 <__cudaPushCallConfiguration@plt>
  120d36:	test   %eax,%eax
  120d38:	je     120e10 <synreal::Fluid::limit_step(glm::vec<3, float, (glm::qualifier)0>*, float, float, CUstream_st*)+0x160>
  120d3e:	mov    0x750(%rbx),%ecx
  120d44:	mov    %r13,%rdx
  120d47:	mov    %rbp,%r9
  120d4a:	mov    %r13,0x10(%rsp)
  120d4f:	movl   $0x1,0x18(%rsp)
  120d57:	lea    0xfe(%rcx),%eax
  120d5d:	add    $0x7f,%ecx
  120d60:	cmovns %ecx,%eax
  120d63:	xor    %r8d,%r8d
  120d66:	mov    $0x1,%ecx
  120d6b:	sar    $0x7,%eax
  120d6e:	mov    %eax,0x20(%rsp)
  120d72:	movabs $0x100000001,%rax
  120d7c:	mov    %rax,0x24(%rsp)
  120d81:	mov    0x20(%rsp),%rdi
  120d86:	mov    0x28(%rsp),%esi
  120d8a:	call   6f040 <__cudaPushCallConfiguration@plt>
  120d8f:	test   %eax,%eax
  120d91:	je     120e70 <synreal::Fluid::limit_step(glm::vec<3, float, (glm::qualifier)0>*, float, float, CUstream_st*)+0x1c0>
  120d97:	mov    0x758(%rbx),%edx
  120d9d:	mov    %rbp,%r9
  120da0:	mov    $0x1,%ecx
  120da5:	mov    %r13,0x10(%rsp)
  120daa:	movl   $0x1,0x18(%rsp)
  120db2:	lea    0xfe(%rdx),%eax
  120db8:	add    $0x7f,%edx
  120dbb:	cmovns %edx,%eax
  120dbe:	xor    %r8d,%r8d
  120dc1:	mov    %r13,%rdx
  120dc4:	sar    $0x7,%eax
  120dc7:	mov    %eax,0x20(%rsp)
  120dcb:	movabs $0x100000001,%rax
  120dd5:	mov    %rax,0x24(%rsp)
  120dda:	mov    0x20(%rsp),%rdi
  120ddf:	mov    0x28(%rsp),%esi
  120de3:	call   6f040 <__cudaPushCallConfiguration@plt>
  120de8:	test   %eax,%eax
  120dea:	je     120e30 <synreal::Fluid::limit_step(glm::vec<3, float, (glm::qualifier)0>*, float, float, CUstream_st*)+0x180>
  120dec:	call   6c900 <cudaGetLastError@plt>
  120df1:	add    $0xa0,%rsp
  120df8:	pop    %rbx
  120df9:	mov    %eax,%edi
  120dfb:	pop    %rbp
  120dfc:	pop    %r12
  120dfe:	pop    %r13
  120e00:	pop    %r14
  120e02:	jmp    6b600 <synreal::(anonymous namespace)::check(cudaError)@plt>
  120e07:	nopw   0x0(%rax,%rax,1)
  120e10:	mov    0x75c(%rbx),%esi
  120e16:	mov    0x8b0(%rbx),%rdi
  120e1d:	movss  0xdc15b(%rip),%xmm0        # 1fcf80 <cuda::std::__4::in_place+0x33>
  120e25:	call   6ac80 <synreal::fluid_kernel::initialize_scale(float*, float, int)@plt>
  120e2a:	jmp    120d3e <synreal::Fluid::limit_step(glm::vec<3, float, (glm::qualifier)0>*, float, float, CUstream_st*)+0x8e>
  120e2f:	nop
  120e30:	sub    $0x750,%rsp
  120e37:	mov    0x8b0(%rbx),%r8
  120e3e:	mov    $0xe9,%ecx
  120e43:	mov    %rbx,%rsi
  120e46:	mov    0x758(%rbx),%edx
  120e4c:	mov    %rsp,%rdi
  120e4f:	rep movsq %ds:(%rsi),%es:(%rdi)
  120e52:	mov    %r8,%rsi
  120e55:	mov    %r12,%rdi
  120e58:	call   6ac40 <synreal::fluid_kernel::scale_step(synreal::Model, glm::vec<3, float, (glm::qualifier)0>*, float const*, int)@plt>
  120e5d:	add    $0x750,%rsp
  120e64:	jmp    120dec <synreal::Fluid::limit_step(glm::vec<3, float, (glm::qualifier)0>*, float, float, CUstream_st*)+0x13c>
  120e66:	cs nopw 0x0(%rax,%rax,1)
  120e70:	movq   0x850(%rbx),%xmm2
  120e78:	sub    $0x20,%rsp
  120e7c:	mov    %r12,%rdi
  120e7f:	movq   0x910(%rbx),%xmm0
  120e87:	movd   0x750(%rbx),%xmm6
  120e8f:	mov    0x8b0(%rbx),%rsi
  120e96:	movhps 0x8f0(%rbx),%xmm2
  120e9d:	movhps 0x930(%rbx),%xmm0
  120ea4:	movd   0x748(%rbx),%xmm7
  120eac:	movq   0x7f0(%rbx),%xmm3
  120eb4:	movaps %xmm2,0x80(%rsp)
  120ebc:	movd   0xc0(%rbx),%xmm2
  120ec4:	movq   0x7b0(%rbx),%xmm4
  120ecc:	movaps %xmm0,0x90(%rsp)
  120ed4:	movhps 0x810(%rbx),%xmm3
  120edb:	movd   0x754(%rbx),%xmm0
  120ee3:	movss  0xdc(%rbx),%xmm1
  120eeb:	punpckldq %xmm6,%xmm2
  120eef:	movaps %xmm3,0x70(%rsp)
  120ef4:	movhps 0x7d0(%rbx),%xmm4
  120efb:	movss  0xe4(%rbx),%xmm3
  120f03:	punpckldq %xmm7,%xmm0
  120f07:	movaps %xmm4,0x60(%rsp)
  120f0c:	movss  0xe0(%rbx),%xmm4
  120f14:	movq   0x770(%rbx),%xmm5
  120f1c:	punpcklqdq %xmm2,%xmm0
  120f20:	movss  0x760(%rbx),%xmm2
  120f28:	movhps 0x790(%rbx),%xmm5
  120f2f:	movaps %xmm0,0xa0(%rsp)
  120f37:	unpcklps %xmm2,%xmm3
  120f3a:	movaps %xmm1,%xmm2
  120f3d:	movaps %xmm5,0x50(%rsp)
  120f42:	unpcklps %xmm4,%xmm2
  120f45:	movlhps %xmm3,%xmm2
  120f48:	movaps %xmm2,0xb0(%rsp)
  120f50:	movups %xmm2,0x10(%rsp)
  120f55:	movups %xmm0,(%rsp)
  120f59:	movd   %r14d,%xmm0
  120f5e:	push   0x98(%rsp)
  120f65:	push   0x98(%rsp)
  120f6c:	push   0x98(%rsp)
  120f73:	push   0x98(%rsp)
  120f7a:	push   0x98(%rsp)
  120f81:	push   0x98(%rsp)
  120f88:	push   0x98(%rsp)
  120f8f:	push   0x98(%rsp)
  120f96:	push   0x98(%rsp)
  120f9d:	push   0x98(%rsp)
  120fa4:	mulss  0x7c(%rsp),%xmm1
  120faa:	call   6a800 <synreal::fluid_kernel::bound_scale(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, float, float, float*)@plt>
  120faf:	add    $0x70,%rsp
  120fb3:	jmp    120d97 <synreal::Fluid::limit_step(glm::vec<3, float, (glm::qualifier)0>*, float, float, CUstream_st*)+0xe7>
  120fb8:	nopl   0x0(%rax,%rax,1)

0000000000120fc0 <synreal::Fluid::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const>:
  120fc0:	endbr64 
  120fc4:	push   %r13
  120fc6:	mov    %rdx,%r13
  120fc9:	mov    %rcx,%r9
  120fcc:	mov    $0x1,%ecx
  120fd1:	push   %r12
  120fd3:	mov    %rsi,%r12
  120fd6:	push   %rbx
  120fd7:	mov    %rdi,%rbx
  120fda:	sub    $0xb0,%rsp
  120fe1:	mov    0x750(%rdi),%edx
  120fe7:	lea    0xfe(%rdx),%eax
  120fed:	add    $0x7f,%edx
  120ff0:	cmovns %edx,%eax
  120ff3:	xor    %r8d,%r8d
  120ff6:	movabs $0x100000080,%rdx
  121000:	sar    $0x7,%eax
  121003:	mov    %eax,0x34(%rsp)
  121007:	movabs $0x100000001,%rax
  121011:	mov    %rax,0x38(%rsp)
  121016:	mov    0x34(%rsp),%rdi
  12101b:	mov    0x3c(%rsp),%esi
  12101f:	call   6f040 <__cudaPushCallConfiguration@plt>
  121024:	test   %eax,%eax
  121026:	je     121040 <synreal::Fluid::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const+0x80>
  121028:	call   6c900 <cudaGetLastError@plt>
  12102d:	add    $0xb0,%rsp
  121034:	pop    %rbx
  121035:	mov    %eax,%edi
  121037:	pop    %r12
  121039:	pop    %r13
  12103b:	jmp    6b600 <synreal::(anonymous namespace)::check(cudaError)@plt>
  121040:	movq   0x910(%rbx),%xmm0
  121048:	mov    %r13,%rcx
  12104b:	mov    %r12,%rdx
  12104e:	movq   0x850(%rbx),%xmm1
  121056:	movd   0x750(%rbx),%xmm7
  12105e:	mov    0x890(%rbx),%rsi
  121065:	movhps 0x930(%rbx),%xmm0
  12106c:	movhps 0x8f0(%rbx),%xmm1
  121073:	movq   0x7f0(%rbx),%xmm2
  12107b:	movq   0x7b0(%rbx),%xmm3
  121083:	movaps %xmm0,0x80(%rsp)
  12108b:	movd   0xc0(%rbx),%xmm0
  121093:	movq   0x770(%rbx),%xmm4
  12109b:	movaps %xmm1,0x70(%rsp)
  1210a0:	movd   0x754(%rbx),%xmm1
  1210a8:	movhps 0x810(%rbx),%xmm2
  1210af:	movhps 0x7d0(%rbx),%xmm3
  1210b6:	punpckldq %xmm7,%xmm0
  1210ba:	movd   0x748(%rbx),%xmm7
  1210c2:	movaps %xmm2,0x60(%rsp)
  1210c7:	movss  0xe0(%rbx),%xmm2
  1210cf:	movhps 0x790(%rbx),%xmm4
  1210d6:	movaps %xmm3,0x50(%rsp)
  1210db:	mov    0x830(%rbx),%rdi
  1210e2:	punpckldq %xmm7,%xmm1
  1210e6:	movaps %xmm4,0x40(%rsp)
  1210eb:	movdqa %xmm1,%xmm5
  1210ef:	movss  0x760(%rbx),%xmm1
  1210f7:	punpcklqdq %xmm0,%xmm5
  1210fb:	movss  0xe4(%rbx),%xmm0
  121103:	movaps %xmm5,0x10(%rsp)
  121108:	unpcklps %xmm1,%xmm0
  12110b:	movss  0xdc(%rbx),%xmm1
  121113:	unpcklps %xmm2,%xmm1
  121116:	movaps %xmm1,%xmm6
  121119:	movlhps %xmm0,%xmm6
  12111c:	movaps %xmm6,(%rsp)
  121120:	push   0x8(%rsp)
  121124:	push   0x8(%rsp)
  121128:	push   0x28(%rsp)
  12112c:	push   0x28(%rsp)
  121130:	push   0xa8(%rsp)
  121137:	push   0xa8(%rsp)
  12113e:	push   0xa8(%rsp)
  121145:	push   0xa8(%rsp)
  12114c:	push   0xa8(%rsp)
  121153:	push   0xa8(%rsp)
  12115a:	push   0xa8(%rsp)
  121161:	push   0xa8(%rsp)
  121168:	push   0xa8(%rsp)
  12116f:	push   0xa8(%rsp)
  121176:	call   6af70 <synreal::fluid_kernel::multiply_rows(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*)@plt>
  12117b:	add    $0x70,%rsp
  12117f:	jmp    121028 <synreal::Fluid::multiply(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*) const+0x68>
  121184:	data16 cs nopw 0x0(%rax,%rax,1)
  12118f:	nop

0000000000121190 <synreal::Fluid::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const>:
  121190:	endbr64 
  121194:	push   %rbp
  121195:	mov    %rsi,%rbp
  121198:	mov    %rdx,%r9
  12119b:	movabs $0x100000080,%rdx
  1211a5:	push   %rbx
  1211a6:	mov    %rdi,%rbx
  1211a9:	sub    $0x28,%rsp
  1211ad:	mov    0x758(%rdi),%ecx
  1211b3:	lea    0xfe(%rcx),%eax
  1211b9:	add    $0x7f,%ecx
  1211bc:	cmovns %ecx,%eax
  1211bf:	xor    %r8d,%r8d
  1211c2:	mov    $0x1,%ecx
  1211c7:	sar    $0x7,%eax
  1211ca:	mov    %eax,0x14(%rsp)
  1211ce:	movabs $0x100000001,%rax
  1211d8:	mov    %rax,0x18(%rsp)
  1211dd:	mov    0x14(%rsp),%rdi
  1211e2:	mov    0x1c(%rsp),%esi
  1211e6:	call   6f040 <__cudaPushCallConfiguration@plt>
  1211eb:	test   %eax,%eax
  1211ed:	je     121208 <synreal::Fluid::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const+0x78>
  1211ef:	call   6c900 <cudaGetLastError@plt>
  1211f4:	add    $0x28,%rsp
  1211f8:	pop    %rbx
  1211f9:	mov    %eax,%edi
  1211fb:	pop    %rbp
  1211fc:	jmp    6b600 <synreal::(anonymous namespace)::check(cudaError)@plt>
  121201:	nopl   0x0(%rax)
  121208:	mov    0x758(%rbx),%edx
  12120e:	mov    0x8d0(%rbx),%rdi
  121215:	mov    %rbp,%rsi
  121218:	call   6ab90 <synreal::fluid_kernel::add_diagonal(glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int)@plt>
  12121d:	jmp    1211ef <synreal::Fluid::add_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0>*, CUstream_st*) const+0x5f>
  12121f:	nop

0000000000121220 <void* thrust::THRUST_200302_520_NS::cuda_cub::malloc<thrust::THRUST_200302_520_NS::cuda_cub::tag>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, unsigned long) [clone .isra.0]>:
  121220:	push   %r12
  121222:	mov    %rdi,%rsi
  121225:	push   %rbp
  121226:	push   %rbx
  121227:	sub    $0x60,%rsp
  12122b:	mov    %fs:0x28,%rax
  121234:	mov    %rax,0x58(%rsp)
  121239:	xor    %eax,%eax
  12123b:	lea    0x8(%rsp),%rdi
  121240:	movq   $0x0,0x8(%rsp)
  121249:	call   6b150 <cudaMalloc@plt>
  12124e:	test   %eax,%eax
  121250:	jne    121274 <void* thrust::THRUST_200302_520_NS::cuda_cub::malloc<thrust::THRUST_200302_520_NS::cuda_cub::tag>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, unsigned long) [clone .isra.0]+0x54>
  121252:	mov    0x8(%rsp),%rax
  121257:	mov    0x58(%rsp),%rdx
  12125c:	sub    %fs:0x28,%rdx
  121265:	jne    1212ff <void* thrust::THRUST_200302_520_NS::cuda_cub::malloc<thrust::THRUST_200302_520_NS::cuda_cub::tag>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, unsigned long) [clone .isra.0]+0xdf>
  12126b:	add    $0x60,%rsp
  12126f:	pop    %rbx
  121270:	pop    %rbp
  121271:	pop    %r12
  121273:	ret    
  121274:	mov    %eax,%r12d
  121277:	call   6c900 <cudaGetLastError@plt>
  12127c:	mov    $0x28,%edi
  121281:	call   6bf30 <__cxa_allocate_exception@plt>
  121286:	mov    %rax,%rbp
  121289:	call   6d3f0 <thrust::THRUST_200302_520_NS::system::cuda_category()@plt>
  12128e:	lea    0x10(%rsp),%rdi
  121293:	mov    %r12d,%edx
  121296:	mov    %rax,%rsi
  121299:	mov    (%rax),%rax
  12129c:	call   *0x30(%rax)
  12129f:	lea    0x30(%rsp),%r12
  1212a4:	mov    0x10(%rsp),%rsi
  1212a9:	mov    %r12,%rdi
  1212ac:	call   11f9c0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&) [clone .constprop.0]>
  1212b1:	mov    %r12,%rsi
  1212b4:	mov    %rbp,%rdi
  1212b7:	call   6d6b0 <thrust::THRUST_200302_520_NS::system::detail::bad_alloc::bad_alloc(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)@plt>
  1212bc:	mov    0x30(%rsp),%rdi
  1212c1:	lea    0x40(%rsp),%rax
  1212c6:	cmp    %rax,%rdi
  1212c9:	je     1212d9 <void* thrust::THRUST_200302_520_NS::cuda_cub::malloc<thrust::THRUST_200302_520_NS::cuda_cub::tag>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, unsigned long) [clone .isra.0]+0xb9>
  1212cb:	mov    0x40(%rsp),%rax
  1212d0:	lea    0x1(%rax),%rsi
  1212d4:	call   6d220 <operator delete(void*, unsigned long)@plt>
  1212d9:	mov    0x10(%rsp),%rdi
  1212de:	lea    0x20(%rsp),%rax
  1212e3:	cmp    %rax,%rdi
  1212e6:	je     7a753 <void* thrust::THRUST_200302_520_NS::cuda_cub::malloc<thrust::THRUST_200302_520_NS::cuda_cub::tag>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, unsigned long) [clone .isra.0] [clone .cold]+0x4a>
  1212ec:	mov    0x20(%rsp),%rax
  1212f1:	lea    0x1(%rax),%rsi
  1212f5:	call   6d220 <operator delete(void*, unsigned long)@plt>
  1212fa:	jmp    7a753 <void* thrust::THRUST_200302_520_NS::cuda_cub::malloc<thrust::THRUST_200302_520_NS::cuda_cub::tag>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, unsigned long) [clone .isra.0] [clone .cold]+0x4a>
  1212ff:	call   6d630 <__stack_chk_fail@plt>
  121304:	endbr64 
  121308:	mov    %rax,%rbx
  12130b:	jmp    7a709 <void* thrust::THRUST_200302_520_NS::cuda_cub::malloc<thrust::THRUST_200302_520_NS::cuda_cub::tag>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, unsigned long) [clone .isra.0] [clone .cold]>
  121310:	endbr64 
  121314:	mov    %rax,%rbx
  121317:	jmp    7a726 <void* thrust::THRUST_200302_520_NS::cuda_cub::malloc<thrust::THRUST_200302_520_NS::cuda_cub::tag>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, unsigned long) [clone .isra.0] [clone .cold]+0x1d>
  12131c:	endbr64 
  121320:	mov    %rax,%rbx
  121323:	jmp    7a743 <void* thrust::THRUST_200302_520_NS::cuda_cub::malloc<thrust::THRUST_200302_520_NS::cuda_cub::tag>(thrust::THRUST_200302_520_NS::cuda_cub::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, unsigned long) [clone .isra.0] [clone .cold]+0x3a>
  121328:	nopl   0x0(%rax,%rax,1)

0000000000121330 <synreal::Fluid::initialize(synreal::Model const&)>:
  121330:	endbr64 
  121334:	push   %r15
  121336:	mov    $0xe9,%ecx
  12133b:	push   %r14
  12133d:	push   %r13
  12133f:	push   %r12
  121341:	mov    %rdi,%r12
  121344:	push   %rbp
  121345:	mov    %rsi,%rbp
  121348:	push   %rbx
  121349:	sub    $0x128,%rsp
