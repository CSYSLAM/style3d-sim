
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

00000000000fac30 <synreal::SolverNewton::reset_cable_penalty_state(CUstream_st*, synreal::Span<int const>)>:
   fac30:	f3 0f 1e fa          	endbr64 
   fac34:	41 56                	push   %r14
   fac36:	49 89 d6             	mov    %rdx,%r14
   fac39:	41 55                	push   %r13
   fac3b:	41 54                	push   %r12
   fac3d:	49 89 f4             	mov    %rsi,%r12
   fac40:	55                   	push   %rbp
   fac41:	48 89 cd             	mov    %rcx,%rbp
   fac44:	53                   	push   %rbx
   fac45:	48 89 fb             	mov    %rdi,%rbx
   fac48:	48 83 c7 08          	add    $0x8,%rdi
   fac4c:	48 83 ec 20          	sub    $0x20,%rsp
   fac50:	e8 ab 35 f7 ff       	call   6e200 <(anonymous namespace)::validate_cable_penalty_config(synreal::Config const&)@plt>
   fac55:	4c 8b ab 30 31 00 00 	mov    0x3130(%rbx),%r13
   fac5c:	48 85 ed             	test   %rbp,%rbp
   fac5f:	0f 84 8b 00 00 00    	je     facf0 <synreal::SolverNewton::reset_cable_penalty_state(CUstream_st*, synreal::Span<int const>)+0xc0>
   fac65:	4c 39 ed             	cmp    %r13,%rbp
   fac68:	0f 85 e0 b8 f7 ff    	jne    7654e <synreal::SolverNewton::reset_cable_penalty_state(CUstream_st*, synreal::Span<int const>) [clone .cold]>
   fac6e:	4d 85 f6             	test   %r14,%r14
   fac71:	0f 84 d7 b8 f7 ff    	je     7654e <synreal::SolverNewton::reset_cable_penalty_state(CUstream_st*, synreal::Span<int const>) [clone .cold]>
   fac77:	48 8b 05 12 d3 0f 00 	mov    0xfd312(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fac7e:	4c 89 ef             	mov    %r13,%rdi
   fac81:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%rsp)
   fac88:	00 
   fac89:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   fac8e:	e8 cd 20 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fac93:	8b 4c 24 10          	mov    0x10(%rsp),%ecx
   fac97:	45 31 c0             	xor    %r8d,%r8d
   fac9a:	4d 89 e1             	mov    %r12,%r9
   fac9d:	89 44 24 14          	mov    %eax,0x14(%rsp)
   faca1:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
   faca6:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
   facad:	00 00 00 
   facb0:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   facb5:	48 8b 7c 24 14       	mov    0x14(%rsp),%rdi
   facba:	8b 74 24 1c          	mov    0x1c(%rsp),%esi
   facbe:	e8 ed 42 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   facc3:	85 c0                	test   %eax,%eax
   facc5:	0f 84 95 00 00 00    	je     fad60 <synreal::SolverNewton::reset_cable_penalty_state(CUstream_st*, synreal::Span<int const>)+0x130>
   faccb:	e8 c0 1b f7 ff       	call   6c890 <cudaGetLastError@plt>
   facd0:	48 83 c4 20          	add    $0x20,%rsp
   facd4:	48 8d 35 0d 99 0f 00 	lea    0xf990d(%rip),%rsi        # 1f45e8 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x46e8>
   facdb:	5b                   	pop    %rbx
   facdc:	89 c7                	mov    %eax,%edi
   facde:	5d                   	pop    %rbp
   facdf:	41 5c                	pop    %r12
   face1:	41 5d                	pop    %r13
   face3:	41 5e                	pop    %r14
   face5:	e9 16 30 f7 ff       	jmp    6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   facea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   facf0:	4d 85 ed             	test   %r13,%r13
   facf3:	75 0d                	jne    fad02 <synreal::SolverNewton::reset_cable_penalty_state(CUstream_st*, synreal::Span<int const>)+0xd2>
   facf5:	48 83 c4 20          	add    $0x20,%rsp
   facf9:	5b                   	pop    %rbx
   facfa:	5d                   	pop    %rbp
   facfb:	41 5c                	pop    %r12
   facfd:	41 5d                	pop    %r13
   facff:	41 5e                	pop    %r14
   fad01:	c3                   	ret    
   fad02:	48 8b 05 87 d2 0f 00 	mov    0xfd287(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fad09:	4c 89 ef             	mov    %r13,%rdi
   fad0c:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%rsp)
   fad13:	00 
   fad14:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   fad19:	e8 42 20 f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fad1e:	8b 4c 24 10          	mov    0x10(%rsp),%ecx
   fad22:	45 31 c0             	xor    %r8d,%r8d
   fad25:	4d 89 e1             	mov    %r12,%r9
   fad28:	89 44 24 14          	mov    %eax,0x14(%rsp)
   fad2c:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
   fad31:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
   fad38:	00 00 00 
   fad3b:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   fad40:	48 8b 7c 24 14       	mov    0x14(%rsp),%rdi
   fad45:	8b 74 24 1c          	mov    0x1c(%rsp),%esi
   fad49:	e8 62 42 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fad4e:	85 c0                	test   %eax,%eax
   fad50:	0f 85 75 ff ff ff    	jne    faccb <synreal::SolverNewton::reset_cable_penalty_state(CUstream_st*, synreal::Span<int const>)+0x9b>
   fad56:	45 31 f6             	xor    %r14d,%r14d
   fad59:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   fad60:	41 56                	push   %r14
   fad62:	f3 0f 10 43 60       	movss  0x60(%rbx),%xmm0
   fad67:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   fad6d:	4d 89 e8             	mov    %r13,%r8
   fad70:	48 8b 93 40 31 00 00 	mov    0x3140(%rbx),%rdx
   fad77:	8b 8b 00 04 00 00    	mov    0x400(%rbx),%ecx
   fad7d:	6a 00                	push   $0x0
   fad7f:	48 8b b3 20 31 00 00 	mov    0x3120(%rbx),%rsi
   fad86:	48 8b bb 38 04 00 00 	mov    0x438(%rbx),%rdi
   fad8d:	f3 0f 10 63 70       	movss  0x70(%rbx),%xmm4
   fad92:	f3 0f 10 5b 6c       	movss  0x6c(%rbx),%xmm3
   fad97:	f3 0f 10 53 68       	movss  0x68(%rbx),%xmm2
   fad9c:	f3 0f 10 4b 64       	movss  0x64(%rbx),%xmm1
   fada1:	e8 da fc f6 ff       	call   6aa80 <synreal::kernel::prepare_cable_penalties(glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0>*, int*, unsigned long, unsigned long, float, float, float, float, float, bool, bool, int const*)@plt>
   fada6:	58                   	pop    %rax
   fada7:	5a                   	pop    %rdx
   fada8:	e9 1e ff ff ff       	jmp    faccb <synreal::SolverNewton::reset_cable_penalty_state(CUstream_st*, synreal::Span<int const>)+0x9b>
   fadad:	90                   	nop
   fadae:	66 90                	xchg   %ax,%ax

00000000000fadb0 <synreal::SolverNewton::copy_cable_penalties(synreal::Span<glm::vec<4, float, (glm::qualifier)0> >, CUstream_st*)>:
   fadb0:	f3 0f 1e fa          	endbr64 
   fadb4:	41 56                	push   %r14
   fadb6:	49 89 ce             	mov    %rcx,%r14
   fadb9:	41 55                	push   %r13
   fadbb:	49 89 f5             	mov    %rsi,%r13
   fadbe:	41 54                	push   %r12
   fadc0:	49 89 d4             	mov    %rdx,%r12
   fadc3:	55                   	push   %rbp
   fadc4:	53                   	push   %rbx
   fadc5:	48 89 fb             	mov    %rdi,%rbx
   fadc8:	48 83 c7 08          	add    $0x8,%rdi
   fadcc:	48 83 ec 20          	sub    $0x20,%rsp
   fadd0:	e8 2b 34 f7 ff       	call   6e200 <(anonymous namespace)::validate_cable_penalty_config(synreal::Config const&)@plt>
   fadd5:	48 8b ab 30 31 00 00 	mov    0x3130(%rbx),%rbp
   faddc:	4c 39 e5             	cmp    %r12,%rbp
   faddf:	0f 85 b3 b7 f7 ff    	jne    76598 <synreal::SolverNewton::copy_cable_penalties(synreal::Span<glm::vec<4, float, (glm::qualifier)0> >, CUstream_st*) [clone .cold]>
   fade5:	48 85 ed             	test   %rbp,%rbp
   fade8:	0f 84 b2 00 00 00    	je     faea0 <synreal::SolverNewton::copy_cable_penalties(synreal::Span<glm::vec<4, float, (glm::qualifier)0> >, CUstream_st*)+0xf0>
   fadee:	4d 85 ed             	test   %r13,%r13
   fadf1:	0f 84 a1 b7 f7 ff    	je     76598 <synreal::SolverNewton::copy_cable_penalties(synreal::Span<glm::vec<4, float, (glm::qualifier)0> >, CUstream_st*) [clone .cold]>
   fadf7:	48 85 ed             	test   %rbp,%rbp
   fadfa:	0f 84 a0 00 00 00    	je     faea0 <synreal::SolverNewton::copy_cable_penalties(synreal::Span<glm::vec<4, float, (glm::qualifier)0> >, CUstream_st*)+0xf0>
   fae00:	48 8b 05 89 d1 0f 00 	mov    0xfd189(%rip),%rax        # 1f7f90 <cuda::std::__4::in_place+0x43>
   fae07:	48 89 ef             	mov    %rbp,%rdi
   fae0a:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%rsp)
   fae11:	00 
   fae12:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   fae17:	e8 44 1f f7 ff       	call   6cd60 <(anonymous namespace)::block_count(unsigned long)@plt>
   fae1c:	8b 4c 24 10          	mov    0x10(%rsp),%ecx
   fae20:	45 31 c0             	xor    %r8d,%r8d
   fae23:	4d 89 f1             	mov    %r14,%r9
   fae26:	89 44 24 14          	mov    %eax,0x14(%rsp)
   fae2a:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
   fae2f:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
   fae36:	00 00 00 
   fae39:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   fae3e:	48 8b 7c 24 14       	mov    0x14(%rsp),%rdi
   fae43:	8b 74 24 1c          	mov    0x1c(%rsp),%esi
   fae47:	e8 64 41 f7 ff       	call   6efb0 <__cudaPushCallConfiguration@plt>
   fae4c:	85 c0                	test   %eax,%eax
   fae4e:	74 60                	je     faeb0 <synreal::SolverNewton::copy_cable_penalties(synreal::Span<glm::vec<4, float, (glm::qualifier)0> >, CUstream_st*)+0x100>
   fae50:	e8 3b 1a f7 ff       	call   6c890 <cudaGetLastError@plt>
   fae55:	48 8d 35 ec 97 0f 00 	lea    0xf97ec(%rip),%rsi        # 1f4648 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x4748>
   fae5c:	89 c7                	mov    %eax,%edi
   fae5e:	e8 9d 2e f7 ff       	call   6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fae63:	48 89 ea             	mov    %rbp,%rdx
   fae66:	4c 89 ef             	mov    %r13,%rdi
   fae69:	4d 89 f0             	mov    %r14,%r8
   fae6c:	48 8b b3 20 31 00 00 	mov    0x3120(%rbx),%rsi
   fae73:	48 c1 e2 04          	shl    $0x4,%rdx
   fae77:	b9 03 00 00 00       	mov    $0x3,%ecx
   fae7c:	e8 2f 32 f7 ff       	call   6e0b0 <cudaMemcpyAsync@plt>
   fae81:	48 83 c4 20          	add    $0x20,%rsp
   fae85:	48 8d 35 ed c6 0f 00 	lea    0xfc6ed(%rip),%rsi        # 1f7579 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x7679>
   fae8c:	5b                   	pop    %rbx
   fae8d:	89 c7                	mov    %eax,%edi
   fae8f:	5d                   	pop    %rbp
   fae90:	41 5c                	pop    %r12
   fae92:	41 5d                	pop    %r13
   fae94:	41 5e                	pop    %r14
   fae96:	e9 65 2e f7 ff       	jmp    6dd00 <(anonymous namespace)::throw_on_cuda_error(cudaError, char const*)@plt>
   fae9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   faea0:	48 83 c4 20          	add    $0x20,%rsp
   faea4:	5b                   	pop    %rbx
   faea5:	5d                   	pop    %rbp
   faea6:	41 5c                	pop    %r12
   faea8:	41 5d                	pop    %r13
   faeaa:	41 5e                	pop    %r14
   faeac:	c3                   	ret    
   faead:	0f 1f 00             	nopl   (%rax)
   faeb0:	6a 00                	push   $0x0
   faeb2:	48 8b 93 40 31 00 00 	mov    0x3140(%rbx),%rdx
   faeb9:	45 31 c9             	xor    %r9d,%r9d
   faebc:	49 89 e8             	mov    %rbp,%r8
   faebf:	f3 0f 10 43 60       	movss  0x60(%rbx),%xmm0
   faec4:	8b 8b 00 04 00 00    	mov    0x400(%rbx),%ecx
   faeca:	6a 00                	push   $0x0
   faecc:	48 8b b3 20 31 00 00 	mov    0x3120(%rbx),%rsi
   faed3:	48 8b bb 38 04 00 00 	mov    0x438(%rbx),%rdi
   faeda:	f3 0f 10 63 70       	movss  0x70(%rbx),%xmm4
   faedf:	f3 0f 10 5b 6c       	movss  0x6c(%rbx),%xmm3
   faee4:	f3 0f 10 53 68       	movss  0x68(%rbx),%xmm2
   faee9:	f3 0f 10 4b 64       	movss  0x64(%rbx),%xmm1
   faeee:	e8 8d fb f6 ff       	call   6aa80 <synreal::kernel::prepare_cable_penalties(glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0>*, int*, unsigned long, unsigned long, float, float, float, float, float, bool, bool, int const*)@plt>
   faef3:	58                   	pop    %rax
   faef4:	5a                   	pop    %rdx
   faef5:	e9 56 ff ff ff       	jmp    fae50 <synreal::SolverNewton::copy_cable_penalties(synreal::Span<glm::vec<4, float, (glm::qualifier)0> >, CUstream_st*)+0xa0>
   faefa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
