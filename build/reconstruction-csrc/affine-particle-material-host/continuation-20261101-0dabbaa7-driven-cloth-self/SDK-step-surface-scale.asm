
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

00000000000ffe20 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x4dc0>:
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
