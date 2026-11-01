
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

000000000011b7f0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)>:
  11b7f0:	endbr64 
  11b7f4:	push   %rbp
  11b7f5:	mov    %rsp,%rbp
  11b7f8:	push   %r15
  11b7fa:	push   %r14
  11b7fc:	push   %r13
  11b7fe:	push   %r12
  11b800:	push   %rbx
  11b801:	sub    $0xe8,%rsp
  11b808:	mov    %rsi,-0x108(%rbp)
  11b80f:	mov    %fs:0x28,%rax
  11b818:	mov    %rax,-0x38(%rbp)
  11b81c:	xor    %eax,%eax
  11b81e:	test   %rsi,%rsi
  11b821:	je     11ba10 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x220>
  11b827:	mov    0x10(%rdi),%rax
  11b82b:	mov    0x18(%rdi),%r12
  11b82f:	mov    %rdi,%rbx
  11b832:	mov    %rsi,%rcx
  11b835:	mov    %rax,%rdx
  11b838:	sub    %r12,%rdx
  11b83b:	cmp    %rsi,%rdx
  11b83e:	jae    11ba38 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x248>
  11b844:	cmp    %rsi,%r12
  11b847:	mov    %rsi,%r13
  11b84a:	movq   $0x0,-0xe8(%rbp)
  11b855:	movq   $0x0,-0xe0(%rbp)
  11b860:	cmovae %r12,%r13
  11b864:	add    %rax,%rax
  11b867:	add    %r12,%r13
  11b86a:	cmp    %rax,%r13
  11b86d:	cmovb  %rax,%r13
  11b871:	mov    (%rdi),%rax
  11b874:	mov    %rax,-0xf0(%rbp)
  11b87b:	test   %r13,%r13
  11b87e:	jne    11bb88 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x398>
  11b884:	movq   $0x0,-0xe8(%rbp)
  11b88f:	mov    %r12,%rax
  11b892:	xor    %r15d,%r15d
  11b895:	lea    (%rax,%rax,8),%r14
  11b899:	mov    0x8(%rbx),%rsi
  11b89d:	shl    $0x2,%r14
  11b8a1:	test   %r14,%r14
  11b8a4:	jle    11b8e8 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0xf8>
  11b8a6:	mov    $0x1,%r8d
  11b8ac:	mov    $0x3,%ecx
  11b8b1:	mov    %r14,%rdx
  11b8b4:	mov    %r15,%rdi
  11b8b7:	call   6e0b0 <cudaMemcpyAsync@plt>
  11b8bc:	mov    $0x1,%edi
  11b8c1:	mov    %eax,-0x10c(%rbp)
  11b8c7:	call   6d140 <cudaStreamSynchronize@plt>
  11b8cc:	call   6c890 <cudaGetLastError@plt>
  11b8d1:	call   6c890 <cudaGetLastError@plt>
  11b8d6:	mov    -0x10c(%rbp),%eax
  11b8dc:	test   %eax,%eax
  11b8de:	jne    11bd9d <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x5ad>
  11b8e4:	nopl   0x0(%rax)
  11b8e8:	pxor   %xmm0,%xmm0
  11b8ec:	add    %r14,%r15
  11b8ef:	sub    $0x30,%rsp
  11b8f3:	mov    $0x1,%esi
  11b8f8:	movups %xmm0,-0x88(%rbp)
  11b8ff:	mov    -0x108(%rbp),%rdi
  11b906:	movups %xmm0,-0x98(%rbp)
  11b90d:	movdqa -0x90(%rbp),%xmm1
  11b915:	movl   $0x0,-0x78(%rbp)
  11b91c:	movdqa -0x80(%rbp),%xmm2
  11b921:	mov    %r15,-0xa0(%rbp)
  11b928:	movaps %xmm0,-0xd0(%rbp)
  11b92f:	movaps %xmm0,-0xc0(%rbp)
  11b936:	movdqa -0xa0(%rbp),%xmm0
  11b93e:	movl   $0x0,-0xb0(%rbp)
  11b948:	movaps %xmm0,-0x70(%rbp)
  11b94c:	movaps %xmm1,-0x60(%rbp)
  11b950:	movaps %xmm2,-0x50(%rbp)
  11b954:	movups %xmm2,0x20(%rsp)
  11b959:	movups %xmm1,0x10(%rsp)
  11b95e:	movups %xmm0,(%rsp)
  11b962:	call   6d320 <cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> >, glm::mat<3, 3, float, (glm::qualifier)0> >, unsigned long>(unsigned long, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> >, glm::mat<3, 3, float, (glm::qualifier)0> >, CUstream_st*)@plt>
  11b967:	add    $0x30,%rsp
  11b96b:	mov    %eax,%r14d
  11b96e:	call   6c890 <cudaGetLastError@plt>
  11b973:	test   %r14d,%r14d
  11b976:	jne    11be64 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x674>
  11b97c:	mov    $0x1,%edi
  11b981:	call   6d140 <cudaStreamSynchronize@plt>
  11b986:	mov    %eax,%r15d
  11b989:	call   6c890 <cudaGetLastError@plt>
  11b98e:	mov    %eax,%r14d
  11b991:	test   %r15d,%r15d
  11b994:	jne    11bbc8 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x3d8>
  11b99a:	test   %eax,%eax
  11b99c:	je     11bbc8 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x3d8>
  11b9a2:	call   6c890 <cudaGetLastError@plt>
  11b9a7:	test   %r14d,%r14d
  11b9aa:	jne    11bee6 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x6f6>
  11b9b0:	mov    -0xe8(%rbp),%rax
  11b9b7:	mov    (%rbx),%rdx
  11b9ba:	mov    0x8(%rbx),%rdi
  11b9be:	mov    -0xf0(%rbp),%rcx
  11b9c5:	mov    %rax,0x8(%rbx)
  11b9c9:	mov    0x10(%rbx),%rax
  11b9cd:	add    -0x108(%rbp),%r12
  11b9d4:	mov    %rdi,-0xe8(%rbp)
  11b9db:	mov    %r13,0x10(%rbx)
  11b9df:	mov    %rax,-0xe0(%rbp)
  11b9e6:	mov    %rdx,-0xf8(%rbp)
  11b9ed:	mov    %rcx,(%rbx)
  11b9f0:	mov    %rdx,-0xf0(%rbp)
  11b9f7:	mov    %r12,0x18(%rbx)
  11b9fb:	test   %rax,%rax
  11b9fe:	je     11ba10 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x220>
  11ba00:	call   6e120 <cudaFree@plt>
  11ba05:	mov    %eax,%ebx
  11ba07:	test   %eax,%eax
  11ba09:	jne    11bcd8 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x4e8>
  11ba0f:	nop
  11ba10:	mov    -0x38(%rbp),%rax
  11ba14:	sub    %fs:0x28,%rax
  11ba1d:	jne    11bbd0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x3e0>
  11ba23:	lea    -0x28(%rbp),%rsp
  11ba27:	pop    %rbx
  11ba28:	pop    %r12
  11ba2a:	pop    %r13
  11ba2c:	pop    %r14
  11ba2e:	pop    %r15
  11ba30:	pop    %rbp
  11ba31:	ret    
  11ba32:	nopw   0x0(%rax,%rax,1)
  11ba38:	mov    0x8(%rdi),%rax
  11ba3c:	lea    (%r12,%r12,8),%rdx
  11ba40:	pxor   %xmm0,%xmm0
  11ba44:	sub    $0x30,%rsp
  11ba48:	movups %xmm0,-0x88(%rbp)
  11ba4f:	mov    $0x1,%esi
  11ba54:	mov    %rcx,%rdi
  11ba57:	lea    (%rax,%rdx,4),%rax
  11ba5b:	movups %xmm0,-0x98(%rbp)
  11ba62:	movdqa -0x90(%rbp),%xmm1
  11ba6a:	movl   $0x0,-0x78(%rbp)
  11ba71:	movdqa -0x80(%rbp),%xmm2
  11ba76:	mov    %rax,-0xa0(%rbp)
  11ba7d:	movaps %xmm0,-0xd0(%rbp)
  11ba84:	movaps %xmm0,-0xc0(%rbp)
  11ba8b:	movdqa -0xa0(%rbp),%xmm0
  11ba93:	movups %xmm2,0x20(%rsp)
  11ba98:	movups %xmm1,0x10(%rsp)
  11ba9d:	movups %xmm0,(%rsp)
  11baa1:	movl   $0x0,-0xb0(%rbp)
  11baab:	movaps %xmm0,-0x70(%rbp)
  11baaf:	movaps %xmm1,-0x60(%rbp)
  11bab3:	movaps %xmm2,-0x50(%rbp)
  11bab7:	call   6d320 <cudaError thrust::THRUST_200302_520_NS::cuda_cub::__parallel_for::parallel_for<thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> >, glm::mat<3, 3, float, (glm::qualifier)0> >, unsigned long>(unsigned long, thrust::THRUST_200302_520_NS::cuda_cub::__uninitialized_fill::functor<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> >, glm::mat<3, 3, float, (glm::qualifier)0> >, CUstream_st*)@plt>
  11babc:	add    $0x30,%rsp
  11bac0:	mov    %eax,%r12d
  11bac3:	call   6c890 <cudaGetLastError@plt>
  11bac8:	test   %r12d,%r12d
  11bacb:	jne    11bd4d <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x55d>
  11bad1:	mov    $0x1,%edi
  11bad6:	call   6d140 <cudaStreamSynchronize@plt>
  11badb:	mov    %eax,%r13d
  11bade:	call   6c890 <cudaGetLastError@plt>
  11bae3:	mov    %eax,%r12d
  11bae6:	test   %r13d,%r13d
  11bae9:	jne    11bb68 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x378>
  11baeb:	test   %eax,%eax
  11baed:	je     11bb68 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x378>
  11baef:	call   6c890 <cudaGetLastError@plt>
  11baf4:	mov    %r12d,%r13d
  11baf7:	mov    $0x40,%edi
  11bafc:	call   6beb0 <__cxa_allocate_exception@plt>
  11bb01:	mov    %rax,%r15
  11bb04:	call   6d380 <thrust::THRUST_200302_520_NS::system::cuda_category()@plt>
  11bb09:	lea    0xdbe00(%rip),%rsi        # 1f7910 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7a10>
  11bb10:	mov    %r15,%rdi
  11bb13:	mov    %rax,%rbx
  11bb16:	call   6f320 <std::runtime_error::runtime_error(char const*)@plt>
  11bb1b:	mov    0x59b30e(%rip),%rax        # 6b6e30 <vtable for thrust::THRUST_200302_520_NS::system::system_error@@Base+0x1420>
  11bb22:	mov    %r13d,0x10(%r15)
  11bb26:	movq   %rbx,%xmm0
  11bb2b:	mov    %r15,%rdi
  11bb2e:	add    $0x10,%rax
  11bb32:	mov    %rax,(%r15)
  11bb35:	lea    0x30(%r15),%rax
  11bb39:	movq   %rax,%xmm4
  11bb3e:	punpcklqdq %xmm4,%xmm0
  11bb42:	movq   $0x0,0x28(%rdi)
  11bb4a:	mov    0x59ba7f(%rip),%rdx        # 6b75d0 <thrust::THRUST_200302_520_NS::system::system_error::~system_error()@@Base+0x5a7f50>
  11bb51:	movb   $0x0,0x30(%rdi)
  11bb55:	mov    0x59c1ec(%rip),%rsi        # 6b7d48 <typeinfo for thrust::THRUST_200302_520_NS::system::system_error@@Base+0x2480>
  11bb5c:	movups %xmm0,0x18(%rdi)
  11bb60:	call   6ec80 <__cxa_throw@plt>
  11bb65:	nopl   (%rax)
  11bb68:	call   6c890 <cudaGetLastError@plt>
  11bb6d:	test   %r13d,%r13d
  11bb70:	jne    11baf7 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x307>
  11bb72:	mov    -0x108(%rbp),%rax
  11bb79:	add    %rax,0x18(%rbx)
  11bb7d:	jmp    11ba10 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x220>
  11bb82:	nopw   0x0(%rax,%rax,1)
  11bb88:	lea    0x0(%r13,%r13,8),%rsi
  11bb8d:	lea    -0xf8(%rbp),%rdi
  11bb94:	shl    $0x2,%rsi
  11bb98:	call   6b120 <cudaMalloc@plt>
  11bb9d:	mov    %eax,%r14d
  11bba0:	test   %eax,%eax
  11bba2:	jne    11bbd5 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x3e5>
  11bba4:	mov    -0xf8(%rbp),%r15
  11bbab:	mov    0x18(%rbx),%rax
  11bbaf:	mov    %r13,-0xe0(%rbp)
  11bbb6:	mov    %r15,-0xe8(%rbp)
  11bbbd:	jmp    11b895 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0xa5>
  11bbc2:	nopw   0x0(%rax,%rax,1)
  11bbc8:	mov    %r15d,%r14d
  11bbcb:	jmp    11b9a2 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x1b2>
  11bbd0:	call   6d5c0 <__stack_chk_fail@plt>
  11bbd5:	call   6c890 <cudaGetLastError@plt>
  11bbda:	mov    $0x28,%edi
  11bbdf:	call   6beb0 <__cxa_allocate_exception@plt>
  11bbe4:	mov    %rax,%rbx
  11bbe7:	mov    %rax,%r15
  11bbea:	call   6d380 <thrust::THRUST_200302_520_NS::system::cuda_category()@plt>
  11bbef:	lea    -0x70(%rbp),%rdi
  11bbf3:	mov    %r14d,%edx
  11bbf6:	mov    %rax,%rsi
  11bbf9:	mov    (%rax),%rax
  11bbfc:	call   *0x30(%rax)
  11bbff:	lea    -0xa0(%rbp),%r12
  11bc06:	mov    -0x70(%rbp),%rsi
  11bc0a:	mov    %r12,%rdi
  11bc0d:	call   efea0 <std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::basic_string<std::allocator<char> >(char const*, std::allocator<char> const&) [clone .constprop.0]>
  11bc12:	mov    %r12,%rsi
  11bc15:	mov    %rbx,%rdi
  11bc18:	call   6d630 <thrust::THRUST_200302_520_NS::system::detail::bad_alloc::bad_alloc(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)@plt>
  11bc1d:	mov    -0xa0(%rbp),%rdi
  11bc24:	lea    -0x90(%rbp),%rax
  11bc2b:	cmp    %rax,%rdi
  11bc2e:	je     11bc40 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x450>
  11bc30:	mov    -0x90(%rbp),%rax
  11bc37:	lea    0x1(%rax),%rsi
  11bc3b:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  11bc40:	mov    -0x70(%rbp),%rdi
  11bc44:	lea    -0x60(%rbp),%rax
  11bc48:	cmp    %rax,%rdi
  11bc4b:	je     11bc5a <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x46a>
  11bc4d:	mov    -0x60(%rbp),%rax
  11bc51:	lea    0x1(%rax),%rsi
  11bc55:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  11bc5a:	mov    0x59b0f7(%rip),%rdx        # 6b6d58 <thrust::THRUST_200302_520_NS::system::detail::bad_alloc::~bad_alloc()@@Base+0x5a7698>
  11bc61:	mov    0x59b090(%rip),%rsi        # 6b6cf8 <typeinfo for thrust::THRUST_200302_520_NS::system::detail::bad_alloc@@Base+0x1400>
  11bc68:	mov    %r15,%rdi
  11bc6b:	call   6ec80 <__cxa_throw@plt>
  11bc70:	endbr64 
  11bc74:	mov    %rax,%rbx
  11bc77:	jmp    11bc8b <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x49b>
  11bc79:	endbr64 
  11bc7d:	mov    %rax,%rbx
  11bc80:	jmp    11bcae <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x4be>
  11bc82:	endbr64 
  11bc86:	mov    %rax,%rbx
  11bc89:	jmp    11bcc8 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x4d8>
  11bc8b:	mov    -0xa0(%rbp),%rdi
  11bc92:	lea    -0x90(%rbp),%rax
  11bc99:	cmp    %rax,%rdi
  11bc9c:	je     11bcae <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x4be>
  11bc9e:	mov    -0x90(%rbp),%rax
  11bca5:	lea    0x1(%rax),%rsi
  11bca9:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  11bcae:	mov    -0x70(%rbp),%rdi
  11bcb2:	lea    -0x60(%rbp),%rax
  11bcb6:	cmp    %rax,%rdi
  11bcb9:	je     11bcc8 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x4d8>
  11bcbb:	mov    -0x60(%rbp),%rax
  11bcbf:	lea    0x1(%rax),%rsi
  11bcc3:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  11bcc8:	mov    %r15,%rdi
  11bccb:	call   6c720 <__cxa_free_exception@plt>
  11bcd0:	mov    %rbx,%rdi
  11bcd3:	call   6ee80 <_Unwind_Resume@plt>
  11bcd8:	call   6c890 <cudaGetLastError@plt>
  11bcdd:	mov    $0x40,%edi
  11bce2:	call   6beb0 <__cxa_allocate_exception@plt>
  11bce7:	mov    %rax,%r15
  11bcea:	call   6d380 <thrust::THRUST_200302_520_NS::system::cuda_category()@plt>
  11bcef:	lea    0xd3c8a(%rip),%rsi        # 1ef980 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x230>
  11bcf6:	mov    %r15,%rdi
  11bcf9:	mov    %rax,%r12
  11bcfc:	call   6f320 <std::runtime_error::runtime_error(char const*)@plt>
  11bd01:	mov    0x59b128(%rip),%rax        # 6b6e30 <vtable for thrust::THRUST_200302_520_NS::system::system_error@@Base+0x1420>
  11bd08:	movq   %r12,%xmm0
  11bd0d:	mov    %r15,%rdi
  11bd10:	mov    %ebx,0x10(%r15)
  11bd14:	movq   $0x0,0x28(%r15)
  11bd1c:	mov    0x59b8ad(%rip),%rdx        # 6b75d0 <thrust::THRUST_200302_520_NS::system::system_error::~system_error()@@Base+0x5a7f50>
  11bd23:	add    $0x10,%rax
  11bd27:	movb   $0x0,0x30(%r15)
  11bd2c:	mov    0x59c015(%rip),%rsi        # 6b7d48 <typeinfo for thrust::THRUST_200302_520_NS::system::system_error@@Base+0x2480>
  11bd33:	mov    %rax,(%r15)
  11bd36:	lea    0x30(%r15),%rax
  11bd3a:	movq   %rax,%xmm3
  11bd3f:	punpcklqdq %xmm3,%xmm0
  11bd43:	movups %xmm0,0x18(%r15)
  11bd48:	call   6ec80 <__cxa_throw@plt>
  11bd4d:	mov    $0x40,%edi
  11bd52:	call   6beb0 <__cxa_allocate_exception@plt>
  11bd57:	mov    %rax,%r15
  11bd5a:	call   6d380 <thrust::THRUST_200302_520_NS::system::cuda_category()@plt>
  11bd5f:	lea    0xdbb95(%rip),%rsi        # 1f78fb <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x79fb>
  11bd66:	mov    %r15,%rdi
  11bd69:	mov    %rax,%rbx
  11bd6c:	call   6f320 <std::runtime_error::runtime_error(char const*)@plt>
  11bd71:	mov    0x59b0b8(%rip),%rax        # 6b6e30 <vtable for thrust::THRUST_200302_520_NS::system::system_error@@Base+0x1420>
  11bd78:	movq   %rbx,%xmm0
  11bd7d:	mov    %r12d,0x10(%r15)
  11bd81:	mov    %r15,%rdi
  11bd84:	add    $0x10,%rax
  11bd88:	mov    %rax,(%r15)
  11bd8b:	lea    0x30(%r15),%rax
  11bd8f:	movq   %rax,%xmm3
  11bd94:	punpcklqdq %xmm3,%xmm0
  11bd98:	jmp    11bb42 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x352>
  11bd9d:	mov    $0x40,%edi
  11bda2:	call   6beb0 <__cxa_allocate_exception@plt>
  11bda7:	mov    %rax,%r15
  11bdaa:	call   6d380 <thrust::THRUST_200302_520_NS::system::cuda_category()@plt>
  11bdaf:	lea    0xdb7ad(%rip),%rsi        # 1f7563 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7663>
  11bdb6:	mov    %r15,%rdi
  11bdb9:	mov    %rax,%rbx
  11bdbc:	call   6f320 <std::runtime_error::runtime_error(char const*)@plt>
  11bdc1:	mov    0x59b068(%rip),%rax        # 6b6e30 <vtable for thrust::THRUST_200302_520_NS::system::system_error@@Base+0x1420>
  11bdc8:	movq   %rbx,%xmm0
  11bdcd:	mov    %r15,%rdi
  11bdd0:	mov    0x59b7f9(%rip),%rdx        # 6b75d0 <thrust::THRUST_200302_520_NS::system::system_error::~system_error()@@Base+0x5a7f50>
  11bdd7:	mov    0x59bf6a(%rip),%rsi        # 6b7d48 <typeinfo for thrust::THRUST_200302_520_NS::system::system_error@@Base+0x2480>
  11bdde:	add    $0x10,%rax
  11bde2:	mov    %rax,(%r15)
  11bde5:	mov    -0x10c(%rbp),%eax
  11bdeb:	movq   $0x0,0x28(%r15)
  11bdf3:	mov    %eax,0x10(%r15)
  11bdf7:	lea    0x30(%r15),%rax
  11bdfb:	movq   %rax,%xmm5
  11be00:	movb   $0x0,0x30(%r15)
  11be05:	punpcklqdq %xmm5,%xmm0
  11be09:	movups %xmm0,0x18(%r15)
  11be0e:	call   6ec80 <__cxa_throw@plt>
  11be13:	endbr64 
  11be17:	mov    %rax,%r12
  11be1a:	jmp    11be25 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x635>
  11be1c:	endbr64 
  11be20:	mov    %rax,%rbx
  11be23:	jmp    11be35 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x645>
  11be25:	mov    %r15,%rdi
  11be28:	call   6c720 <__cxa_free_exception@plt>
  11be2d:	mov    %r12,%rdi
  11be30:	call   6ee80 <_Unwind_Resume@plt>
  11be35:	mov    %r15,%rdi
  11be38:	call   6c720 <__cxa_free_exception@plt>
  11be3d:	mov    %rbx,%rdi
  11be40:	call   6bb90 <__cxa_begin_catch@plt>
  11be45:	test   %r13,%r13
  11be48:	je     11be56 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x666>
  11be4a:	lea    -0xf0(%rbp),%rdi
  11be51:	call   79ff2 <thrust::THRUST_200302_520_NS::detail::contiguous_storage<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::deallocate() [clone .part.0]>
  11be56:	call   6e2d0 <__cxa_rethrow@plt>
  11be5b:	endbr64 
  11be5f:	mov    %rax,%rbx
  11be62:	jmp    11be3d <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x64d>
  11be64:	mov    $0x40,%edi
  11be69:	call   6beb0 <__cxa_allocate_exception@plt>
  11be6e:	mov    %rax,%r15
  11be71:	call   6d380 <thrust::THRUST_200302_520_NS::system::cuda_category()@plt>
  11be76:	lea    0xdba7e(%rip),%rsi        # 1f78fb <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x79fb>
  11be7d:	mov    %r15,%rdi
  11be80:	mov    %rax,%rbx
  11be83:	call   6f320 <std::runtime_error::runtime_error(char const*)@plt>
  11be88:	mov    0x59afa1(%rip),%rax        # 6b6e30 <vtable for thrust::THRUST_200302_520_NS::system::system_error@@Base+0x1420>
  11be8f:	movq   %rbx,%xmm0
  11be94:	mov    %r15,%rdi
  11be97:	mov    %r14d,0x10(%r15)
  11be9b:	movq   $0x0,0x28(%r15)
  11bea3:	mov    0x59b726(%rip),%rdx        # 6b75d0 <thrust::THRUST_200302_520_NS::system::system_error::~system_error()@@Base+0x5a7f50>
  11beaa:	add    $0x10,%rax
  11beae:	movb   $0x0,0x30(%r15)
  11beb3:	mov    0x59be8e(%rip),%rsi        # 6b7d48 <typeinfo for thrust::THRUST_200302_520_NS::system::system_error@@Base+0x2480>
  11beba:	mov    %rax,(%r15)
  11bebd:	lea    0x30(%r15),%rax
  11bec1:	movq   %rax,%xmm6
  11bec6:	punpcklqdq %xmm6,%xmm0
  11beca:	movups %xmm0,0x18(%r15)
  11becf:	call   6ec80 <__cxa_throw@plt>
  11bed4:	endbr64 
  11bed8:	jmp    11be20 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x630>
  11bedd:	endbr64 
  11bee1:	mov    %rax,%rbx
  11bee4:	jmp    11bf5f <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x76f>
  11bee6:	mov    $0x40,%edi
  11beeb:	call   6beb0 <__cxa_allocate_exception@plt>
  11bef0:	mov    %rax,%r15
  11bef3:	call   6d380 <thrust::THRUST_200302_520_NS::system::cuda_category()@plt>
  11bef8:	lea    0xdba11(%rip),%rsi        # 1f7910 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7a10>
  11beff:	mov    %r15,%rdi
  11bf02:	mov    %rax,%rbx
  11bf05:	call   6f320 <std::runtime_error::runtime_error(char const*)@plt>
  11bf0a:	mov    0x59af1f(%rip),%rax        # 6b6e30 <vtable for thrust::THRUST_200302_520_NS::system::system_error@@Base+0x1420>
  11bf11:	movq   %rbx,%xmm0
  11bf16:	mov    %r15,%rdi
  11bf19:	mov    %r14d,0x10(%r15)
  11bf1d:	movq   $0x0,0x28(%r15)
  11bf25:	mov    0x59b6a4(%rip),%rdx        # 6b75d0 <thrust::THRUST_200302_520_NS::system::system_error::~system_error()@@Base+0x5a7f50>
  11bf2c:	add    $0x10,%rax
  11bf30:	movb   $0x0,0x30(%r15)
  11bf35:	mov    0x59be0c(%rip),%rsi        # 6b7d48 <typeinfo for thrust::THRUST_200302_520_NS::system::system_error@@Base+0x2480>
  11bf3c:	mov    %rax,(%r15)
  11bf3f:	lea    0x30(%r15),%rax
  11bf43:	movq   %rax,%xmm7
  11bf48:	punpcklqdq %xmm7,%xmm0
  11bf4c:	movups %xmm0,0x18(%r15)
  11bf51:	call   6ec80 <__cxa_throw@plt>
  11bf56:	endbr64 
  11bf5a:	jmp    11be17 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x627>
  11bf5f:	call   6e970 <__cxa_end_catch@plt>
  11bf64:	cmpq   $0x0,-0xe0(%rbp)
  11bf6c:	je     11bf7a <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x78a>
  11bf6e:	lea    -0xf0(%rbp),%rdi
  11bf75:	call   79ff2 <thrust::THRUST_200302_520_NS::detail::contiguous_storage<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::deallocate() [clone .part.0]>
  11bf7a:	mov    %rbx,%rdi
  11bf7d:	call   6ee80 <_Unwind_Resume@plt>
  11bf82:	endbr64 
  11bf86:	jmp    11bf91 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x7a1>
  11bf88:	endbr64 
  11bf8c:	jmp    11be20 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)+0x630>
  11bf91:	mov    %r15,%rdi
  11bf94:	call   6c720 <__cxa_free_exception@plt>
  11bf99:	call   6b720 <std::terminate()@plt>
