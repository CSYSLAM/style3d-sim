
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

000000000010cd30 <synreal::SolverNewton::initialize(synreal::Model const&)>:
  10cd30:	f3 0f 1e fa          	endbr64 
  10cd34:	41 57                	push   %r15
  10cd36:	41 56                	push   %r14
  10cd38:	41 55                	push   %r13
  10cd3a:	41 54                	push   %r12
  10cd3c:	55                   	push   %rbp
  10cd3d:	53                   	push   %rbx
  10cd3e:	48 89 f3             	mov    %rsi,%rbx
  10cd41:	48 81 ec 58 02 00 00 	sub    $0x258,%rsp
  10cd48:	8b 56 1c             	mov    0x1c(%rsi),%edx
  10cd4b:	44 8b 76 18          	mov    0x18(%rsi),%r14d
  10cd4f:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
  10cd54:	8b b6 0c 03 00 00    	mov    0x30c(%rsi),%esi
  10cd5a:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  10cd61:	00 00 
  10cd63:	48 89 84 24 48 02 00 	mov    %rax,0x248(%rsp)
  10cd6a:	00 
  10cd6b:	31 c0                	xor    %eax,%eax
  10cd6d:	85 d2                	test   %edx,%edx
  10cd6f:	49 0f 44 d6          	cmove  %r14,%rdx
  10cd73:	49 89 d7             	mov    %rdx,%r15
  10cd76:	85 f6                	test   %esi,%esi
  10cd78:	75 06                	jne    10cd80 <synreal::SolverNewton::initialize(synreal::Model const&)+0x50>
  10cd7a:	8b b3 08 03 00 00    	mov    0x308(%rbx),%esi
  10cd80:	4d 85 f6             	test   %r14,%r14
  10cd83:	0f 85 9f 01 00 00    	jne    10cf28 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1f8>
  10cd89:	4d 85 ff             	test   %r15,%r15
  10cd8c:	0f 85 af c3 f6 ff    	jne    79141 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x349>
  10cd92:	4d 85 f6             	test   %r14,%r14
  10cd95:	0f 85 8d 01 00 00    	jne    10cf28 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1f8>
  10cd9b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  10cda1:	85 d2                	test   %edx,%edx
  10cda3:	0f 84 b1 01 00 00    	je     10cf5a <synreal::SolverNewton::initialize(synreal::Model const&)+0x22a>
  10cda9:	89 d1                	mov    %edx,%ecx
  10cdab:	48 89 f0             	mov    %rsi,%rax
  10cdae:	31 d2                	xor    %edx,%edx
  10cdb0:	48 f7 f1             	div    %rcx
  10cdb3:	48 89 c6             	mov    %rax,%rsi
  10cdb6:	48 85 d2             	test   %rdx,%rdx
  10cdb9:	0f 85 e4 c0 f6 ff    	jne    78ea3 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xab>
  10cdbf:	4d 85 f6             	test   %r14,%r14
  10cdc2:	0f 84 84 12 00 00    	je     10e04c <synreal::SolverNewton::initialize(synreal::Model const&)+0x131c>
  10cdc8:	4c 89 f8             	mov    %r15,%rax
  10cdcb:	31 d2                	xor    %edx,%edx
  10cdcd:	49 f7 f6             	div    %r14
  10cdd0:	48 39 c6             	cmp    %rax,%rsi
  10cdd3:	0f 85 d2 ca f6 ff    	jne    798ab <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xab3>
  10cdd9:	4c 3b 73 38          	cmp    0x38(%rbx),%r14
  10cddd:	0f 87 9a 24 00 00    	ja     10f27d <synreal::SolverNewton::initialize(synreal::Model const&)+0x254d>
  10cde3:	48 8d 84 24 30 02 00 	lea    0x230(%rsp),%rax
  10cdea:	00 
  10cdeb:	48 8b 53 38          	mov    0x38(%rbx),%rdx
  10cdef:	48 8b 73 30          	mov    0x30(%rbx),%rsi
  10cdf3:	4c 89 f1             	mov    %r14,%rcx
  10cdf6:	48 89 c7             	mov    %rax,%rdi
  10cdf9:	4c 8d 05 8c dd 0d 00 	lea    0xddd8c(%rip),%r8        # 1eab8c <_fini+0x5448>
  10ce00:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
  10ce05:	e8 b6 0e f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10ce0a:	48 8b bc 24 30 02 00 	mov    0x230(%rsp),%rdi
  10ce11:	00 
  10ce12:	48 8b 94 24 38 02 00 	mov    0x238(%rsp),%rdx
  10ce19:	00 
  10ce1a:	48 39 fa             	cmp    %rdi,%rdx
  10ce1d:	74 49                	je     10ce68 <synreal::SolverNewton::initialize(synreal::Model const&)+0x138>
  10ce1f:	66 0f ef db          	pxor   %xmm3,%xmm3
  10ce23:	f3 0f 10 0d 61 29 0e 	movss  0xe2961(%rip),%xmm1        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  10ce2a:	00 
  10ce2b:	48 89 f8             	mov    %rdi,%rax
  10ce2e:	f3 0f 10 15 6a 29 0e 	movss  0xe296a(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10ce35:	00 
  10ce36:	f3 0f 11 5c 24 08    	movss  %xmm3,0x8(%rsp)
  10ce3c:	0f 1f 40 00          	nopl   0x0(%rax)
  10ce40:	f3 0f 10 00          	movss  (%rax),%xmm0
  10ce44:	f3 0f 10 7c 24 08    	movss  0x8(%rsp),%xmm7
  10ce4a:	0f 2f f8             	comiss %xmm0,%xmm7
  10ce4d:	0f 87 82 ca f6 ff    	ja     798d5 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xadd>
  10ce53:	0f 54 c2             	andps  %xmm2,%xmm0
  10ce56:	0f 2e c8             	ucomiss %xmm0,%xmm1
  10ce59:	0f 82 76 ca f6 ff    	jb     798d5 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xadd>
  10ce5f:	48 83 c0 04          	add    $0x4,%rax
  10ce63:	48 39 c2             	cmp    %rax,%rdx
  10ce66:	75 d8                	jne    10ce40 <synreal::SolverNewton::initialize(synreal::Model const&)+0x110>
  10ce68:	48 85 ff             	test   %rdi,%rdi
  10ce6b:	74 10                	je     10ce7d <synreal::SolverNewton::initialize(synreal::Model const&)+0x14d>
  10ce6d:	48 8b b4 24 40 02 00 	mov    0x240(%rsp),%rsi
  10ce74:	00 
  10ce75:	48 29 fe             	sub    %rdi,%rsi
  10ce78:	e8 33 03 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ce7d:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
  10ce81:	48 85 c9             	test   %rcx,%rcx
  10ce84:	0f 85 dc 11 00 00    	jne    10e066 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1336>
  10ce8a:	48 8b 43 70          	mov    0x70(%rbx),%rax
  10ce8e:	49 39 c6             	cmp    %rax,%r14
  10ce91:	76 09                	jbe    10ce9c <synreal::SolverNewton::initialize(synreal::Model const&)+0x16c>
  10ce93:	48 85 c0             	test   %rax,%rax
  10ce96:	0f 85 12 c8 f6 ff    	jne    796ae <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x8b6>
  10ce9c:	48 8b 93 80 00 00 00 	mov    0x80(%rbx),%rdx
  10cea3:	48 85 d2             	test   %rdx,%rdx
  10cea6:	0f 84 d7 00 00 00    	je     10cf83 <synreal::SolverNewton::initialize(synreal::Model const&)+0x253>
  10ceac:	49 39 d6             	cmp    %rdx,%r14
  10ceaf:	0f 87 2c c8 f6 ff    	ja     796e1 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x8e9>
  10ceb5:	4d 85 f6             	test   %r14,%r14
  10ceb8:	0f 84 c5 00 00 00    	je     10cf83 <synreal::SolverNewton::initialize(synreal::Model const&)+0x253>
  10cebe:	48 8b 73 78          	mov    0x78(%rbx),%rsi
  10cec2:	48 8d bc 24 30 02 00 	lea    0x230(%rsp),%rdi
  10cec9:	00 
  10ceca:	4c 8d 05 da dc 0d 00 	lea    0xddcda(%rip),%r8        # 1eabab <_fini+0x5467>
  10ced1:	4c 89 f1             	mov    %r14,%rcx
  10ced4:	e8 57 09 f6 ff       	call   6d830 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  10ced9:	48 8b bc 24 30 02 00 	mov    0x230(%rsp),%rdi
  10cee0:	00 
  10cee1:	48 8b 94 24 38 02 00 	mov    0x238(%rsp),%rdx
  10cee8:	00 
  10cee9:	48 39 d7             	cmp    %rdx,%rdi
  10ceec:	74 1c                	je     10cf0a <synreal::SolverNewton::initialize(synreal::Model const&)+0x1da>
  10ceee:	48 89 f8             	mov    %rdi,%rax
  10cef1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10cef8:	83 38 ff             	cmpl   $0xffffffff,(%rax)
  10cefb:	0f 8c 76 c5 f6 ff    	jl     79477 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x67f>
  10cf01:	48 83 c0 04          	add    $0x4,%rax
  10cf05:	48 39 c2             	cmp    %rax,%rdx
  10cf08:	75 ee                	jne    10cef8 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1c8>
  10cf0a:	48 85 ff             	test   %rdi,%rdi
  10cf0d:	74 74                	je     10cf83 <synreal::SolverNewton::initialize(synreal::Model const&)+0x253>
  10cf0f:	48 8b b4 24 40 02 00 	mov    0x240(%rsp),%rsi
  10cf16:	00 
  10cf17:	48 29 fe             	sub    %rdi,%rsi
  10cf1a:	e8 91 02 f6 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10cf1f:	eb 62                	jmp    10cf83 <synreal::SolverNewton::initialize(synreal::Model const&)+0x253>
  10cf21:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10cf28:	4c 89 f8             	mov    %r15,%rax
  10cf2b:	31 d2                	xor    %edx,%edx
  10cf2d:	49 f7 f6             	div    %r14
  10cf30:	48 85 d2             	test   %rdx,%rdx
  10cf33:	0f 85 38 c4 f6 ff    	jne    79371 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x579>
  10cf39:	8b 13                	mov    (%rbx),%edx
  10cf3b:	85 d2                	test   %edx,%edx
  10cf3d:	0f 84 58 fe ff ff    	je     10cd9b <synreal::SolverNewton::initialize(synreal::Model const&)+0x6b>
  10cf43:	48 39 d0             	cmp    %rdx,%rax
  10cf46:	0f 85 99 c8 f6 ff    	jne    797e5 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x9ed>
  10cf4c:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  10cf52:	85 d2                	test   %edx,%edx
  10cf54:	0f 85 4f fe ff ff    	jne    10cda9 <synreal::SolverNewton::initialize(synreal::Model const&)+0x79>
  10cf5a:	48 85 f6             	test   %rsi,%rsi
  10cf5d:	0f 85 59 c4 f6 ff    	jne    793bc <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x5c4>
  10cf63:	4c 3b 73 38          	cmp    0x38(%rbx),%r14
  10cf67:	0f 87 2e c4 f6 ff    	ja     7939b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x5a3>
  10cf6d:	4d 85 f6             	test   %r14,%r14
  10cf70:	0f 85 6d fe ff ff    	jne    10cde3 <synreal::SolverNewton::initialize(synreal::Model const&)+0xb3>
  10cf76:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
  10cf7a:	48 85 c9             	test   %rcx,%rcx
  10cf7d:	0f 85 d6 10 00 00    	jne    10e059 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1329>
  10cf83:	8b 83 50 02 00 00    	mov    0x250(%rbx),%eax
  10cf89:	48 3b 83 60 02 00 00 	cmp    0x260(%rbx),%rax
  10cf90:	0f 87 60 c1 f6 ff    	ja     790f6 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x2fe>
  10cf96:	48 3b 83 70 02 00 00 	cmp    0x270(%rbx),%rax
  10cf9d:	0f 87 53 c1 f6 ff    	ja     790f6 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x2fe>
  10cfa3:	48 3b 83 80 02 00 00 	cmp    0x280(%rbx),%rax
  10cfaa:	0f 87 46 c1 f6 ff    	ja     790f6 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x2fe>
  10cfb0:	8b 93 80 01 00 00    	mov    0x180(%rbx),%edx
  10cfb6:	48 8b 83 90 01 00 00 	mov    0x190(%rbx),%rax
  10cfbd:	48 89 d5             	mov    %rdx,%rbp
  10cfc0:	48 39 c2             	cmp    %rax,%rdx
  10cfc3:	0f 87 02 22 00 00    	ja     10f1cb <synreal::SolverNewton::initialize(synreal::Model const&)+0x249b>
  10cfc9:	8b 93 98 01 00 00    	mov    0x198(%rbx),%edx
  10cfcf:	48 3b 93 a8 01 00 00 	cmp    0x1a8(%rbx),%rdx
  10cfd6:	0f 87 fe c2 f6 ff    	ja     792da <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x4e2>
  10cfdc:	85 ed                	test   %ebp,%ebp
  10cfde:	0f 85 dc 15 00 00    	jne    10e5c0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1890>
  10cfe4:	4c 8b a3 f8 01 00 00 	mov    0x1f8(%rbx),%r12
  10cfeb:	8b ab e8 01 00 00    	mov    0x1e8(%rbx),%ebp
  10cff1:	4c 8b ab f0 01 00 00 	mov    0x1f0(%rbx),%r13
  10cff8:	4c 89 e0             	mov    %r12,%rax
  10cffb:	48 8b 93 48 02 00 00 	mov    0x248(%rbx),%rdx
  10d002:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10d006:	48 c7 84 24 c0 00 00 	movq   $0x0,0xc0(%rsp)
  10d00d:	00 00 00 00 00 
  10d012:	48 c7 84 24 e0 00 00 	movq   $0x0,0xe0(%rsp)
  10d019:	00 00 00 00 00 
  10d01e:	0f 29 84 24 b0 00 00 	movaps %xmm0,0xb0(%rsp)
  10d025:	00 
  10d026:	0f 29 84 24 d0 00 00 	movaps %xmm0,0xd0(%rsp)
  10d02d:	00 
  10d02e:	48 85 d2             	test   %rdx,%rdx
  10d031:	0f 84 c2 01 00 00    	je     10d1f9 <synreal::SolverNewton::initialize(synreal::Model const&)+0x4c9>
  10d037:	48 39 c2             	cmp    %rax,%rdx
  10d03a:	48 0f 46 c2          	cmovbe %rdx,%rax
  10d03e:	48 39 c5             	cmp    %rax,%rbp
  10d041:	0f 87 b4 c2 f6 ff    	ja     792fb <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x503>
  10d047:	48 8b b3 40 02 00 00 	mov    0x240(%rbx),%rsi
  10d04e:	48 8d bc 24 10 02 00 	lea    0x210(%rsp),%rdi
  10d055:	00 
  10d056:	4c 8d 05 3e de 0d 00 	lea    0xdde3e(%rip),%r8        # 1eae9b <_fini+0x5757>
  10d05d:	48 89 e9             	mov    %rbp,%rcx
  10d060:	e8 5b 0c f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10d065:	4c 89 ee             	mov    %r13,%rsi
  10d068:	4c 89 e2             	mov    %r12,%rdx
  10d06b:	4c 8d 05 5c a6 0e 00 	lea    0xea65c(%rip),%r8        # 1f76ce <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x77ce>
  10d072:	48 89 e9             	mov    %rbp,%rcx
  10d075:	48 8d bc 24 30 02 00 	lea    0x230(%rsp),%rdi
  10d07c:	00 
  10d07d:	e8 ae 1e f6 ff       	call   6ef30 <std::vector<glm::vec<3, int, (glm::qualifier)0>, std::allocator<glm::vec<3, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, int, (glm::qualifier)0> >(synreal::Span<glm::vec<3, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10d082:	48 85 ed             	test   %rbp,%rbp
  10d085:	0f 84 34 01 00 00    	je     10d1bf <synreal::SolverNewton::initialize(synreal::Model const&)+0x48f>
  10d08b:	f3 0f 10 15 f9 26 0e 	movss  0xe26f9(%rip),%xmm2        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  10d092:	00 
  10d093:	f3 0f 10 1d 05 27 0e 	movss  0xe2705(%rip),%xmm3        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10d09a:	00 
  10d09b:	45 31 e4             	xor    %r12d,%r12d
  10d09e:	0f 29 5c 24 10       	movaps %xmm3,0x10(%rsp)
  10d0a3:	f3 0f 11 54 24 20    	movss  %xmm2,0x20(%rsp)
  10d0a9:	eb 12                	jmp    10d0bd <synreal::SolverNewton::initialize(synreal::Model const&)+0x38d>
  10d0ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10d0b0:	49 83 c4 01          	add    $0x1,%r12
  10d0b4:	4c 39 e5             	cmp    %r12,%rbp
  10d0b7:	0f 84 02 01 00 00    	je     10d1bf <synreal::SolverNewton::initialize(synreal::Model const&)+0x48f>
  10d0bd:	48 8b 84 24 10 02 00 	mov    0x210(%rsp),%rax
  10d0c4:	00 
  10d0c5:	f3 0f 10 74 24 20    	movss  0x20(%rsp),%xmm6
  10d0cb:	f3 42 0f 10 3c a0    	movss  (%rax,%r12,4),%xmm7
  10d0d1:	0f 28 c7             	movaps %xmm7,%xmm0
  10d0d4:	0f 54 44 24 10       	andps  0x10(%rsp),%xmm0
  10d0d9:	f3 0f 11 7c 24 08    	movss  %xmm7,0x8(%rsp)
  10d0df:	f3 0f 11 bc 24 f0 01 	movss  %xmm7,0x1f0(%rsp)
  10d0e6:	00 00 
  10d0e8:	0f 2e f0             	ucomiss %xmm0,%xmm6
  10d0eb:	0f 82 4e c2 f6 ff    	jb     7933f <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x547>
  10d0f1:	66 0f ef ed          	pxor   %xmm5,%xmm5
  10d0f5:	0f 2f ef             	comiss %xmm7,%xmm5
  10d0f8:	0f 87 41 c2 f6 ff    	ja     7933f <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x547>
  10d0fe:	0f 2e fd             	ucomiss %xmm5,%xmm7
  10d101:	7a 02                	jp     10d105 <synreal::SolverNewton::initialize(synreal::Model const&)+0x3d5>
  10d103:	74 ab                	je     10d0b0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x380>
  10d105:	48 8b 94 24 30 02 00 	mov    0x230(%rsp),%rdx
  10d10c:	00 
  10d10d:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  10d111:	48 8b 8c 24 c0 00 00 	mov    0xc0(%rsp),%rcx
  10d118:	00 
  10d119:	48 8d 14 82          	lea    (%rdx,%rax,4),%rdx
  10d11d:	48 63 02             	movslq (%rdx),%rax
  10d120:	85 c0                	test   %eax,%eax
  10d122:	0f 88 8b c6 f6 ff    	js     797b3 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x9bb>
  10d128:	49 39 c6             	cmp    %rax,%r14
  10d12b:	0f 86 82 c6 f6 ff    	jbe    797b3 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x9bb>
  10d131:	48 63 42 04          	movslq 0x4(%rdx),%rax
  10d135:	85 c0                	test   %eax,%eax
  10d137:	0f 88 76 c6 f6 ff    	js     797b3 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x9bb>
  10d13d:	49 39 c6             	cmp    %rax,%r14
  10d140:	0f 86 6d c6 f6 ff    	jbe    797b3 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x9bb>
  10d146:	48 63 42 08          	movslq 0x8(%rdx),%rax
  10d14a:	85 c0                	test   %eax,%eax
  10d14c:	0f 88 61 c6 f6 ff    	js     797b3 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x9bb>
  10d152:	49 39 c6             	cmp    %rax,%r14
  10d155:	0f 86 11 21 00 00    	jbe    10f26c <synreal::SolverNewton::initialize(synreal::Model const&)+0x253c>
  10d15b:	48 8b b4 24 b8 00 00 	mov    0xb8(%rsp),%rsi
  10d162:	00 
  10d163:	48 39 ce             	cmp    %rcx,%rsi
  10d166:	0f 84 67 1c 00 00    	je     10edd3 <synreal::SolverNewton::initialize(synreal::Model const&)+0x20a3>
  10d16c:	48 8b 02             	mov    (%rdx),%rax
  10d16f:	48 83 c6 0c          	add    $0xc,%rsi
  10d173:	48 89 46 f4          	mov    %rax,-0xc(%rsi)
  10d177:	8b 42 08             	mov    0x8(%rdx),%eax
  10d17a:	89 46 fc             	mov    %eax,-0x4(%rsi)
  10d17d:	48 89 b4 24 b8 00 00 	mov    %rsi,0xb8(%rsp)
  10d184:	00 
  10d185:	48 8b b4 24 d8 00 00 	mov    0xd8(%rsp),%rsi
  10d18c:	00 
  10d18d:	48 3b b4 24 e0 00 00 	cmp    0xe0(%rsp),%rsi
  10d194:	00 
  10d195:	0f 84 1e 1c 00 00    	je     10edb9 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2089>
  10d19b:	f3 0f 10 74 24 08    	movss  0x8(%rsp),%xmm6
  10d1a1:	48 83 c6 04          	add    $0x4,%rsi
  10d1a5:	49 83 c4 01          	add    $0x1,%r12
  10d1a9:	f3 0f 11 76 fc       	movss  %xmm6,-0x4(%rsi)
  10d1ae:	48 89 b4 24 d8 00 00 	mov    %rsi,0xd8(%rsp)
  10d1b5:	00 
  10d1b6:	4c 39 e5             	cmp    %r12,%rbp
  10d1b9:	0f 85 fe fe ff ff    	jne    10d0bd <synreal::SolverNewton::initialize(synreal::Model const&)+0x38d>
  10d1bf:	48 8b bc 24 30 02 00 	mov    0x230(%rsp),%rdi
  10d1c6:	00 
  10d1c7:	48 85 ff             	test   %rdi,%rdi
  10d1ca:	74 10                	je     10d1dc <synreal::SolverNewton::initialize(synreal::Model const&)+0x4ac>
  10d1cc:	48 8b b4 24 40 02 00 	mov    0x240(%rsp),%rsi
  10d1d3:	00 
  10d1d4:	48 29 fe             	sub    %rdi,%rsi
  10d1d7:	e8 d4 ff f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10d1dc:	48 8b bc 24 10 02 00 	mov    0x210(%rsp),%rdi
  10d1e3:	00 
  10d1e4:	48 85 ff             	test   %rdi,%rdi
  10d1e7:	74 10                	je     10d1f9 <synreal::SolverNewton::initialize(synreal::Model const&)+0x4c9>
  10d1e9:	48 8b b4 24 20 02 00 	mov    0x220(%rsp),%rsi
  10d1f0:	00 
  10d1f1:	48 29 fe             	sub    %rdi,%rsi
  10d1f4:	e8 b7 ff f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10d1f9:	8b 93 a8 00 00 00    	mov    0xa8(%rbx),%edx
  10d1ff:	48 3b 93 b8 00 00 00 	cmp    0xb8(%rbx),%rdx
  10d206:	0f 87 c9 bc f6 ff    	ja     78ed5 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xdd>
  10d20c:	89 d1                	mov    %edx,%ecx
  10d20e:	0b 8b 80 01 00 00    	or     0x180(%rbx),%ecx
  10d214:	74 1e                	je     10d234 <synreal::SolverNewton::initialize(synreal::Model const&)+0x504>
  10d216:	4c 3b bb a0 00 00 00 	cmp    0xa0(%rbx),%r15
  10d21d:	0f 87 f0 bd f6 ff    	ja     79013 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x21b>
  10d223:	85 d2                	test   %edx,%edx
  10d225:	74 0d                	je     10d234 <synreal::SolverNewton::initialize(synreal::Model const&)+0x504>
  10d227:	4c 3b b3 90 00 00 00 	cmp    0x90(%rbx),%r14
  10d22e:	0f 87 11 be f6 ff    	ja     79045 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x24d>
  10d234:	8b 8b 08 03 00 00    	mov    0x308(%rbx),%ecx
  10d23a:	48 3b 8b 48 03 00 00 	cmp    0x348(%rbx),%rcx
  10d241:	0f 87 37 1f 00 00    	ja     10f17e <synreal::SolverNewton::initialize(synreal::Model const&)+0x244e>
  10d247:	48 3b 8b 18 03 00 00 	cmp    0x318(%rbx),%rcx
  10d24e:	0f 87 00 c7 f6 ff    	ja     79954 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xb5c>
  10d254:	48 3b 8b 38 03 00 00 	cmp    0x338(%rbx),%rcx
  10d25b:	0f 87 25 c7 f6 ff    	ja     79986 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xb8e>
  10d261:	48 3b 8b 68 03 00 00 	cmp    0x368(%rbx),%rcx
  10d268:	0f 87 4a c7 f6 ff    	ja     799b8 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xbc0>
  10d26e:	48 3b 8b 58 03 00 00 	cmp    0x358(%rbx),%rcx
  10d275:	0f 87 3d c7 f6 ff    	ja     799b8 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xbc0>
  10d27b:	83 f9 01             	cmp    $0x1,%ecx
  10d27e:	0f 87 bc 13 00 00    	ja     10e640 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1910>
  10d284:	8b 8b 70 03 00 00    	mov    0x370(%rbx),%ecx
  10d28a:	48 3b 8b 80 03 00 00 	cmp    0x380(%rbx),%rcx
  10d291:	0f 87 6e c7 f6 ff    	ja     79a05 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc0d>
  10d297:	48 3b 8b 90 03 00 00 	cmp    0x390(%rbx),%rcx
  10d29e:	0f 87 61 c7 f6 ff    	ja     79a05 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc0d>
  10d2a4:	48 3b 8b a0 03 00 00 	cmp    0x3a0(%rbx),%rcx
  10d2ab:	0f 87 54 c7 f6 ff    	ja     79a05 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc0d>
  10d2b1:	48 3b 8b b0 03 00 00 	cmp    0x3b0(%rbx),%rcx
  10d2b8:	0f 87 47 c7 f6 ff    	ja     79a05 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc0d>
  10d2be:	48 3b 8b c0 03 00 00 	cmp    0x3c0(%rbx),%rcx
  10d2c5:	0f 87 3a c7 f6 ff    	ja     79a05 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc0d>
  10d2cb:	48 3b 8b d0 03 00 00 	cmp    0x3d0(%rbx),%rcx
  10d2d2:	0f 87 2d c7 f6 ff    	ja     79a05 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc0d>
  10d2d8:	85 c9                	test   %ecx,%ecx
  10d2da:	0f 85 1b 14 00 00    	jne    10e6fb <synreal::SolverNewton::initialize(synreal::Model const&)+0x19cb>
  10d2e0:	8b 83 08 04 00 00    	mov    0x408(%rbx),%eax
  10d2e6:	48 3b 83 18 04 00 00 	cmp    0x418(%rbx),%rax
  10d2ed:	0f 87 44 c7 f6 ff    	ja     79a37 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc3f>
  10d2f3:	48 3b 83 28 04 00 00 	cmp    0x428(%rbx),%rax
  10d2fa:	0f 87 37 c7 f6 ff    	ja     79a37 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc3f>
  10d300:	48 3b 83 38 04 00 00 	cmp    0x438(%rbx),%rax
  10d307:	0f 87 2a c7 f6 ff    	ja     79a37 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc3f>
  10d30d:	48 3b 83 48 04 00 00 	cmp    0x448(%rbx),%rax
  10d314:	0f 87 1d c7 f6 ff    	ja     79a37 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc3f>
  10d31a:	48 3b 83 58 04 00 00 	cmp    0x458(%rbx),%rax
  10d321:	0f 87 10 c7 f6 ff    	ja     79a37 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc3f>
  10d327:	3b 83 0c 04 00 00    	cmp    0x40c(%rbx),%eax
  10d32d:	0f 82 58 1f 00 00    	jb     10f28b <synreal::SolverNewton::initialize(synreal::Model const&)+0x255b>
  10d333:	8b 83 60 04 00 00    	mov    0x460(%rbx),%eax
  10d339:	48 3b 83 70 04 00 00 	cmp    0x470(%rbx),%rax
  10d340:	0f 87 35 c7 f6 ff    	ja     79a7b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc83>
  10d346:	48 3b 83 80 04 00 00 	cmp    0x480(%rbx),%rax
  10d34d:	0f 87 28 c7 f6 ff    	ja     79a7b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc83>
  10d353:	48 3b 83 90 04 00 00 	cmp    0x490(%rbx),%rax
  10d35a:	0f 87 1b c7 f6 ff    	ja     79a7b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc83>
  10d360:	48 3b 83 a0 04 00 00 	cmp    0x4a0(%rbx),%rax
  10d367:	0f 87 0e c7 f6 ff    	ja     79a7b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc83>
  10d36d:	48 3b 83 b0 04 00 00 	cmp    0x4b0(%rbx),%rax
  10d374:	0f 87 01 c7 f6 ff    	ja     79a7b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc83>
  10d37a:	48 3b 83 c0 04 00 00 	cmp    0x4c0(%rbx),%rax
  10d381:	0f 87 f4 c6 f6 ff    	ja     79a7b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc83>
  10d387:	48 3b 83 d0 04 00 00 	cmp    0x4d0(%rbx),%rax
  10d38e:	0f 87 e7 c6 f6 ff    	ja     79a7b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xc83>
  10d394:	8b 83 d8 04 00 00    	mov    0x4d8(%rbx),%eax
  10d39a:	48 3b 83 e8 04 00 00 	cmp    0x4e8(%rbx),%rax
  10d3a1:	0f 87 e9 1e 00 00    	ja     10f290 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2560>
  10d3a7:	48 3b 83 f8 04 00 00 	cmp    0x4f8(%rbx),%rax
  10d3ae:	0f 87 3d c7 f6 ff    	ja     79af1 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xcf9>
  10d3b4:	48 3b 83 08 05 00 00 	cmp    0x508(%rbx),%rax
  10d3bb:	0f 87 30 c7 f6 ff    	ja     79af1 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xcf9>
  10d3c1:	48 3b 83 18 05 00 00 	cmp    0x518(%rbx),%rax
  10d3c8:	0f 87 23 c7 f6 ff    	ja     79af1 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xcf9>
  10d3ce:	48 3b 83 28 05 00 00 	cmp    0x528(%rbx),%rax
  10d3d5:	0f 87 16 c7 f6 ff    	ja     79af1 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xcf9>
  10d3db:	48 3b 83 38 05 00 00 	cmp    0x538(%rbx),%rax
  10d3e2:	0f 87 09 c7 f6 ff    	ja     79af1 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xcf9>
  10d3e8:	3b 83 dc 04 00 00    	cmp    0x4dc(%rbx),%eax
  10d3ee:	0f 82 a1 1e 00 00    	jb     10f295 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2565>
  10d3f4:	8b 83 44 05 00 00    	mov    0x544(%rbx),%eax
  10d3fa:	48 3b 83 58 05 00 00 	cmp    0x558(%rbx),%rax
  10d401:	0f 87 1c c7 f6 ff    	ja     79b23 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xd2b>
  10d407:	48 3b 83 68 05 00 00 	cmp    0x568(%rbx),%rax
  10d40e:	0f 87 0f c7 f6 ff    	ja     79b23 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xd2b>
  10d414:	48 3b 83 78 05 00 00 	cmp    0x578(%rbx),%rax
  10d41b:	0f 87 02 c7 f6 ff    	ja     79b23 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xd2b>
  10d421:	48 3b 83 88 05 00 00 	cmp    0x588(%rbx),%rax
  10d428:	0f 87 f5 c6 f6 ff    	ja     79b23 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xd2b>
  10d42e:	48 3b 83 98 05 00 00 	cmp    0x598(%rbx),%rax
  10d435:	0f 87 e8 c6 f6 ff    	ja     79b23 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xd2b>
  10d43b:	48 3b 83 a8 05 00 00 	cmp    0x5a8(%rbx),%rax
  10d442:	0f 87 db c6 f6 ff    	ja     79b23 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xd2b>
  10d448:	48 3b 83 b8 05 00 00 	cmp    0x5b8(%rbx),%rax
  10d44f:	0f 87 ce c6 f6 ff    	ja     79b23 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xd2b>
  10d455:	48 3b 83 c8 05 00 00 	cmp    0x5c8(%rbx),%rax
  10d45c:	0f 87 c1 c6 f6 ff    	ja     79b23 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xd2b>
  10d462:	48 3b 83 d8 05 00 00 	cmp    0x5d8(%rbx),%rax
  10d469:	0f 87 b4 c6 f6 ff    	ja     79b23 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xd2b>
  10d46f:	85 c0                	test   %eax,%eax
  10d471:	74 2d                	je     10d4a0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x770>
  10d473:	8b 83 48 05 00 00    	mov    0x548(%rbx),%eax
  10d479:	48 3b 83 e8 05 00 00 	cmp    0x5e8(%rbx),%rax
  10d480:	0f 87 1c c7 f6 ff    	ja     79ba2 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xdaa>
  10d486:	48 3b 83 f8 05 00 00 	cmp    0x5f8(%rbx),%rax
  10d48d:	0f 87 0f c7 f6 ff    	ja     79ba2 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xdaa>
  10d493:	48 3b 83 38 06 00 00 	cmp    0x638(%rbx),%rax
  10d49a:	0f 87 02 c7 f6 ff    	ja     79ba2 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xdaa>
  10d4a0:	48 8b 83 28 06 00 00 	mov    0x628(%rbx),%rax
  10d4a7:	48 85 c0             	test   %rax,%rax
  10d4aa:	74 0f                	je     10d4bb <synreal::SolverNewton::initialize(synreal::Model const&)+0x78b>
  10d4ac:	8b 93 48 05 00 00    	mov    0x548(%rbx),%edx
  10d4b2:	48 39 c2             	cmp    %rax,%rdx
  10d4b5:	0f 87 19 c7 f6 ff    	ja     79bd4 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xddc>
  10d4bb:	48 8b 83 18 06 00 00 	mov    0x618(%rbx),%rax
  10d4c2:	48 85 c0             	test   %rax,%rax
  10d4c5:	74 0f                	je     10d4d6 <synreal::SolverNewton::initialize(synreal::Model const&)+0x7a6>
  10d4c7:	8b 93 48 05 00 00    	mov    0x548(%rbx),%edx
  10d4cd:	48 39 c2             	cmp    %rax,%rdx
  10d4d0:	0f 87 42 c7 f6 ff    	ja     79c18 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xe20>
  10d4d6:	48 8b 83 08 06 00 00 	mov    0x608(%rbx),%rax
  10d4dd:	48 85 c0             	test   %rax,%rax
  10d4e0:	74 0f                	je     10d4f1 <synreal::SolverNewton::initialize(synreal::Model const&)+0x7c1>
  10d4e2:	8b 93 48 05 00 00    	mov    0x548(%rbx),%edx
  10d4e8:	48 39 c2             	cmp    %rax,%rdx
  10d4eb:	0f 87 07 b9 f6 ff    	ja     78df8 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]>
  10d4f1:	48 8b 83 48 06 00 00 	mov    0x648(%rbx),%rax
  10d4f8:	48 85 c0             	test   %rax,%rax
  10d4fb:	75 1b                	jne    10d518 <synreal::SolverNewton::initialize(synreal::Model const&)+0x7e8>
  10d4fd:	48 83 bb 58 06 00 00 	cmpq   $0x0,0x658(%rbx)
  10d504:	00 
  10d505:	75 11                	jne    10d518 <synreal::SolverNewton::initialize(synreal::Model const&)+0x7e8>
  10d507:	48 83 bb 68 06 00 00 	cmpq   $0x0,0x668(%rbx)
  10d50e:	00 
  10d50f:	0f 84 06 1b 00 00    	je     10f01b <synreal::SolverNewton::initialize(synreal::Model const&)+0x22eb>
  10d515:	0f 1f 00             	nopl   (%rax)
  10d518:	8b 8b 48 05 00 00    	mov    0x548(%rbx),%ecx
  10d51e:	48 39 c1             	cmp    %rax,%rcx
  10d521:	0f 87 2c c7 f6 ff    	ja     79c53 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xe5b>
  10d527:	48 3b 8b 58 06 00 00 	cmp    0x658(%rbx),%rcx
  10d52e:	0f 87 1f c7 f6 ff    	ja     79c53 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xe5b>
  10d534:	48 3b 8b 68 06 00 00 	cmp    0x668(%rbx),%rcx
  10d53b:	0f 87 12 c7 f6 ff    	ja     79c53 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xe5b>
  10d541:	48 3b 8b 78 06 00 00 	cmp    0x678(%rbx),%rcx
  10d548:	0f 87 05 c7 f6 ff    	ja     79c53 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xe5b>
  10d54e:	48 8b b3 40 06 00 00 	mov    0x640(%rbx),%rsi
  10d555:	48 8b 93 48 06 00 00 	mov    0x648(%rbx),%rdx
  10d55c:	48 8d bc 24 d0 01 00 	lea    0x1d0(%rsp),%rdi
  10d563:	00 
  10d564:	4c 8d 05 d4 dd 0d 00 	lea    0xdddd4(%rip),%r8        # 1eb33f <_fini+0x5bfb>
  10d56b:	e8 50 07 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10d570:	8b 8b 48 05 00 00    	mov    0x548(%rbx),%ecx
  10d576:	48 8b b3 50 06 00 00 	mov    0x650(%rbx),%rsi
  10d57d:	48 8d bc 24 f0 01 00 	lea    0x1f0(%rsp),%rdi
  10d584:	00 
  10d585:	4c 8d 05 c5 dd 0d 00 	lea    0xdddc5(%rip),%r8        # 1eb351 <_fini+0x5c0d>
  10d58c:	48 8b 93 58 06 00 00 	mov    0x658(%rbx),%rdx
  10d593:	e8 28 07 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10d598:	8b 8b 48 05 00 00    	mov    0x548(%rbx),%ecx
  10d59e:	48 8b b3 60 06 00 00 	mov    0x660(%rbx),%rsi
  10d5a5:	48 8d bc 24 10 02 00 	lea    0x210(%rsp),%rdi
  10d5ac:	00 
  10d5ad:	4c 8d 05 af dd 0d 00 	lea    0xdddaf(%rip),%r8        # 1eb363 <_fini+0x5c1f>
  10d5b4:	48 8b 93 68 06 00 00 	mov    0x668(%rbx),%rdx
  10d5bb:	e8 00 07 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10d5c0:	8b 8b 48 05 00 00    	mov    0x548(%rbx),%ecx
  10d5c6:	48 8b b3 70 06 00 00 	mov    0x670(%rbx),%rsi
  10d5cd:	48 8d bc 24 30 02 00 	lea    0x230(%rsp),%rdi
  10d5d4:	00 
  10d5d5:	4c 8d 05 9f dd 0d 00 	lea    0xddd9f(%rip),%r8        # 1eb37b <_fini+0x5c37>
  10d5dc:	48 8b 93 78 06 00 00 	mov    0x678(%rbx),%rdx
  10d5e3:	e8 d8 06 f6 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10d5e8:	8b 93 48 05 00 00    	mov    0x548(%rbx),%edx
  10d5ee:	48 8b bc 24 30 02 00 	mov    0x230(%rsp),%rdi
  10d5f5:	00 
  10d5f6:	48 85 d2             	test   %rdx,%rdx
  10d5f9:	0f 84 d4 0f 00 00    	je     10e5d3 <synreal::SolverNewton::initialize(synreal::Model const&)+0x18a3>
  10d5ff:	4c 8b 84 24 d0 01 00 	mov    0x1d0(%rsp),%r8
  10d606:	00 
  10d607:	31 c0                	xor    %eax,%eax
  10d609:	66 0f ef d2          	pxor   %xmm2,%xmm2
  10d60d:	48 8b b4 24 f0 01 00 	mov    0x1f0(%rsp),%rsi
  10d614:	00 
  10d615:	48 8b 8c 24 10 02 00 	mov    0x210(%rsp),%rcx
  10d61c:	00 
  10d61d:	f3 0f 10 1d 67 21 0e 	movss  0xe2167(%rip),%xmm3        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  10d624:	00 
  10d625:	f3 0f 10 25 73 21 0e 	movss  0xe2173(%rip),%xmm4        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10d62c:	00 
  10d62d:	0f 1f 00             	nopl   (%rax)
  10d630:	f3 41 0f 10 0c 80    	movss  (%r8,%rax,4),%xmm1
  10d636:	0f 2e c9             	ucomiss %xmm1,%xmm1
  10d639:	0f 8a 3a c7 f6 ff    	jp     79d79 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf81>
  10d63f:	f3 0f 10 04 86       	movss  (%rsi,%rax,4),%xmm0
  10d644:	0f 2e c0             	ucomiss %xmm0,%xmm0
  10d647:	0f 8a 2c c7 f6 ff    	jp     79d79 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf81>
  10d64d:	0f 2f c8             	comiss %xmm0,%xmm1
  10d650:	0f 87 23 c7 f6 ff    	ja     79d79 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf81>
  10d656:	f3 0f 10 04 81       	movss  (%rcx,%rax,4),%xmm0
  10d65b:	0f 28 c8             	movaps %xmm0,%xmm1
  10d65e:	0f 54 cc             	andps  %xmm4,%xmm1
  10d661:	0f 2e d9             	ucomiss %xmm1,%xmm3
  10d664:	0f 82 0f c7 f6 ff    	jb     79d79 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf81>
  10d66a:	0f 2f d0             	comiss %xmm0,%xmm2
  10d66d:	f3 0f 11 54 24 08    	movss  %xmm2,0x8(%rsp)
  10d673:	0f 87 00 c7 f6 ff    	ja     79d79 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf81>
  10d679:	f3 0f 10 04 87       	movss  (%rdi,%rax,4),%xmm0
  10d67e:	0f 28 c8             	movaps %xmm0,%xmm1
  10d681:	0f 54 cc             	andps  %xmm4,%xmm1
  10d684:	0f 2e d9             	ucomiss %xmm1,%xmm3
  10d687:	0f 82 ec c6 f6 ff    	jb     79d79 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf81>
  10d68d:	0f 2f d0             	comiss %xmm0,%xmm2
  10d690:	0f 87 e3 c6 f6 ff    	ja     79d79 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf81>
  10d696:	48 83 c0 01          	add    $0x1,%rax
  10d69a:	48 39 d0             	cmp    %rdx,%rax
  10d69d:	75 91                	jne    10d630 <synreal::SolverNewton::initialize(synreal::Model const&)+0x900>
  10d69f:	48 8b b4 24 40 02 00 	mov    0x240(%rsp),%rsi
  10d6a6:	00 
  10d6a7:	48 29 fe             	sub    %rdi,%rsi
  10d6aa:	e8 01 fb f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10d6af:	48 8b bc 24 10 02 00 	mov    0x210(%rsp),%rdi
  10d6b6:	00 
  10d6b7:	48 85 ff             	test   %rdi,%rdi
  10d6ba:	74 10                	je     10d6cc <synreal::SolverNewton::initialize(synreal::Model const&)+0x99c>
  10d6bc:	48 8b b4 24 20 02 00 	mov    0x220(%rsp),%rsi
  10d6c3:	00 
  10d6c4:	48 29 fe             	sub    %rdi,%rsi
  10d6c7:	e8 e4 fa f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10d6cc:	48 8b bc 24 f0 01 00 	mov    0x1f0(%rsp),%rdi
  10d6d3:	00 
  10d6d4:	48 85 ff             	test   %rdi,%rdi
  10d6d7:	74 10                	je     10d6e9 <synreal::SolverNewton::initialize(synreal::Model const&)+0x9b9>
  10d6d9:	48 8b b4 24 00 02 00 	mov    0x200(%rsp),%rsi
  10d6e0:	00 
  10d6e1:	48 29 fe             	sub    %rdi,%rsi
  10d6e4:	e8 c7 fa f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10d6e9:	48 8b bc 24 d0 01 00 	mov    0x1d0(%rsp),%rdi
  10d6f0:	00 
  10d6f1:	48 85 ff             	test   %rdi,%rdi
  10d6f4:	74 10                	je     10d706 <synreal::SolverNewton::initialize(synreal::Model const&)+0x9d6>
  10d6f6:	48 8b b4 24 e0 01 00 	mov    0x1e0(%rsp),%rsi
  10d6fd:	00 
  10d6fe:	48 29 fe             	sub    %rdi,%rsi
  10d701:	e8 aa fa f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10d706:	f3 0f 10 83 40 05 00 	movss  0x540(%rbx),%xmm0
  10d70d:	00 
  10d70e:	0f 2f 44 24 08       	comiss 0x8(%rsp),%xmm0
  10d713:	0f 86 2e c6 f6 ff    	jbe    79d47 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf4f>
  10d719:	f3 0f 10 15 7f 20 0e 	movss  0xe207f(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10d720:	00 
  10d721:	0f 54 c2             	andps  %xmm2,%xmm0
  10d724:	0f 29 54 24 10       	movaps %xmm2,0x10(%rsp)
  10d729:	f3 0f 10 15 5b 20 0e 	movss  0xe205b(%rip),%xmm2        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  10d730:	00 
  10d731:	0f 2e d0             	ucomiss %xmm0,%xmm2
  10d734:	f3 0f 11 54 24 20    	movss  %xmm2,0x20(%rsp)
  10d73a:	0f 82 07 c6 f6 ff    	jb     79d47 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf4f>
  10d740:	8b 8b 80 06 00 00    	mov    0x680(%rbx),%ecx
  10d746:	48 89 c8             	mov    %rcx,%rax
  10d749:	48 3b 8b 90 06 00 00 	cmp    0x690(%rbx),%rcx
  10d750:	0f 87 8a 1b 00 00    	ja     10f2e0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x25b0>
  10d756:	48 3b 8b a0 06 00 00 	cmp    0x6a0(%rbx),%rcx
  10d75d:	0f 87 b2 c5 f6 ff    	ja     79d15 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf1d>
  10d763:	48 3b 8b b0 06 00 00 	cmp    0x6b0(%rbx),%rcx
  10d76a:	0f 87 a5 c5 f6 ff    	ja     79d15 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf1d>
  10d770:	48 3b 8b c0 06 00 00 	cmp    0x6c0(%rbx),%rcx
  10d777:	0f 87 98 c5 f6 ff    	ja     79d15 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf1d>
  10d77d:	48 3b 8b d0 06 00 00 	cmp    0x6d0(%rbx),%rcx
  10d784:	0f 87 8b c5 f6 ff    	ja     79d15 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf1d>
  10d78a:	48 3b 8b e0 06 00 00 	cmp    0x6e0(%rbx),%rcx
  10d791:	0f 87 7e c5 f6 ff    	ja     79d15 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf1d>
  10d797:	48 3b 8b 00 07 00 00 	cmp    0x700(%rbx),%rcx
  10d79e:	0f 87 71 c5 f6 ff    	ja     79d15 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf1d>
  10d7a4:	48 3b 8b f0 06 00 00 	cmp    0x6f0(%rbx),%rcx
  10d7ab:	0f 87 64 c5 f6 ff    	ja     79d15 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf1d>
  10d7b1:	48 3b 8b 30 07 00 00 	cmp    0x730(%rbx),%rcx
  10d7b8:	0f 87 57 c5 f6 ff    	ja     79d15 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf1d>
  10d7be:	48 8b 93 10 07 00 00 	mov    0x710(%rbx),%rdx
  10d7c5:	48 39 d1             	cmp    %rdx,%rcx
  10d7c8:	76 09                	jbe    10d7d3 <synreal::SolverNewton::initialize(synreal::Model const&)+0xaa3>
  10d7ca:	48 85 d2             	test   %rdx,%rdx
  10d7cd:	0f 85 08 1b 00 00    	jne    10f2db <synreal::SolverNewton::initialize(synreal::Model const&)+0x25ab>
  10d7d3:	48 8b 93 20 07 00 00 	mov    0x720(%rbx),%rdx
  10d7da:	48 39 d1             	cmp    %rdx,%rcx
  10d7dd:	76 09                	jbe    10d7e8 <synreal::SolverNewton::initialize(synreal::Model const&)+0xab8>
  10d7df:	48 85 d2             	test   %rdx,%rdx
  10d7e2:	0f 85 ee 1a 00 00    	jne    10f2d6 <synreal::SolverNewton::initialize(synreal::Model const&)+0x25a6>
  10d7e8:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
  10d7ed:	c6 86 41 33 00 00 00 	movb   $0x0,0x3341(%rsi)
  10d7f4:	3b 83 84 06 00 00    	cmp    0x684(%rbx),%eax
  10d7fa:	0f 82 e5 1a 00 00    	jb     10f2e5 <synreal::SolverNewton::initialize(synreal::Model const&)+0x25b5>
  10d800:	85 c0                	test   %eax,%eax
  10d802:	0f 85 86 11 00 00    	jne    10e98e <synreal::SolverNewton::initialize(synreal::Model const&)+0x1c5e>
  10d808:	8b 8b a8 00 00 00    	mov    0xa8(%rbx),%ecx
  10d80e:	85 c9                	test   %ecx,%ecx
  10d810:	74 0e                	je     10d820 <synreal::SolverNewton::initialize(synreal::Model const&)+0xaf0>
  10d812:	4d 85 f6             	test   %r14,%r14
  10d815:	0f 85 32 17 00 00    	jne    10ef4d <synreal::SolverNewton::initialize(synreal::Model const&)+0x221d>
  10d81b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10d820:	f3 0f 10 83 38 07 00 	movss  0x738(%rbx),%xmm0
  10d827:	00 
  10d828:	0f 2f 44 24 08       	comiss 0x8(%rsp),%xmm0
  10d82d:	0f 82 56 b8 f6 ff    	jb     79089 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x291>
  10d833:	0f 54 44 24 10       	andps  0x10(%rsp),%xmm0
  10d838:	f3 0f 10 7c 24 20    	movss  0x20(%rsp),%xmm7
  10d83e:	0f 2e f8             	ucomiss %xmm0,%xmm7
  10d841:	0f 82 42 b8 f6 ff    	jb     79089 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x291>
  10d847:	f3 0f 10 83 3c 07 00 	movss  0x73c(%rbx),%xmm0
  10d84e:	00 
  10d84f:	0f 2f 44 24 08       	comiss 0x8(%rsp),%xmm0
  10d854:	0f 82 2f b8 f6 ff    	jb     79089 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x291>
  10d85a:	0f 54 44 24 10       	andps  0x10(%rsp),%xmm0
  10d85f:	0f 2e f8             	ucomiss %xmm0,%xmm7
  10d862:	0f 82 21 b8 f6 ff    	jb     79089 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x291>
  10d868:	f3 0f 10 83 40 07 00 	movss  0x740(%rbx),%xmm0
  10d86f:	00 
  10d870:	0f 2f 44 24 08       	comiss 0x8(%rsp),%xmm0
  10d875:	0f 82 0e b8 f6 ff    	jb     79089 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x291>
  10d87b:	0f 54 44 24 10       	andps  0x10(%rsp),%xmm0
  10d880:	0f 2e f8             	ucomiss %xmm0,%xmm7
  10d883:	0f 82 00 b8 f6 ff    	jb     79089 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x291>
  10d889:	f3 0f 10 83 44 07 00 	movss  0x744(%rbx),%xmm0
  10d890:	00 
  10d891:	0f 2f 44 24 08       	comiss 0x8(%rsp),%xmm0
  10d896:	0f 82 ed b7 f6 ff    	jb     79089 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x291>
  10d89c:	0f 54 44 24 10       	andps  0x10(%rsp),%xmm0
  10d8a1:	0f 2e f8             	ucomiss %xmm0,%xmm7
  10d8a4:	0f 82 df b7 f6 ff    	jb     79089 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x291>
  10d8aa:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10d8af:	b9 e9 00 00 00       	mov    $0xe9,%ecx
  10d8b4:	48 89 de             	mov    %rbx,%rsi
  10d8b7:	48 8d 94 24 d0 01 00 	lea    0x1d0(%rsp),%rdx
  10d8be:	00 
  10d8bf:	c7 84 24 d0 01 00 00 	movl   $0x0,0x1d0(%rsp)
  10d8c6:	00 00 00 00 
  10d8ca:	48 8d b8 90 00 00 00 	lea    0x90(%rax),%rdi
  10d8d1:	48 89 54 24 40       	mov    %rdx,0x40(%rsp)
  10d8d6:	48 89 7c 24 78       	mov    %rdi,0x78(%rsp)
  10d8db:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  10d8de:	48 8d b8 18 32 00 00 	lea    0x3218(%rax),%rdi
  10d8e5:	be 01 00 00 00       	mov    $0x1,%esi
  10d8ea:	e8 41 1a f6 ff       	call   6f330 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::fill_assign(unsigned long, int const&)@plt>
  10d8ef:	41 bc 01 00 00 00    	mov    $0x1,%r12d
  10d8f5:	4d 85 f6             	test   %r14,%r14
  10d8f8:	74 0b                	je     10d905 <synreal::SolverNewton::initialize(synreal::Model const&)+0xbd5>
  10d8fa:	4c 89 f8             	mov    %r15,%rax
  10d8fd:	31 d2                	xor    %edx,%edx
  10d8ff:	49 f7 f6             	div    %r14
  10d902:	49 89 c4             	mov    %rax,%r12
  10d905:	4c 8b 6c 24 28       	mov    0x28(%rsp),%r13
  10d90a:	4c 89 fe             	mov    %r15,%rsi
  10d90d:	49 8d bd 18 30 00 00 	lea    0x3018(%r13),%rdi
  10d914:	e8 17 15 f6 ff       	call   6ee30 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10d919:	49 8d bd 38 30 00 00 	lea    0x3038(%r13),%rdi
  10d920:	4c 89 fe             	mov    %r15,%rsi
  10d923:	e8 08 15 f6 ff       	call   6ee30 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10d928:	49 8d bd 58 30 00 00 	lea    0x3058(%r13),%rdi
  10d92f:	4c 89 fe             	mov    %r15,%rsi
  10d932:	e8 f9 14 f6 ff       	call   6ee30 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10d937:	49 8d bd 78 30 00 00 	lea    0x3078(%r13),%rdi
  10d93e:	4c 89 fe             	mov    %r15,%rsi
  10d941:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
  10d946:	e8 e5 14 f6 ff       	call   6ee30 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10d94b:	8b ab 70 03 00 00    	mov    0x370(%rbx),%ebp
  10d951:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10d956:	49 0f af ec          	imul   %r12,%rbp
  10d95a:	48 8d b8 98 30 00 00 	lea    0x3098(%rax),%rdi
  10d961:	4c 8d 2c ed 00 00 00 	lea    0x0(,%rbp,8),%r13
  10d968:	00 
  10d969:	4c 89 ee             	mov    %r13,%rsi
  10d96c:	e8 5f f3 f5 ff       	call   6ccd0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10d971:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10d976:	4c 89 ee             	mov    %r13,%rsi
  10d979:	48 8d b8 b8 30 00 00 	lea    0x30b8(%rax),%rdi
  10d980:	e8 4b f3 f5 ff       	call   6ccd0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10d985:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10d98a:	4c 89 ee             	mov    %r13,%rsi
  10d98d:	48 8d b8 d8 30 00 00 	lea    0x30d8(%rax),%rdi
  10d994:	e8 f7 e4 f5 ff       	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  10d999:	4c 8b 6c 24 28       	mov    0x28(%rsp),%r13
  10d99e:	48 89 ee             	mov    %rbp,%rsi
  10d9a1:	49 8d bd f8 30 00 00 	lea    0x30f8(%r13),%rdi
  10d9a8:	e8 e3 e4 f5 ff       	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  10d9ad:	4c 89 e8             	mov    %r13,%rax
  10d9b0:	4d 8b ad 30 31 00 00 	mov    0x3130(%r13),%r13
  10d9b7:	4c 39 ed             	cmp    %r13,%rbp
  10d9ba:	0f 83 e0 0b 00 00    	jae    10e5a0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1870>
  10d9c0:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
  10d9c5:	48 89 e9             	mov    %rbp,%rcx
  10d9c8:	48 8b 80 20 31 00 00 	mov    0x3120(%rax),%rax
  10d9cf:	49 c1 e5 04          	shl    $0x4,%r13
  10d9d3:	48 c1 e1 04          	shl    $0x4,%rcx
  10d9d7:	48 8d bc 24 b0 01 00 	lea    0x1b0(%rsp),%rdi
  10d9de:	00 
  10d9df:	4a 8d 34 28          	lea    (%rax,%r13,1),%rsi
  10d9e3:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
  10d9e8:	48 01 c1             	add    %rax,%rcx
  10d9eb:	48 89 f2             	mov    %rsi,%rdx
  10d9ee:	e8 fd d5 f5 ff       	call   6aff0 <thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > > thrust::THRUST_200302_520_NS::detail::dispatch::overlapped_copy<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > > >(thrust::THRUST_200302_520_NS::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > >)@plt>
  10d9f3:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10d9f8:	4c 2b 6c 24 08       	sub    0x8(%rsp),%r13
  10d9fd:	49 c1 fd 04          	sar    $0x4,%r13
  10da01:	4c 29 a8 30 31 00 00 	sub    %r13,0x3130(%rax)
  10da08:	4c 8b 6c 24 28       	mov    0x28(%rsp),%r13
  10da0d:	48 89 ee             	mov    %rbp,%rsi
  10da10:	48 8d 94 24 30 02 00 	lea    0x230(%rsp),%rdx
  10da17:	00 
  10da18:	c7 84 24 30 02 00 00 	movl   $0x0,0x230(%rsp)
  10da1f:	00 00 00 00 
  10da23:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
  10da28:	49 8d bd 38 31 00 00 	lea    0x3138(%r13),%rdi
  10da2f:	e8 fc 18 f6 ff       	call   6f330 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::fill_assign(unsigned long, int const&)@plt>
  10da34:	41 8b ad d4 05 00 00 	mov    0x5d4(%r13),%ebp
  10da3b:	49 8d 85 38 32 00 00 	lea    0x3238(%r13),%rax
  10da42:	48 89 c7             	mov    %rax,%rdi
  10da45:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10da4a:	49 0f af ec          	imul   %r12,%rbp
  10da4e:	48 89 ee             	mov    %rbp,%rsi
  10da51:	e8 7a 0c f6 ff       	call   6e6d0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::resize(unsigned long)@plt>
  10da56:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
  10da5b:	49 81 c5 58 32 00 00 	add    $0x3258,%r13
  10da62:	48 89 ee             	mov    %rbp,%rsi
  10da65:	4c 89 ef             	mov    %r13,%rdi
  10da68:	e8 23 e4 f5 ff       	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  10da6d:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10da72:	48 89 ee             	mov    %rbp,%rsi
  10da75:	48 8d b8 78 32 00 00 	lea    0x3278(%rax),%rdi
  10da7c:	e8 4f 0c f6 ff       	call   6e6d0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::resize(unsigned long)@plt>
  10da81:	48 85 ed             	test   %rbp,%rbp
  10da84:	0f 84 97 00 00 00    	je     10db21 <synreal::SolverNewton::initialize(synreal::Model const&)+0xdf1>
  10da8a:	48 89 e8             	mov    %rbp,%rax
  10da8d:	48 c1 e8 3d          	shr    $0x3d,%rax
  10da91:	0f 85 c3 16 00 00    	jne    10f15a <synreal::SolverNewton::initialize(synreal::Model const&)+0x242a>
  10da97:	48 c1 e5 02          	shl    $0x2,%rbp
  10da9b:	48 89 ef             	mov    %rbp,%rdi
  10da9e:	e8 ad f6 f5 ff       	call   6d150 <operator new(unsigned long)@plt>
  10daa3:	48 8d 0c 28          	lea    (%rax,%rbp,1),%rcx
  10daa7:	48 89 c7             	mov    %rax,%rdi
  10daaa:	48 89 ea             	mov    %rbp,%rdx
  10daad:	31 f6                	xor    %esi,%esi
  10daaf:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
  10dab4:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  10dab9:	e8 62 e6 f5 ff       	call   6c120 <memset@plt>
  10dabe:	48 89 ef             	mov    %rbp,%rdi
  10dac1:	e8 8a f6 f5 ff       	call   6d150 <operator new(unsigned long)@plt>
  10dac6:	48 8d 34 28          	lea    (%rax,%rbp,1),%rsi
  10daca:	48 89 ea             	mov    %rbp,%rdx
  10dacd:	48 89 c7             	mov    %rax,%rdi
  10dad0:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  10dad5:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  10dada:	31 f6                	xor    %esi,%esi
  10dadc:	e8 3f e6 f5 ff       	call   6c120 <memset@plt>
  10dae1:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
  10dae6:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  10daeb:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  10daf0:	e8 fb e0 f5 ff       	call   6bbf0 <void thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::range_assign<__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > > >(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, __gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  10daf5:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
  10dafa:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
  10daff:	4c 89 ef             	mov    %r13,%rdi
  10db02:	e8 99 d9 f5 ff       	call   6b4a0 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::range_assign<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > > >(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  10db07:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  10db0c:	48 89 ee             	mov    %rbp,%rsi
  10db0f:	e8 9c f6 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10db14:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  10db19:	48 89 ee             	mov    %rbp,%rsi
  10db1c:	e8 8f f6 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10db21:	48 8b 84 24 b0 00 00 	mov    0xb0(%rsp),%rax
  10db28:	00 
  10db29:	4c 8b ac 24 b8 00 00 	mov    0xb8(%rsp),%r13
  10db30:	00 
  10db31:	48 8b 6c 24 28       	mov    0x28(%rsp),%rbp
  10db36:	4c 89 ea             	mov    %r13,%rdx
  10db39:	48 89 c6             	mov    %rax,%rsi
  10db3c:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
  10db41:	48 8d bd a0 32 00 00 	lea    0x32a0(%rbp),%rdi
  10db48:	e8 23 db f5 ff       	call   6b670 <void thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, int, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, int, (glm::qualifier)0> > >::range_assign<__gnu_cxx::__normal_iterator<glm::vec<3, int, (glm::qualifier)0>*, std::vector<glm::vec<3, int, (glm::qualifier)0>, std::allocator<glm::vec<3, int, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<3, int, (glm::qualifier)0>*, std::vector<glm::vec<3, int, (glm::qualifier)0>, std::allocator<glm::vec<3, int, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<3, int, (glm::qualifier)0>*, std::vector<glm::vec<3, int, (glm::qualifier)0>, std::allocator<glm::vec<3, int, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  10db4d:	48 8b 8c 24 d0 00 00 	mov    0xd0(%rsp),%rcx
  10db54:	00 
  10db55:	48 8b 94 24 d8 00 00 	mov    0xd8(%rsp),%rdx
  10db5c:	00 
  10db5d:	48 8d bd c0 32 00 00 	lea    0x32c0(%rbp),%rdi
  10db64:	48 89 ce             	mov    %rcx,%rsi
  10db67:	48 89 8c 24 80 00 00 	mov    %rcx,0x80(%rsp)
  10db6e:	00 
  10db6f:	e8 7c e0 f5 ff       	call   6bbf0 <void thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::range_assign<__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > > >(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, __gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  10db74:	31 ed                	xor    %ebp,%ebp
  10db76:	4d 85 f6             	test   %r14,%r14
  10db79:	74 26                	je     10dba1 <synreal::SolverNewton::initialize(synreal::Model const&)+0xe71>
  10db7b:	4c 2b 6c 24 70       	sub    0x70(%rsp),%r13
  10db80:	31 d2                	xor    %edx,%edx
  10db82:	48 b8 ab aa aa aa aa 	movabs $0xaaaaaaaaaaaaaaab,%rax
  10db89:	aa aa aa 
  10db8c:	49 c1 fd 02          	sar    $0x2,%r13
  10db90:	4c 0f af e8          	imul   %rax,%r13
  10db94:	4c 89 f8             	mov    %r15,%rax
  10db97:	49 f7 f6             	div    %r14
  10db9a:	4c 89 ed             	mov    %r13,%rbp
  10db9d:	48 0f af e8          	imul   %rax,%rbp
  10dba1:	4c 8b 6c 24 28       	mov    0x28(%rsp),%r13
  10dba6:	48 89 ee             	mov    %rbp,%rsi
  10dba9:	49 8d bd e0 32 00 00 	lea    0x32e0(%r13),%rdi
  10dbb0:	e8 7b 12 f6 ff       	call   6ee30 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10dbb5:	49 8d bd 00 33 00 00 	lea    0x3300(%r13),%rdi
  10dbbc:	48 89 ee             	mov    %rbp,%rsi
  10dbbf:	e8 0c 0b f6 ff       	call   6e6d0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::resize(unsigned long)@plt>
  10dbc4:	49 8d bd 20 33 00 00 	lea    0x3320(%r13),%rdi
  10dbcb:	48 89 ee             	mov    %rbp,%rsi
  10dbce:	e8 fd 0a f6 ff       	call   6e6d0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::resize(unsigned long)@plt>
  10dbd3:	49 8d bd b8 2e 00 00 	lea    0x2eb8(%r13),%rdi
  10dbda:	4c 89 fe             	mov    %r15,%rsi
  10dbdd:	e8 ee 0a f6 ff       	call   6e6d0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::resize(unsigned long)@plt>
  10dbe2:	49 8d bd d8 2e 00 00 	lea    0x2ed8(%r13),%rdi
  10dbe9:	4c 89 fe             	mov    %r15,%rsi
  10dbec:	e8 df 0a f6 ff       	call   6e6d0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::resize(unsigned long)@plt>
  10dbf1:	49 8d bd f8 2e 00 00 	lea    0x2ef8(%r13),%rdi
  10dbf8:	4c 89 fe             	mov    %r15,%rsi
  10dbfb:	e8 d0 0a f6 ff       	call   6e6d0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::resize(unsigned long)@plt>
  10dc00:	49 8d bd 18 2f 00 00 	lea    0x2f18(%r13),%rdi
  10dc07:	4c 89 fe             	mov    %r15,%rsi
  10dc0a:	e8 c1 0a f6 ff       	call   6e6d0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::resize(unsigned long)@plt>
  10dc0f:	49 8d bd 38 2f 00 00 	lea    0x2f38(%r13),%rdi
  10dc16:	4c 89 fe             	mov    %r15,%rsi
  10dc19:	e8 b2 f0 f5 ff       	call   6ccd0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10dc1e:	49 8d bd 58 2f 00 00 	lea    0x2f58(%r13),%rdi
  10dc25:	4c 89 fe             	mov    %r15,%rsi
  10dc28:	e8 a3 f0 f5 ff       	call   6ccd0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10dc2d:	8b b3 0c 03 00 00    	mov    0x30c(%rbx),%esi
  10dc33:	48 89 74 24 60       	mov    %rsi,0x60(%rsp)
  10dc38:	85 f6                	test   %esi,%esi
  10dc3a:	75 0b                	jne    10dc47 <synreal::SolverNewton::initialize(synreal::Model const&)+0xf17>
  10dc3c:	8b 83 08 03 00 00    	mov    0x308(%rbx),%eax
  10dc42:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  10dc47:	8b ab 60 04 00 00    	mov    0x460(%rbx),%ebp
  10dc4d:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
  10dc52:	44 8b ab 0c 04 00 00 	mov    0x40c(%rbx),%r13d
  10dc59:	8b 83 dc 04 00 00    	mov    0x4dc(%rbx),%eax
  10dc5f:	49 0f af ec          	imul   %r12,%rbp
  10dc63:	49 8d bf 68 34 00 00 	lea    0x3468(%r15),%rdi
  10dc6a:	4d 0f af ec          	imul   %r12,%r13
  10dc6e:	4c 0f af e0          	imul   %rax,%r12
  10dc72:	48 89 ee             	mov    %rbp,%rsi
  10dc75:	e8 b6 11 f6 ff       	call   6ee30 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10dc7a:	49 8d bf 88 34 00 00 	lea    0x3488(%r15),%rdi
  10dc81:	48 89 ee             	mov    %rbp,%rsi
  10dc84:	e8 a7 11 f6 ff       	call   6ee30 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10dc89:	49 8d bf 08 34 00 00 	lea    0x3408(%r15),%rdi
  10dc90:	4c 89 ee             	mov    %r13,%rsi
  10dc93:	e8 98 11 f6 ff       	call   6ee30 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10dc98:	49 8d bf 08 35 00 00 	lea    0x3508(%r15),%rdi
  10dc9f:	4c 89 e6             	mov    %r12,%rsi
  10dca2:	e8 29 0a f6 ff       	call   6e6d0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::resize(unsigned long)@plt>
  10dca7:	49 8d bf 28 35 00 00 	lea    0x3528(%r15),%rdi
  10dcae:	4c 89 e6             	mov    %r12,%rsi
  10dcb1:	e8 1a f0 f5 ff       	call   6ccd0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10dcb6:	49 8d bf 48 35 00 00 	lea    0x3548(%r15),%rdi
  10dcbd:	4c 89 e6             	mov    %r12,%rsi
  10dcc0:	e8 6b 11 f6 ff       	call   6ee30 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10dcc5:	48 8b 6c 24 60       	mov    0x60(%rsp),%rbp
  10dcca:	49 8d bf 78 2f 00 00 	lea    0x2f78(%r15),%rdi
  10dcd1:	48 8d 74 ed 00       	lea    0x0(%rbp,%rbp,8),%rsi
  10dcd6:	48 c1 e6 04          	shl    $0x4,%rsi
  10dcda:	e8 f1 09 f6 ff       	call   6e6d0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::resize(unsigned long)@plt>
  10dcdf:	49 8d bf 98 2f 00 00 	lea    0x2f98(%r15),%rdi
  10dce6:	48 89 ee             	mov    %rbp,%rsi
  10dce9:	e8 a2 e1 f5 ff       	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  10dcee:	8b ab 08 03 00 00    	mov    0x308(%rbx),%ebp
  10dcf4:	48 85 ed             	test   %rbp,%rbp
  10dcf7:	0f 84 f3 08 00 00    	je     10e5f0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x18c0>
  10dcfd:	48 c1 e5 02          	shl    $0x2,%rbp
  10dd01:	48 89 ef             	mov    %rbp,%rdi
  10dd04:	e8 47 f4 f5 ff       	call   6d150 <operator new(unsigned long)@plt>
  10dd09:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
  10dd0d:	48 89 c6             	mov    %rax,%rsi
  10dd10:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  10dd15:	48 8d 04 28          	lea    (%rax,%rbp,1),%rax
  10dd19:	48 89 d1             	mov    %rdx,%rcx
  10dd1c:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  10dd21:	48 89 f0             	mov    %rsi,%rax
  10dd24:	48 c1 e9 02          	shr    $0x2,%rcx
  10dd28:	48 83 c1 01          	add    $0x1,%rcx
  10dd2c:	48 83 fa 08          	cmp    $0x8,%rdx
  10dd30:	76 3f                	jbe    10dd71 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1041>
  10dd32:	48 89 ca             	mov    %rcx,%rdx
  10dd35:	66 0f 6f 05 33 a2 0e 	movdqa 0xea233(%rip),%xmm0        # 1f7f70 <cuda::std::__4::in_place+0x23>
  10dd3c:	00 
  10dd3d:	48 c1 ea 02          	shr    $0x2,%rdx
  10dd41:	48 c1 e2 04          	shl    $0x4,%rdx
  10dd45:	48 01 f2             	add    %rsi,%rdx
  10dd48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10dd4f:	00 
  10dd50:	0f 11 00             	movups %xmm0,(%rax)
  10dd53:	48 83 c0 10          	add    $0x10,%rax
  10dd57:	48 39 d0             	cmp    %rdx,%rax
  10dd5a:	75 f4                	jne    10dd50 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1020>
  10dd5c:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  10dd61:	48 89 ca             	mov    %rcx,%rdx
  10dd64:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  10dd68:	48 8d 04 90          	lea    (%rax,%rdx,4),%rax
  10dd6c:	48 39 ca             	cmp    %rcx,%rdx
  10dd6f:	74 2b                	je     10dd9c <synreal::SolverNewton::initialize(synreal::Model const&)+0x106c>
  10dd71:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
  10dd76:	48 8d 50 04          	lea    0x4(%rax),%rdx
  10dd7a:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  10dd80:	48 39 d1             	cmp    %rdx,%rcx
  10dd83:	74 17                	je     10dd9c <synreal::SolverNewton::initialize(synreal::Model const&)+0x106c>
  10dd85:	48 8d 50 08          	lea    0x8(%rax),%rdx
  10dd89:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%rax)
  10dd90:	48 39 d1             	cmp    %rdx,%rcx
  10dd93:	74 07                	je     10dd9c <synreal::SolverNewton::initialize(synreal::Model const&)+0x106c>
  10dd95:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  10dd9c:	48 89 ac 24 98 00 00 	mov    %rbp,0x98(%rsp)
  10dda3:	00 
  10dda4:	4e 8d 24 b5 00 00 00 	lea    0x0(,%r14,4),%r12
  10ddab:	00 
  10ddac:	4d 85 f6             	test   %r14,%r14
  10ddaf:	0f 84 6a 08 00 00    	je     10e61f <synreal::SolverNewton::initialize(synreal::Model const&)+0x18ef>
  10ddb5:	4c 89 e7             	mov    %r12,%rdi
  10ddb8:	e8 93 f3 f5 ff       	call   6d150 <operator new(unsigned long)@plt>
  10ddbd:	4a 8d 0c 20          	lea    (%rax,%r12,1),%rcx
  10ddc1:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  10ddc6:	48 89 8c 24 a0 00 00 	mov    %rcx,0xa0(%rsp)
  10ddcd:	00 
  10ddce:	48 39 c1             	cmp    %rax,%rcx
  10ddd1:	74 10                	je     10dde3 <synreal::SolverNewton::initialize(synreal::Model const&)+0x10b3>
  10ddd3:	4c 89 e2             	mov    %r12,%rdx
  10ddd6:	be ff 00 00 00       	mov    $0xff,%esi
  10dddb:	48 89 c7             	mov    %rax,%rdi
  10ddde:	e8 3d e3 f5 ff       	call   6c120 <memset@plt>
  10dde3:	8b 8b 08 03 00 00    	mov    0x308(%rbx),%ecx
  10dde9:	48 8b b3 40 03 00 00 	mov    0x340(%rbx),%rsi
  10ddf0:	48 8d bc 24 f0 01 00 	lea    0x1f0(%rsp),%rdi
  10ddf7:	00 
  10ddf8:	4c 8d 05 ce d1 0d 00 	lea    0xdd1ce(%rip),%r8        # 1eafcd <_fini+0x5889>
  10ddff:	48 8b 93 48 03 00 00 	mov    0x348(%rbx),%rdx
  10de06:	e8 e5 17 f6 ff       	call   6f5f0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10de0b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  10de11:	45 31 ed             	xor    %r13d,%r13d
  10de14:	4c 8d 3d c9 98 0e 00 	lea    0xe98c9(%rip),%r15        # 1f76e4 <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x77e4>
  10de1b:	85 d2                	test   %edx,%edx
  10de1d:	0f 84 8f 00 00 00    	je     10deb2 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1182>
  10de23:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10de28:	4c 89 e8             	mov    %r13,%rax
  10de2b:	31 ed                	xor    %ebp,%ebp
  10de2d:	48 c1 e0 04          	shl    $0x4,%rax
  10de31:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10de36:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  10de3b:	48 03 84 24 f0 01 00 	add    0x1f0(%rsp),%rax
  10de42:	00 
  10de43:	83 fd 02             	cmp    $0x2,%ebp
  10de46:	0f 84 f4 02 00 00    	je     10e140 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1410>
  10de4c:	83 fd 03             	cmp    $0x3,%ebp
  10de4f:	0f 84 db 02 00 00    	je     10e130 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1400>
  10de55:	83 fd 01             	cmp    $0x1,%ebp
  10de58:	0f 84 c2 02 00 00    	je     10e120 <synreal::SolverNewton::initialize(synreal::Model const&)+0x13f0>
  10de5e:	4c 63 20             	movslq (%rax),%r12
  10de61:	4c 89 fa             	mov    %r15,%rdx
  10de64:	4c 89 f6             	mov    %r14,%rsi
  10de67:	44 89 e7             	mov    %r12d,%edi
  10de6a:	e8 31 d4 f5 ff       	call   6b2a0 <(anonymous namespace)::validate_particle_index(int, unsigned long, char const*)@plt>
  10de6f:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  10de74:	4a 8d 14 a0          	lea    (%rax,%r12,4),%rdx
  10de78:	48 63 02             	movslq (%rdx),%rax
  10de7b:	85 c0                	test   %eax,%eax
  10de7d:	0f 88 8d 02 00 00    	js     10e110 <synreal::SolverNewton::initialize(synreal::Model const&)+0x13e0>
  10de83:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
  10de88:	42 c7 04 a9 00 00 00 	movl   $0x0,(%rcx,%r13,4)
  10de8f:	00 
  10de90:	c7 04 81 00 00 00 00 	movl   $0x0,(%rcx,%rax,4)
  10de97:	83 c5 01             	add    $0x1,%ebp
  10de9a:	83 fd 04             	cmp    $0x4,%ebp
  10de9d:	75 97                	jne    10de36 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1106>
  10de9f:	8b 83 08 03 00 00    	mov    0x308(%rbx),%eax
  10dea5:	49 83 c5 01          	add    $0x1,%r13
  10dea9:	4c 39 e8             	cmp    %r13,%rax
  10deac:	0f 87 76 ff ff ff    	ja     10de28 <synreal::SolverNewton::initialize(synreal::Model const&)+0x10f8>
  10deb2:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10deb7:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
  10debc:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
  10dec1:	48 8d b8 b8 2f 00 00 	lea    0x2fb8(%rax),%rdi
  10dec8:	e8 d3 d5 f5 ff       	call   6b4a0 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::range_assign<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > > >(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  10decd:	8b ab 08 03 00 00    	mov    0x308(%rbx),%ebp
  10ded3:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10ded7:	0f 11 84 24 18 02 00 	movups %xmm0,0x218(%rsp)
  10dede:	00 
  10dedf:	4c 8d 64 6d 00       	lea    0x0(%rbp,%rbp,2),%r12
  10dee4:	49 c1 e4 03          	shl    $0x3,%r12
  10dee8:	48 85 ed             	test   %rbp,%rbp
  10deeb:	0f 84 bf 11 00 00    	je     10f0b0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2380>
  10def1:	4c 89 e7             	mov    %r12,%rdi
  10def4:	e8 57 f2 f5 ff       	call   6d150 <operator new(unsigned long)@plt>
  10def9:	66 48 0f 6e c0       	movq   %rax,%xmm0
  10defe:	49 01 c4             	add    %rax,%r12
  10df01:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  10df06:	48 89 c6             	mov    %rax,%rsi
  10df09:	66 0f 6c c0          	punpcklqdq %xmm0,%xmm0
  10df0d:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  10df11:	4c 89 64 24 38       	mov    %r12,0x38(%rsp)
  10df16:	4c 89 a4 24 20 02 00 	mov    %r12,0x220(%rsp)
  10df1d:	00 
  10df1e:	0f 29 84 24 10 02 00 	movaps %xmm0,0x210(%rsp)
  10df25:	00 
  10df26:	48 83 f8 01          	cmp    $0x1,%rax
  10df2a:	0f 86 af 11 00 00    	jbe    10f0df <synreal::SolverNewton::initialize(synreal::Model const&)+0x23af>
  10df30:	48 89 ea             	mov    %rbp,%rdx
  10df33:	48 89 f0             	mov    %rsi,%rax
  10df36:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10df3a:	48 d1 ea             	shr    %rdx
  10df3d:	48 8d 14 52          	lea    (%rdx,%rdx,2),%rdx
  10df41:	48 c1 e2 04          	shl    $0x4,%rdx
  10df45:	48 01 f2             	add    %rsi,%rdx
  10df48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10df4f:	00 
  10df50:	0f 11 00             	movups %xmm0,(%rax)
  10df53:	48 83 c0 30          	add    $0x30,%rax
  10df57:	0f 11 40 e0          	movups %xmm0,-0x20(%rax)
  10df5b:	0f 11 40 f0          	movups %xmm0,-0x10(%rax)
  10df5f:	48 39 c2             	cmp    %rax,%rdx
  10df62:	75 ec                	jne    10df50 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1220>
  10df64:	48 89 e8             	mov    %rbp,%rax
  10df67:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
  10df6c:	48 89 e9             	mov    %rbp,%rcx
  10df6f:	48 83 e0 fe          	and    $0xfffffffffffffffe,%rax
  10df73:	48 8d 14 40          	lea    (%rax,%rax,2),%rdx
  10df77:	48 29 c1             	sub    %rax,%rcx
  10df7a:	48 8d 14 d6          	lea    (%rsi,%rdx,8),%rdx
  10df7e:	48 39 c5             	cmp    %rax,%rbp
  10df81:	74 21                	je     10dfa4 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1274>
  10df83:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10df87:	48 c7 42 10 00 00 00 	movq   $0x0,0x10(%rdx)
  10df8e:	00 
  10df8f:	0f 11 02             	movups %xmm0,(%rdx)
  10df92:	48 83 f9 01          	cmp    $0x1,%rcx
  10df96:	74 0c                	je     10dfa4 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1274>
  10df98:	48 c7 42 28 00 00 00 	movq   $0x0,0x28(%rdx)
  10df9f:	00 
  10dfa0:	0f 11 42 18          	movups %xmm0,0x18(%rdx)
  10dfa4:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
  10dfa9:	8b 8b 70 03 00 00    	mov    0x370(%rbx),%ecx
  10dfaf:	4c 8d 05 69 d0 0d 00 	lea    0xdd069(%rip),%r8        # 1eb01f <_fini+0x58db>
  10dfb6:	48 8b b3 78 03 00 00 	mov    0x378(%rbx),%rsi
  10dfbd:	48 8b 93 80 03 00 00 	mov    0x380(%rbx),%rdx
  10dfc4:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  10dfc9:	48 89 84 24 18 02 00 	mov    %rax,0x218(%rsp)
  10dfd0:	00 
  10dfd1:	e8 3a f1 f5 ff       	call   6d110 <std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<2, int, (glm::qualifier)0> >(synreal::Span<glm::vec<2, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10dfd6:	8b 83 70 03 00 00    	mov    0x370(%rbx),%eax
  10dfdc:	31 ed                	xor    %ebp,%ebp
  10dfde:	85 c0                	test   %eax,%eax
  10dfe0:	75 2f                	jne    10e011 <synreal::SolverNewton::initialize(synreal::Model const&)+0x12e1>
  10dfe2:	e9 9a 01 00 00       	jmp    10e181 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1451>
  10dfe7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10dfee:	00 00 
  10dff0:	45 85 e4             	test   %r12d,%r12d
  10dff3:	78 09                	js     10dffe <synreal::SolverNewton::initialize(synreal::Model const&)+0x12ce>
  10dff5:	45 39 ec             	cmp    %r13d,%r12d
  10dff8:	0f 85 52 01 00 00    	jne    10e150 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1420>
  10dffe:	8b 83 70 03 00 00    	mov    0x370(%rbx),%eax
  10e004:	48 83 c5 01          	add    $0x1,%rbp
  10e008:	48 39 e8             	cmp    %rbp,%rax
  10e00b:	0f 86 70 01 00 00    	jbe    10e181 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1451>
  10e011:	48 8b 84 24 30 02 00 	mov    0x230(%rsp),%rax
  10e018:	00 
  10e019:	48 8d 04 e8          	lea    (%rax,%rbp,8),%rax
  10e01d:	44 8b 28             	mov    (%rax),%r13d
  10e020:	4c 63 60 04          	movslq 0x4(%rax),%r12
  10e024:	45 85 ed             	test   %r13d,%r13d
  10e027:	78 c7                	js     10dff0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x12c0>
  10e029:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
  10e02e:	49 63 c5             	movslq %r13d,%rax
  10e031:	89 ac 24 d0 01 00 00 	mov    %ebp,0x1d0(%rsp)
  10e038:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  10e03c:	48 8d 3c c6          	lea    (%rsi,%rax,8),%rdi
  10e040:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  10e045:	e8 46 08 f6 ff       	call   6e890 <int& std::vector<int, std::allocator<int> >::emplace_back<int>(int&&)@plt>
  10e04a:	eb a4                	jmp    10dff0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x12c0>
  10e04c:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
  10e050:	48 85 c9             	test   %rcx,%rcx
  10e053:	0f 84 43 ee ff ff    	je     10ce9c <synreal::SolverNewton::initialize(synreal::Model const&)+0x16c>
  10e059:	48 8d 84 24 30 02 00 	lea    0x230(%rsp),%rax
  10e060:	00 
  10e061:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
  10e066:	48 8b 53 10          	mov    0x10(%rbx),%rdx
  10e06a:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  10e06f:	4c 8d 05 0e cb 0d 00 	lea    0xdcb0e(%rip),%r8        # 1eab84 <_fini+0x5440>
  10e076:	48 8b 73 08          	mov    0x8(%rbx),%rsi
  10e07a:	e8 31 ed f5 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10e07f:	48 8b bc 24 30 02 00 	mov    0x230(%rsp),%rdi
  10e086:	00 
  10e087:	48 8b 94 24 38 02 00 	mov    0x238(%rsp),%rdx
  10e08e:	00 
  10e08f:	48 39 d7             	cmp    %rdx,%rdi
  10e092:	74 5c                	je     10e0f0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x13c0>
  10e094:	f3 0f 10 15 04 17 0e 	movss  0xe1704(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10e09b:	00 
  10e09c:	f3 0f 10 1d e8 16 0e 	movss  0xe16e8(%rip),%xmm3        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  10e0a3:	00 
  10e0a4:	48 89 f8             	mov    %rdi,%rax
  10e0a7:	0f 29 54 24 10       	movaps %xmm2,0x10(%rsp)
  10e0ac:	0f 1f 40 00          	nopl   0x0(%rax)
  10e0b0:	f3 0f 10 10          	movss  (%rax),%xmm2
  10e0b4:	0f 28 6c 24 10       	movaps 0x10(%rsp),%xmm5
  10e0b9:	f3 0f 10 48 04       	movss  0x4(%rax),%xmm1
  10e0be:	f3 0f 10 40 08       	movss  0x8(%rax),%xmm0
  10e0c3:	0f 54 d5             	andps  %xmm5,%xmm2
  10e0c6:	0f 2e da             	ucomiss %xmm2,%xmm3
  10e0c9:	0f 82 3c b6 f6 ff    	jb     7970b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x913>
  10e0cf:	0f 54 cd             	andps  %xmm5,%xmm1
  10e0d2:	0f 2e d9             	ucomiss %xmm1,%xmm3
  10e0d5:	0f 82 30 b6 f6 ff    	jb     7970b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x913>
  10e0db:	0f 54 c5             	andps  %xmm5,%xmm0
  10e0de:	0f 2e d8             	ucomiss %xmm0,%xmm3
  10e0e1:	0f 82 24 b6 f6 ff    	jb     7970b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x913>
  10e0e7:	48 83 c0 0c          	add    $0xc,%rax
  10e0eb:	48 39 c2             	cmp    %rax,%rdx
  10e0ee:	75 c0                	jne    10e0b0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1380>
  10e0f0:	48 85 ff             	test   %rdi,%rdi
  10e0f3:	0f 84 91 ed ff ff    	je     10ce8a <synreal::SolverNewton::initialize(synreal::Model const&)+0x15a>
  10e0f9:	48 8b b4 24 40 02 00 	mov    0x240(%rsp),%rsi
  10e100:	00 
  10e101:	48 29 fe             	sub    %rdi,%rsi
  10e104:	e8 a7 f0 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e109:	e9 7c ed ff ff       	jmp    10ce8a <synreal::SolverNewton::initialize(synreal::Model const&)+0x15a>
  10e10e:	66 90                	xchg   %ax,%ax
  10e110:	44 89 2a             	mov    %r13d,(%rdx)
  10e113:	e9 7f fd ff ff       	jmp    10de97 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1167>
  10e118:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10e11f:	00 
  10e120:	4c 63 60 04          	movslq 0x4(%rax),%r12
  10e124:	e9 38 fd ff ff       	jmp    10de61 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1131>
  10e129:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10e130:	4c 63 60 0c          	movslq 0xc(%rax),%r12
  10e134:	e9 28 fd ff ff       	jmp    10de61 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1131>
  10e139:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10e140:	4c 63 60 08          	movslq 0x8(%rax),%r12
  10e144:	e9 18 fd ff ff       	jmp    10de61 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1131>
  10e149:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10e150:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
  10e155:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  10e159:	89 ac 24 d0 01 00 00 	mov    %ebp,0x1d0(%rsp)
  10e160:	48 8d 3c c6          	lea    (%rsi,%rax,8),%rdi
  10e164:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  10e169:	e8 22 07 f6 ff       	call   6e890 <int& std::vector<int, std::allocator<int> >::emplace_back<int>(int&&)@plt>
  10e16e:	8b 83 70 03 00 00    	mov    0x370(%rbx),%eax
  10e174:	48 83 c5 01          	add    $0x1,%rbp
  10e178:	48 39 e8             	cmp    %rbp,%rax
  10e17b:	0f 87 90 fe ff ff    	ja     10e011 <synreal::SolverNewton::initialize(synreal::Model const&)+0x12e1>
  10e181:	8b 83 08 03 00 00    	mov    0x308(%rbx),%eax
  10e187:	8d 68 01             	lea    0x1(%rax),%ebp
  10e18a:	48 85 ed             	test   %rbp,%rbp
  10e18d:	0f 84 3d 05 00 00    	je     10e6d0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x19a0>
  10e193:	48 c1 e5 03          	shl    $0x3,%rbp
  10e197:	48 89 ef             	mov    %rbp,%rdi
  10e19a:	e8 b1 ef f5 ff       	call   6d150 <operator new(unsigned long)@plt>
  10e19f:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  10e1a4:	48 89 c7             	mov    %rax,%rdi
  10e1a7:	48 89 ea             	mov    %rbp,%rdx
  10e1aa:	48 8d 04 28          	lea    (%rax,%rbp,1),%rax
  10e1ae:	31 f6                	xor    %esi,%esi
  10e1b0:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  10e1b7:	00 
  10e1b8:	e8 63 df f5 ff       	call   6c120 <memset@plt>
  10e1bd:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  10e1c3:	48 89 ac 24 88 00 00 	mov    %rbp,0x88(%rsp)
  10e1ca:	00 
  10e1cb:	85 d2                	test   %edx,%edx
  10e1cd:	0f 84 73 01 00 00    	je     10e346 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1616>
  10e1d3:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
  10e1da:	00 00 
  10e1dc:	4c 8b 6c 24 30       	mov    0x30(%rsp),%r13
  10e1e1:	45 31 f6             	xor    %r14d,%r14d
  10e1e4:	45 31 ff             	xor    %r15d,%r15d
  10e1e7:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
  10e1ee:	00 00 
  10e1f0:	eb 48                	jmp    10e23a <synreal::SolverNewton::initialize(synreal::Model const&)+0x150a>
  10e1f2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  10e1f8:	48 89 cd             	mov    %rcx,%rbp
  10e1fb:	48 89 cf             	mov    %rcx,%rdi
  10e1fe:	e8 1d 07 f6 ff       	call   6e920 <memmove@plt>
  10e203:	48 89 e9             	mov    %rbp,%rcx
  10e206:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  10e20c:	4c 01 e1             	add    %r12,%rcx
  10e20f:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
  10e214:	48 89 cd             	mov    %rcx,%rbp
  10e217:	4c 29 f5             	sub    %r14,%rbp
  10e21a:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  10e21f:	49 83 c7 01          	add    $0x1,%r15
  10e223:	48 c1 fd 02          	sar    $0x2,%rbp
  10e227:	49 83 c5 18          	add    $0x18,%r13
  10e22b:	4a 89 2c f8          	mov    %rbp,(%rax,%r15,8)
  10e22f:	89 d0                	mov    %edx,%eax
  10e231:	49 39 c7             	cmp    %rax,%r15
  10e234:	0f 83 2e 01 00 00    	jae    10e368 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1638>
  10e23a:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
  10e23f:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
  10e244:	49 8b 7d 00          	mov    0x0(%r13),%rdi
  10e248:	4d 8b 65 08          	mov    0x8(%r13),%r12
  10e24c:	48 89 c6             	mov    %rax,%rsi
  10e24f:	48 89 cd             	mov    %rcx,%rbp
  10e252:	4c 29 f6             	sub    %r14,%rsi
  10e255:	48 89 7c 24 58       	mov    %rdi,0x58(%rsp)
  10e25a:	4c 29 f5             	sub    %r14,%rbp
  10e25d:	48 89 74 24 40       	mov    %rsi,0x40(%rsp)
  10e262:	48 89 fe             	mov    %rdi,%rsi
  10e265:	4c 39 e7             	cmp    %r12,%rdi
  10e268:	74 b0                	je     10e21a <synreal::SolverNewton::initialize(synreal::Model const&)+0x14ea>
  10e26a:	49 29 fc             	sub    %rdi,%r12
  10e26d:	48 29 c8             	sub    %rcx,%rax
  10e270:	4c 89 e2             	mov    %r12,%rdx
  10e273:	4c 39 e0             	cmp    %r12,%rax
  10e276:	73 80                	jae    10e1f8 <synreal::SolverNewton::initialize(synreal::Model const&)+0x14c8>
  10e278:	48 89 e9             	mov    %rbp,%rcx
  10e27b:	48 c1 fa 02          	sar    $0x2,%rdx
  10e27f:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
  10e286:	ff ff 1f 
  10e289:	48 c1 f9 02          	sar    $0x2,%rcx
  10e28d:	48 29 c8             	sub    %rcx,%rax
  10e290:	48 39 c2             	cmp    %rax,%rdx
  10e293:	0f 87 cd 0e 00 00    	ja     10f166 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2436>
  10e299:	48 39 ca             	cmp    %rcx,%rdx
  10e29c:	48 89 d0             	mov    %rdx,%rax
  10e29f:	48 0f 42 c1          	cmovb  %rcx,%rax
  10e2a3:	48 01 c8             	add    %rcx,%rax
  10e2a6:	0f 82 95 0e 00 00    	jb     10f141 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2411>
  10e2ac:	48 85 c0             	test   %rax,%rax
  10e2af:	0f 85 45 0e 00 00    	jne    10f0fa <synreal::SolverNewton::initialize(synreal::Model const&)+0x23ca>
  10e2b5:	48 c7 44 24 68 00 00 	movq   $0x0,0x68(%rsp)
  10e2bc:	00 00 
  10e2be:	31 c9                	xor    %ecx,%ecx
  10e2c0:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
  10e2c7:	00 00 
  10e2c9:	4c 39 74 24 08       	cmp    %r14,0x8(%rsp)
  10e2ce:	0f 84 8c 02 00 00    	je     10e560 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1830>
  10e2d4:	48 89 cf             	mov    %rcx,%rdi
  10e2d7:	48 89 ea             	mov    %rbp,%rdx
  10e2da:	4c 89 f6             	mov    %r14,%rsi
  10e2dd:	e8 3e 06 f6 ff       	call   6e920 <memmove@plt>
  10e2e2:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
  10e2e7:	4c 89 e2             	mov    %r12,%rdx
  10e2ea:	48 01 c5             	add    %rax,%rbp
  10e2ed:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  10e2f4:	00 
  10e2f5:	48 89 ef             	mov    %rbp,%rdi
  10e2f8:	e8 23 06 f6 ff       	call   6e920 <memmove@plt>
  10e2fd:	4a 8d 44 25 00       	lea    0x0(%rbp,%r12,1),%rax
  10e302:	48 8b 8c 24 a8 00 00 	mov    0xa8(%rsp),%rcx
  10e309:	00 
  10e30a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10e30f:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  10e314:	4c 89 f7             	mov    %r14,%rdi
  10e317:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
  10e31c:	e8 8f ee f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e321:	48 8b 4c 24 58       	mov    0x58(%rsp),%rcx
  10e326:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
  10e32b:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
  10e330:	49 89 ce             	mov    %rcx,%r14
  10e333:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
  10e339:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
  10e33e:	48 29 cd             	sub    %rcx,%rbp
  10e341:	e9 d4 fe ff ff       	jmp    10e21a <synreal::SolverNewton::initialize(synreal::Model const&)+0x14ea>
  10e346:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
  10e34d:	00 00 
  10e34f:	45 31 f6             	xor    %r14d,%r14d
  10e352:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
  10e359:	00 00 
  10e35b:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
  10e362:	00 00 
  10e364:	0f 1f 40 00          	nopl   0x0(%rax)
  10e368:	48 8b 5c 24 28       	mov    0x28(%rsp),%rbx
  10e36d:	48 8b 94 24 90 00 00 	mov    0x90(%rsp),%rdx
  10e374:	00 
  10e375:	48 8b 74 24 50       	mov    0x50(%rsp),%rsi
  10e37a:	48 8d bb d8 2f 00 00 	lea    0x2fd8(%rbx),%rdi
  10e381:	e8 2a 0f f6 ff       	call   6f2b0 <void thrust::THRUST_200302_520_NS::detail::vector_base<unsigned long, thrust::THRUST_200302_520_NS::device_allocator<unsigned long> >::range_assign<__gnu_cxx::__normal_iterator<unsigned long*, std::vector<unsigned long, std::allocator<unsigned long> > > >(__gnu_cxx::__normal_iterator<unsigned long*, std::vector<unsigned long, std::allocator<unsigned long> > >, __gnu_cxx::__normal_iterator<unsigned long*, std::vector<unsigned long, std::allocator<unsigned long> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  10e386:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  10e38b:	48 8d bb f8 2f 00 00 	lea    0x2ff8(%rbx),%rdi
  10e392:	4c 89 f6             	mov    %r14,%rsi
  10e395:	e8 06 d1 f5 ff       	call   6b4a0 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::range_assign<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > > >(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag)@plt>
  10e39a:	4c 8b 7c 24 60       	mov    0x60(%rsp),%r15
  10e39f:	48 8d bb 48 33 00 00 	lea    0x3348(%rbx),%rdi
  10e3a6:	4c 89 fe             	mov    %r15,%rsi
  10e3a9:	e8 22 e9 f5 ff       	call   6ccd0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10e3ae:	48 8d bb 68 33 00 00 	lea    0x3368(%rbx),%rdi
  10e3b5:	4c 89 fe             	mov    %r15,%rsi
  10e3b8:	e8 13 e9 f5 ff       	call   6ccd0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  10e3bd:	48 89 df             	mov    %rbx,%rdi
  10e3c0:	e8 fb f4 f5 ff       	call   6d8c0 <synreal::SolverNewton::precompute_matrices()@plt>
  10e3c5:	4c 8b 7c 24 78       	mov    0x78(%rsp),%r15
  10e3ca:	48 8d bb f0 08 00 00 	lea    0x8f0(%rbx),%rdi
  10e3d1:	4c 89 fe             	mov    %r15,%rsi
  10e3d4:	e8 57 da f5 ff       	call   6be30 <synreal::SelfCollision::initialize(synreal::Model const&)@plt>
  10e3d9:	48 8d bb 28 17 00 00 	lea    0x1728(%rbx),%rdi
  10e3e0:	4c 89 fe             	mov    %r15,%rsi
  10e3e3:	e8 28 f5 f5 ff       	call   6d910 <synreal::Fluid::initialize(synreal::Model const&)@plt>
  10e3e8:	48 81 c3 70 20 00 00 	add    $0x2070,%rbx
  10e3ef:	4c 89 fe             	mov    %r15,%rsi
  10e3f2:	48 89 df             	mov    %rbx,%rdi
  10e3f5:	e8 e6 df f5 ff       	call   6c3e0 <synreal::Granular::initialize(synreal::Model const&)@plt>
  10e3fa:	4d 85 f6             	test   %r14,%r14
  10e3fd:	74 0d                	je     10e40c <synreal::SolverNewton::initialize(synreal::Model const&)+0x16dc>
  10e3ff:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  10e404:	4c 89 f7             	mov    %r14,%rdi
  10e407:	e8 a4 ed f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e40c:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
  10e411:	48 8b b4 24 88 00 00 	mov    0x88(%rsp),%rsi
  10e418:	00 
  10e419:	e8 92 ed f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e41e:	48 8b bc 24 30 02 00 	mov    0x230(%rsp),%rdi
  10e425:	00 
  10e426:	48 85 ff             	test   %rdi,%rdi
  10e429:	74 10                	je     10e43b <synreal::SolverNewton::initialize(synreal::Model const&)+0x170b>
  10e42b:	48 8b b4 24 40 02 00 	mov    0x240(%rsp),%rsi
  10e432:	00 
  10e433:	48 29 fe             	sub    %rdi,%rsi
  10e436:	e8 75 ed f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e43b:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
  10e440:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
  10e445:	48 89 c3             	mov    %rax,%rbx
  10e448:	48 39 c8             	cmp    %rcx,%rax
  10e44b:	74 26                	je     10e473 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1743>
  10e44d:	0f 1f 00             	nopl   (%rax)
  10e450:	48 8b 3b             	mov    (%rbx),%rdi
  10e453:	48 85 ff             	test   %rdi,%rdi
  10e456:	0f 84 ec 00 00 00    	je     10e548 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1818>
  10e45c:	48 8b 73 10          	mov    0x10(%rbx),%rsi
  10e460:	48 83 c3 18          	add    $0x18,%rbx
  10e464:	48 29 fe             	sub    %rdi,%rsi
  10e467:	e8 44 ed f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e46c:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
  10e471:	75 dd                	jne    10e450 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1720>
  10e473:	48 83 7c 24 30 00    	cmpq   $0x0,0x30(%rsp)
  10e479:	74 12                	je     10e48d <synreal::SolverNewton::initialize(synreal::Model const&)+0x175d>
  10e47b:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
  10e480:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
  10e485:	48 29 fe             	sub    %rdi,%rsi
  10e488:	e8 23 ed f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e48d:	48 8b bc 24 f0 01 00 	mov    0x1f0(%rsp),%rdi
  10e494:	00 
  10e495:	48 85 ff             	test   %rdi,%rdi
  10e498:	74 10                	je     10e4aa <synreal::SolverNewton::initialize(synreal::Model const&)+0x177a>
  10e49a:	48 8b b4 24 00 02 00 	mov    0x200(%rsp),%rsi
  10e4a1:	00 
  10e4a2:	48 29 fe             	sub    %rdi,%rsi
  10e4a5:	e8 06 ed f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e4aa:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  10e4af:	48 85 ff             	test   %rdi,%rdi
  10e4b2:	74 10                	je     10e4c4 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1794>
  10e4b4:	48 8b b4 24 a0 00 00 	mov    0xa0(%rsp),%rsi
  10e4bb:	00 
  10e4bc:	48 29 fe             	sub    %rdi,%rsi
  10e4bf:	e8 ec ec f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e4c4:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  10e4c9:	48 85 c0             	test   %rax,%rax
  10e4cc:	74 10                	je     10e4de <synreal::SolverNewton::initialize(synreal::Model const&)+0x17ae>
  10e4ce:	48 8b b4 24 98 00 00 	mov    0x98(%rsp),%rsi
  10e4d5:	00 
  10e4d6:	48 89 c7             	mov    %rax,%rdi
  10e4d9:	e8 d2 ec f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e4de:	48 8b bc 24 80 00 00 	mov    0x80(%rsp),%rdi
  10e4e5:	00 
  10e4e6:	48 85 ff             	test   %rdi,%rdi
  10e4e9:	74 10                	je     10e4fb <synreal::SolverNewton::initialize(synreal::Model const&)+0x17cb>
  10e4eb:	48 8b b4 24 e0 00 00 	mov    0xe0(%rsp),%rsi
  10e4f2:	00 
  10e4f3:	48 29 fe             	sub    %rdi,%rsi
  10e4f6:	e8 b5 ec f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e4fb:	48 83 7c 24 70 00    	cmpq   $0x0,0x70(%rsp)
  10e501:	0f 84 89 08 00 00    	je     10ed90 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2060>
  10e507:	48 8b 84 24 48 02 00 	mov    0x248(%rsp),%rax
  10e50e:	00 
  10e50f:	64 48 2b 04 25 28 00 	sub    %fs:0x28,%rax
  10e516:	00 00 
  10e518:	0f 85 37 0c 00 00    	jne    10f155 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2425>
  10e51e:	48 8b b4 24 c0 00 00 	mov    0xc0(%rsp),%rsi
  10e525:	00 
  10e526:	48 8b 7c 24 70       	mov    0x70(%rsp),%rdi
  10e52b:	48 81 c4 58 02 00 00 	add    $0x258,%rsp
  10e532:	5b                   	pop    %rbx
  10e533:	5d                   	pop    %rbp
  10e534:	48 29 fe             	sub    %rdi,%rsi
  10e537:	41 5c                	pop    %r12
  10e539:	41 5d                	pop    %r13
  10e53b:	41 5e                	pop    %r14
  10e53d:	41 5f                	pop    %r15
  10e53f:	e9 6c ec f5 ff       	jmp    6d1b0 <operator delete(void*, unsigned long)@plt>
  10e544:	0f 1f 40 00          	nopl   0x0(%rax)
  10e548:	48 83 c3 18          	add    $0x18,%rbx
  10e54c:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
  10e551:	0f 85 f9 fe ff ff    	jne    10e450 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1720>
  10e557:	e9 17 ff ff ff       	jmp    10e473 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1743>
  10e55c:	0f 1f 40 00          	nopl   0x0(%rax)
  10e560:	48 01 cd             	add    %rcx,%rbp
  10e563:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
  10e568:	4c 89 e2             	mov    %r12,%rdx
  10e56b:	48 89 8c 24 a8 00 00 	mov    %rcx,0xa8(%rsp)
  10e572:	00 
  10e573:	48 89 ef             	mov    %rbp,%rdi
  10e576:	e8 a5 03 f6 ff       	call   6e920 <memmove@plt>
  10e57b:	4a 8d 44 25 00       	lea    0x0(%rbp,%r12,1),%rax
  10e580:	4d 85 f6             	test   %r14,%r14
  10e583:	48 8b 8c 24 a8 00 00 	mov    0xa8(%rsp),%rcx
  10e58a:	00 
  10e58b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10e590:	0f 84 90 fd ff ff    	je     10e326 <synreal::SolverNewton::initialize(synreal::Model const&)+0x15f6>
  10e596:	e9 74 fd ff ff       	jmp    10e30f <synreal::SolverNewton::initialize(synreal::Model const&)+0x15df>
  10e59b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10e5a0:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
  10e5a5:	48 89 ee             	mov    %rbp,%rsi
  10e5a8:	4c 29 ee             	sub    %r13,%rsi
  10e5ab:	48 8d b8 18 31 00 00 	lea    0x3118(%rax),%rdi
  10e5b2:	e8 a9 0f f6 ff       	call   6f560 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::append(unsigned long)@plt>
  10e5b7:	e9 4c f4 ff ff       	jmp    10da08 <synreal::SolverNewton::initialize(synreal::Model const&)+0xcd8>
  10e5bc:	0f 1f 40 00          	nopl   0x0(%rax)
  10e5c0:	4c 8b ab 88 01 00 00 	mov    0x188(%rbx),%r13
  10e5c7:	4c 8b a3 90 01 00 00 	mov    0x190(%rbx),%r12
  10e5ce:	e9 28 ea ff ff       	jmp    10cffb <synreal::SolverNewton::initialize(synreal::Model const&)+0x2cb>
  10e5d3:	48 85 ff             	test   %rdi,%rdi
  10e5d6:	0f 85 56 0b 00 00    	jne    10f132 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2402>
  10e5dc:	66 0f ef f6          	pxor   %xmm6,%xmm6
  10e5e0:	f3 0f 11 74 24 08    	movss  %xmm6,0x8(%rsp)
  10e5e6:	e9 c4 f0 ff ff       	jmp    10d6af <synreal::SolverNewton::initialize(synreal::Model const&)+0x97f>
  10e5eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10e5f0:	48 c7 84 24 98 00 00 	movq   $0x0,0x98(%rsp)
  10e5f7:	00 00 00 00 00 
  10e5fc:	4e 8d 24 b5 00 00 00 	lea    0x0(,%r14,4),%r12
  10e603:	00 
  10e604:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
  10e60b:	00 00 
  10e60d:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
  10e614:	00 00 
  10e616:	4d 85 f6             	test   %r14,%r14
  10e619:	0f 85 96 f7 ff ff    	jne    10ddb5 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1085>
  10e61f:	48 c7 84 24 a0 00 00 	movq   $0x0,0xa0(%rsp)
  10e626:	00 00 00 00 00 
  10e62b:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
  10e632:	00 00 
  10e634:	e9 aa f7 ff ff       	jmp    10dde3 <synreal::SolverNewton::initialize(synreal::Model const&)+0x10b3>
  10e639:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10e640:	48 8b b3 60 03 00 00 	mov    0x360(%rbx),%rsi
  10e647:	48 8b 93 68 03 00 00 	mov    0x368(%rbx),%rdx
  10e64e:	48 8d bc 24 30 02 00 	lea    0x230(%rsp),%rdi
  10e655:	00 
  10e656:	4c 8d 05 84 c9 0d 00 	lea    0xdc984(%rip),%r8        # 1eafe1 <_fini+0x589d>
  10e65d:	e8 ce f1 f5 ff       	call   6d830 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  10e662:	48 8b bc 24 30 02 00 	mov    0x230(%rsp),%rdi
  10e669:	00 
  10e66a:	48 8b 94 24 38 02 00 	mov    0x238(%rsp),%rdx
  10e671:	00 
  10e672:	31 f6                	xor    %esi,%esi
  10e674:	48 29 fa             	sub    %rdi,%rdx
  10e677:	48 c1 fa 02          	sar    $0x2,%rdx
  10e67b:	74 35                	je     10e6b2 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1982>
  10e67d:	0f 1f 00             	nopl   (%rax)
  10e680:	48 83 c6 01          	add    $0x1,%rsi
  10e684:	48 39 d6             	cmp    %rdx,%rsi
  10e687:	73 27                	jae    10e6b0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1980>
  10e689:	8b 4c b7 fc          	mov    -0x4(%rdi,%rsi,4),%ecx
  10e68d:	48 89 f0             	mov    %rsi,%rax
  10e690:	eb 0f                	jmp    10e6a1 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1971>
  10e692:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  10e698:	48 83 c0 01          	add    $0x1,%rax
  10e69c:	48 39 d0             	cmp    %rdx,%rax
  10e69f:	73 df                	jae    10e680 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1950>
  10e6a1:	3b 0c 87             	cmp    (%rdi,%rax,4),%ecx
  10e6a4:	75 f2                	jne    10e698 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1968>
  10e6a6:	e9 a6 b1 f6 ff       	jmp    79851 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xa59>
  10e6ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10e6b0:	75 ce                	jne    10e680 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1950>
  10e6b2:	48 85 ff             	test   %rdi,%rdi
  10e6b5:	0f 84 c9 eb ff ff    	je     10d284 <synreal::SolverNewton::initialize(synreal::Model const&)+0x554>
  10e6bb:	48 8b b4 24 40 02 00 	mov    0x240(%rsp),%rsi
  10e6c2:	00 
  10e6c3:	48 29 fe             	sub    %rdi,%rsi
  10e6c6:	e8 e5 ea f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e6cb:	e9 b4 eb ff ff       	jmp    10d284 <synreal::SolverNewton::initialize(synreal::Model const&)+0x554>
  10e6d0:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
  10e6d7:	00 00 
  10e6d9:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  10e6de:	48 c7 84 24 88 00 00 	movq   $0x0,0x88(%rsp)
  10e6e5:	00 00 00 00 00 
  10e6ea:	48 c7 84 24 90 00 00 	movq   $0x0,0x90(%rsp)
  10e6f1:	00 00 00 00 00 
  10e6f6:	e9 d8 fa ff ff       	jmp    10e1d3 <synreal::SolverNewton::initialize(synreal::Model const&)+0x14a3>
  10e6fb:	48 8b b3 78 03 00 00 	mov    0x378(%rbx),%rsi
  10e702:	48 8b 93 80 03 00 00 	mov    0x380(%rbx),%rdx
  10e709:	48 8d bc 24 f0 01 00 	lea    0x1f0(%rsp),%rdi
  10e710:	00 
  10e711:	4c 8d 05 07 c9 0d 00 	lea    0xdc907(%rip),%r8        # 1eb01f <_fini+0x58db>
  10e718:	e8 f3 e9 f5 ff       	call   6d110 <std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<2, int, (glm::qualifier)0> >(synreal::Span<glm::vec<2, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10e71d:	8b 8b 70 03 00 00    	mov    0x370(%rbx),%ecx
  10e723:	48 8b b3 a8 03 00 00 	mov    0x3a8(%rbx),%rsi
  10e72a:	48 8d bc 24 10 02 00 	lea    0x210(%rsp),%rdi
  10e731:	00 
  10e732:	4c 8d 05 51 c9 0d 00 	lea    0xdc951(%rip),%r8        # 1eb08a <_fini+0x5946>
  10e739:	48 8b 93 b0 03 00 00 	mov    0x3b0(%rbx),%rdx
  10e740:	e8 0b fa f5 ff       	call   6e150 <std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, float, (glm::qualifier)0> >(synreal::Span<glm::vec<4, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10e745:	8b 8b 70 03 00 00    	mov    0x370(%rbx),%ecx
  10e74b:	48 8b b3 b8 03 00 00 	mov    0x3b8(%rbx),%rsi
  10e752:	48 8d bc 24 30 02 00 	lea    0x230(%rsp),%rdi
  10e759:	00 
  10e75a:	4c 8d 05 3b c9 0d 00 	lea    0xdc93b(%rip),%r8        # 1eb09c <_fini+0x5958>
  10e761:	48 8b 93 c0 03 00 00 	mov    0x3c0(%rbx),%rdx
  10e768:	e8 e3 f9 f5 ff       	call   6e150 <std::vector<glm::vec<4, float, (glm::qualifier)0>, std::allocator<glm::vec<4, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, float, (glm::qualifier)0> >(synreal::Span<glm::vec<4, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10e76d:	44 8b 93 70 03 00 00 	mov    0x370(%rbx),%r10d
  10e774:	4d 85 d2             	test   %r10,%r10
  10e777:	0f 84 6d 09 00 00    	je     10f0ea <synreal::SolverNewton::initialize(synreal::Model const&)+0x23ba>
  10e77d:	4c 8b 8c 24 f0 01 00 	mov    0x1f0(%rsp),%r9
  10e784:	00 
  10e785:	31 f6                	xor    %esi,%esi
  10e787:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10e78b:	48 8b 94 24 30 02 00 	mov    0x230(%rsp),%rdx
  10e792:	00 
  10e793:	48 8b 84 24 10 02 00 	mov    0x210(%rsp),%rax
  10e79a:	00 
  10e79b:	f3 0f 10 0d e9 0f 0e 	movss  0xe0fe9(%rip),%xmm1        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  10e7a2:	00 
  10e7a3:	f3 0f 10 15 f5 0f 0e 	movss  0xe0ff5(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  10e7aa:	00 
  10e7ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10e7b0:	41 8b 3c f1          	mov    (%r9,%rsi,8),%edi
  10e7b4:	83 ff ff             	cmp    $0xffffffff,%edi
  10e7b7:	0f 8c cd ad f6 ff    	jl     7958a <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x792>
  10e7bd:	44 8b 83 08 03 00 00 	mov    0x308(%rbx),%r8d
  10e7c4:	41 39 f8             	cmp    %edi,%r8d
  10e7c7:	0f 8e bd ad f6 ff    	jle    7958a <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x792>
  10e7cd:	41 8b 4c f1 04       	mov    0x4(%r9,%rsi,8),%ecx
  10e7d2:	83 f9 ff             	cmp    $0xffffffff,%ecx
  10e7d5:	0f 8c af ad f6 ff    	jl     7958a <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x792>
  10e7db:	44 39 c1             	cmp    %r8d,%ecx
  10e7de:	0f 8d 4e 0a 00 00    	jge    10f232 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2502>
  10e7e4:	21 f9                	and    %edi,%ecx
  10e7e6:	83 f9 ff             	cmp    $0xffffffff,%ecx
  10e7e9:	0f 84 dc ad f6 ff    	je     795cb <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x7d3>
  10e7ef:	f3 0f 10 18          	movss  (%rax),%xmm3
  10e7f3:	0f 28 e3             	movaps %xmm3,%xmm4
  10e7f6:	0f 54 e2             	andps  %xmm2,%xmm4
  10e7f9:	0f 2e cc             	ucomiss %xmm4,%xmm1
  10e7fc:	0f 82 7a ae f6 ff    	jb     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e802:	0f 2f c3             	comiss %xmm3,%xmm0
  10e805:	0f 87 71 ae f6 ff    	ja     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e80b:	f3 0f 10 1a          	movss  (%rdx),%xmm3
  10e80f:	0f 28 e3             	movaps %xmm3,%xmm4
  10e812:	0f 54 e2             	andps  %xmm2,%xmm4
  10e815:	0f 2e cc             	ucomiss %xmm4,%xmm1
  10e818:	0f 82 5e ae f6 ff    	jb     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e81e:	0f 2f c3             	comiss %xmm3,%xmm0
  10e821:	0f 87 55 ae f6 ff    	ja     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e827:	f3 0f 10 58 04       	movss  0x4(%rax),%xmm3
  10e82c:	0f 28 e3             	movaps %xmm3,%xmm4
  10e82f:	0f 54 e2             	andps  %xmm2,%xmm4
  10e832:	0f 2e cc             	ucomiss %xmm4,%xmm1
  10e835:	0f 82 41 ae f6 ff    	jb     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e83b:	0f 2f c3             	comiss %xmm3,%xmm0
  10e83e:	0f 87 38 ae f6 ff    	ja     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e844:	f3 0f 10 5a 04       	movss  0x4(%rdx),%xmm3
  10e849:	0f 28 e3             	movaps %xmm3,%xmm4
  10e84c:	0f 54 e2             	andps  %xmm2,%xmm4
  10e84f:	0f 2e cc             	ucomiss %xmm4,%xmm1
  10e852:	0f 82 24 ae f6 ff    	jb     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e858:	0f 2f c3             	comiss %xmm3,%xmm0
  10e85b:	0f 87 1b ae f6 ff    	ja     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e861:	f3 0f 10 58 08       	movss  0x8(%rax),%xmm3
  10e866:	0f 28 e3             	movaps %xmm3,%xmm4
  10e869:	0f 54 e2             	andps  %xmm2,%xmm4
  10e86c:	0f 2e cc             	ucomiss %xmm4,%xmm1
  10e86f:	0f 82 07 ae f6 ff    	jb     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e875:	0f 2f c3             	comiss %xmm3,%xmm0
  10e878:	0f 87 fe ad f6 ff    	ja     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e87e:	f3 0f 10 5a 08       	movss  0x8(%rdx),%xmm3
  10e883:	0f 28 e3             	movaps %xmm3,%xmm4
  10e886:	0f 54 e2             	andps  %xmm2,%xmm4
  10e889:	0f 2e cc             	ucomiss %xmm4,%xmm1
  10e88c:	0f 82 ea ad f6 ff    	jb     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e892:	0f 2f c3             	comiss %xmm3,%xmm0
  10e895:	0f 87 e1 ad f6 ff    	ja     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e89b:	f3 0f 10 58 0c       	movss  0xc(%rax),%xmm3
  10e8a0:	0f 28 e3             	movaps %xmm3,%xmm4
  10e8a3:	0f 54 e2             	andps  %xmm2,%xmm4
  10e8a6:	0f 2e cc             	ucomiss %xmm4,%xmm1
  10e8a9:	0f 82 cd ad f6 ff    	jb     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e8af:	0f 2f c3             	comiss %xmm3,%xmm0
  10e8b2:	0f 87 c4 ad f6 ff    	ja     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e8b8:	f3 0f 10 5a 0c       	movss  0xc(%rdx),%xmm3
  10e8bd:	0f 28 e3             	movaps %xmm3,%xmm4
  10e8c0:	0f 54 e2             	andps  %xmm2,%xmm4
  10e8c3:	0f 2e cc             	ucomiss %xmm4,%xmm1
  10e8c6:	0f 82 b0 ad f6 ff    	jb     7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10e8cc:	0f 2f c3             	comiss %xmm3,%xmm0
  10e8cf:	0f 87 62 09 00 00    	ja     10f237 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2507>
  10e8d5:	48 83 c6 01          	add    $0x1,%rsi
  10e8d9:	48 83 c2 10          	add    $0x10,%rdx
  10e8dd:	48 83 c0 10          	add    $0x10,%rax
  10e8e1:	4c 39 d6             	cmp    %r10,%rsi
  10e8e4:	0f 85 c6 fe ff ff    	jne    10e7b0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1a80>
  10e8ea:	4c 89 d0             	mov    %r10,%rax
  10e8ed:	4d 85 f6             	test   %r14,%r14
  10e8f0:	74 0c                	je     10e8fe <synreal::SolverNewton::initialize(synreal::Model const&)+0x1bce>
  10e8f2:	4c 89 f8             	mov    %r15,%rax
  10e8f5:	31 d2                	xor    %edx,%edx
  10e8f7:	49 f7 f6             	div    %r14
  10e8fa:	49 0f af c2          	imul   %r10,%rax
  10e8fe:	48 8b 93 00 04 00 00 	mov    0x400(%rbx),%rdx
  10e905:	48 85 d2             	test   %rdx,%rdx
  10e908:	0f 85 f2 06 00 00    	jne    10f000 <synreal::SolverNewton::initialize(synreal::Model const&)+0x22d0>
  10e90e:	48 8b 93 e0 03 00 00 	mov    0x3e0(%rbx),%rdx
  10e915:	48 39 c2             	cmp    %rax,%rdx
  10e918:	0f 82 d4 06 00 00    	jb     10eff2 <synreal::SolverNewton::initialize(synreal::Model const&)+0x22c2>
  10e91e:	48 8b 93 f0 03 00 00 	mov    0x3f0(%rbx),%rdx
  10e925:	48 85 d2             	test   %rdx,%rdx
  10e928:	0f 85 a5 06 00 00    	jne    10efd3 <synreal::SolverNewton::initialize(synreal::Model const&)+0x22a3>
  10e92e:	48 8b bc 24 30 02 00 	mov    0x230(%rsp),%rdi
  10e935:	00 
  10e936:	48 85 ff             	test   %rdi,%rdi
  10e939:	74 10                	je     10e94b <synreal::SolverNewton::initialize(synreal::Model const&)+0x1c1b>
  10e93b:	48 8b b4 24 40 02 00 	mov    0x240(%rsp),%rsi
  10e942:	00 
  10e943:	48 29 fe             	sub    %rdi,%rsi
  10e946:	e8 65 e8 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e94b:	48 8b bc 24 10 02 00 	mov    0x210(%rsp),%rdi
  10e952:	00 
  10e953:	48 85 ff             	test   %rdi,%rdi
  10e956:	74 10                	je     10e968 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1c38>
  10e958:	48 8b b4 24 20 02 00 	mov    0x220(%rsp),%rsi
  10e95f:	00 
  10e960:	48 29 fe             	sub    %rdi,%rsi
  10e963:	e8 48 e8 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e968:	48 8b bc 24 f0 01 00 	mov    0x1f0(%rsp),%rdi
  10e96f:	00 
  10e970:	48 85 ff             	test   %rdi,%rdi
  10e973:	0f 84 67 e9 ff ff    	je     10d2e0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x5b0>
  10e979:	48 8b b4 24 00 02 00 	mov    0x200(%rsp),%rsi
  10e980:	00 
  10e981:	48 29 fe             	sub    %rdi,%rsi
  10e984:	e8 27 e8 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10e989:	e9 52 e9 ff ff       	jmp    10d2e0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x5b0>
  10e98e:	48 8b b3 88 06 00 00 	mov    0x688(%rbx),%rsi
  10e995:	48 8b 93 90 06 00 00 	mov    0x690(%rbx),%rdx
  10e99c:	48 8d bc 24 f0 00 00 	lea    0xf0(%rsp),%rdi
  10e9a3:	00 
  10e9a4:	4c 8d 05 e5 c9 0d 00 	lea    0xdc9e5(%rip),%r8        # 1eb390 <_fini+0x5c4c>
  10e9ab:	e8 80 ee f5 ff       	call   6d830 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  10e9b0:	8b 8b 80 06 00 00    	mov    0x680(%rbx),%ecx
  10e9b6:	48 8b b3 98 06 00 00 	mov    0x698(%rbx),%rsi
  10e9bd:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
  10e9c4:	00 
  10e9c5:	4c 8d 05 d1 c9 0d 00 	lea    0xdc9d1(%rip),%r8        # 1eb39d <_fini+0x5c59>
  10e9cc:	48 8b 93 a0 06 00 00 	mov    0x6a0(%rbx),%rdx
  10e9d3:	e8 58 ee f5 ff       	call   6d830 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  10e9d8:	8b 8b 80 06 00 00    	mov    0x680(%rbx),%ecx
  10e9de:	48 8b b3 a8 06 00 00 	mov    0x6a8(%rbx),%rsi
  10e9e5:	48 8d bc 24 30 01 00 	lea    0x130(%rsp),%rdi
  10e9ec:	00 
  10e9ed:	4c 8d 05 b5 c9 0d 00 	lea    0xdc9b5(%rip),%r8        # 1eb3a9 <_fini+0x5c65>
  10e9f4:	48 8b 93 b0 06 00 00 	mov    0x6b0(%rbx),%rdx
  10e9fb:	e8 10 cb f5 ff       	call   6b510 <std::vector<synreal::Transform, std::allocator<synreal::Transform> > (anonymous namespace)::copy_to_host<synreal::Transform>(synreal::Span<synreal::Transform const>, unsigned long, char const*)@plt>
  10ea00:	8b 8b 80 06 00 00    	mov    0x680(%rbx),%ecx
  10ea06:	48 8b b3 b8 06 00 00 	mov    0x6b8(%rbx),%rsi
  10ea0d:	48 8d bc 24 50 01 00 	lea    0x150(%rsp),%rdi
  10ea14:	00 
  10ea15:	4c 8d 05 9e c9 0d 00 	lea    0xdc99e(%rip),%r8        # 1eb3ba <_fini+0x5c76>
  10ea1c:	48 8b 93 c0 06 00 00 	mov    0x6c0(%rbx),%rdx
  10ea23:	e8 88 e3 f5 ff       	call   6cdb0 <std::vector<glm::vec<3, float, (glm::qualifier)0>, std::allocator<glm::vec<3, float, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, float, (glm::qualifier)0> >(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  10ea28:	8b 8b 80 06 00 00    	mov    0x680(%rbx),%ecx
  10ea2e:	48 8b b3 c8 06 00 00 	mov    0x6c8(%rbx),%rsi
  10ea35:	48 8d bc 24 70 01 00 	lea    0x170(%rsp),%rdi
  10ea3c:	00 
  10ea3d:	4c 8d 05 83 c9 0d 00 	lea    0xdc983(%rip),%r8        # 1eb3c7 <_fini+0x5c83>
  10ea44:	48 8b 93 d0 06 00 00 	mov    0x6d0(%rbx),%rdx
  10ea4b:	e8 70 f2 f5 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10ea50:	8b 8b 80 06 00 00    	mov    0x680(%rbx),%ecx
  10ea56:	48 8b b3 d8 06 00 00 	mov    0x6d8(%rbx),%rsi
  10ea5d:	48 8d bc 24 90 01 00 	lea    0x190(%rsp),%rdi
  10ea64:	00 
  10ea65:	4c 8d 05 75 c9 0d 00 	lea    0xdc975(%rip),%r8        # 1eb3e1 <_fini+0x5c9d>
  10ea6c:	48 8b 93 e0 06 00 00 	mov    0x6e0(%rbx),%rdx
  10ea73:	e8 48 f2 f5 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10ea78:	8b 8b 80 06 00 00    	mov    0x680(%rbx),%ecx
  10ea7e:	48 8b b3 f8 06 00 00 	mov    0x6f8(%rbx),%rsi
  10ea85:	48 8d bc 24 b0 01 00 	lea    0x1b0(%rsp),%rdi
  10ea8c:	00 
  10ea8d:	4c 8d 05 81 c9 0d 00 	lea    0xdc981(%rip),%r8        # 1eb415 <_fini+0x5cd1>
  10ea94:	48 8b 93 00 07 00 00 	mov    0x700(%rbx),%rdx
  10ea9b:	e8 20 f2 f5 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10eaa0:	48 83 bb 10 07 00 00 	cmpq   $0x0,0x710(%rbx)
  10eaa7:	00 
  10eaa8:	8b 83 80 06 00 00    	mov    0x680(%rbx),%eax
  10eaae:	0f 85 c5 05 00 00    	jne    10f079 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2349>
  10eab4:	48 c7 84 24 e0 01 00 	movq   $0x0,0x1e0(%rsp)
  10eabb:	00 00 00 00 00 
  10eac0:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10eac4:	0f 29 84 24 d0 01 00 	movaps %xmm0,0x1d0(%rsp)
  10eacb:	00 
  10eacc:	48 83 bb 20 07 00 00 	cmpq   $0x0,0x720(%rbx)
  10ead3:	00 
  10ead4:	0f 85 76 05 00 00    	jne    10f050 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2320>
  10eada:	48 c7 84 24 00 02 00 	movq   $0x0,0x200(%rsp)
  10eae1:	00 00 00 00 00 
  10eae6:	66 0f ef c0          	pxor   %xmm0,%xmm0
  10eaea:	0f 29 84 24 f0 01 00 	movaps %xmm0,0x1f0(%rsp)
  10eaf1:	00 
  10eaf2:	8b 8b 80 06 00 00    	mov    0x680(%rbx),%ecx
  10eaf8:	48 8b b3 e8 06 00 00 	mov    0x6e8(%rbx),%rsi
  10eaff:	48 8d bc 24 10 02 00 	lea    0x210(%rsp),%rdi
  10eb06:	00 
  10eb07:	4c 8d 05 ea c8 0d 00 	lea    0xdc8ea(%rip),%r8        # 1eb3f8 <_fini+0x5cb4>
  10eb0e:	48 8b 93 f0 06 00 00 	mov    0x6f0(%rbx),%rdx
  10eb15:	e8 a6 f1 f5 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10eb1a:	8b 8b 80 06 00 00    	mov    0x680(%rbx),%ecx
  10eb20:	48 8b b3 28 07 00 00 	mov    0x728(%rbx),%rsi
  10eb27:	48 8d bc 24 30 02 00 	lea    0x230(%rsp),%rdi
  10eb2e:	00 
  10eb2f:	4c 8d 05 21 c9 0d 00 	lea    0xdc921(%rip),%r8        # 1eb457 <_fini+0x5d13>
  10eb36:	48 8b 93 30 07 00 00 	mov    0x730(%rbx),%rdx
  10eb3d:	e8 7e f1 f5 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10eb42:	8b 83 80 06 00 00    	mov    0x680(%rbx),%eax
  10eb48:	4c 8b 8c 24 30 02 00 	mov    0x230(%rsp),%r9
  10eb4f:	00 
  10eb50:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  10eb55:	48 85 c0             	test   %rax,%rax
  10eb58:	0f 84 da 04 00 00    	je     10f038 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2308>
  10eb5e:	48 8b 84 24 d8 01 00 	mov    0x1d8(%rsp),%rax
  10eb65:	00 
  10eb66:	4c 8b 84 24 b0 01 00 	mov    0x1b0(%rsp),%r8
  10eb6d:	00 
  10eb6e:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
  10eb73:	4c 89 74 24 50       	mov    %r14,0x50(%rsp)
  10eb78:	4c 8b a4 24 f0 00 00 	mov    0xf0(%rsp),%r12
  10eb7f:	00 
  10eb80:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
  10eb85:	48 8b 84 24 f8 01 00 	mov    0x1f8(%rsp),%rax
  10eb8c:	00 
  10eb8d:	4d 89 c6             	mov    %r8,%r14
  10eb90:	48 8b ac 24 10 01 00 	mov    0x110(%rsp),%rbp
  10eb97:	00 
  10eb98:	4c 8b 9c 24 70 01 00 	mov    0x170(%rsp),%r11
  10eb9f:	00 
  10eba0:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
  10eba5:	4c 8b 94 24 90 01 00 	mov    0x190(%rsp),%r10
  10ebac:	00 
  10ebad:	31 c0                	xor    %eax,%eax
  10ebaf:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
  10ebb4:	4c 8b ac 24 10 02 00 	mov    0x210(%rsp),%r13
  10ebbb:	00 
  10ebbc:	48 89 5c 24 40       	mov    %rbx,0x40(%rsp)
  10ebc1:	48 8b bc 24 d0 01 00 	mov    0x1d0(%rsp),%rdi
  10ebc8:	00 
  10ebc9:	48 8b b4 24 f0 01 00 	mov    0x1f0(%rsp),%rsi
  10ebd0:	00 
  10ebd1:	48 8b 8c 24 50 01 00 	mov    0x150(%rsp),%rcx
  10ebd8:	00 
  10ebd9:	48 8b 94 24 30 01 00 	mov    0x130(%rsp),%rdx
  10ebe0:	00 
  10ebe1:	4c 8b 44 24 28       	mov    0x28(%rsp),%r8
  10ebe6:	f3 0f 10 54 24 20    	movss  0x20(%rsp),%xmm2
  10ebec:	e9 29 01 00 00       	jmp    10ed1a <synreal::SolverNewton::initialize(synreal::Model const&)+0x1fea>
  10ebf1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10ebf8:	f3 41 0f 10 04 83    	movss  (%r11,%rax,4),%xmm0
  10ebfe:	0f 28 74 24 10       	movaps 0x10(%rsp),%xmm6
  10ec03:	0f 54 f0             	andps  %xmm0,%xmm6
  10ec06:	0f 2e d6             	ucomiss %xmm6,%xmm2
  10ec09:	0f 82 1e 06 00 00    	jb     10f22d <synreal::SolverNewton::initialize(synreal::Model const&)+0x24fd>
  10ec0f:	f3 0f 10 64 24 08    	movss  0x8(%rsp),%xmm4
  10ec15:	0f 2f e0             	comiss %xmm0,%xmm4
  10ec18:	0f 87 df a9 f6 ff    	ja     795fd <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x805>
  10ec1e:	0f 28 6c 24 10       	movaps 0x10(%rsp),%xmm5
  10ec23:	f3 41 0f 10 04 82    	movss  (%r10,%rax,4),%xmm0
  10ec29:	0f 28 f5             	movaps %xmm5,%xmm6
  10ec2c:	0f 54 f0             	andps  %xmm0,%xmm6
  10ec2f:	0f 2e d6             	ucomiss %xmm6,%xmm2
  10ec32:	0f 82 c5 a9 f6 ff    	jb     795fd <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x805>
  10ec38:	0f 2f e0             	comiss %xmm0,%xmm4
  10ec3b:	0f 87 bc a9 f6 ff    	ja     795fd <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x805>
  10ec41:	f3 41 0f 10 44 85 00 	movss  0x0(%r13,%rax,4),%xmm0
  10ec48:	0f 28 fd             	movaps %xmm5,%xmm7
  10ec4b:	0f 54 f8             	andps  %xmm0,%xmm7
  10ec4e:	0f 2e d7             	ucomiss %xmm7,%xmm2
  10ec51:	0f 82 a6 a9 f6 ff    	jb     795fd <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x805>
  10ec57:	0f 2f e0             	comiss %xmm0,%xmm4
  10ec5a:	0f 87 9d a9 f6 ff    	ja     795fd <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x805>
  10ec60:	f3 41 0f 10 04 86    	movss  (%r14,%rax,4),%xmm0
  10ec66:	0f 28 f5             	movaps %xmm5,%xmm6
  10ec69:	0f 54 f0             	andps  %xmm0,%xmm6
  10ec6c:	0f 2e d6             	ucomiss %xmm6,%xmm2
  10ec6f:	0f 82 88 a9 f6 ff    	jb     795fd <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x805>
  10ec75:	0f 2f e0             	comiss %xmm0,%xmm4
  10ec78:	0f 87 7f a9 f6 ff    	ja     795fd <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x805>
  10ec7e:	f3 41 0f 10 04 81    	movss  (%r9,%rax,4),%xmm0
  10ec84:	0f 54 e8             	andps  %xmm0,%xmm5
  10ec87:	0f 2e d5             	ucomiss %xmm5,%xmm2
  10ec8a:	0f 82 6d a9 f6 ff    	jb     795fd <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x805>
  10ec90:	0f 2f e0             	comiss %xmm0,%xmm4
  10ec93:	0f 87 64 a9 f6 ff    	ja     795fd <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x805>
  10ec99:	48 39 7c 24 38       	cmp    %rdi,0x38(%rsp)
  10ec9e:	74 2c                	je     10eccc <synreal::SolverNewton::initialize(synreal::Model const&)+0x1f9c>
  10eca0:	f3 0f 10 04 87       	movss  (%rdi,%rax,4),%xmm0
  10eca5:	0f 28 6c 24 10       	movaps 0x10(%rsp),%xmm5
  10ecaa:	0f 54 e8             	andps  %xmm0,%xmm5
  10ecad:	0f 2e d5             	ucomiss %xmm5,%xmm2
  10ecb0:	0f 82 79 a9 f6 ff    	jb     7962f <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x837>
  10ecb6:	0f 2f e0             	comiss %xmm0,%xmm4
  10ecb9:	0f 87 70 a9 f6 ff    	ja     7962f <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x837>
  10ecbf:	0f 2f c4             	comiss %xmm4,%xmm0
  10ecc2:	0f 97 c3             	seta   %bl
  10ecc5:	41 08 98 41 33 00 00 	or     %bl,0x3341(%r8)
  10eccc:	49 39 f7             	cmp    %rsi,%r15
  10eccf:	74 32                	je     10ed03 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1fd3>
  10ecd1:	f3 0f 10 04 86       	movss  (%rsi,%rax,4),%xmm0
  10ecd6:	0f 28 74 24 10       	movaps 0x10(%rsp),%xmm6
  10ecdb:	0f 54 f0             	andps  %xmm0,%xmm6
  10ecde:	0f 2e d6             	ucomiss %xmm6,%xmm2
  10ece1:	0f 82 71 a8 f6 ff    	jb     79558 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x760>
  10ece7:	f3 0f 10 5c 24 08    	movss  0x8(%rsp),%xmm3
  10eced:	0f 2f d8             	comiss %xmm0,%xmm3
  10ecf0:	0f 87 62 a8 f6 ff    	ja     79558 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x760>
  10ecf6:	0f 2f c3             	comiss %xmm3,%xmm0
  10ecf9:	0f 97 c3             	seta   %bl
  10ecfc:	41 08 98 41 33 00 00 	or     %bl,0x3341(%r8)
  10ed03:	48 83 c0 01          	add    $0x1,%rax
  10ed07:	48 83 c1 0c          	add    $0xc,%rcx
  10ed0b:	48 83 c2 1c          	add    $0x1c,%rdx
  10ed0f:	48 3b 44 24 30       	cmp    0x30(%rsp),%rax
  10ed14:	0f 84 cb 00 00 00    	je     10ede5 <synreal::SolverNewton::initialize(synreal::Model const&)+0x20b5>
  10ed1a:	41 83 3c 84 ff       	cmpl   $0xffffffff,(%r12,%rax,4)
  10ed1f:	0f 8c 9f a3 f6 ff    	jl     790c4 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x2cc>
  10ed25:	83 7c 85 00 03       	cmpl   $0x3,0x0(%rbp,%rax,4)
  10ed2a:	0f 85 c8 fe ff ff    	jne    10ebf8 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1ec8>
  10ed30:	f3 0f 10 02          	movss  (%rdx),%xmm0
  10ed34:	0f 28 6c 24 10       	movaps 0x10(%rsp),%xmm5
  10ed39:	0f 54 c5             	andps  %xmm5,%xmm0
  10ed3c:	0f 2e d0             	ucomiss %xmm0,%xmm2
  10ed3f:	0f 82 c2 ab f6 ff    	jb     79907 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xb0f>
  10ed45:	f3 0f 10 42 04       	movss  0x4(%rdx),%xmm0
  10ed4a:	0f 54 c5             	andps  %xmm5,%xmm0
  10ed4d:	0f 2e d0             	ucomiss %xmm0,%xmm2
  10ed50:	0f 82 b1 ab f6 ff    	jb     79907 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xb0f>
  10ed56:	f3 0f 10 42 08       	movss  0x8(%rdx),%xmm0
  10ed5b:	0f 54 c5             	andps  %xmm5,%xmm0
  10ed5e:	0f 2e d0             	ucomiss %xmm0,%xmm2
  10ed61:	0f 82 a0 ab f6 ff    	jb     79907 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xb0f>
  10ed67:	f3 0f 10 01          	movss  (%rcx),%xmm0
  10ed6b:	0f 54 e8             	andps  %xmm0,%xmm5
  10ed6e:	0f 2e d5             	ucomiss %xmm5,%xmm2
  10ed71:	0f 82 90 ab f6 ff    	jb     79907 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xb0f>
  10ed77:	0f 2f 44 24 08       	comiss 0x8(%rsp),%xmm0
  10ed7c:	0f 87 76 fe ff ff    	ja     10ebf8 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1ec8>
  10ed82:	e9 80 ab f6 ff       	jmp    79907 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xb0f>
  10ed87:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  10ed8e:	00 00 
  10ed90:	48 8b 84 24 48 02 00 	mov    0x248(%rsp),%rax
  10ed97:	00 
  10ed98:	64 48 2b 04 25 28 00 	sub    %fs:0x28,%rax
  10ed9f:	00 00 
  10eda1:	0f 85 ae 03 00 00    	jne    10f155 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2425>
  10eda7:	48 81 c4 58 02 00 00 	add    $0x258,%rsp
  10edae:	5b                   	pop    %rbx
  10edaf:	5d                   	pop    %rbp
  10edb0:	41 5c                	pop    %r12
  10edb2:	41 5d                	pop    %r13
  10edb4:	41 5e                	pop    %r14
  10edb6:	41 5f                	pop    %r15
  10edb8:	c3                   	ret    
  10edb9:	48 8d 94 24 f0 01 00 	lea    0x1f0(%rsp),%rdx
  10edc0:	00 
  10edc1:	48 8d bc 24 d0 00 00 	lea    0xd0(%rsp),%rdi
  10edc8:	00 
  10edc9:	e8 12 05 f6 ff       	call   6f2e0 <void std::vector<float, std::allocator<float> >::_M_realloc_insert<float const&>(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, float const&)@plt>
  10edce:	e9 dd e2 ff ff       	jmp    10d0b0 <synreal::SolverNewton::initialize(synreal::Model const&)+0x380>
  10edd3:	48 8d bc 24 b0 00 00 	lea    0xb0(%rsp),%rdi
  10edda:	00 
  10eddb:	e8 30 c8 f5 ff       	call   6b610 <void std::vector<glm::vec<3, int, (glm::qualifier)0>, std::allocator<glm::vec<3, int, (glm::qualifier)0> > >::_M_realloc_insert<glm::vec<3, int, (glm::qualifier)0> const&>(__gnu_cxx::__normal_iterator<glm::vec<3, int, (glm::qualifier)0>*, std::vector<glm::vec<3, int, (glm::qualifier)0>, std::allocator<glm::vec<3, int, (glm::qualifier)0> > > >, glm::vec<3, int, (glm::qualifier)0> const&)@plt>
  10ede0:	e9 a0 e3 ff ff       	jmp    10d185 <synreal::SolverNewton::initialize(synreal::Model const&)+0x455>
  10ede5:	4c 8b 7c 24 48       	mov    0x48(%rsp),%r15
  10edea:	4c 8b 74 24 50       	mov    0x50(%rsp),%r14
  10edef:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
  10edf4:	48 8b b4 24 40 02 00 	mov    0x240(%rsp),%rsi
  10edfb:	00 
  10edfc:	4c 89 cf             	mov    %r9,%rdi
  10edff:	4c 29 ce             	sub    %r9,%rsi
  10ee02:	e8 a9 e3 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ee07:	48 8b bc 24 10 02 00 	mov    0x210(%rsp),%rdi
  10ee0e:	00 
  10ee0f:	48 85 ff             	test   %rdi,%rdi
  10ee12:	74 10                	je     10ee24 <synreal::SolverNewton::initialize(synreal::Model const&)+0x20f4>
  10ee14:	48 8b b4 24 20 02 00 	mov    0x220(%rsp),%rsi
  10ee1b:	00 
  10ee1c:	48 29 fe             	sub    %rdi,%rsi
  10ee1f:	e8 8c e3 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ee24:	48 8b bc 24 f0 01 00 	mov    0x1f0(%rsp),%rdi
  10ee2b:	00 
  10ee2c:	48 85 ff             	test   %rdi,%rdi
  10ee2f:	74 10                	je     10ee41 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2111>
  10ee31:	48 8b b4 24 00 02 00 	mov    0x200(%rsp),%rsi
  10ee38:	00 
  10ee39:	48 29 fe             	sub    %rdi,%rsi
  10ee3c:	e8 6f e3 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ee41:	48 8b bc 24 d0 01 00 	mov    0x1d0(%rsp),%rdi
  10ee48:	00 
  10ee49:	48 85 ff             	test   %rdi,%rdi
  10ee4c:	74 10                	je     10ee5e <synreal::SolverNewton::initialize(synreal::Model const&)+0x212e>
  10ee4e:	48 8b b4 24 e0 01 00 	mov    0x1e0(%rsp),%rsi
  10ee55:	00 
  10ee56:	48 29 fe             	sub    %rdi,%rsi
  10ee59:	e8 52 e3 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ee5e:	48 8b bc 24 b0 01 00 	mov    0x1b0(%rsp),%rdi
  10ee65:	00 
  10ee66:	48 85 ff             	test   %rdi,%rdi
  10ee69:	74 10                	je     10ee7b <synreal::SolverNewton::initialize(synreal::Model const&)+0x214b>
  10ee6b:	48 8b b4 24 c0 01 00 	mov    0x1c0(%rsp),%rsi
  10ee72:	00 
  10ee73:	48 29 fe             	sub    %rdi,%rsi
  10ee76:	e8 35 e3 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ee7b:	48 8b bc 24 90 01 00 	mov    0x190(%rsp),%rdi
  10ee82:	00 
  10ee83:	48 85 ff             	test   %rdi,%rdi
  10ee86:	74 10                	je     10ee98 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2168>
  10ee88:	48 8b b4 24 a0 01 00 	mov    0x1a0(%rsp),%rsi
  10ee8f:	00 
  10ee90:	48 29 fe             	sub    %rdi,%rsi
  10ee93:	e8 18 e3 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ee98:	48 8b bc 24 70 01 00 	mov    0x170(%rsp),%rdi
  10ee9f:	00 
  10eea0:	48 85 ff             	test   %rdi,%rdi
  10eea3:	74 10                	je     10eeb5 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2185>
  10eea5:	48 8b b4 24 80 01 00 	mov    0x180(%rsp),%rsi
  10eeac:	00 
  10eead:	48 29 fe             	sub    %rdi,%rsi
  10eeb0:	e8 fb e2 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10eeb5:	48 8b bc 24 50 01 00 	mov    0x150(%rsp),%rdi
  10eebc:	00 
  10eebd:	48 85 ff             	test   %rdi,%rdi
  10eec0:	74 10                	je     10eed2 <synreal::SolverNewton::initialize(synreal::Model const&)+0x21a2>
  10eec2:	48 8b b4 24 60 01 00 	mov    0x160(%rsp),%rsi
  10eec9:	00 
  10eeca:	48 29 fe             	sub    %rdi,%rsi
  10eecd:	e8 de e2 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10eed2:	48 8b bc 24 30 01 00 	mov    0x130(%rsp),%rdi
  10eed9:	00 
  10eeda:	48 85 ff             	test   %rdi,%rdi
  10eedd:	74 10                	je     10eeef <synreal::SolverNewton::initialize(synreal::Model const&)+0x21bf>
  10eedf:	48 8b b4 24 40 01 00 	mov    0x140(%rsp),%rsi
  10eee6:	00 
  10eee7:	48 29 fe             	sub    %rdi,%rsi
  10eeea:	e8 c1 e2 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10eeef:	48 8b bc 24 10 01 00 	mov    0x110(%rsp),%rdi
  10eef6:	00 
  10eef7:	48 85 ff             	test   %rdi,%rdi
  10eefa:	74 10                	je     10ef0c <synreal::SolverNewton::initialize(synreal::Model const&)+0x21dc>
  10eefc:	48 8b b4 24 20 01 00 	mov    0x120(%rsp),%rsi
  10ef03:	00 
  10ef04:	48 29 fe             	sub    %rdi,%rsi
  10ef07:	e8 a4 e2 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ef0c:	48 8b bc 24 f0 00 00 	mov    0xf0(%rsp),%rdi
  10ef13:	00 
  10ef14:	48 85 ff             	test   %rdi,%rdi
  10ef17:	74 10                	je     10ef29 <synreal::SolverNewton::initialize(synreal::Model const&)+0x21f9>
  10ef19:	48 8b b4 24 00 01 00 	mov    0x100(%rsp),%rsi
  10ef20:	00 
  10ef21:	48 29 fe             	sub    %rdi,%rsi
  10ef24:	e8 87 e2 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10ef29:	8b b3 80 06 00 00    	mov    0x680(%rbx),%esi
  10ef2f:	85 f6                	test   %esi,%esi
  10ef31:	0f 84 d1 e8 ff ff    	je     10d808 <synreal::SolverNewton::initialize(synreal::Model const&)+0xad8>
  10ef37:	4c 3b b3 90 00 00 00 	cmp    0x90(%rbx),%r14
  10ef3e:	0f 87 0b a8 f6 ff    	ja     7974f <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x957>
  10ef44:	4d 85 f6             	test   %r14,%r14
  10ef47:	0f 84 d3 e8 ff ff    	je     10d820 <synreal::SolverNewton::initialize(synreal::Model const&)+0xaf0>
  10ef4d:	48 8b b3 88 00 00 00 	mov    0x88(%rbx),%rsi
  10ef54:	48 8b 93 90 00 00 00 	mov    0x90(%rbx),%rdx
  10ef5b:	4c 89 f1             	mov    %r14,%rcx
  10ef5e:	48 8d bc 24 30 02 00 	lea    0x230(%rsp),%rdi
  10ef65:	00 
  10ef66:	4c 8d 05 4d bc 0d 00 	lea    0xdbc4d(%rip),%r8        # 1eabba <_fini+0x5476>
  10ef6d:	e8 4e ed f5 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10ef72:	48 8b bc 24 30 02 00 	mov    0x230(%rsp),%rdi
  10ef79:	00 
  10ef7a:	48 8b 94 24 38 02 00 	mov    0x238(%rsp),%rdx
  10ef81:	00 
  10ef82:	48 39 fa             	cmp    %rdi,%rdx
  10ef85:	74 2e                	je     10efb5 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2285>
  10ef87:	48 89 f8             	mov    %rdi,%rax
  10ef8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  10ef90:	f3 0f 10 00          	movss  (%rax),%xmm0
  10ef94:	0f 2e c0             	ucomiss %xmm0,%xmm0
  10ef97:	0f 8a e4 a7 f6 ff    	jp     79781 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x989>
  10ef9d:	f3 0f 10 54 24 08    	movss  0x8(%rsp),%xmm2
  10efa3:	0f 2f d0             	comiss %xmm0,%xmm2
  10efa6:	0f 87 d5 a7 f6 ff    	ja     79781 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x989>
  10efac:	48 83 c0 04          	add    $0x4,%rax
  10efb0:	48 39 c2             	cmp    %rax,%rdx
  10efb3:	75 db                	jne    10ef90 <synreal::SolverNewton::initialize(synreal::Model const&)+0x2260>
  10efb5:	48 85 ff             	test   %rdi,%rdi
  10efb8:	0f 84 62 e8 ff ff    	je     10d820 <synreal::SolverNewton::initialize(synreal::Model const&)+0xaf0>
  10efbe:	48 8b b4 24 40 02 00 	mov    0x240(%rsp),%rsi
  10efc5:	00 
  10efc6:	48 29 fe             	sub    %rdi,%rsi
  10efc9:	e8 e2 e1 f5 ff       	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  10efce:	e9 4d e8 ff ff       	jmp    10d820 <synreal::SolverNewton::initialize(synreal::Model const&)+0xaf0>
  10efd3:	48 39 c2             	cmp    %rax,%rdx
  10efd6:	0f 82 69 a4 f6 ff    	jb     79445 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x64d>
  10efdc:	48 8b bc 24 30 02 00 	mov    0x230(%rsp),%rdi
  10efe3:	00 
  10efe4:	48 85 ff             	test   %rdi,%rdi
  10efe7:	0f 85 4e f9 ff ff    	jne    10e93b <synreal::SolverNewton::initialize(synreal::Model const&)+0x1c0b>
  10efed:	e9 59 f9 ff ff       	jmp    10e94b <synreal::SolverNewton::initialize(synreal::Model const&)+0x1c1b>
  10eff2:	48 85 d2             	test   %rdx,%rdx
  10eff5:	0f 84 23 f9 ff ff    	je     10e91e <synreal::SolverNewton::initialize(synreal::Model const&)+0x1bee>
  10effb:	e9 45 a4 f6 ff       	jmp    79445 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x64d>
  10f000:	4c 39 d2             	cmp    %r10,%rdx
  10f003:	0f 82 3c a4 f6 ff    	jb     79445 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x64d>
  10f009:	48 8b 93 e0 03 00 00 	mov    0x3e0(%rbx),%rdx
  10f010:	48 39 c2             	cmp    %rax,%rdx
  10f013:	0f 83 05 f9 ff ff    	jae    10e91e <synreal::SolverNewton::initialize(synreal::Model const&)+0x1bee>
  10f019:	eb d7                	jmp    10eff2 <synreal::SolverNewton::initialize(synreal::Model const&)+0x22c2>
  10f01b:	48 83 bb 78 06 00 00 	cmpq   $0x0,0x678(%rbx)
  10f022:	00 
  10f023:	0f 85 ef e4 ff ff    	jne    10d518 <synreal::SolverNewton::initialize(synreal::Model const&)+0x7e8>
  10f029:	66 0f ef ff          	pxor   %xmm7,%xmm7
  10f02d:	f3 0f 11 7c 24 08    	movss  %xmm7,0x8(%rsp)
  10f033:	e9 ce e6 ff ff       	jmp    10d706 <synreal::SolverNewton::initialize(synreal::Model const&)+0x9d6>
  10f038:	4d 85 c9             	test   %r9,%r9
  10f03b:	0f 84 c6 fd ff ff    	je     10ee07 <synreal::SolverNewton::initialize(synreal::Model const&)+0x20d7>
  10f041:	e9 ae fd ff ff       	jmp    10edf4 <synreal::SolverNewton::initialize(synreal::Model const&)+0x20c4>
  10f046:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10f04d:	00 00 00 
  10f050:	48 8b b3 18 07 00 00 	mov    0x718(%rbx),%rsi
  10f057:	48 8b 93 20 07 00 00 	mov    0x720(%rbx),%rdx
  10f05e:	89 c1                	mov    %eax,%ecx
  10f060:	48 8d bc 24 f0 01 00 	lea    0x1f0(%rsp),%rdi
  10f067:	00 
  10f068:	4c 8d 05 ce c3 0d 00 	lea    0xdc3ce(%rip),%r8        # 1eb43d <_fini+0x5cf9>
  10f06f:	e8 4c ec f5 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10f074:	e9 79 fa ff ff       	jmp    10eaf2 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1dc2>
  10f079:	48 8b b3 08 07 00 00 	mov    0x708(%rbx),%rsi
  10f080:	48 8b 93 10 07 00 00 	mov    0x710(%rbx),%rdx
  10f087:	89 c1                	mov    %eax,%ecx
  10f089:	48 8d bc 24 d0 01 00 	lea    0x1d0(%rsp),%rdi
  10f090:	00 
  10f091:	4c 8d 05 8d c3 0d 00 	lea    0xdc38d(%rip),%r8        # 1eb425 <_fini+0x5ce1>
  10f098:	e8 23 ec f5 ff       	call   6dcc0 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  10f09d:	8b 83 80 06 00 00    	mov    0x680(%rbx),%eax
  10f0a3:	e9 24 fa ff ff       	jmp    10eacc <synreal::SolverNewton::initialize(synreal::Model const&)+0x1d9c>
  10f0a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  10f0af:	00 
  10f0b0:	48 c7 84 24 10 02 00 	movq   $0x0,0x210(%rsp)
  10f0b7:	00 00 00 00 00 
  10f0bc:	48 c7 84 24 20 02 00 	movq   $0x0,0x220(%rsp)
  10f0c3:	00 00 00 00 00 
  10f0c8:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
  10f0cf:	00 00 
  10f0d1:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
  10f0d8:	00 00 
  10f0da:	e9 c5 ee ff ff       	jmp    10dfa4 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1274>
  10f0df:	48 89 f2             	mov    %rsi,%rdx
  10f0e2:	48 89 e9             	mov    %rbp,%rcx
  10f0e5:	e9 99 ee ff ff       	jmp    10df83 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1253>
  10f0ea:	4d 85 f6             	test   %r14,%r14
  10f0ed:	0f 84 3b f8 ff ff    	je     10e92e <synreal::SolverNewton::initialize(synreal::Model const&)+0x1bfe>
  10f0f3:	31 c0                	xor    %eax,%eax
  10f0f5:	e9 24 f8 ff ff       	jmp    10e91e <synreal::SolverNewton::initialize(synreal::Model const&)+0x1bee>
  10f0fa:	48 ba ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rdx
  10f101:	ff ff 1f 
  10f104:	48 39 d0             	cmp    %rdx,%rax
  10f107:	48 0f 47 c2          	cmova  %rdx,%rax
  10f10b:	48 c1 e0 02          	shl    $0x2,%rax
  10f10f:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  10f114:	48 89 c7             	mov    %rax,%rdi
  10f117:	e8 34 e0 f5 ff       	call   6d150 <operator new(unsigned long)@plt>
  10f11c:	48 89 c1             	mov    %rax,%rcx
  10f11f:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
  10f124:	48 8d 34 01          	lea    (%rcx,%rax,1),%rsi
  10f128:	48 89 74 24 48       	mov    %rsi,0x48(%rsp)
  10f12d:	e9 97 f1 ff ff       	jmp    10e2c9 <synreal::SolverNewton::initialize(synreal::Model const&)+0x1599>
  10f132:	66 0f ef ff          	pxor   %xmm7,%xmm7
  10f136:	f3 0f 11 7c 24 08    	movss  %xmm7,0x8(%rsp)
  10f13c:	e9 5e e5 ff ff       	jmp    10d69f <synreal::SolverNewton::initialize(synreal::Model const&)+0x96f>
  10f141:	48 b8 fc ff ff ff ff 	movabs $0x7ffffffffffffffc,%rax
  10f148:	ff ff 7f 
  10f14b:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  10f150:	48 89 c7             	mov    %rax,%rdi
  10f153:	eb c2                	jmp    10f117 <synreal::SolverNewton::initialize(synreal::Model const&)+0x23e7>
  10f155:	e8 66 e4 f5 ff       	call   6d5c0 <__stack_chk_fail@plt>
  10f15a:	48 8d 3d cf da 0d 00 	lea    0xddacf(%rip),%rdi        # 1ecc30 <_fini+0x74ec>
  10f161:	e8 0a cf f5 ff       	call   6c070 <std::__throw_length_error(char const*)@plt>
  10f166:	48 8d 3d 9f 84 0e 00 	lea    0xe849f(%rip),%rdi        # 1f760c <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x770c>
  10f16d:	e8 fe ce f5 ff       	call   6c070 <std::__throw_length_error(char const*)@plt>
  10f172:	f3 0f 1e fa          	endbr64 
  10f176:	48 89 c3             	mov    %rax,%rbx
  10f179:	e9 13 9d f6 ff       	jmp    78e91 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x99>
  10f17e:	e9 a4 9d f6 ff       	jmp    78f27 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x12f>
  10f183:	f3 0f 1e fa          	endbr64 
  10f187:	48 89 c3             	mov    %rax,%rbx
  10f18a:	e9 3c 9e f6 ff       	jmp    78fcb <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x1d3>
  10f18f:	f3 0f 1e fa          	endbr64 
  10f193:	48 89 c3             	mov    %rax,%rbx
  10f196:	e9 13 9e f6 ff       	jmp    78fae <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x1b6>
  10f19b:	f3 0f 1e fa          	endbr64 
  10f19f:	48 89 c3             	mov    %rax,%rbx
  10f1a2:	e9 fa 9d f6 ff       	jmp    78fa1 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x1a9>
  10f1a7:	f3 0f 1e fa          	endbr64 
  10f1ab:	48 89 c3             	mov    %rax,%rbx
  10f1ae:	e9 d1 9c f6 ff       	jmp    78e84 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x8c>
  10f1b3:	f3 0f 1e fa          	endbr64 
  10f1b7:	48 89 c3             	mov    %rax,%rbx
  10f1ba:	e9 29 9e f6 ff       	jmp    78fe8 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x1f0>
  10f1bf:	f3 0f 1e fa          	endbr64 
  10f1c3:	48 89 c3             	mov    %rax,%rbx
  10f1c6:	e9 b9 9d f6 ff       	jmp    78f84 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x18c>
  10f1cb:	e9 50 9f f6 ff       	jmp    79120 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x328>
  10f1d0:	f3 0f 1e fa          	endbr64 
  10f1d4:	e9 55 9c f6 ff       	jmp    78e2e <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x36>
  10f1d9:	f3 0f 1e fa          	endbr64 
  10f1dd:	48 89 c3             	mov    %rax,%rbx
  10f1e0:	e9 36 a2 f6 ff       	jmp    7941b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x623>
  10f1e5:	f3 0f 1e fa          	endbr64 
  10f1e9:	48 89 c5             	mov    %rax,%rbp
  10f1ec:	e9 ef 9f f6 ff       	jmp    791e0 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x3e8>
  10f1f1:	f3 0f 1e fa          	endbr64 
  10f1f5:	48 89 c5             	mov    %rax,%rbp
  10f1f8:	e9 c6 9f f6 ff       	jmp    791c3 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x3cb>
  10f1fd:	f3 0f 1e fa          	endbr64 
  10f201:	48 89 c5             	mov    %rax,%rbp
  10f204:	e9 85 a0 f6 ff       	jmp    7928e <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x496>
  10f209:	f3 0f 1e fa          	endbr64 
  10f20d:	48 89 c5             	mov    %rax,%rbp
  10f210:	e9 5c a0 f6 ff       	jmp    79271 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x479>
  10f215:	f3 0f 1e fa          	endbr64 
  10f219:	48 89 c5             	mov    %rax,%rbp
  10f21c:	e9 33 a0 f6 ff       	jmp    79254 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x45c>
  10f221:	f3 0f 1e fa          	endbr64 
  10f225:	48 89 c5             	mov    %rax,%rbp
  10f228:	e9 0a a0 f6 ff       	jmp    79237 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x43f>
  10f22d:	e9 cb a3 f6 ff       	jmp    795fd <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x805>
  10f232:	e9 53 a3 f6 ff       	jmp    7958a <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x792>
  10f237:	e9 40 a4 f6 ff       	jmp    7967c <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x884>
  10f23c:	f3 0f 1e fa          	endbr64 
  10f240:	48 89 c5             	mov    %rax,%rbp
  10f243:	e9 5e 9f f6 ff       	jmp    791a6 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x3ae>
  10f248:	f3 0f 1e fa          	endbr64 
  10f24c:	48 89 c5             	mov    %rax,%rbp
  10f24f:	e9 35 9f f6 ff       	jmp    79189 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x391>
  10f254:	f3 0f 1e fa          	endbr64 
  10f258:	48 89 c5             	mov    %rax,%rbp
  10f25b:	e9 c6 a2 f6 ff       	jmp    79526 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x72e>
  10f260:	f3 0f 1e fa          	endbr64 
  10f264:	48 89 c5             	mov    %rax,%rbp
  10f267:	e9 9d a2 f6 ff       	jmp    79509 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x711>
  10f26c:	e9 42 a5 f6 ff       	jmp    797b3 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x9bb>
  10f271:	f3 0f 1e fa          	endbr64 
  10f275:	48 89 c3             	mov    %rax,%rbx
  10f278:	e9 dc 9c f6 ff       	jmp    78f59 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x161>
  10f27d:	e9 19 a1 f6 ff       	jmp    7939b <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x5a3>
  10f282:	f3 0f 1e fa          	endbr64 
  10f286:	e9 0b a1 f6 ff       	jmp    79396 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x59e>
  10f28b:	e9 1d a8 f6 ff       	jmp    79aad <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xcb5>
  10f290:	e9 5c a8 f6 ff       	jmp    79af1 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xcf9>
  10f295:	e9 c4 a8 f6 ff       	jmp    79b5e <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xd66>
  10f29a:	f3 0f 1e fa          	endbr64 
  10f29e:	48 89 c5             	mov    %rax,%rbp
  10f2a1:	e9 74 9f f6 ff       	jmp    7921a <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x422>
  10f2a6:	f3 0f 1e fa          	endbr64 
  10f2aa:	48 89 c5             	mov    %rax,%rbp
  10f2ad:	e9 4b 9f f6 ff       	jmp    791fd <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x405>
  10f2b2:	f3 0f 1e fa          	endbr64 
  10f2b6:	48 89 c5             	mov    %rax,%rbp
  10f2b9:	e9 36 aa f6 ff       	jmp    79cf4 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xefc>
  10f2be:	f3 0f 1e fa          	endbr64 
  10f2c2:	48 89 c5             	mov    %rax,%rbp
  10f2c5:	e9 0d aa f6 ff       	jmp    79cd7 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xedf>
  10f2ca:	f3 0f 1e fa          	endbr64 
  10f2ce:	48 89 c5             	mov    %rax,%rbp
  10f2d1:	e9 e4 a9 f6 ff       	jmp    79cba <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xec2>
  10f2d6:	e9 14 ab f6 ff       	jmp    79def <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xff7>
  10f2db:	e9 cb aa f6 ff       	jmp    79dab <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xfb3>
  10f2e0:	e9 30 aa f6 ff       	jmp    79d15 <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0xf1d>
  10f2e5:	e9 55 ab f6 ff       	jmp    79e3f <synreal::SolverNewton::initialize(synreal::Model const&) [clone .cold]+0x1047>
  10f2ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
