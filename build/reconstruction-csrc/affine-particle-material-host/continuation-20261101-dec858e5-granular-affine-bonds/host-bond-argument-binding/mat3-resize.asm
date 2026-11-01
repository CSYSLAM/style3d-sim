
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

000000000011bfa0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)>:
  11bfa0:	endbr64 
  11bfa4:	push   %r12
  11bfa6:	push   %rbp
  11bfa7:	mov    %rdi,%rbp
  11bfaa:	push   %rbx
  11bfab:	sub    $0x10,%rsp
  11bfaf:	mov    %fs:0x28,%rax
  11bfb8:	mov    %rax,0x8(%rsp)
  11bfbd:	mov    0x18(%rdi),%rax
  11bfc1:	cmp    %rax,%rsi
  11bfc4:	jae    11c020 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)+0x80>
  11bfc6:	mov    0x8(%rdi),%rcx
  11bfca:	lea    (%rax,%rax,8),%rbx
  11bfce:	lea    (%rsi,%rsi,8),%r12
  11bfd2:	shl    $0x2,%rbx
  11bfd6:	shl    $0x2,%r12
  11bfda:	lea    0x7(%rsp),%rdi
  11bfdf:	lea    (%rcx,%rbx,1),%rsi
  11bfe3:	add    %r12,%rcx
  11bfe6:	sub    %r12,%rbx
  11bfe9:	mov    %rsi,%rdx
  11bfec:	sar    $0x2,%rbx
  11bff0:	call   6b020 <thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > > thrust::THRUST_200302_520_NS::detail::dispatch::overlapped_copy<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > > >(thrust::THRUST_200302_520_NS::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > >)@plt>
  11bff5:	movabs $0x8e38e38e38e38e39,%rax
  11bfff:	imul   %rax,%rbx
  11c003:	sub    %rbx,0x18(%rbp)
  11c007:	mov    0x8(%rsp),%rax
  11c00c:	sub    %fs:0x28,%rax
  11c015:	jne    11c040 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)+0xa0>
  11c017:	add    $0x10,%rsp
  11c01b:	pop    %rbx
  11c01c:	pop    %rbp
  11c01d:	pop    %r12
  11c01f:	ret    
  11c020:	mov    0x8(%rsp),%rdx
  11c025:	sub    %fs:0x28,%rdx
  11c02e:	jne    11c040 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)+0xa0>
  11c030:	add    $0x10,%rsp
  11c034:	sub    %rax,%rsi
  11c037:	pop    %rbx
  11c038:	pop    %rbp
  11c039:	pop    %r12
  11c03b:	jmp    6e4f0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)@plt>
  11c040:	call   6d5c0 <__stack_chk_fail@plt>
