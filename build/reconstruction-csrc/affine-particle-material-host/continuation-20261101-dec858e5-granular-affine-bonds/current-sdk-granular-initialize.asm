
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

0000000000127fa0 <synreal::Granular::initialize(synreal::Model const&)>:
  127fa0:	endbr64 
  127fa4:	push   %r15
  127fa6:	mov    $0xe9,%ecx
  127fab:	push   %r14
  127fad:	mov    %rsi,%r14
  127fb0:	push   %r13
  127fb2:	push   %r12
  127fb4:	push   %rbp
  127fb5:	push   %rbx
  127fb6:	sub    $0x228,%rsp
  127fbd:	mov    %fs:0x28,%rax
  127fc6:	mov    %rax,0x218(%rsp)
  127fce:	xor    %eax,%eax
  127fd0:	mov    %rdi,%rax
  127fd3:	mov    %rdi,0x8(%rsp)
  127fd8:	rep movsq %ds:(%rsi),%es:(%rdi)
  127fdb:	movq   $0x0,0x754(%rax)
  127fe6:	mov    0x110(%rax),%esi
  127fec:	test   %esi,%esi
  127fee:	je     129658 <synreal::Granular::initialize(synreal::Model const&)+0x16b8>
  127ff4:	movss  0x128(%r14),%xmm0
  127ffd:	movss  0xc7787(%rip),%xmm7        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  128005:	movaps %xmm0,%xmm1
  128008:	andps  0xc7791(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  12800f:	ucomiss %xmm1,%xmm7
  128012:	jb     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  128018:	pxor   %xmm7,%xmm7
  12801c:	comiss %xmm0,%xmm7
  12801f:	jae    7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  128025:	movss  0x12c(%r14),%xmm0
  12802e:	movss  0xc7756(%rip),%xmm2        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  128036:	movaps %xmm0,%xmm1
  128039:	andps  0xc7760(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  128040:	ucomiss %xmm1,%xmm2
  128043:	jb     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  128049:	comiss %xmm0,%xmm7
  12804c:	ja     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  128052:	movss  0x130(%r14),%xmm0
  12805b:	movaps %xmm0,%xmm1
  12805e:	andps  0xc773b(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  128065:	ucomiss %xmm1,%xmm2
  128068:	jb     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  12806e:	comiss %xmm0,%xmm7
  128071:	ja     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  128077:	movss  0x134(%r14),%xmm0
  128080:	movaps %xmm0,%xmm1
  128083:	andps  0xc7716(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  12808a:	ucomiss %xmm1,%xmm2
  12808d:	jb     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  128093:	comiss %xmm0,%xmm7
  128096:	ja     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  12809c:	movss  0x138(%r14),%xmm0
  1280a5:	movaps %xmm0,%xmm1
  1280a8:	andps  0xc76f1(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1280af:	ucomiss %xmm1,%xmm2
  1280b2:	jb     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  1280b8:	comiss %xmm0,%xmm7
  1280bb:	ja     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  1280c1:	movss  0x148(%r14),%xmm0
  1280ca:	movaps %xmm0,%xmm1
  1280cd:	andps  0xc76cc(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1280d4:	ucomiss %xmm1,%xmm2
  1280d7:	jb     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  1280dd:	comiss %xmm0,%xmm7
  1280e0:	movaps %xmm7,%xmm6
  1280e3:	ja     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  1280e9:	movss  0x14c(%r14),%xmm0
  1280f2:	movaps %xmm2,%xmm7
  1280f5:	movaps %xmm0,%xmm1
  1280f8:	andps  0xc76a1(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1280ff:	ucomiss %xmm1,%xmm2
  128102:	jb     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  128108:	comiss %xmm0,%xmm6
  12810b:	movaps %xmm6,%xmm2
  12810e:	ja     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  128114:	movss  0x150(%r14),%xmm0
  12811d:	movaps %xmm7,%xmm6
  128120:	movaps %xmm0,%xmm1
  128123:	andps  0xc7676(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  12812a:	ucomiss %xmm1,%xmm7
  12812d:	jb     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  128133:	comiss %xmm0,%xmm2
  128136:	movaps %xmm2,%xmm7
  128139:	ja     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  12813f:	mov    0x154(%r14),%eax
  128146:	sub    $0x1,%eax
  128149:	cmp    $0x3f,%eax
  12814c:	ja     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  128152:	movss  0x13c(%r14),%xmm0
  12815b:	movaps %xmm0,%xmm1
  12815e:	andps  0xc763b(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  128165:	ucomiss %xmm1,%xmm6
  128168:	jb     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  12816e:	comiss %xmm0,%xmm7
  128171:	movaps %xmm7,%xmm6
  128174:	ja     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  12817a:	movss  0xcfdfe(%rip),%xmm1        # 1f7f80 <cuda::std::__4::in_place+0x33>
  128182:	comiss %xmm1,%xmm0
  128185:	jae    7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  12818b:	movss  0x140(%r14),%xmm0
  128194:	movss  0xc75f0(%rip),%xmm7        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  12819c:	movaps %xmm0,%xmm2
  12819f:	andps  0xc75fa(%rip),%xmm2        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1281a6:	ucomiss %xmm2,%xmm7
  1281a9:	jb     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  1281af:	comiss %xmm0,%xmm6
  1281b2:	ja     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  1281b8:	comiss %xmm1,%xmm0
  1281bb:	jae    7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  1281c1:	movss  0x144(%r14),%xmm0
  1281ca:	movaps %xmm0,%xmm1
  1281cd:	andps  0xc75cc(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1281d4:	ucomiss %xmm1,%xmm7
  1281d7:	jb     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  1281dd:	comiss %xmm0,%xmm6
  1281e0:	ja     7b86f <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2ff>
  1281e6:	mov    0x18(%r14),%ecx
  1281ea:	test   %ecx,%ecx
  1281ec:	je     12a080 <synreal::Granular::initialize(synreal::Model const&)+0x20e0>
  1281f2:	mov    0x1c(%r14),%eax
  1281f6:	test   %eax,%eax
  1281f8:	je     12820e <synreal::Granular::initialize(synreal::Model const&)+0x26e>
  1281fa:	cmp    %eax,%ecx
  1281fc:	ja     7bb25 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x5b5>
  128202:	xor    %edx,%edx
  128204:	div    %ecx
  128206:	test   %edx,%edx
  128208:	jne    7bb25 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x5b5>
  12820e:	mov    0x110(%r14),%ecx
  128215:	mov    0x118(%r14),%rsi
  12821c:	lea    0x90(%rsp),%rdi
  128224:	mov    0x120(%r14),%rdx
  12822b:	call   6c310 <std::vector<int, std::allocator<int> > synreal::(anonymous namespace)::read<int>(synreal::Span<int const>, unsigned long)@plt>
  128230:	mov    0x18(%r14),%ecx
  128234:	mov    0x30(%r14),%rsi
  128238:	lea    0xb0(%rsp),%rdi
  128240:	mov    0x38(%r14),%rdx
  128244:	call   6cec0 <std::vector<float, std::allocator<float> > synreal::(anonymous namespace)::read<float>(synreal::Span<float const>, unsigned long)@plt>
  128249:	mov    0x18(%r14),%ecx
  12824d:	mov    0x88(%r14),%rsi
  128254:	lea    0xd0(%rsp),%rdi
  12825c:	mov    0x90(%r14),%rdx
  128263:	call   6cec0 <std::vector<float, std::allocator<float> > synreal::(anonymous namespace)::read<float>(synreal::Span<float const>, unsigned long)@plt>
  128268:	mov    0x70(%r14),%rcx
  12826c:	test   %rcx,%rcx
  12826f:	jne    12936a <synreal::Granular::initialize(synreal::Model const&)+0x13ca>
  128275:	mov    0x68(%r14),%rsi
  128279:	mov    0x70(%r14),%rdx
  12827d:	lea    0xf0(%rsp),%rdi
  128285:	call   6c310 <std::vector<int, std::allocator<int> > synreal::(anonymous namespace)::read<int>(synreal::Span<int const>, unsigned long)@plt>
  12828a:	mov    0x80(%r14),%rcx
  128291:	test   %rcx,%rcx
  128294:	jne    129361 <synreal::Granular::initialize(synreal::Model const&)+0x13c1>
  12829a:	mov    0x78(%r14),%rsi
  12829e:	mov    0x80(%r14),%rdx
  1282a5:	lea    0x110(%rsp),%rdi
  1282ad:	call   6c310 <std::vector<int, std::allocator<int> > synreal::(anonymous namespace)::read<int>(synreal::Span<int const>, unsigned long)@plt>
  1282b2:	mov    0x90(%rsp),%r12
  1282ba:	mov    0x98(%rsp),%r15
  1282c2:	lea    0x198(%rsp),%rbx
  1282ca:	movl   $0x0,0x198(%rsp)
  1282d5:	movq   $0x0,0x1a0(%rsp)
  1282e1:	mov    %rbx,0x1a8(%rsp)
  1282e9:	mov    %rbx,0x1b0(%rsp)
  1282f1:	movq   $0x0,0x1b8(%rsp)
  1282fd:	movl   $0x0,(%rsp)
  128304:	cmp    %r15,%r12
  128307:	je     129e76 <synreal::Granular::initialize(synreal::Model const&)+0x1ed6>
  12830d:	lea    0x1c0(%rsp),%r13
  128315:	nopl   (%rax)
  128318:	mov    (%r12),%eax
  12831c:	mov    %eax,0x1c0(%rsp)
  128323:	test   %eax,%eax
  128325:	js     7b7ff <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x28f>
  12832b:	cmp    %eax,0x18(%r14)
  12832f:	jbe    7b7ff <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x28f>
  128335:	lea    0x190(%rsp),%rdi
  12833d:	mov    %r13,%rsi
  128340:	mov    %r13,%rbp
  128343:	call   6d350 <std::pair<std::_Rb_tree_iterator<int>, bool> std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_insert_unique<int const&>(int const&)@plt>
  128348:	test   %dl,%dl
  12834a:	je     7b7ff <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x28f>
  128350:	movslq 0x1c0(%rsp),%rax
  128358:	mov    0xb0(%rsp),%rdx
  128360:	movss  0xc7424(%rip),%xmm4        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  128368:	movss  (%rdx,%rax,4),%xmm0
  12836d:	movaps %xmm0,%xmm1
  128370:	andps  0xc7429(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  128377:	ucomiss %xmm1,%xmm4
  12837a:	jb     12a051 <synreal::Granular::initialize(synreal::Model const&)+0x20b1>
  128380:	pxor   %xmm5,%xmm5
  128384:	comiss %xmm0,%xmm5
  128387:	jae    7b831 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2c1>
  12838d:	mov    0xd0(%rsp),%rdx
  128395:	movss  (%rdx,%rax,4),%xmm0
  12839a:	movaps %xmm0,%xmm1
  12839d:	andps  0xc73fc(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  1283a4:	ucomiss %xmm1,%xmm4
  1283a7:	jb     7b831 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2c1>
  1283ad:	comiss %xmm0,%xmm5
  1283b0:	jae    7b831 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2c1>
  1283b6:	mov    0xf0(%rsp),%rdx
  1283be:	cmp    0xf8(%rsp),%rdx
  1283c6:	je     1283d2 <synreal::Granular::initialize(synreal::Model const&)+0x432>
  1283c8:	testb  $0x1,(%rdx,%rax,4)
  1283cc:	je     7b831 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2c1>
  1283d2:	maxss  (%rsp),%xmm0
  1283d7:	add    $0x4,%r12
  1283db:	movss  %xmm0,(%rsp)
  1283e0:	cmp    %r12,%r15
  1283e3:	jne    128318 <synreal::Granular::initialize(synreal::Model const&)+0x378>
  1283e9:	mov    0x1e8(%r14),%ecx
  1283f0:	mov    0x1f0(%r14),%rsi
  1283f7:	mov    %rbp,%rdi
  1283fa:	mov    0x1f8(%r14),%rdx
  128401:	call   6d440 <std::vector<glm::vec<3, int, (glm::qualifier)0>, std::allocator<glm::vec<3, int, (glm::qualifier)0> > > synreal::(anonymous namespace)::read<glm::vec<3, int, (glm::qualifier)0> >(synreal::Span<glm::vec<3, int, (glm::qualifier)0> const>, unsigned long)@plt>
  128406:	mov    0x1c0(%rsp),%r13
  12840e:	mov    0x1c8(%rsp),%r15
  128416:	cmp    %r15,%r13
  128419:	je     1284b6 <synreal::Granular::initialize(synreal::Model const&)+0x516>
  12841f:	mov    0x1a0(%rsp),%r10
  128427:	mov    %r13,%r9
  12842a:	nopw   0x0(%rax,%rax,1)
  128430:	xor    %edi,%edi
  128432:	lea    0x4(%r9),%r12
  128436:	lea    0x8(%r9),%r11
  12843a:	cmp    $0x1,%edi
  12843d:	je     128cc0 <synreal::Granular::initialize(synreal::Model const&)+0xd20>
  128443:	cmp    $0x2,%edi
  128446:	je     128cd8 <synreal::Granular::initialize(synreal::Model const&)+0xd38>
  12844c:	mov    %r9,%rax
  12844f:	test   %r10,%r10
  128452:	je     1284a1 <synreal::Granular::initialize(synreal::Model const&)+0x501>
  128454:	mov    (%rax),%esi
  128456:	mov    %rbx,%r8
  128459:	mov    %r10,%rax
  12845c:	nopl   0x0(%rax)
  128460:	mov    0x10(%rax),%rcx
  128464:	mov    0x18(%rax),%rdx
  128468:	cmp    0x20(%rax),%esi
  12846b:	jle    128482 <synreal::Granular::initialize(synreal::Model const&)+0x4e2>
  12846d:	test   %rdx,%rdx
  128470:	je     128490 <synreal::Granular::initialize(synreal::Model const&)+0x4f0>
  128472:	mov    %rdx,%rax
  128475:	mov    0x10(%rax),%rcx
  128479:	mov    0x18(%rax),%rdx
  12847d:	cmp    0x20(%rax),%esi
  128480:	jg     12846d <synreal::Granular::initialize(synreal::Model const&)+0x4cd>
  128482:	test   %rcx,%rcx
  128485:	je     128493 <synreal::Granular::initialize(synreal::Model const&)+0x4f3>
  128487:	mov    %rax,%r8
  12848a:	mov    %rcx,%rax
  12848d:	jmp    128460 <synreal::Granular::initialize(synreal::Model const&)+0x4c0>
  12848f:	nop
  128490:	mov    %r8,%rax
  128493:	cmp    %rbx,%rax
  128496:	je     1284a1 <synreal::Granular::initialize(synreal::Model const&)+0x501>
  128498:	cmp    0x20(%rax),%esi
  12849b:	jge    7bb60 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x5f0>
  1284a1:	add    $0x1,%edi
  1284a4:	cmp    $0x3,%edi
  1284a7:	jne    12843a <synreal::Granular::initialize(synreal::Model const&)+0x49a>
  1284a9:	add    $0xc,%r9
  1284ad:	cmp    %r9,%r15
  1284b0:	jne    128430 <synreal::Granular::initialize(synreal::Model const&)+0x490>
  1284b6:	test   %r13,%r13
  1284b9:	je     1284ce <synreal::Granular::initialize(synreal::Model const&)+0x52e>
  1284bb:	mov    0x1d0(%rsp),%rsi
  1284c3:	mov    %r13,%rdi
  1284c6:	sub    %r13,%rsi
  1284c9:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1284ce:	mov    0x288(%r14),%ecx
  1284d5:	mov    0x290(%r14),%rsi
  1284dc:	mov    %rbp,%rdi
  1284df:	mov    0x298(%r14),%rdx
  1284e6:	call   6bea0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > synreal::(anonymous namespace)::read<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long)@plt>
  1284eb:	mov    0x1c0(%rsp),%r10
  1284f3:	mov    0x1c8(%rsp),%r15
  1284fb:	mov    %r10,0x10(%rsp)
  128500:	cmp    %r15,%r10
  128503:	je     1285ba <synreal::Granular::initialize(synreal::Model const&)+0x61a>
  128509:	mov    0x1a0(%rsp),%r9
  128511:	nopl   0x0(%rax)
  128518:	xor    %edi,%edi
  12851a:	lea    0x8(%r10),%r13
  12851e:	lea    0xc(%r10),%r12
  128522:	lea    0x4(%r10),%r11
  128526:	cmp    $0x2,%edi
  128529:	je     128c90 <synreal::Granular::initialize(synreal::Model const&)+0xcf0>
  12852f:	cmp    $0x3,%edi
  128532:	je     128c98 <synreal::Granular::initialize(synreal::Model const&)+0xcf8>
  128538:	cmp    $0x1,%edi
  12853b:	je     128c78 <synreal::Granular::initialize(synreal::Model const&)+0xcd8>
  128541:	mov    %r10,%rax
  128544:	test   %r9,%r9
  128547:	je     1285a1 <synreal::Granular::initialize(synreal::Model const&)+0x601>
  128549:	mov    (%rax),%esi
  12854b:	mov    %rbx,%r8
  12854e:	mov    %r9,%rax
  128551:	nopl   0x0(%rax)
  128558:	mov    0x10(%rax),%rcx
  12855c:	mov    0x18(%rax),%rdx
  128560:	cmp    0x20(%rax),%esi
  128563:	jle    12857a <synreal::Granular::initialize(synreal::Model const&)+0x5da>
  128565:	test   %rdx,%rdx
  128568:	je     128590 <synreal::Granular::initialize(synreal::Model const&)+0x5f0>
  12856a:	mov    %rdx,%rax
  12856d:	mov    0x10(%rax),%rcx
  128571:	mov    0x18(%rax),%rdx
  128575:	cmp    0x20(%rax),%esi
  128578:	jg     128565 <synreal::Granular::initialize(synreal::Model const&)+0x5c5>
  12857a:	test   %rcx,%rcx
  12857d:	je     128593 <synreal::Granular::initialize(synreal::Model const&)+0x5f3>
  12857f:	mov    %rax,%r8
  128582:	mov    %rcx,%rax
  128585:	jmp    128558 <synreal::Granular::initialize(synreal::Model const&)+0x5b8>
  128587:	nopw   0x0(%rax,%rax,1)
  128590:	mov    %r8,%rax
  128593:	cmp    %rbx,%rax
  128596:	je     1285a1 <synreal::Granular::initialize(synreal::Model const&)+0x601>
  128598:	cmp    0x20(%rax),%esi
  12859b:	jge    7baaf <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x53f>
  1285a1:	add    $0x1,%edi
  1285a4:	cmp    $0x4,%edi
  1285a7:	jne    128526 <synreal::Granular::initialize(synreal::Model const&)+0x586>
  1285ad:	add    $0x10,%r10
  1285b1:	cmp    %r10,%r15
  1285b4:	jne    128518 <synreal::Granular::initialize(synreal::Model const&)+0x578>
  1285ba:	mov    0x10(%rsp),%rdi
  1285bf:	test   %rdi,%rdi
  1285c2:	je     1285d4 <synreal::Granular::initialize(synreal::Model const&)+0x634>
  1285c4:	mov    0x1d0(%rsp),%rsi
  1285cc:	sub    %rdi,%rsi
  1285cf:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1285d4:	mov    0x2d0(%r14),%ecx
  1285db:	mov    0x2d8(%r14),%rsi
  1285e2:	mov    %rbp,%rdi
  1285e5:	mov    0x2e0(%r14),%rdx
  1285ec:	call   6bea0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > synreal::(anonymous namespace)::read<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long)@plt>
  1285f1:	mov    0x1c0(%rsp),%r10
  1285f9:	mov    0x1c8(%rsp),%r15
  128601:	mov    %r10,0x10(%rsp)
  128606:	cmp    %r15,%r10
  128609:	je     1286ba <synreal::Granular::initialize(synreal::Model const&)+0x71a>
  12860f:	mov    0x1a0(%rsp),%r9
  128617:	nopw   0x0(%rax,%rax,1)
  128620:	xor    %edi,%edi
  128622:	lea    0x8(%r10),%r13
  128626:	lea    0xc(%r10),%r12
  12862a:	lea    0x4(%r10),%r11
  12862e:	cmp    $0x2,%edi
  128631:	je     128790 <synreal::Granular::initialize(synreal::Model const&)+0x7f0>
  128637:	cmp    $0x3,%edi
  12863a:	je     128798 <synreal::Granular::initialize(synreal::Model const&)+0x7f8>
  128640:	cmp    $0x1,%edi
  128643:	je     128770 <synreal::Granular::initialize(synreal::Model const&)+0x7d0>
  128649:	mov    %r10,%rax
  12864c:	test   %r9,%r9
  12864f:	je     1286a1 <synreal::Granular::initialize(synreal::Model const&)+0x701>
  128651:	mov    (%rax),%esi
  128653:	mov    %rbx,%r8
  128656:	mov    %r9,%rax
  128659:	nopl   0x0(%rax)
  128660:	mov    0x10(%rax),%rcx
  128664:	mov    0x18(%rax),%rdx
  128668:	cmp    0x20(%rax),%esi
  12866b:	jle    128682 <synreal::Granular::initialize(synreal::Model const&)+0x6e2>
  12866d:	test   %rdx,%rdx
  128670:	je     128690 <synreal::Granular::initialize(synreal::Model const&)+0x6f0>
  128672:	mov    %rdx,%rax
  128675:	mov    0x10(%rax),%rcx
  128679:	mov    0x18(%rax),%rdx
  12867d:	cmp    0x20(%rax),%esi
  128680:	jg     12866d <synreal::Granular::initialize(synreal::Model const&)+0x6cd>
  128682:	test   %rcx,%rcx
  128685:	je     128693 <synreal::Granular::initialize(synreal::Model const&)+0x6f3>
  128687:	mov    %rax,%r8
  12868a:	mov    %rcx,%rax
  12868d:	jmp    128660 <synreal::Granular::initialize(synreal::Model const&)+0x6c0>
  12868f:	nop
  128690:	mov    %r8,%rax
  128693:	cmp    %rbx,%rax
  128696:	je     1286a1 <synreal::Granular::initialize(synreal::Model const&)+0x701>
  128698:	cmp    0x20(%rax),%esi
  12869b:	jge    7ba7d <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x50d>
  1286a1:	add    $0x1,%edi
  1286a4:	cmp    $0x4,%edi
  1286a7:	jne    12862e <synreal::Granular::initialize(synreal::Model const&)+0x68e>
  1286ad:	add    $0x10,%r10
  1286b1:	cmp    %r10,%r15
  1286b4:	jne    128620 <synreal::Granular::initialize(synreal::Model const&)+0x680>
  1286ba:	mov    0x10(%rsp),%rdi
  1286bf:	test   %rdi,%rdi
  1286c2:	je     1286d4 <synreal::Granular::initialize(synreal::Model const&)+0x734>
  1286c4:	mov    0x1d0(%rsp),%rsi
  1286cc:	sub    %rdi,%rsi
  1286cf:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1286d4:	mov    0x1b0(%r14),%ecx
  1286db:	mov    0x1b8(%r14),%rsi
  1286e2:	mov    %rbp,%rdi
  1286e5:	mov    0x1c0(%r14),%rdx
  1286ec:	call   6cc60 <std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > synreal::(anonymous namespace)::read<glm::vec<2, int, (glm::qualifier)0> >(synreal::Span<glm::vec<2, int, (glm::qualifier)0> const>, unsigned long)@plt>
  1286f1:	mov    0x1c0(%rsp),%r9
  1286f9:	mov    0x1c8(%rsp),%r10
  128701:	cmp    %r10,%r9
  128704:	je     1287de <synreal::Granular::initialize(synreal::Model const&)+0x83e>
  12870a:	mov    0x1a0(%rsp),%r8
  128712:	mov    %r9,%rdi
  128715:	nopl   (%rax)
  128718:	test   %r8,%r8
  12871b:	je     1287d1 <synreal::Granular::initialize(synreal::Model const&)+0x831>
  128721:	mov    (%rdi),%esi
  128723:	mov    %r8,%rax
  128726:	mov    %rbx,%r11
  128729:	nopl   0x0(%rax)
  128730:	mov    0x10(%rax),%rcx
  128734:	mov    0x18(%rax),%rdx
  128738:	cmp    %esi,0x20(%rax)
  12873b:	jl     128759 <synreal::Granular::initialize(synreal::Model const&)+0x7b9>
  12873d:	test   %rcx,%rcx
  128740:	je     1292eb <synreal::Granular::initialize(synreal::Model const&)+0x134b>
  128746:	mov    %rax,%r11
  128749:	mov    %rcx,%rax
  12874c:	mov    0x10(%rax),%rcx
  128750:	mov    0x18(%rax),%rdx
  128754:	cmp    %esi,0x20(%rax)
  128757:	jge    12873d <synreal::Granular::initialize(synreal::Model const&)+0x79d>
  128759:	test   %rdx,%rdx
  12875c:	je     1292e8 <synreal::Granular::initialize(synreal::Model const&)+0x1348>
  128762:	mov    %rdx,%rax
  128765:	jmp    128730 <synreal::Granular::initialize(synreal::Model const&)+0x790>
  128767:	nopw   0x0(%rax,%rax,1)
  128770:	mov    %r11,%rax
  128773:	test   %r9,%r9
  128776:	jne    128651 <synreal::Granular::initialize(synreal::Model const&)+0x6b1>
  12877c:	add    $0x1,%edi
  12877f:	cmp    $0x2,%edi
  128782:	jne    128637 <synreal::Granular::initialize(synreal::Model const&)+0x697>
  128788:	nopl   0x0(%rax,%rax,1)
  128790:	mov    %r13,%rax
  128793:	jmp    128773 <synreal::Granular::initialize(synreal::Model const&)+0x7d3>
  128795:	nopl   (%rax)
  128798:	mov    %r12,%rax
  12879b:	test   %r9,%r9
  12879e:	jne    128651 <synreal::Granular::initialize(synreal::Model const&)+0x6b1>
  1287a4:	add    $0x10,%r10
  1287a8:	cmp    %r10,%r15
  1287ab:	jne    128620 <synreal::Granular::initialize(synreal::Model const&)+0x680>
  1287b1:	jmp    1286ba <synreal::Granular::initialize(synreal::Model const&)+0x71a>
  1287b6:	cs nopw 0x0(%rax,%rax,1)
  1287c0:	mov    %r11,%rax
  1287c3:	cmp    %rbx,%rax
  1287c6:	je     1287d1 <synreal::Granular::initialize(synreal::Model const&)+0x831>
  1287c8:	cmp    0x20(%rax),%esi
  1287cb:	jge    7baf3 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x583>
  1287d1:	add    $0x8,%rdi
  1287d5:	cmp    %rdi,%r10
  1287d8:	jne    128718 <synreal::Granular::initialize(synreal::Model const&)+0x778>
  1287de:	test   %r9,%r9
  1287e1:	je     1287f6 <synreal::Granular::initialize(synreal::Model const&)+0x856>
  1287e3:	mov    0x1d0(%rsp),%rsi
  1287eb:	mov    %r9,%rdi
  1287ee:	sub    %r9,%rsi
  1287f1:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1287f6:	mov    0x250(%r14),%ecx
  1287fd:	mov    0x258(%r14),%rsi
  128804:	mov    %rbp,%rdi
  128807:	mov    0x260(%r14),%rdx
  12880e:	call   6bea0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > synreal::(anonymous namespace)::read<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long)@plt>
  128813:	mov    0x1c0(%rsp),%r10
  12881b:	mov    0x1c8(%rsp),%r15
  128823:	mov    %r10,0x10(%rsp)
  128828:	cmp    %r15,%r10
  12882b:	je     1288da <synreal::Granular::initialize(synreal::Model const&)+0x93a>
  128831:	mov    0x1a0(%rsp),%r9
  128839:	nopl   0x0(%rax)
  128840:	xor    %edi,%edi
  128842:	lea    0x8(%r10),%r13
  128846:	lea    0xc(%r10),%r12
  12884a:	lea    0x4(%r10),%r11
  12884e:	cmp    $0x2,%edi
  128851:	je     128ab0 <synreal::Granular::initialize(synreal::Model const&)+0xb10>
  128857:	cmp    $0x3,%edi
  12885a:	je     128a90 <synreal::Granular::initialize(synreal::Model const&)+0xaf0>
  128860:	cmp    $0x1,%edi
  128863:	je     128b10 <synreal::Granular::initialize(synreal::Model const&)+0xb70>
  128869:	mov    %r10,%rax
  12886c:	test   %r9,%r9
  12886f:	je     1288c1 <synreal::Granular::initialize(synreal::Model const&)+0x921>
  128871:	mov    (%rax),%esi
  128873:	mov    %rbx,%r8
  128876:	mov    %r9,%rax
  128879:	nopl   0x0(%rax)
  128880:	mov    0x10(%rax),%rcx
  128884:	mov    0x18(%rax),%rdx
  128888:	cmp    0x20(%rax),%esi
  12888b:	jle    1288a2 <synreal::Granular::initialize(synreal::Model const&)+0x902>
  12888d:	test   %rdx,%rdx
  128890:	je     1288b0 <synreal::Granular::initialize(synreal::Model const&)+0x910>
  128892:	mov    %rdx,%rax
  128895:	mov    0x10(%rax),%rcx
  128899:	mov    0x18(%rax),%rdx
  12889d:	cmp    0x20(%rax),%esi
  1288a0:	jg     12888d <synreal::Granular::initialize(synreal::Model const&)+0x8ed>
  1288a2:	test   %rcx,%rcx
  1288a5:	je     1288b3 <synreal::Granular::initialize(synreal::Model const&)+0x913>
  1288a7:	mov    %rax,%r8
  1288aa:	mov    %rcx,%rax
  1288ad:	jmp    128880 <synreal::Granular::initialize(synreal::Model const&)+0x8e0>
  1288af:	nop
  1288b0:	mov    %r8,%rax
  1288b3:	cmp    %rbx,%rax
  1288b6:	je     1288c1 <synreal::Granular::initialize(synreal::Model const&)+0x921>
  1288b8:	cmp    0x20(%rax),%esi
  1288bb:	jge    7b97a <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x40a>
  1288c1:	add    $0x1,%edi
  1288c4:	cmp    $0x4,%edi
  1288c7:	jne    12884e <synreal::Granular::initialize(synreal::Model const&)+0x8ae>
  1288cd:	add    $0x10,%r10
  1288d1:	cmp    %r10,%r15
  1288d4:	jne    128840 <synreal::Granular::initialize(synreal::Model const&)+0x8a0>
  1288da:	mov    0x10(%rsp),%rdi
  1288df:	test   %rdi,%rdi
  1288e2:	je     1288f4 <synreal::Granular::initialize(synreal::Model const&)+0x954>
  1288e4:	mov    0x1d0(%rsp),%rsi
  1288ec:	sub    %rdi,%rsi
  1288ef:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1288f4:	mov    0x308(%r14),%ecx
  1288fb:	mov    0x340(%r14),%rsi
  128902:	mov    %rbp,%rdi
  128905:	mov    0x348(%r14),%rdx
  12890c:	call   6bea0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > synreal::(anonymous namespace)::read<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long)@plt>
  128911:	mov    0x1c0(%rsp),%r10
  128919:	mov    0x1c8(%rsp),%r15
  128921:	mov    %r10,0x10(%rsp)
  128926:	cmp    %r15,%r10
  128929:	je     1289da <synreal::Granular::initialize(synreal::Model const&)+0xa3a>
  12892f:	mov    0x1a0(%rsp),%r9
  128937:	nopw   0x0(%rax,%rax,1)
  128940:	xor    %edi,%edi
  128942:	lea    0x8(%r10),%r13
  128946:	lea    0xc(%r10),%r12
  12894a:	lea    0x4(%r10),%r11
  12894e:	cmp    $0x2,%edi
  128951:	je     128af0 <synreal::Granular::initialize(synreal::Model const&)+0xb50>
  128957:	cmp    $0x3,%edi
  12895a:	je     128ac8 <synreal::Granular::initialize(synreal::Model const&)+0xb28>
  128960:	cmp    $0x1,%edi
  128963:	je     128b08 <synreal::Granular::initialize(synreal::Model const&)+0xb68>
  128969:	mov    %r10,%rax
  12896c:	test   %r9,%r9
  12896f:	je     1289c1 <synreal::Granular::initialize(synreal::Model const&)+0xa21>
  128971:	mov    (%rax),%esi
  128973:	mov    %rbx,%r8
  128976:	mov    %r9,%rax
  128979:	nopl   0x0(%rax)
  128980:	mov    0x10(%rax),%rcx
  128984:	mov    0x18(%rax),%rdx
  128988:	cmp    0x20(%rax),%esi
  12898b:	jle    1289a2 <synreal::Granular::initialize(synreal::Model const&)+0xa02>
  12898d:	test   %rdx,%rdx
  128990:	je     1289b0 <synreal::Granular::initialize(synreal::Model const&)+0xa10>
  128992:	mov    %rdx,%rax
  128995:	mov    0x10(%rax),%rcx
  128999:	mov    0x18(%rax),%rdx
  12899d:	cmp    0x20(%rax),%esi
  1289a0:	jg     12898d <synreal::Granular::initialize(synreal::Model const&)+0x9ed>
  1289a2:	test   %rcx,%rcx
  1289a5:	je     1289b3 <synreal::Granular::initialize(synreal::Model const&)+0xa13>
  1289a7:	mov    %rax,%r8
  1289aa:	mov    %rcx,%rax
  1289ad:	jmp    128980 <synreal::Granular::initialize(synreal::Model const&)+0x9e0>
  1289af:	nop
  1289b0:	mov    %r8,%rax
  1289b3:	cmp    %rbx,%rax
  1289b6:	je     1289c1 <synreal::Granular::initialize(synreal::Model const&)+0xa21>
  1289b8:	cmp    0x20(%rax),%esi
  1289bb:	jge    7b9ac <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x43c>
  1289c1:	add    $0x1,%edi
  1289c4:	cmp    $0x4,%edi
  1289c7:	jne    12894e <synreal::Granular::initialize(synreal::Model const&)+0x9ae>
  1289cd:	add    $0x10,%r10
  1289d1:	cmp    %r10,%r15
  1289d4:	jne    128940 <synreal::Granular::initialize(synreal::Model const&)+0x9a0>
  1289da:	mov    0x10(%rsp),%rdi
  1289df:	test   %rdi,%rdi
  1289e2:	je     1289f4 <synreal::Granular::initialize(synreal::Model const&)+0xa54>
  1289e4:	mov    0x1d0(%rsp),%rsi
  1289ec:	sub    %rdi,%rsi
  1289ef:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1289f4:	mov    0xc0(%r14),%ecx
  1289fb:	mov    0xc8(%r14),%rsi
  128a02:	mov    %rbp,%rdi
  128a05:	mov    0xd0(%r14),%rdx
  128a0c:	call   6c310 <std::vector<int, std::allocator<int> > synreal::(anonymous namespace)::read<int>(synreal::Span<int const>, unsigned long)@plt>
  128a11:	mov    0x1c0(%rsp),%r11
  128a19:	mov    0x1c8(%rsp),%r10
  128a21:	cmp    %r11,%r10
  128a24:	je     128b36 <synreal::Granular::initialize(synreal::Model const&)+0xb96>
  128a2a:	mov    0x1a0(%rsp),%r9
  128a32:	mov    %r11,%r8
  128a35:	nopl   (%rax)
  128a38:	mov    (%r8),%esi
  128a3b:	test   %r9,%r9
  128a3e:	je     128b29 <synreal::Granular::initialize(synreal::Model const&)+0xb89>
  128a44:	mov    %r9,%rax
  128a47:	mov    %rbx,%rdi
  128a4a:	nopw   0x0(%rax,%rax,1)
  128a50:	mov    0x10(%rax),%rcx
  128a54:	mov    0x18(%rax),%rdx
  128a58:	cmp    0x20(%rax),%esi
  128a5b:	jle    128a76 <synreal::Granular::initialize(synreal::Model const&)+0xad6>
  128a5d:	test   %rdx,%rdx
  128a60:	je     128b18 <synreal::Granular::initialize(synreal::Model const&)+0xb78>
  128a66:	mov    %rdx,%rax
  128a69:	mov    0x10(%rax),%rcx
  128a6d:	mov    0x18(%rax),%rdx
  128a71:	cmp    0x20(%rax),%esi
  128a74:	jg     128a5d <synreal::Granular::initialize(synreal::Model const&)+0xabd>
  128a76:	test   %rcx,%rcx
  128a79:	je     128b1b <synreal::Granular::initialize(synreal::Model const&)+0xb7b>
  128a7f:	mov    %rax,%rdi
  128a82:	mov    %rcx,%rax
  128a85:	jmp    128a50 <synreal::Granular::initialize(synreal::Model const&)+0xab0>
  128a87:	nopw   0x0(%rax,%rax,1)
  128a90:	mov    %r12,%rax
  128a93:	test   %r9,%r9
  128a96:	jne    128871 <synreal::Granular::initialize(synreal::Model const&)+0x8d1>
  128a9c:	add    $0x10,%r10
  128aa0:	cmp    %r10,%r15
  128aa3:	jne    128840 <synreal::Granular::initialize(synreal::Model const&)+0x8a0>
  128aa9:	jmp    1288da <synreal::Granular::initialize(synreal::Model const&)+0x93a>
  128aae:	xchg   %ax,%ax
  128ab0:	mov    %r13,%rax
  128ab3:	test   %r9,%r9
  128ab6:	jne    128871 <synreal::Granular::initialize(synreal::Model const&)+0x8d1>
  128abc:	add    $0x1,%edi
  128abf:	jmp    12884e <synreal::Granular::initialize(synreal::Model const&)+0x8ae>
  128ac4:	nopl   0x0(%rax)
  128ac8:	mov    %r12,%rax
  128acb:	test   %r9,%r9
  128ace:	jne    128971 <synreal::Granular::initialize(synreal::Model const&)+0x9d1>
  128ad4:	add    $0x10,%r10
  128ad8:	cmp    %r10,%r15
  128adb:	jne    128940 <synreal::Granular::initialize(synreal::Model const&)+0x9a0>
  128ae1:	jmp    1289da <synreal::Granular::initialize(synreal::Model const&)+0xa3a>
  128ae6:	cs nopw 0x0(%rax,%rax,1)
  128af0:	mov    %r13,%rax
  128af3:	test   %r9,%r9
  128af6:	jne    128971 <synreal::Granular::initialize(synreal::Model const&)+0x9d1>
  128afc:	add    $0x1,%edi
  128aff:	jmp    12894e <synreal::Granular::initialize(synreal::Model const&)+0x9ae>
  128b04:	nopl   0x0(%rax)
  128b08:	mov    %r11,%rax
  128b0b:	jmp    128af3 <synreal::Granular::initialize(synreal::Model const&)+0xb53>
  128b0d:	nopl   (%rax)
  128b10:	mov    %r11,%rax
  128b13:	jmp    128ab3 <synreal::Granular::initialize(synreal::Model const&)+0xb13>
  128b15:	nopl   (%rax)
  128b18:	mov    %rdi,%rax
  128b1b:	cmp    %rbx,%rax
  128b1e:	je     128b29 <synreal::Granular::initialize(synreal::Model const&)+0xb89>
  128b20:	cmp    0x20(%rax),%esi
  128b23:	jge    7b8a1 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x331>
  128b29:	add    $0x4,%r8
  128b2d:	cmp    %r8,%r10
  128b30:	jne    128a38 <synreal::Granular::initialize(synreal::Model const&)+0xa98>
  128b36:	test   %r11,%r11
  128b39:	je     128b4e <synreal::Granular::initialize(synreal::Model const&)+0xbae>
  128b3b:	mov    0x1d0(%rsp),%rsi
  128b43:	mov    %r11,%rdi
  128b46:	sub    %r11,%rsi
  128b49:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  128b4e:	mov    0x158(%r14),%ecx
  128b55:	mov    0x160(%r14),%rsi
  128b5c:	lea    0x130(%rsp),%rdi
  128b64:	mov    0x168(%r14),%rdx
  128b6b:	call   6cc60 <std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > synreal::(anonymous namespace)::read<glm::vec<2, int, (glm::qualifier)0> >(synreal::Span<glm::vec<2, int, (glm::qualifier)0> const>, unsigned long)@plt>
  128b70:	mov    0x158(%r14),%ecx
  128b77:	mov    0x170(%r14),%rsi
  128b7e:	lea    0x150(%rsp),%rdi
  128b86:	mov    0x178(%r14),%rdx
  128b8d:	call   6cec0 <std::vector<float, std::allocator<float> > synreal::(anonymous namespace)::read<float>(synreal::Span<float const>, unsigned long)@plt>
  128b92:	lea    0x1c8(%rsp),%rax
  128b9a:	movl   $0x0,0x1c8(%rsp)
  128ba5:	mov    0x130(%rsp),%rdx
  128bad:	movq   $0x0,0x1d0(%rsp)
  128bb9:	mov    %rax,0x1d8(%rsp)
  128bc1:	mov    %rax,0x1e0(%rsp)
  128bc9:	movq   $0x0,0x1e8(%rsp)
  128bd5:	cmp    %rdx,0x138(%rsp)
  128bdd:	je     128e1a <synreal::Granular::initialize(synreal::Model const&)+0xe7a>
  128be3:	xor    %r12d,%r12d
  128be6:	lea    0x170(%rsp),%r13
  128bee:	lea    0x174(%rsp),%r15
  128bf6:	cs nopw 0x0(%rax,%rax,1)
  128c00:	mov    (%rdx,%r12,8),%rax
  128c04:	mov    %rax,%rdi
  128c07:	mov    %rax,0x170(%rsp)
  128c0f:	mov    %eax,%r8d
  128c12:	shr    $0x20,%rdi
  128c16:	cmp    %edi,%eax
  128c18:	je     7b8d3 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x363>
  128c1e:	mov    0x1a0(%rsp),%rax
  128c26:	test   %rax,%rax
  128c29:	je     7b8d3 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x363>
  128c2f:	mov    %rax,%rdx
  128c32:	mov    %rbx,%r9
  128c35:	nopl   (%rax)
  128c38:	mov    0x10(%rdx),%rsi
  128c3c:	mov    0x18(%rdx),%rcx
  128c40:	cmp    0x20(%rdx),%r8d
  128c44:	jle    128c60 <synreal::Granular::initialize(synreal::Model const&)+0xcc0>
  128c46:	test   %rcx,%rcx
  128c49:	je     128d00 <synreal::Granular::initialize(synreal::Model const&)+0xd60>
  128c4f:	mov    %rcx,%rdx
  128c52:	mov    0x10(%rdx),%rsi
  128c56:	mov    0x18(%rdx),%rcx
  128c5a:	cmp    0x20(%rdx),%r8d
  128c5e:	jg     128c46 <synreal::Granular::initialize(synreal::Model const&)+0xca6>
  128c60:	test   %rsi,%rsi
  128c63:	je     128d03 <synreal::Granular::initialize(synreal::Model const&)+0xd63>
  128c69:	mov    %rdx,%r9
  128c6c:	mov    %rsi,%rdx
  128c6f:	jmp    128c38 <synreal::Granular::initialize(synreal::Model const&)+0xc98>
  128c71:	nopl   0x0(%rax)
  128c78:	mov    %r11,%rax
  128c7b:	test   %r9,%r9
  128c7e:	jne    128549 <synreal::Granular::initialize(synreal::Model const&)+0x5a9>
  128c84:	add    $0x1,%edi
  128c87:	cmp    $0x2,%edi
  128c8a:	jne    12852f <synreal::Granular::initialize(synreal::Model const&)+0x58f>
  128c90:	mov    %r13,%rax
  128c93:	jmp    128c7b <synreal::Granular::initialize(synreal::Model const&)+0xcdb>
  128c95:	nopl   (%rax)
  128c98:	mov    %r12,%rax
  128c9b:	test   %r9,%r9
  128c9e:	jne    128549 <synreal::Granular::initialize(synreal::Model const&)+0x5a9>
  128ca4:	add    $0x10,%r10
  128ca8:	cmp    %r10,%r15
  128cab:	jne    128518 <synreal::Granular::initialize(synreal::Model const&)+0x578>
  128cb1:	jmp    1285ba <synreal::Granular::initialize(synreal::Model const&)+0x61a>
  128cb6:	cs nopw 0x0(%rax,%rax,1)
  128cc0:	mov    %r12,%rax
  128cc3:	test   %r10,%r10
  128cc6:	jne    128454 <synreal::Granular::initialize(synreal::Model const&)+0x4b4>
  128ccc:	mov    $0x2,%edi
  128cd1:	nopl   0x0(%rax)
  128cd8:	mov    %r11,%rax
  128cdb:	test   %r10,%r10
  128cde:	jne    128454 <synreal::Granular::initialize(synreal::Model const&)+0x4b4>
  128ce4:	add    $0xc,%r9
  128ce8:	cmp    %r9,%r15
  128ceb:	jne    128430 <synreal::Granular::initialize(synreal::Model const&)+0x490>
  128cf1:	jmp    1284b6 <synreal::Granular::initialize(synreal::Model const&)+0x516>
  128cf6:	cs nopw 0x0(%rax,%rax,1)
  128d00:	mov    %r9,%rdx
  128d03:	cmp    %rbx,%rdx
  128d06:	je     7b8d3 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x363>
  128d0c:	cmp    0x20(%rdx),%r8d
  128d10:	jl     7b8d3 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x363>
  128d16:	mov    %rbx,%rsi
  128d19:	jmp    128d2b <synreal::Granular::initialize(synreal::Model const&)+0xd8b>
  128d1b:	nopl   0x0(%rax,%rax,1)
  128d20:	test   %rcx,%rcx
  128d23:	je     128d48 <synreal::Granular::initialize(synreal::Model const&)+0xda8>
  128d25:	mov    %rcx,%rdx
  128d28:	mov    %rdx,%rax
  128d2b:	mov    0x10(%rax),%rdx
  128d2f:	mov    0x18(%rax),%rcx
  128d33:	cmp    0x20(%rax),%edi
  128d36:	jg     128d20 <synreal::Granular::initialize(synreal::Model const&)+0xd80>
  128d38:	test   %rdx,%rdx
  128d3b:	je     128d4b <synreal::Granular::initialize(synreal::Model const&)+0xdab>
  128d3d:	mov    %rax,%rsi
  128d40:	jmp    128d28 <synreal::Granular::initialize(synreal::Model const&)+0xd88>
  128d42:	nopw   0x0(%rax,%rax,1)
  128d48:	mov    %rsi,%rax
  128d4b:	cmp    %rbx,%rax
  128d4e:	je     7b8d3 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x363>
  128d54:	cmp    0x20(%rax),%edi
  128d57:	jl     7b8d3 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x363>
  128d5d:	cmp    %edi,%r8d
  128d60:	jl     12933f <synreal::Granular::initialize(synreal::Model const&)+0x139f>
  128d66:	mov    %r13,%rdx
  128d69:	mov    %r15,%rsi
  128d6c:	jg     128d71 <synreal::Granular::initialize(synreal::Model const&)+0xdd1>
  128d6e:	mov    %r13,%rsi
  128d71:	mov    %rbp,%rdi
  128d74:	call   6ede0 <std::pair<std::_Rb_tree_iterator<std::pair<int, int> >, bool> std::_Rb_tree<std::pair<int, int>, std::pair<int, int>, std::_Identity<std::pair<int, int> >, std::less<std::pair<int, int> >, std::allocator<std::pair<int, int> > >::_M_emplace_unique<int const&, int const&>(int const&, int const&)@plt>
  128d79:	test   %dl,%dl
  128d7b:	je     7b8d3 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x363>
  128d81:	mov    0x150(%rsp),%rax
  128d89:	movss  0xc69fb(%rip),%xmm4        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  128d91:	movss  (%rax,%r12,4),%xmm0
  128d97:	movaps %xmm0,%xmm1
  128d9a:	andps  0xc69ff(%rip),%xmm1        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  128da1:	ucomiss %xmm1,%xmm4
  128da4:	jb     12a010 <synreal::Granular::initialize(synreal::Model const&)+0x2070>
  128daa:	pxor   %xmm5,%xmm5
  128dae:	comiss %xmm0,%xmm5
  128db1:	jae    7b731 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x1c1>
  128db7:	mov    0x110(%rsp),%rax
  128dbf:	cmp    %rax,0x118(%rsp)
  128dc7:	je     128df6 <synreal::Granular::initialize(synreal::Model const&)+0xe56>
  128dc9:	movslq 0x170(%rsp),%rdx
  128dd1:	mov    (%rax,%rdx,4),%edx
  128dd4:	test   %edx,%edx
  128dd6:	js     129347 <synreal::Granular::initialize(synreal::Model const&)+0x13a7>
  128ddc:	movslq 0x174(%rsp),%rcx
  128de4:	mov    (%rax,%rcx,4),%eax
  128de7:	xor    %ecx,%ecx
  128de9:	test   %eax,%eax
  128deb:	cmovs  %ecx,%eax
  128dee:	cmp    %edx,%eax
  128df0:	jne    7b928 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x3b8>
  128df6:	mov    0x130(%rsp),%rdx
  128dfe:	mov    0x138(%rsp),%rax
  128e06:	add    $0x1,%r12
  128e0a:	sub    %rdx,%rax
  128e0d:	sar    $0x3,%rax
  128e11:	cmp    %rax,%r12
  128e14:	jb     128c00 <synreal::Granular::initialize(synreal::Model const&)+0xc60>
  128e1a:	mov    0x1c(%r14),%eax
  128e1e:	mov    0x18(%r14),%ecx
  128e22:	test   %eax,%eax
  128e24:	jne    129373 <synreal::Granular::initialize(synreal::Model const&)+0x13d3>
  128e2a:	movl   $0x1,0x18(%rsp)
  128e32:	mov    $0x1,%eax
  128e37:	mov    0x110(%r14),%edx
  128e3e:	mov    %ecx,%ebx
  128e40:	pxor   %xmm5,%xmm5
  128e44:	movss  0x148(%r14),%xmm0
  128e4d:	imul   %rax,%rbx
  128e51:	mov    %rdx,%rdi
  128e54:	mov    0x158(%r14),%edx
  128e5b:	imul   %rax,%rdi
  128e5f:	imul   %rax,%rdx
  128e63:	comiss %xmm5,%xmm0
  128e66:	mov    %rdi,0x10(%rsp)
  128e6b:	mov    %rdx,0x20(%rsp)
  128e70:	jbe    1296cc <synreal::Granular::initialize(synreal::Model const&)+0x172c>
  128e76:	mov    0x154(%r14),%eax
  128e7d:	imul   %rdi,%rax
  128e81:	mov    %rax,0x40(%rsp)
  128e86:	cmpq   $0x1fffffff,0x10(%rsp)
  128e8f:	ja     7b5a2 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x32>
  128e95:	mov    0x20(%rsp),%rax
  128e9a:	or     %rbx,%rax
  128e9d:	or     0x40(%rsp),%rax
  128ea2:	cmp    $0x7fffffff,%rax
  128ea8:	ja     7b5a2 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x32>
  128eae:	mov    0x10(%rsp),%rax
  128eb3:	movd   %ebx,%xmm6
  128eb7:	cmpq   $0x0,0x40(%rsp)
  128ebd:	pxor   %xmm1,%xmm1
  128ec1:	movd   %eax,%xmm0
  128ec5:	mov    %eax,%ecx
  128ec7:	mov    0x8(%rsp),%rax
  128ecc:	punpckldq %xmm6,%xmm0
  128ed0:	movq   %xmm0,0x748(%rax)
  128ed8:	movss  (%rsp),%xmm0
  128edd:	addss  %xmm0,%xmm0
  128ee1:	je     128eec <synreal::Granular::initialize(synreal::Model const&)+0xf4c>
  128ee3:	movss  0x14c(%r14),%xmm1
  128eec:	addss  %xmm1,%xmm0
  128ef0:	mov    0x8(%rsp),%rax
  128ef5:	movss  0xc688f(%rip),%xmm7        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  128efd:	movss  %xmm0,0x75c(%rax)
  128f05:	andps  0xc6894(%rip),%xmm0        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  128f0c:	ucomiss %xmm0,%xmm7
  128f0f:	jb     7b5d4 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x64>
  128f15:	movl   $0x1,0x750(%rax)
  128f1f:	mov    0x10(%rsp),%eax
  128f23:	add    %eax,%eax
  128f25:	cmp    $0x1,%eax
  128f28:	jle    129e83 <synreal::Granular::initialize(synreal::Model const&)+0x1ee3>
  128f2e:	mov    $0x1,%eax
  128f33:	nopl   0x0(%rax,%rax,1)
  128f38:	mov    %eax,%edx
  128f3a:	add    %eax,%eax
  128f3c:	cmp    %edx,%ecx
  128f3e:	jg     128f38 <synreal::Granular::initialize(synreal::Model const&)+0xf98>
  128f40:	mov    0x8(%rsp),%rdi
  128f45:	movslq %eax,%rsi
  128f48:	mov    %eax,0x750(%rdi)
  128f4e:	mov    %rdi,%r15
  128f51:	lea    0x768(%r15),%rdi
  128f58:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  128f5d:	mov    0x10(%rsp),%rbp
  128f62:	lea    0x788(%r15),%rdi
  128f69:	mov    %rbp,%rsi
  128f6c:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  128f71:	lea    0x7a8(%r15),%rdi
  128f78:	mov    %rbp,%rsi
  128f7b:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  128f80:	lea    0x7c8(%r15),%rdi
  128f87:	mov    %rbp,%rsi
  128f8a:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  128f8f:	mov    0x800(%r15),%rax
  128f96:	cmp    %rax,%rbp
  128f99:	jae    129670 <synreal::Granular::initialize(synreal::Model const&)+0x16d0>
  128f9f:	mov    0x7f0(%r15),%rdx
  128fa6:	lea    0x0(%rbp,%rbp,2),%r12
  128fab:	lea    (%rax,%rax,2),%rbp
  128faf:	shl    $0x2,%rbp
  128fb3:	shl    $0x2,%r12
  128fb7:	lea    0x88(%rsp),%rdi
  128fbf:	lea    (%rdx,%rbp,1),%rsi
  128fc3:	lea    (%rdx,%r12,1),%rcx
  128fc7:	mov    %rsi,%rdx
  128fca:	call   6b620 <thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, int, (glm::qualifier)0> > > thrust::THRUST_200302_520_NS::detail::dispatch::overlapped_copy<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, int, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, int, (glm::qualifier)0> > > >(thrust::THRUST_200302_520_NS::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, int, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, int, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<3, int, (glm::qualifier)0> > >)@plt>
  128fcf:	movabs $0xaaaaaaaaaaaaaaab,%rdx
  128fd9:	mov    %rbp,%rax
  128fdc:	sub    %r12,%rax
  128fdf:	sar    $0x2,%rax
  128fe3:	imul   %rdx,%rax
  128fe7:	sub    %rax,0x800(%r15)
  128fee:	mov    0x8(%rsp),%r15
  128ff3:	mov    0x10(%rsp),%rbp
  128ff8:	lea    0x808(%r15),%rdi
  128fff:	mov    %rbp,%rsi
  129002:	call   6ee30 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  129007:	lea    0x828(%r15),%rdi
  12900e:	mov    %rbp,%rsi
  129011:	call   6ee30 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  129016:	mov    0x860(%r15),%rax
  12901d:	lea    0x848(%r15),%rdi
  129024:	cmp    %rax,%rbp
  129027:	jae    1296aa <synreal::Granular::initialize(synreal::Model const&)+0x170a>
  12902d:	mov    0x850(%r15),%rdx
  129034:	lea    (%rdx,%rax,4),%r8
  129038:	lea    (%rdx,%rbp,4),%rsi
  12903c:	mov    %r8,%rdx
  12903f:	call   6d420 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::erase(thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<float> >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<float> >)@plt>
  129044:	mov    0x8(%rsp),%r15
  129049:	mov    0x10(%rsp),%r13
  12904e:	lea    0x868(%r15),%rdi
  129055:	mov    %r13,%rsi
  129058:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  12905d:	mov    %r13,%r12
  129060:	lea    0x888(%r15),%rdi
  129067:	shl    $0x5,%r12
  12906b:	mov    %r12,%rsi
  12906e:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  129073:	mov    0x8c0(%r15),%rbp
  12907a:	cmp    %rbp,%r12
  12907d:	jae    12968e <synreal::Granular::initialize(synreal::Model const&)+0x16ee>
  129083:	mov    0x8b0(%r15),%rax
  12908a:	mov    %r13,%r12
  12908d:	shl    $0x4,%rbp
  129091:	lea    0x170(%rsp),%rdi
  129099:	shl    $0x9,%r12
  12909d:	lea    (%rax,%rbp,1),%rsi
  1290a1:	lea    (%rax,%r12,1),%rcx
  1290a5:	mov    %rsi,%rdx
  1290a8:	call   6aff0 <thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > > thrust::THRUST_200302_520_NS::detail::dispatch::overlapped_copy<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > > >(thrust::THRUST_200302_520_NS::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<4, float, (glm::qualifier)0> > >)@plt>
  1290ad:	mov    %rbp,%rax
  1290b0:	sub    %r12,%rax
  1290b3:	sar    $0x4,%rax
  1290b7:	sub    %rax,0x8c0(%r15)
  1290be:	mov    0x8(%rsp),%rsi
  1290c3:	mov    0x8e0(%rsi),%rax
  1290ca:	lea    0x8c8(%rsi),%rdi
  1290d1:	cmp    %rax,%rbx
  1290d4:	jae    1296bc <synreal::Granular::initialize(synreal::Model const&)+0x171c>
  1290da:	mov    0x8d0(%rsi),%rdx
  1290e1:	lea    (%rax,%rax,8),%rax
  1290e5:	lea    (%rdx,%rax,4),%r8
  1290e9:	lea    (%rbx,%rbx,8),%rax
  1290ed:	lea    (%rdx,%rax,4),%rsi
  1290f1:	mov    %r8,%rdx
  1290f4:	call   6eb10 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::erase(thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > >)@plt>
  1290f9:	movss  0x134(%r14),%xmm0
  129102:	pxor   %xmm3,%xmm3
  129106:	comiss %xmm3,%xmm0
  129109:	jbe    129117 <synreal::Granular::initialize(synreal::Model const&)+0x1177>
  12910b:	cmpq   $0x0,0x20(%rsp)
  129111:	jne    129af1 <synreal::Granular::initialize(synreal::Model const&)+0x1b51>
  129117:	mov    0x40(%rsp),%rax
  12911c:	test   %rax,%rax
  12911f:	je     12954a <synreal::Granular::initialize(synreal::Model const&)+0x15aa>
  129125:	mov    0x8(%rsp),%rbx
  12912a:	mov    %eax,0x758(%rbx)
  129130:	mov    0x18(%r14),%ebx
  129134:	test   %rbx,%rbx
  129137:	je     1296da <synreal::Granular::initialize(synreal::Model const&)+0x173a>
  12913d:	shl    $0x2,%rbx
  129141:	mov    %rbx,%rdi
  129144:	call   6d150 <operator new(unsigned long)@plt>
  129149:	mov    %rbx,%rdx
  12914c:	mov    $0xff,%esi
  129151:	mov    %rax,%rdi
  129154:	mov    %rax,%rbp
  129157:	call   6c120 <memset@plt>
  12915c:	mov    %rbx,0x58(%rsp)
  129161:	mov    0x90(%rsp),%rsi
  129169:	mov    0x98(%rsp),%rcx
  129171:	xor    %eax,%eax
  129173:	sub    %rsi,%rcx
  129176:	sar    $0x2,%rcx
  12917a:	je     129191 <synreal::Granular::initialize(synreal::Model const&)+0x11f1>
  12917c:	nopl   0x0(%rax)
  129180:	movslq (%rsi,%rax,4),%rdx
  129184:	mov    %eax,0x0(%rbp,%rdx,4)
  129188:	add    $0x1,%rax
  12918c:	cmp    %rcx,%rax
  12918f:	jne    129180 <synreal::Granular::initialize(synreal::Model const&)+0x11e0>
  129191:	mov    0x10(%rsp),%rax
  129196:	lea    (%rax,%rax,2),%rbx
  12919a:	shl    $0x3,%rbx
  12919e:	test   %rax,%rax
  1291a1:	je     129ae0 <synreal::Granular::initialize(synreal::Model const&)+0x1b40>
  1291a7:	mov    %rbx,%rdi
  1291aa:	call   6d150 <operator new(unsigned long)@plt>
  1291af:	mov    %rax,%r15
  1291b2:	lea    (%rax,%rbx,1),%rax
  1291b6:	mov    0x10(%rsp),%rbx
  1291bb:	mov    %rax,0x38(%rsp)
  1291c0:	lea    -0x1(%rbx),%rax
  1291c4:	cmp    $0x1,%rax
  1291c8:	jbe    129fa0 <synreal::Granular::initialize(synreal::Model const&)+0x2000>
  1291ce:	mov    %rbx,%rcx
  1291d1:	and    $0xfffffffffffffffe,%rbx
  1291d5:	pxor   %xmm0,%xmm0
  1291d9:	mov    %r15,%rax
  1291dc:	shr    %rcx
  1291df:	mov    %rbx,%rdx
  1291e2:	add    %rcx,%rdx
  1291e5:	shl    $0x4,%rdx
  1291e9:	add    %r15,%rdx
  1291ec:	movups %xmm0,(%rax)
  1291ef:	add    $0x30,%rax
  1291f3:	movups %xmm0,-0x20(%rax)
  1291f7:	movups %xmm0,-0x10(%rax)
  1291fb:	cmp    %rdx,%rax
  1291fe:	jne    1291ec <synreal::Granular::initialize(synreal::Model const&)+0x124c>
  129200:	mov    0x10(%rsp),%rbx
  129205:	mov    %rbx,%rdx
  129208:	mov    %rbx,%rcx
  12920b:	and    $0xfffffffffffffffe,%rdx
  12920f:	lea    (%rdx,%rdx,2),%rax
  129213:	sub    %rdx,%rcx
  129216:	lea    (%r15,%rax,8),%rax
  12921a:	cmp    %rdx,%rbx
  12921d:	je     129240 <synreal::Granular::initialize(synreal::Model const&)+0x12a0>
  12921f:	pxor   %xmm0,%xmm0
  129223:	movq   $0x0,0x10(%rax)
  12922b:	movups %xmm0,(%rax)
  12922e:	cmp    $0x1,%rcx
  129232:	je     129240 <synreal::Granular::initialize(synreal::Model const&)+0x12a0>
  129234:	movq   $0x0,0x28(%rax)
  12923c:	movups %xmm0,0x18(%rax)
  129240:	lea    0x170(%rsp),%rax
  129248:	xor    %r12d,%r12d
  12924b:	mov    %rax,(%rsp)
  12924f:	mov    0x18(%rsp),%eax
  129253:	test   %eax,%eax
  129255:	je     12971f <synreal::Granular::initialize(synreal::Model const&)+0x177f>
  12925b:	nopl   0x0(%rax,%rax,1)
  129260:	mov    0x130(%rsp),%rbx
  129268:	mov    0x138(%rsp),%r13
  129270:	cmp    %rbx,%r13
  129273:	jne    1292b9 <synreal::Granular::initialize(synreal::Model const&)+0x1319>
  129275:	jmp    12971f <synreal::Granular::initialize(synreal::Model const&)+0x177f>
  12927a:	nopw   0x0(%rax,%rax,1)
  129280:	jle    129285 <synreal::Granular::initialize(synreal::Model const&)+0x12e5>
  129282:	lea    (%rsi,%rcx,1),%edx
  129285:	lea    (%rax,%rax,2),%rax
  129289:	mov    %edx,0x170(%rsp)
  129290:	lea    (%r15,%rax,8),%rdi
  129294:	mov    0x8(%rdi),%rsi
  129298:	cmp    0x10(%rdi),%rsi
  12929c:	je     1296f0 <synreal::Granular::initialize(synreal::Model const&)+0x1750>
  1292a2:	mov    %edx,(%rsi)
  1292a4:	add    $0x8,%rbx
  1292a8:	add    $0x4,%rsi
  1292ac:	mov    %rsi,0x8(%rdi)
  1292b0:	cmp    %rbx,%r13
  1292b3:	je     129710 <synreal::Granular::initialize(synreal::Model const&)+0x1770>
  1292b9:	movslq 0x4(%rbx),%rax
  1292bd:	mov    0x110(%r14),%ecx
  1292c4:	mov    0x0(%rbp,%rax,4),%esi
  1292c8:	movslq (%rbx),%rax
  1292cb:	imul   %r12d,%ecx
  1292cf:	mov    0x0(%rbp,%rax,4),%edx
  1292d3:	lea    (%rdx,%rcx,1),%eax
  1292d6:	cmp    %edx,%esi
  1292d8:	mov    %eax,%edx
  1292da:	jge    129280 <synreal::Granular::initialize(synreal::Model const&)+0x12e0>
  1292dc:	lea    (%rsi,%rcx,1),%eax
  1292df:	jmp    129285 <synreal::Granular::initialize(synreal::Model const&)+0x12e5>
  1292e1:	nopl   0x0(%rax)
  1292e8:	mov    %r11,%rax
  1292eb:	cmp    %rbx,%rax
  1292ee:	je     1292f9 <synreal::Granular::initialize(synreal::Model const&)+0x1359>
  1292f0:	cmp    0x20(%rax),%esi
  1292f3:	jge    7baf3 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x583>
  1292f9:	mov    0x4(%rdi),%esi
  1292fc:	mov    %r8,%rax
  1292ff:	mov    %rbx,%r11
  129302:	nopw   0x0(%rax,%rax,1)
  129308:	mov    0x10(%rax),%rcx
  12930c:	mov    0x18(%rax),%rdx
  129310:	cmp    0x20(%rax),%esi
  129313:	jle    12932e <synreal::Granular::initialize(synreal::Model const&)+0x138e>
  129315:	test   %rdx,%rdx
  129318:	je     1287c0 <synreal::Granular::initialize(synreal::Model const&)+0x820>
  12931e:	mov    %rdx,%rax
  129321:	mov    0x10(%rax),%rcx
  129325:	mov    0x18(%rax),%rdx
  129329:	cmp    0x20(%rax),%esi
  12932c:	jg     129315 <synreal::Granular::initialize(synreal::Model const&)+0x1375>
  12932e:	test   %rcx,%rcx
  129331:	je     1287c3 <synreal::Granular::initialize(synreal::Model const&)+0x823>
  129337:	mov    %rax,%r11
  12933a:	mov    %rcx,%rax
  12933d:	jmp    129308 <synreal::Granular::initialize(synreal::Model const&)+0x1368>
  12933f:	mov    %r15,%rdx
  129342:	jmp    128d6e <synreal::Granular::initialize(synreal::Model const&)+0xdce>
  129347:	movslq 0x174(%rsp),%rdx
  12934f:	mov    (%rax,%rdx,4),%eax
  129352:	xor    %edx,%edx
  129354:	test   %eax,%eax
  129356:	jns    128dee <synreal::Granular::initialize(synreal::Model const&)+0xe4e>
  12935c:	jmp    128df6 <synreal::Granular::initialize(synreal::Model const&)+0xe56>
  129361:	mov    0x18(%r14),%ecx
  129365:	jmp    12829a <synreal::Granular::initialize(synreal::Model const&)+0x2fa>
  12936a:	mov    0x18(%r14),%ecx
  12936e:	jmp    128275 <synreal::Granular::initialize(synreal::Model const&)+0x2d5>
  129373:	xor    %edx,%edx
  129375:	div    %ecx
  129377:	mov    %eax,0x18(%rsp)
  12937b:	mov    %eax,%eax
  12937d:	jmp    128e37 <synreal::Granular::initialize(synreal::Model const&)+0xe97>
  129382:	mov    (%rsp),%rbx
  129386:	mov    0x30(%rsp),%rax
  12938b:	mov    0x18(%rsp),%r13
  129390:	sub    %rbx,%rax
  129393:	mov    %rax,0x28(%rsp)
  129398:	sub    %rbx,%r13
  12939b:	mov    0x20(%rsp),%rbx
  1293a0:	mov    %r13,%rax
  1293a3:	add    $0x18,%r14
  1293a7:	sar    $0x2,%rax
  1293ab:	mov    %eax,(%rbx)
  1293ad:	add    $0x4,%rbx
  1293b1:	mov    %rbx,0x20(%rsp)
  1293b6:	cmp    %rbx,0x48(%rsp)
  1293bb:	jne    1297b0 <synreal::Granular::initialize(synreal::Model const&)+0x1810>
  1293c1:	mov    0x8(%rsp),%rbx
  1293c6:	mov    0x48(%rsp),%rdx
  1293cb:	mov    0x50(%rsp),%rsi
  1293d0:	lea    0x988(%rbx),%rdi
  1293d7:	call   127d90 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::range_assign<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > > >(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  1293dc:	mov    (%rsp),%r13
  1293e0:	mov    0x18(%rsp),%rdx
  1293e5:	lea    0x9a8(%rbx),%rdi
  1293ec:	mov    %r13,%rsi
  1293ef:	call   127d90 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::range_assign<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > > >(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  1293f4:	mov    0x40(%rsp),%r14
  1293f9:	lea    0x170(%rsp),%r12
  129401:	lea    0x9c8(%rbx),%rdi
  129408:	movl   $0xffffffff,0x170(%rsp)
  129413:	mov    %r12,%rdx
  129416:	mov    %r14,%rsi
  129419:	call   6f330 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::fill_assign(unsigned long, int const&)@plt>
  12941e:	lea    0x9e8(%rbx),%rdi
  129425:	mov    %r12,%rdx
  129428:	mov    %r14,%rsi
  12942b:	movq   $0x0,0x170(%rsp)
  129437:	call   6f380 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<2, int, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<2, int, (glm::qualifier)0> > >::fill_assign(unsigned long, glm::vec<2, int, (glm::qualifier)0> const&)@plt>
  12943c:	lea    0xa08(%rbx),%rdi
  129443:	mov    %r12,%rdx
  129446:	mov    %r14,%rsi
  129449:	movl   $0x0,0x170(%rsp)
  129454:	call   6d1f0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::fill_assign(unsigned long, float const&)@plt>
  129459:	lea    0xa28(%rbx),%rdi
  129460:	mov    %r12,%rdx
  129463:	mov    %r14,%rsi
  129466:	movl   $0x0,0x170(%rsp)
  129471:	call   6d1f0 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::fill_assign(unsigned long, float const&)@plt>
  129476:	lea    0xa48(%rbx),%rdi
  12947d:	mov    %r12,%rdx
  129480:	mov    %r14,%rsi
  129483:	movl   $0x0,0x170(%rsp)
  12948e:	call   6f330 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::fill_assign(unsigned long, int const&)@plt>
  129493:	add    $0xa68,%rbx
  12949a:	pxor   %xmm0,%xmm0
  12949e:	lea    0x1f0(%rsp),%rdx
  1294a6:	mov    %r14,%rsi
  1294a9:	mov    %rbx,%rdi
  1294ac:	movaps %xmm0,0x1f0(%rsp)
  1294b4:	movl   $0x0,0x210(%rsp)
  1294bf:	movaps %xmm0,0x200(%rsp)
  1294c7:	call   6b570 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::fill_assign(unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const&)@plt>
  1294cc:	test   %r13,%r13
  1294cf:	je     1294de <synreal::Granular::initialize(synreal::Model const&)+0x153e>
  1294d1:	mov    0x28(%rsp),%rsi
  1294d6:	mov    %r13,%rdi
  1294d9:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1294de:	mov    0x60(%rsp),%rsi
  1294e3:	mov    0x50(%rsp),%rdi
  1294e8:	mov    %r15,%rbx
  1294eb:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1294f0:	cmp    0x38(%rsp),%r15
  1294f5:	je     129523 <synreal::Granular::initialize(synreal::Model const&)+0x1583>
  1294f7:	nopw   0x0(%rax,%rax,1)
  129500:	mov    (%rbx),%rdi
  129503:	test   %rdi,%rdi
  129506:	je     129930 <synreal::Granular::initialize(synreal::Model const&)+0x1990>
  12950c:	mov    0x10(%rbx),%rsi
  129510:	add    $0x18,%rbx
  129514:	sub    %rdi,%rsi
  129517:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  12951c:	cmp    0x38(%rsp),%rbx
  129521:	jne    129500 <synreal::Granular::initialize(synreal::Model const&)+0x1560>
  129523:	test   %r15,%r15
  129526:	je     129538 <synreal::Granular::initialize(synreal::Model const&)+0x1598>
  129528:	mov    0x38(%rsp),%rsi
  12952d:	mov    %r15,%rdi
  129530:	sub    %r15,%rsi
  129533:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  129538:	test   %rbp,%rbp
  12953b:	je     12954a <synreal::Granular::initialize(synreal::Model const&)+0x15aa>
  12953d:	mov    0x58(%rsp),%rsi
  129542:	mov    %rbp,%rdi
  129545:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  12954a:	mov    0x1d0(%rsp),%rdi
  129552:	call   125340 <std::_Rb_tree<std::pair<int, int>, std::pair<int, int>, std::_Identity<std::pair<int, int> >, std::less<std::pair<int, int> >, std::allocator<std::pair<int, int> > >::_M_erase(std::_Rb_tree_node<std::pair<int, int> >*) [clone .isra.0]>
  129557:	mov    0x150(%rsp),%rdi
  12955f:	test   %rdi,%rdi
  129562:	je     129574 <synreal::Granular::initialize(synreal::Model const&)+0x15d4>
  129564:	mov    0x160(%rsp),%rsi
  12956c:	sub    %rdi,%rsi
  12956f:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  129574:	mov    0x130(%rsp),%rdi
  12957c:	test   %rdi,%rdi
  12957f:	je     129591 <synreal::Granular::initialize(synreal::Model const&)+0x15f1>
  129581:	mov    0x140(%rsp),%rsi
  129589:	sub    %rdi,%rsi
  12958c:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  129591:	mov    0x1a0(%rsp),%rdi
  129599:	call   125510 <std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_erase(std::_Rb_tree_node<int>*) [clone .isra.0]>
  12959e:	mov    0x110(%rsp),%rdi
  1295a6:	test   %rdi,%rdi
  1295a9:	je     1295bb <synreal::Granular::initialize(synreal::Model const&)+0x161b>
  1295ab:	mov    0x120(%rsp),%rsi
  1295b3:	sub    %rdi,%rsi
  1295b6:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1295bb:	mov    0xf0(%rsp),%rdi
  1295c3:	test   %rdi,%rdi
  1295c6:	je     1295d8 <synreal::Granular::initialize(synreal::Model const&)+0x1638>
  1295c8:	mov    0x100(%rsp),%rsi
  1295d0:	sub    %rdi,%rsi
  1295d3:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1295d8:	mov    0xd0(%rsp),%rdi
  1295e0:	test   %rdi,%rdi
  1295e3:	je     1295f5 <synreal::Granular::initialize(synreal::Model const&)+0x1655>
  1295e5:	mov    0xe0(%rsp),%rsi
  1295ed:	sub    %rdi,%rsi
  1295f0:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  1295f5:	mov    0xb0(%rsp),%rdi
  1295fd:	test   %rdi,%rdi
  129600:	je     129612 <synreal::Granular::initialize(synreal::Model const&)+0x1672>
  129602:	mov    0xc0(%rsp),%rsi
  12960a:	sub    %rdi,%rsi
  12960d:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  129612:	mov    0x90(%rsp),%rdi
  12961a:	test   %rdi,%rdi
  12961d:	je     12962f <synreal::Granular::initialize(synreal::Model const&)+0x168f>
  12961f:	mov    0xa0(%rsp),%rsi
  129627:	sub    %rdi,%rsi
  12962a:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  12962f:	mov    0x218(%rsp),%rax
  129637:	sub    %fs:0x28,%rax
  129640:	jne    12a00b <synreal::Granular::initialize(synreal::Model const&)+0x206b>
  129646:	add    $0x228,%rsp
  12964d:	pop    %rbx
  12964e:	pop    %rbp
  12964f:	pop    %r12
  129651:	pop    %r13
  129653:	pop    %r14
  129655:	pop    %r15
  129657:	ret    
  129658:	mov    0x158(%r14),%ecx
  12965f:	test   %ecx,%ecx
  129661:	je     12962f <synreal::Granular::initialize(synreal::Model const&)+0x168f>
  129663:	jmp    7b570 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]>
  129668:	nopl   0x0(%rax,%rax,1)
  129670:	mov    0x10(%rsp),%rsi
  129675:	sub    %rax,%rsi
  129678:	mov    0x8(%rsp),%rax
  12967d:	lea    0x7e8(%rax),%rdi
  129684:	call   6f700 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<3, int, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<3, int, (glm::qualifier)0> > >::append(unsigned long)@plt>
  129689:	jmp    128fee <synreal::Granular::initialize(synreal::Model const&)+0x104e>
  12968e:	mov    0x8(%rsp),%rax
  129693:	mov    %r12,%rsi
  129696:	sub    %rbp,%rsi
  129699:	lea    0x8a8(%rax),%rdi
  1296a0:	call   6f560 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::vec<4, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<4, float, (glm::qualifier)0> > >::append(unsigned long)@plt>
  1296a5:	jmp    1290be <synreal::Granular::initialize(synreal::Model const&)+0x111e>
  1296aa:	mov    0x10(%rsp),%rsi
  1296af:	sub    %rax,%rsi
  1296b2:	call   6f670 <thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::append(unsigned long)@plt>
  1296b7:	jmp    129044 <synreal::Granular::initialize(synreal::Model const&)+0x10a4>
  1296bc:	sub    %rax,%rbx
  1296bf:	mov    %rbx,%rsi
  1296c2:	call   6e4f0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)@plt>
  1296c7:	jmp    1290f9 <synreal::Granular::initialize(synreal::Model const&)+0x1159>
  1296cc:	movq   $0x0,0x40(%rsp)
  1296d5:	jmp    128e86 <synreal::Granular::initialize(synreal::Model const&)+0xee6>
  1296da:	movq   $0x0,0x58(%rsp)
  1296e3:	xor    %ebp,%ebp
  1296e5:	jmp    129161 <synreal::Granular::initialize(synreal::Model const&)+0x11c1>
  1296ea:	nopw   0x0(%rax,%rax,1)
  1296f0:	mov    (%rsp),%rdx
  1296f4:	call   6e740 <void std::vector<int, std::allocator<int> >::_M_realloc_insert<int>(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, int&&)@plt>
  1296f9:	add    $0x8,%rbx
  1296fd:	cmp    %rbx,%r13
  129700:	jne    1292b9 <synreal::Granular::initialize(synreal::Model const&)+0x1319>
  129706:	cs nopw 0x0(%rax,%rax,1)
  129710:	add    $0x1,%r12d
  129714:	cmp    %r12d,0x18(%rsp)
  129719:	jne    129260 <synreal::Granular::initialize(synreal::Model const&)+0x12c0>
  12971f:	mov    0x10(%rsp),%rax
  129724:	lea    0x4(,%rax,4),%rbx
  12972c:	mov    %rbx,%rdi
  12972f:	mov    %rbx,0x60(%rsp)
  129734:	call   6d150 <operator new(unsigned long)@plt>
  129739:	mov    %rax,0x50(%rsp)
  12973e:	mov    %rax,%rdi
  129741:	xor    %esi,%esi
  129743:	add    %rbx,%rax
  129746:	mov    %rbx,%rdx
  129749:	mov    %rax,0x48(%rsp)
  12974e:	call   6c120 <memset@plt>
  129753:	cmpq   $0x0,0x20(%rsp)
  129759:	je     129ac0 <synreal::Granular::initialize(synreal::Model const&)+0x1b20>
  12975f:	mov    0x20(%rsp),%rbx
  129764:	shl    $0x2,%rbx
  129768:	mov    %rbx,%rdi
  12976b:	call   6d150 <operator new(unsigned long)@plt>
  129770:	mov    %rax,0x18(%rsp)
  129775:	add    %rbx,%rax
  129778:	mov    %rax,0x30(%rsp)
  12977d:	mov    %rbx,0x28(%rsp)
  129782:	mov    0x50(%rsp),%rax
  129787:	lea    0x8(%r15),%r14
  12978b:	add    $0x4,%rax
  12978f:	cmpq   $0x0,0x10(%rsp)
  129795:	mov    %rax,0x20(%rsp)
  12979a:	mov    0x18(%rsp),%rax
  12979f:	mov    %rax,(%rsp)
  1297a3:	je     1293c1 <synreal::Granular::initialize(synreal::Model const&)+0x1421>
  1297a9:	nopl   0x0(%rax)
  1297b0:	mov    (%r14),%rcx
  1297b3:	mov    -0x8(%r14),%r12
  1297b7:	cmp    %rcx,%r12
  1297ba:	je     129382 <synreal::Granular::initialize(synreal::Model const&)+0x13e2>
  1297c0:	mov    %rcx,%r13
  1297c3:	mov    $0x3f,%edx
  1297c8:	mov    %rcx,%rsi
  1297cb:	mov    %r12,%rdi
  1297ce:	sub    %r12,%r13
  1297d1:	mov    %rcx,0x10(%rsp)
  1297d6:	lea    0x4(%r12),%rbx
  1297db:	mov    %r13,%rax
  1297de:	sar    $0x2,%rax
  1297e2:	bsr    %rax,%rax
  1297e6:	xor    $0x3f,%rax
  1297ea:	sub    %eax,%edx
  1297ec:	movslq %edx,%rdx
  1297ef:	add    %rdx,%rdx
  1297f2:	call   1256e0 <void std::__introsort_loop<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, long, __gnu_cxx::__ops::_Iter_less_iter>(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, long, __gnu_cxx::__ops::_Iter_less_iter) [clone .isra.0]>
  1297f7:	cmp    $0x40,%r13
  1297fb:	mov    0x10(%rsp),%rcx
  129800:	jle    129944 <synreal::Granular::initialize(synreal::Model const&)+0x19a4>
  129806:	lea    0x40(%r12),%r13
  12980b:	mov    %rbx,%rax
  12980e:	mov    %rbp,0x28(%rsp)
  129813:	mov    %r12,%rbx
  129816:	mov    %r13,%rbp
  129819:	mov    %rax,%r12
  12981c:	jmp    129848 <synreal::Granular::initialize(synreal::Model const&)+0x18a8>
  12981e:	xchg   %ax,%ax
  129820:	cmp    %r12,%rbx
  129823:	je     12983c <synreal::Granular::initialize(synreal::Model const&)+0x189c>
  129825:	mov    %r12,%rdx
  129828:	mov    $0x4,%eax
  12982d:	mov    %rbx,%rsi
  129830:	sub    %rbx,%rdx
  129833:	lea    (%rbx,%rax,1),%rdi
  129837:	call   6e920 <memmove@plt>
  12983c:	add    $0x4,%r12
  129840:	mov    %r13d,(%rbx)
  129843:	cmp    %r12,%rbp
  129846:	je     129886 <synreal::Granular::initialize(synreal::Model const&)+0x18e6>
  129848:	mov    (%r12),%r13d
  12984c:	cmp    (%rbx),%r13d
  12984f:	jl     129820 <synreal::Granular::initialize(synreal::Model const&)+0x1880>
  129851:	mov    -0x4(%r12),%edx
  129856:	lea    -0x4(%r12),%rax
  12985b:	cmp    %edx,%r13d
  12985e:	jge    129e6b <synreal::Granular::initialize(synreal::Model const&)+0x1ecb>
  129864:	nopl   0x0(%rax)
  129868:	mov    %edx,0x4(%rax)
  12986b:	mov    %rax,%rsi
  12986e:	mov    -0x4(%rax),%edx
  129871:	sub    $0x4,%rax
  129875:	cmp    %edx,%r13d
  129878:	jl     129868 <synreal::Granular::initialize(synreal::Model const&)+0x18c8>
  12987a:	mov    %r13d,(%rsi)
  12987d:	add    $0x4,%r12
  129881:	cmp    %r12,%rbp
  129884:	jne    129848 <synreal::Granular::initialize(synreal::Model const&)+0x18a8>
  129886:	mov    0x10(%rsp),%rcx
  12988b:	mov    %rbp,%r13
  12988e:	mov    (%r14),%rbx
  129891:	mov    0x28(%rsp),%rbp
  129896:	mov    -0x8(%r14),%r12
  12989a:	cmp    %r13,%rcx
  12989d:	je     1298d4 <synreal::Granular::initialize(synreal::Model const&)+0x1934>
  12989f:	nop
  1298a0:	mov    0x0(%r13),%esi
  1298a4:	mov    -0x4(%r13),%edx
  1298a8:	lea    -0x4(%r13),%rax
  1298ac:	cmp    %edx,%esi
  1298ae:	jge    1299cf <synreal::Granular::initialize(synreal::Model const&)+0x1a2f>
  1298b4:	nopl   0x0(%rax)
  1298b8:	mov    %edx,0x4(%rax)
  1298bb:	mov    %rax,%rdi
  1298be:	mov    -0x4(%rax),%edx
  1298c1:	sub    $0x4,%rax
  1298c5:	cmp    %edx,%esi
  1298c7:	jl     1298b8 <synreal::Granular::initialize(synreal::Model const&)+0x1918>
  1298c9:	add    $0x4,%r13
  1298cd:	mov    %esi,(%rdi)
  1298cf:	cmp    %r13,%rcx
  1298d2:	jne    1298a0 <synreal::Granular::initialize(synreal::Model const&)+0x1900>
  1298d4:	mov    0x30(%rsp),%rax
  1298d9:	mov    (%rsp),%rcx
  1298dd:	mov    0x18(%rsp),%rdi
  1298e2:	mov    %rax,%rsi
  1298e5:	mov    %rdi,%r13
  1298e8:	sub    %rcx,%rsi
  1298eb:	mov    %rsi,0x28(%rsp)
  1298f0:	sub    %rcx,%r13
  1298f3:	cmp    %rbx,%r12
  1298f6:	je     12939b <synreal::Granular::initialize(synreal::Model const&)+0x13fb>
  1298fc:	sub    %r12,%rbx
  1298ff:	sub    %rdi,%rax
  129902:	cmp    %rbx,%rax
  129905:	jb     1299d7 <synreal::Granular::initialize(synreal::Model const&)+0x1a37>
  12990b:	mov    %r12,%rsi
  12990e:	mov    %rbx,%rdx
  129911:	mov    %rdi,%r12
  129914:	call   6e920 <memmove@plt>
  129919:	mov    %r12,%rdi
  12991c:	add    %rbx,%rdi
  12991f:	mov    %rdi,0x18(%rsp)
  129924:	sub    (%rsp),%rdi
  129928:	mov    %rdi,%r13
  12992b:	jmp    12939b <synreal::Granular::initialize(synreal::Model const&)+0x13fb>
  129930:	add    $0x18,%rbx
  129934:	cmp    %rbx,0x38(%rsp)
  129939:	jne    129500 <synreal::Granular::initialize(synreal::Model const&)+0x1560>
  12993f:	jmp    129523 <synreal::Granular::initialize(synreal::Model const&)+0x1583>
  129944:	cmp    %rbx,%rcx
  129947:	je     1298d4 <synreal::Granular::initialize(synreal::Model const&)+0x1934>
  129949:	mov    %rbp,0x10(%rsp)
  12994e:	mov    %rcx,%rbp
  129951:	jmp    129981 <synreal::Granular::initialize(synreal::Model const&)+0x19e1>
  129953:	nopl   0x0(%rax,%rax,1)
  129958:	cmp    %rbx,%r12
  12995b:	je     129974 <synreal::Granular::initialize(synreal::Model const&)+0x19d4>
  12995d:	mov    %rbx,%rdx
  129960:	mov    $0x4,%eax
  129965:	mov    %r12,%rsi
  129968:	sub    %r12,%rdx
  12996b:	lea    (%r12,%rax,1),%rdi
  12996f:	call   6e920 <memmove@plt>
  129974:	add    $0x4,%rbx
  129978:	mov    %r13d,(%r12)
  12997c:	cmp    %rbp,%rbx
  12997f:	je     1299be <synreal::Granular::initialize(synreal::Model const&)+0x1a1e>
  129981:	mov    (%rbx),%r13d
  129984:	mov    %rbx,%rsi
  129987:	cmp    (%r12),%r13d
  12998b:	jl     129958 <synreal::Granular::initialize(synreal::Model const&)+0x19b8>
  12998d:	mov    -0x4(%rbx),%edx
  129990:	lea    -0x4(%rbx),%rax
  129994:	cmp    %r13d,%edx
  129997:	jle    1299b2 <synreal::Granular::initialize(synreal::Model const&)+0x1a12>
  129999:	nopl   0x0(%rax)
  1299a0:	mov    %edx,0x4(%rax)
  1299a3:	mov    %rax,%rsi
  1299a6:	mov    -0x4(%rax),%edx
  1299a9:	sub    $0x4,%rax
  1299ad:	cmp    %edx,%r13d
  1299b0:	jl     1299a0 <synreal::Granular::initialize(synreal::Model const&)+0x1a00>
  1299b2:	add    $0x4,%rbx
  1299b6:	mov    %r13d,(%rsi)
  1299b9:	cmp    %rbp,%rbx
  1299bc:	jne    129981 <synreal::Granular::initialize(synreal::Model const&)+0x19e1>
  1299be:	mov    0x10(%rsp),%rbp
  1299c3:	mov    (%r14),%rbx
  1299c6:	mov    -0x8(%r14),%r12
  1299ca:	jmp    1298d4 <synreal::Granular::initialize(synreal::Model const&)+0x1934>
  1299cf:	mov    %r13,%rdi
  1299d2:	jmp    1298c9 <synreal::Granular::initialize(synreal::Model const&)+0x1929>
  1299d7:	movabs $0x1fffffffffffffff,%rcx
  1299e1:	mov    %r13,%rdx
  1299e4:	mov    %rbx,%rax
  1299e7:	sar    $0x2,%rdx
  1299eb:	sar    $0x2,%rax
  1299ef:	sub    %rdx,%rcx
  1299f2:	cmp    %rcx,%rax
  1299f5:	ja     129fff <synreal::Granular::initialize(synreal::Model const&)+0x205f>
  1299fb:	cmp    %rdx,%rax
  1299fe:	cmovb  %rdx,%rax
  129a02:	add    %rdx,%rax
  129a05:	jb     129feb <synreal::Granular::initialize(synreal::Model const&)+0x204b>
  129a0b:	test   %rax,%rax
  129a0e:	jne    129fb3 <synreal::Granular::initialize(synreal::Model const&)+0x2013>
  129a14:	movq   $0x0,0x10(%rsp)
  129a1d:	xor    %ecx,%ecx
  129a1f:	movq   $0x0,0x30(%rsp)
  129a28:	mov    (%rsp),%rsi
  129a2c:	cmp    %rsi,0x18(%rsp)
  129a31:	je     129a93 <synreal::Granular::initialize(synreal::Model const&)+0x1af3>
  129a33:	mov    %rcx,%rdi
  129a36:	mov    %r13,%rdx
  129a39:	call   6e920 <memmove@plt>
  129a3e:	mov    %rbx,%rdx
  129a41:	mov    %r12,%rsi
  129a44:	lea    (%rax,%r13,1),%rdi
  129a48:	mov    %rax,0x68(%rsp)
  129a4d:	call   6e920 <memmove@plt>
  129a52:	mov    0x68(%rsp),%rcx
  129a57:	lea    (%rax,%rbx,1),%rax
  129a5b:	mov    %rax,0x18(%rsp)
  129a60:	mov    0x28(%rsp),%rsi
  129a65:	mov    (%rsp),%rdi
  129a69:	mov    %rcx,0x68(%rsp)
  129a6e:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  129a73:	mov    0x68(%rsp),%rcx
  129a78:	mov    0x18(%rsp),%r13
  129a7d:	mov    0x10(%rsp),%rax
  129a82:	mov    %rcx,(%rsp)
  129a86:	mov    %rax,0x28(%rsp)
  129a8b:	sub    %rcx,%r13
  129a8e:	jmp    12939b <synreal::Granular::initialize(synreal::Model const&)+0x13fb>
  129a93:	lea    (%rcx,%r13,1),%rdi
  129a97:	mov    %rbx,%rdx
  129a9a:	mov    %r12,%rsi
  129a9d:	mov    %rcx,0x68(%rsp)
  129aa2:	call   6e920 <memmove@plt>
  129aa7:	cmpq   $0x0,(%rsp)
  129aac:	mov    0x68(%rsp),%rcx
  129ab1:	lea    (%rax,%rbx,1),%rax
  129ab5:	mov    %rax,0x18(%rsp)
  129aba:	je     129a78 <synreal::Granular::initialize(synreal::Model const&)+0x1ad8>
  129abc:	jmp    129a60 <synreal::Granular::initialize(synreal::Model const&)+0x1ac0>
  129abe:	xchg   %ax,%ax
  129ac0:	movq   $0x0,0x28(%rsp)
  129ac9:	movq   $0x0,0x30(%rsp)
  129ad2:	movq   $0x0,0x18(%rsp)
  129adb:	jmp    129782 <synreal::Granular::initialize(synreal::Model const&)+0x17e2>
  129ae0:	movq   $0x0,0x38(%rsp)
  129ae9:	xor    %r15d,%r15d
  129aec:	jmp    129240 <synreal::Granular::initialize(synreal::Model const&)+0x12a0>
  129af1:	mov    0x20(%rsp),%rbx
  129af6:	mov    0x8(%rsp),%rax
  129afb:	mov    %ebx,0x754(%rax)
  129b01:	lea    0x0(,%rbx,8),%r15
  129b09:	mov    %r15,%rdi
  129b0c:	mov    %r15,0x68(%rsp)
  129b11:	call   6d150 <operator new(unsigned long)@plt>
  129b16:	lea    0x8(%rax),%rdx
  129b1a:	movq   $0x0,(%rax)
  129b21:	mov    %rax,%rbp
  129b24:	mov    %rdx,(%rsp)
  129b28:	sub    $0x1,%rbx
  129b2c:	je     129b47 <synreal::Granular::initialize(synreal::Model const&)+0x1ba7>
  129b2e:	lea    (%rax,%r15,1),%rax
  129b32:	mov    0x0(%rbp),%rcx
  129b36:	add    $0x8,%rdx
  129b3a:	mov    %rcx,-0x8(%rdx)
  129b3e:	cmp    %rdx,%rax
  129b41:	jne    129b32 <synreal::Granular::initialize(synreal::Model const&)+0x1b92>
  129b43:	mov    %rdx,(%rsp)
  129b47:	mov    0x20(%rsp),%rax
  129b4c:	shl    $0x2,%rax
  129b50:	mov    %rax,%rdi
  129b53:	mov    %rax,0x50(%rsp)
  129b58:	call   6d150 <operator new(unsigned long)@plt>
  129b5d:	movl   $0x0,(%rax)
  129b63:	mov    %rax,%r13
  129b66:	lea    0x4(%rax),%rax
  129b6a:	mov    %rax,0x30(%rsp)
  129b6f:	test   %rbx,%rbx
  129b72:	je     129b91 <synreal::Granular::initialize(synreal::Model const&)+0x1bf1>
  129b74:	mov    %rax,%rdi
  129b77:	mov    0x50(%rsp),%rax
  129b7c:	xor    %esi,%esi
  129b7e:	lea    0x0(%r13,%rax,1),%rbx
  129b83:	lea    -0x4(%rax),%rdx
  129b87:	call   6c120 <memset@plt>
  129b8c:	mov    %rbx,0x30(%rsp)
  129b91:	mov    0x18(%rsp),%edx
  129b95:	test   %edx,%edx
  129b97:	je     129d41 <synreal::Granular::initialize(synreal::Model const&)+0x1da1>
  129b9d:	mov    0x158(%r14),%r11d
  129ba4:	mov    0x130(%rsp),%rdx
  129bac:	mov    0x150(%rsp),%rcx
  129bb4:	test   %r11d,%r11d
  129bb7:	je     129d41 <synreal::Granular::initialize(synreal::Model const&)+0x1da1>
  129bbd:	mov    0x18(%r14),%eax
  129bc1:	mov    %r14,0x78(%rsp)
  129bc6:	mov    %r11d,%r15d
  129bc9:	xor    %esi,%esi
  129bcb:	xor    %r12d,%r12d
  129bce:	mov    %eax,0x28(%rsp)
  129bd2:	lea    -0x1(%r11),%eax
  129bd6:	mov    %eax,0x58(%rsp)
  129bda:	mov    %r11d,%eax
  129bdd:	shr    $0x2,%eax
  129be0:	sub    $0x1,%eax
  129be3:	add    $0x1,%rax
  129be7:	shl    $0x4,%rax
  129beb:	mov    %rax,%rbx
  129bee:	mov    %r11d,%eax
  129bf1:	and    $0xfffffffc,%eax
  129bf4:	mov    %eax,0x38(%rsp)
  129bf8:	lea    0x4(%rcx),%rax
  129bfc:	mov    %rax,0x48(%rsp)
  129c01:	lea    0x8(%rdx),%rax
  129c05:	mov    %rax,0x60(%rsp)
  129c0a:	mov    %r11d,%eax
  129c0d:	and    $0x3,%eax
  129c10:	mov    %eax,0x74(%rsp)
  129c14:	mov    0x28(%rsp),%eax
  129c18:	lea    0x0(%r13,%rsi,4),%rdi
  129c1d:	mov    %rdi,%r8
  129c20:	sub    0x48(%rsp),%r8
  129c25:	imul   %r12d,%eax
  129c29:	cmp    $0x8,%r8
  129c2d:	seta   %r9b
  129c31:	cmp    $0x1,%r11d
  129c35:	setne  %r8b
  129c39:	movd   %eax,%xmm2
  129c3d:	lea    0x0(%rbp,%rsi,8),%rax
  129c42:	pshufd $0xe0,%xmm2,%xmm3
  129c47:	test   %r8b,%r9b
  129c4a:	je     129e3e <synreal::Granular::initialize(synreal::Model const&)+0x1e9e>
  129c50:	mov    %rax,%r8
  129c53:	sub    0x60(%rsp),%r8
  129c58:	add    $0x4,%r8
  129c5c:	cmp    $0x18,%r8
  129c60:	jbe    129e3e <synreal::Granular::initialize(synreal::Model const&)+0x1e9e>
  129c66:	cmpl   $0x2,0x58(%rsp)
  129c6b:	jbe    129e92 <synreal::Granular::initialize(synreal::Model const&)+0x1ef2>
  129c71:	pshufd $0x0,%xmm2,%xmm2
  129c76:	xor    %r8d,%r8d
  129c79:	nopl   0x0(%rax)
  129c80:	movdqu 0x10(%rdx,%r8,2),%xmm0
  129c87:	movdqu (%rdx,%r8,2),%xmm1
  129c8d:	movups (%rcx,%r8,1),%xmm6
  129c92:	paddd  %xmm2,%xmm0
  129c96:	paddd  %xmm2,%xmm1
  129c9a:	movups %xmm1,(%rax,%r8,2)
  129c9f:	movups %xmm0,0x10(%rax,%r8,2)
  129ca5:	movups %xmm6,(%rdi,%r8,1)
  129caa:	add    $0x10,%r8
  129cae:	cmp    %r8,%rbx
  129cb1:	jne    129c80 <synreal::Granular::initialize(synreal::Model const&)+0x1ce0>
  129cb3:	mov    0x38(%rsp),%eax
  129cb7:	cmp    %eax,%r11d
  129cba:	je     129d2a <synreal::Granular::initialize(synreal::Model const&)+0x1d8a>
  129cbc:	mov    0x74(%rsp),%edi
  129cc0:	mov    %edi,%r14d
  129cc3:	cmp    $0x1,%edi
  129cc6:	je     129d0b <synreal::Granular::initialize(synreal::Model const&)+0x1d6b>
  129cc8:	mov    %eax,%edi
  129cca:	lea    (%rdx,%rdi,8),%r10
  129cce:	lea    (%rdi,%rsi,1),%r8
  129cd2:	mov    (%rcx,%rdi,4),%rdi
  129cd6:	movq   0x8(%r10),%xmm0
  129cdc:	movq   (%r10),%xmm1
  129ce1:	lea    0x0(%rbp,%r8,8),%r9
  129ce6:	mov    %rdi,0x0(%r13,%r8,4)
  129ceb:	mov    %r14d,%edi
  129cee:	paddd  %xmm3,%xmm0
  129cf2:	paddd  %xmm3,%xmm1
  129cf6:	and    $0xfffffffe,%edi
  129cf9:	add    %edi,%eax
  129cfb:	movq   %xmm1,(%r9)
  129d00:	movq   %xmm0,0x8(%r9)
  129d06:	cmp    %r14d,%edi
  129d09:	je     129d2a <synreal::Granular::initialize(synreal::Model const&)+0x1d8a>
  129d0b:	movq   (%rdx,%rax,8),%xmm0
  129d10:	lea    (%rax,%rsi,1),%rdi
  129d14:	paddd  %xmm3,%xmm0
  129d18:	movq   %xmm0,0x0(%rbp,%rdi,8)
  129d1e:	movss  (%rcx,%rax,4),%xmm0
  129d23:	movss  %xmm0,0x0(%r13,%rdi,4)
  129d2a:	add    $0x1,%r12d
  129d2e:	add    %r15,%rsi
  129d31:	cmp    %r12d,0x18(%rsp)
  129d36:	jne    129c14 <synreal::Granular::initialize(synreal::Model const&)+0x1c74>
  129d3c:	mov    0x78(%rsp),%r14
  129d41:	mov    (%rsp),%rbx
  129d45:	mov    0x8(%rsp),%rax
  129d4a:	mov    0x8(%rsp),%r15
  129d4f:	sub    %rbp,%rbx
  129d52:	mov    0x918(%rax),%rax
  129d59:	sar    $0x3,%rbx
  129d5d:	cmp    %rax,%rbx
  129d60:	ja     129ead <synreal::Granular::initialize(synreal::Model const&)+0x1f0d>
  129d66:	mov    0x920(%r15),%rax
  129d6d:	mov    0x910(%r15),%rdx
  129d74:	cmp    %rax,%rbx
  129d77:	jbe    129e9c <synreal::Granular::initialize(synreal::Model const&)+0x1efc>
  129d7d:	lea    0x0(%rbp,%rax,8),%r12
  129d82:	mov    %rbp,%rdi
  129d85:	mov    %r12,%rsi
  129d88:	call   6e1f0 <thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<2, int, (glm::qualifier)0> > > thrust::THRUST_200302_520_NS::copy<__gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<2, int, (glm::qualifier)0> > > >(__gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<2, int, (glm::qualifier)0> > >)@plt>
  129d8d:	mov    0x8(%rsp),%r15
  129d92:	mov    (%rsp),%rsi
  129d96:	mov    %r12,%rdi
  129d99:	mov    0x920(%r15),%rdx
  129da0:	mov    0x910(%r15),%rax
  129da7:	lea    (%rax,%rdx,8),%rdx
  129dab:	call   125bc0 <thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<2, int, (glm::qualifier)0> > > thrust::THRUST_200302_520_NS::detail::contiguous_storage<glm::vec<2, int, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<2, int, (glm::qualifier)0> > >::uninitialized_copy<__gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<2, int, (glm::qualifier)0> > >) [clone .isra.0]>
  129db0:	mov    %rbx,0x920(%r15)
  129db7:	mov    0x8(%rsp),%rax
  129dbc:	mov    0x30(%rsp),%rdx
  129dc1:	mov    %r13,%rsi
  129dc4:	lea    0x928(%rax),%rdi
  129dcb:	call   127bf0 <void thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::range_assign<__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > > >(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, __gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  129dd0:	mov    0x8(%rsp),%rbx
  129dd5:	mov    0x30(%rsp),%rdx
  129dda:	mov    %r13,%rsi
  129ddd:	lea    0x948(%rbx),%rdi
  129de4:	call   127bf0 <void thrust::THRUST_200302_520_NS::detail::vector_base<float, thrust::THRUST_200302_520_NS::device_allocator<float> >::range_assign<__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > > >(__gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, __gnu_cxx::__normal_iterator<float*, std::vector<float, std::allocator<float> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  129de9:	mov    0x20(%rsp),%r15
  129dee:	lea    0x170(%rsp),%rdx
  129df6:	lea    0x968(%rbx),%rdi
  129dfd:	movl   $0x1,0x170(%rsp)
  129e08:	mov    %r15,%rsi
  129e0b:	call   6f330 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::fill_assign(unsigned long, int const&)@plt>
  129e10:	lea    0x8e8(%rbx),%rdi
  129e17:	mov    %r15,%rsi
  129e1a:	call   6ccd0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::resize(unsigned long)@plt>
  129e1f:	mov    0x50(%rsp),%rsi
  129e24:	mov    %r13,%rdi
  129e27:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  129e2c:	mov    0x68(%rsp),%rsi
  129e31:	mov    %rbp,%rdi
  129e34:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  129e39:	jmp    129117 <synreal::Granular::initialize(synreal::Model const&)+0x1177>
  129e3e:	xor    %r8d,%r8d
  129e41:	movq   (%rdx,%r8,8),%xmm0
  129e47:	paddd  %xmm3,%xmm0
  129e4b:	movq   %xmm0,(%rax,%r8,8)
  129e51:	movss  (%rcx,%r8,4),%xmm0
  129e57:	movss  %xmm0,(%rdi,%r8,4)
  129e5d:	add    $0x1,%r8
  129e61:	cmp    %r8,%r15
  129e64:	jne    129e41 <synreal::Granular::initialize(synreal::Model const&)+0x1ea1>
  129e66:	jmp    129d2a <synreal::Granular::initialize(synreal::Model const&)+0x1d8a>
  129e6b:	mov    %r12,%rsi
  129e6e:	mov    %r13d,(%rsi)
  129e71:	jmp    12987d <synreal::Granular::initialize(synreal::Model const&)+0x18dd>
  129e76:	lea    0x1c0(%rsp),%rbp
  129e7e:	jmp    1283e9 <synreal::Granular::initialize(synreal::Model const&)+0x449>
  129e83:	mov    0x8(%rsp),%r15
  129e88:	mov    $0x1,%esi
  129e8d:	jmp    128f51 <synreal::Granular::initialize(synreal::Model const&)+0xfb1>
  129e92:	mov    %r11d,%r14d
  129e95:	xor    %eax,%eax
  129e97:	jmp    129cc8 <synreal::Granular::initialize(synreal::Model const&)+0x1d28>
  129e9c:	mov    (%rsp),%rsi
  129ea0:	mov    %rbp,%rdi
  129ea3:	call   6e1f0 <thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<2, int, (glm::qualifier)0> > > thrust::THRUST_200302_520_NS::copy<__gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<2, int, (glm::qualifier)0> > > >(__gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<2, int, (glm::qualifier)0> > >)@plt>
  129ea8:	jmp    129db0 <synreal::Granular::initialize(synreal::Model const&)+0x1e10>
  129ead:	mov    0x908(%r15),%rdx
  129eb4:	movq   $0x0,0x178(%rsp)
  129ec0:	movq   $0x0,0x180(%rsp)
  129ecc:	mov    %rdx,0x170(%rsp)
  129ed4:	test   %rbx,%rbx
  129ed7:	je     129fab <synreal::Granular::initialize(synreal::Model const&)+0x200b>
  129edd:	add    %rax,%rax
  129ee0:	mov    0x8(%rdx),%rdi
  129ee4:	mov    $0x4,%edx
  129ee9:	cmp    %rbx,%rax
  129eec:	cmovb  %rbx,%rax
  129ef0:	lea    0x0(,%rax,8),%rsi
  129ef8:	mov    %rax,%r12
  129efb:	call   6c340 <thrust::THRUST_200302_520_NS::system::cuda::detail::cuda_memory_resource<&cudaMalloc, &cudaFree, thrust::THRUST_200302_520_NS::pointer<void, thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::tagged_reference<void, thrust::THRUST_200302_520_NS::cuda_cub::tag>, thrust::THRUST_200302_520_NS::use_default> >::do_allocate(unsigned long, unsigned long)@plt>
  129f00:	mov    (%rsp),%rsi
  129f04:	mov    %rax,%rdx
  129f07:	mov    %rbp,%rdi
  129f0a:	mov    %rax,0x178(%rsp)
  129f12:	mov    %r12,0x180(%rsp)
  129f1a:	call   125bc0 <thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<2, int, (glm::qualifier)0> > > thrust::THRUST_200302_520_NS::detail::contiguous_storage<glm::vec<2, int, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<2, int, (glm::qualifier)0> > >::uninitialized_copy<__gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > > >(__gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > >, __gnu_cxx::__normal_iterator<glm::vec<2, int, (glm::qualifier)0>*, std::vector<glm::vec<2, int, (glm::qualifier)0>, std::allocator<glm::vec<2, int, (glm::qualifier)0> > > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::vec<2, int, (glm::qualifier)0> > >) [clone .isra.0]>
  129f1f:	mov    0x918(%r15),%rax
  129f26:	mov    0x8(%rsp),%rdi
  129f2b:	mov    0x178(%rsp),%rcx
  129f33:	mov    %rax,0x180(%rsp)
  129f3b:	mov    0x910(%rdi),%rdx
  129f42:	mov    %rcx,0x910(%rdi)
  129f49:	mov    0x170(%rsp),%rcx
  129f51:	mov    %r12,0x918(%rdi)
  129f58:	mov    %rdx,0x178(%rsp)
  129f60:	mov    0x908(%rdi),%rdx
  129f67:	mov    %rbx,0x920(%rdi)
  129f6e:	mov    %rdx,0x88(%rsp)
  129f76:	mov    %rcx,0x908(%rdi)
  129f7d:	mov    %rdx,0x170(%rsp)
  129f85:	test   %rax,%rax
  129f88:	je     129db7 <synreal::Granular::initialize(synreal::Model const&)+0x1e17>
  129f8e:	lea    0x170(%rsp),%rdi
  129f96:	call   125aa0 <thrust::THRUST_200302_520_NS::detail::contiguous_storage<glm::vec<2, int, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::vec<2, int, (glm::qualifier)0> > >::deallocate() [clone .part.0]>
  129f9b:	jmp    129db7 <synreal::Granular::initialize(synreal::Model const&)+0x1e17>
  129fa0:	mov    %rbx,%rcx
  129fa3:	mov    %r15,%rax
  129fa6:	jmp    12921f <synreal::Granular::initialize(synreal::Model const&)+0x127f>
  129fab:	xor    %r12d,%r12d
  129fae:	jmp    129f26 <synreal::Granular::initialize(synreal::Model const&)+0x1f86>
  129fb3:	movabs $0x1fffffffffffffff,%rdx
  129fbd:	cmp    %rdx,%rax
  129fc0:	cmova  %rdx,%rax
  129fc4:	shl    $0x2,%rax
  129fc8:	mov    %rax,0x10(%rsp)
  129fcd:	mov    %rax,%rdi
  129fd0:	call   6d150 <operator new(unsigned long)@plt>
  129fd5:	mov    %rax,%rcx
  129fd8:	mov    0x10(%rsp),%rax
  129fdd:	lea    (%rcx,%rax,1),%rdi
  129fe1:	mov    %rdi,0x30(%rsp)
  129fe6:	jmp    129a28 <synreal::Granular::initialize(synreal::Model const&)+0x1a88>
  129feb:	movabs $0x7ffffffffffffffc,%rax
  129ff5:	mov    %rax,0x10(%rsp)
  129ffa:	mov    %rax,%rdi
  129ffd:	jmp    129fd0 <synreal::Granular::initialize(synreal::Model const&)+0x2030>
  129fff:	lea    0xcd606(%rip),%rdi        # 1f760c <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x770c>
  12a006:	call   6c070 <std::__throw_length_error(char const*)@plt>
  12a00b:	call   6d5c0 <__stack_chk_fail@plt>
  12a010:	jmp    7b731 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x1c1>
  12a015:	endbr64 
  12a019:	mov    %rax,%rbx
  12a01c:	jmp    7b778 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x208>
  12a021:	endbr64 
  12a025:	mov    %rax,%rbx
  12a028:	jmp    7b7a2 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x232>
  12a02d:	endbr64 
  12a031:	mov    %rax,%rbx
  12a034:	jmp    7b790 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x220>
  12a039:	endbr64 
  12a03d:	mov    %rax,%rbx
  12a040:	jmp    7b783 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x213>
  12a045:	endbr64 
  12a049:	mov    %rax,%rbx
  12a04c:	jmp    7b656 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0xe6>
  12a051:	jmp    7b831 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2c1>
  12a056:	endbr64 
  12a05a:	jmp    7b867 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x2f7>
  12a05f:	endbr64 
  12a063:	mov    %rax,%rbp
  12a066:	jmp    7b6bd <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x14d>
  12a06b:	endbr64 
  12a06f:	mov    %rax,%rbp
  12a072:	jmp    7b6a0 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x130>
  12a077:	endbr64 
  12a07b:	jmp    7b720 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x1b0>
  12a080:	jmp    7bb25 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x5b5>
  12a085:	endbr64 
  12a089:	mov    %rax,%rbp
  12a08c:	jmp    7b6f7 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x187>
  12a091:	endbr64 
  12a095:	mov    %rax,%rbp
  12a098:	jmp    7b6da <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x16a>
  12a09d:	endbr64 
  12a0a1:	mov    %rax,%rbx
  12a0a4:	jmp    7ba2c <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x4bc>
  12a0a9:	endbr64 
  12a0ad:	mov    %rax,%rdi
  12a0b0:	jmp    7ba47 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x4d7>
  12a0b5:	endbr64 
  12a0b9:	mov    %rax,%rbx
  12a0bc:	jmp    7b7b7 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x247>
  12a0c1:	endbr64 
  12a0c5:	mov    %rax,%rbx
  12a0c8:	jmp    7b7c6 <synreal::Granular::initialize(synreal::Model const&) [clone .cold]+0x256>
