
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

00000000000fc800 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x17a0>:
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
   fcf1e:	80                   	.byte 0x80
   fcf1f:	bd                   	.byte 0xbd
