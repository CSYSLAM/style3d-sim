
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

00000000000fec60 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x3c00>:
   fec60:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fec67:	48 8b 8b 40 30 00 00 	mov    0x3040(%rbx),%rcx
   fec6e:	48 8d bb 28 17 00 00 	lea    0x1728(%rbx),%rdi
   fec75:	48 8b 93 60 30 00 00 	mov    0x3060(%rbx),%rdx
   fec7c:	4c 8b 85 10 f5 ff ff 	mov    -0xaf0(%rbp),%r8
   fec83:	f3 0f 10 85 1c f5 ff 	movss  -0xae4(%rbp),%xmm0
   fec8a:	ff 
   fec8b:	48 8b 30             	mov    (%rax),%rsi
   fec8e:	e8 5d ff f6 ff       	call   6ebf0 <synreal::Fluid::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)@plt>
   fec93:	8b 83 80 21 00 00    	mov    0x2180(%rbx),%eax
   fec99:	85 c0                	test   %eax,%eax
   fec9b:	0f 84 4c d7 ff ff    	je     fc3ed <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x138d>
   feca1:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   feca8:	48 8b 8b 40 30 00 00 	mov    0x3040(%rbx),%rcx
   fecaf:	48 8d bb 70 20 00 00 	lea    0x2070(%rbx),%rdi
   fecb6:	48 8b 93 60 30 00 00 	mov    0x3060(%rbx),%rdx
   fecbd:	4c 8b 85 10 f5 ff ff 	mov    -0xaf0(%rbp),%r8
   fecc4:	f3 0f 10 85 1c f5 ff 	movss  -0xae4(%rbp),%xmm0
   feccb:	ff 
   feccc:	48 8b 30             	mov    (%rax),%rsi
   feccf:	e8 4c ea f6 ff       	call   6d720 <synreal::Granular::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, CUstream_st*)@plt>
   fecd4:	e9 14 d7 ff ff       	jmp    fc3ed <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x138d>
   fecd9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   fece0:	48 8b 85 08 f5 ff ff 	mov    -0xaf8(%rbp),%rax
   fece7:	f3 0f 10 43 74       	movss  0x74(%rbx),%xmm0
   fecec:	4d 89 e1             	mov    %r12,%r9
   fecef:	48 8d bb f0 08 00 00 	lea    0x8f0(%rbx),%rdi
   fecf6:	48 8b 8b 40 30 00 00 	mov    0x3040(%rbx),%rcx
   fecfd:	48 8b 93 00 2f 00 00 	mov    0x2f00(%rbx),%rdx
   fed04:	44 0f b6 43 41       	movzbl 0x41(%rbx),%r8d
   fed09:	f3 0f 10 a3 84 00 00 	movss  0x84(%rbx),%xmm4
   fed10:	00 
   fed11:	f3 0f 10 9b 80 00 00 	movss  0x80(%rbx),%xmm3
   fed18:	00 
   fed19:	f3 0f 10 53 7c       	movss  0x7c(%rbx),%xmm2
   fed1e:	f3 0f 10 4b 78       	movss  0x78(%rbx),%xmm1
   fed23:	48 8b 30             	mov    (%rax),%rsi
   fed26:	e8 d5 c7 f6 ff       	call   6b500 <synreal::SelfCollision::accumulate(glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, float, float, float, float, glm::vec<3, float, (glm::qualifier)0>*, bool, CUstream_st*)@plt>
   fed2b:	4c 8b a5 10 f5 ff ff 	mov    -0xaf0(%rbp),%r12
   fed32:	e9 7d e1 ff ff       	jmp    fceb4 <synreal::SolverNewton::step(synreal::State const&, synreal::State const&, synreal::Control const&, synreal::Contact const&, float, CUstream_st*)+0x1e54>
   fed37:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   fed3e:	00 00 
