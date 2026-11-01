
/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

0000000000137ec0 <synreal::SelfCollision::initialize(synreal::Model const&)>:
  137ec0:	endbr64 
  137ec4:	push   %r15
  137ec6:	mov    %rdi,%r15
  137ec9:	push   %r14
  137ecb:	push   %r13
  137ecd:	push   %r12
  137ecf:	push   %rbp
  137ed0:	push   %rbx
  137ed1:	sub    $0x1d8,%rsp
  137ed8:	mov    %rsi,0x50(%rsp)
  137edd:	mov    0xe08(%rdi),%rsi
  137ee4:	mov    %fs:0x28,%rax
  137eed:	mov    %rax,0x1c8(%rsp)
  137ef5:	xor    %eax,%eax
  137ef7:	movq   $0x0,0xe08(%rdi)
  137f02:	test   %rsi,%rsi
  137f05:	je     137f13 <synreal::SelfCollision::initialize(synreal::Model const&)+0x53>
  137f07:	lea    0xe08(%rdi),%rdi
  137f0e:	call   6bfc0 <synreal::SelfCollision::ContactTangentDeleter::operator()(synreal::SelfCollisionContactTangent*) const@plt>
  137f13:	mov    0x50(%rsp),%rsi
  137f18:	mov    $0xe9,%ecx
  137f1d:	mov    %r15,%rdi
  137f20:	movq   $0x0,0xe10(%r15)
  137f2b:	rep movsq %ds:(%rsi),%es:(%rdi)
  137f2e:	mov    0x50(%rsp),%rsi
  137f33:	mov    0x180(%rsi),%eax
  137f39:	mov    0x18(%rsi),%ecx
  137f3c:	mov    %rax,0x900(%r15)
  137f43:	mov    0x198(%rsi),%eax
  137f49:	mov    %rcx,0x748(%r15)
  137f50:	mov    %rax,0xa90(%r15)
  137f57:	mov    0xa8(%rsi),%eax
  137f5d:	mov    %rax,0xc20(%r15)
  137f64:	mov    0x1c(%rsi),%eax
  137f67:	test   %eax,%eax
  137f69:	je     137f90 <synreal::SelfCollision::initialize(synreal::Model const&)+0xd0>
  137f6b:	test   %rcx,%rcx
  137f6e:	je     138411 <synreal::SelfCollision::initialize(synreal::Model const&)+0x551>
  137f74:	xor    %edx,%edx
  137f76:	mov    %rax,0x70(%rsp)
  137f7b:	div    %rcx
  137f7e:	test   %rdx,%rdx
  137f81:	je     137fa3 <synreal::SelfCollision::initialize(synreal::Model const&)+0xe3>
  137f83:	jmp    7d100 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x314>
  137f88:	nopl   0x0(%rax,%rax,1)
  137f90:	test   %rcx,%rcx
  137f93:	je     138411 <synreal::SelfCollision::initialize(synreal::Model const&)+0x551>
  137f99:	mov    %rcx,0x70(%rsp)
  137f9e:	mov    $0x1,%eax
  137fa3:	mov    %rax,0x750(%r15)
  137faa:	lea    0x0(,%rcx,4),%rbx
  137fb2:	mov    %rbx,%rdi
  137fb5:	mov    %rbx,0x78(%rsp)
  137fba:	call   6d150 <operator new(unsigned long)@plt>
  137fbf:	mov    %rbx,%rdx
  137fc2:	xor    %esi,%esi
  137fc4:	mov    %rax,%rdi
  137fc7:	mov    %rax,%r12
  137fca:	mov    %rax,0x68(%rsp)
  137fcf:	call   6c120 <memset@plt>
  137fd4:	mov    0x50(%rsp),%rax
  137fd9:	lea    0x190(%rsp),%rdi
  137fe1:	add    %rbx,%r12
  137fe4:	lea    0xb2c88(%rip),%r8        # 1eac73 <_fini+0x552f>
  137feb:	mov    %rdi,0x10(%rsp)
  137ff0:	mov    0xc0(%rax),%ecx
  137ff6:	mov    0xc8(%rax),%rsi
  137ffd:	mov    0xd0(%rax),%rdx
  138004:	call   6bc20 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  138009:	mov    0x190(%rsp),%rdi
  138011:	mov    0x198(%rsp),%rcx
  138019:	mov    0x68(%rsp),%rsi
  13801e:	mov    %rdi,%rdx
  138021:	cmp    %rcx,%rdi
  138024:	je     138058 <synreal::SelfCollision::initialize(synreal::Model const&)+0x198>
  138026:	cs nopw 0x0(%rax,%rax,1)
  138030:	movslq (%rdx),%rax
  138033:	test   %eax,%eax
  138035:	js     7d23e <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x452>
  13803b:	cmp    0x748(%r15),%rax
  138042:	jae    7d23e <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x452>
  138048:	add    $0x4,%rdx
  13804c:	movl   $0x1,(%rsi,%rax,4)
  138053:	cmp    %rdx,%rcx
  138056:	jne    138030 <synreal::SelfCollision::initialize(synreal::Model const&)+0x170>
  138058:	test   %rdi,%rdi
  13805b:	je     13806d <synreal::SelfCollision::initialize(synreal::Model const&)+0x1ad>
  13805d:	mov    0x1a0(%rsp),%rsi
  138065:	sub    %rdi,%rsi
  138068:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  13806d:	mov    0x50(%rsp),%rax
  138072:	mov    0x10(%rsp),%rdi
  138077:	lea    0xb2d82(%rip),%r8        # 1eae00 <_fini+0x56bc>
  13807e:	mov    0x110(%rax),%ecx
  138084:	mov    0x118(%rax),%rsi
  13808b:	mov    0x120(%rax),%rdx
  138092:	call   6bc20 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  138097:	mov    0x190(%rsp),%rdi
  13809f:	mov    0x198(%rsp),%rcx
  1380a7:	mov    0x68(%rsp),%rsi
  1380ac:	mov    %rdi,%rdx
  1380af:	cmp    %rcx,%rdi
  1380b2:	je     1380ec <synreal::SelfCollision::initialize(synreal::Model const&)+0x22c>
  1380b4:	nopl   0x0(%rax)
  1380b8:	movslq (%rdx),%rax
  1380bb:	test   %eax,%eax
  1380bd:	js     7d05e <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x272>
  1380c3:	cmp    0x748(%r15),%rax
  1380ca:	jae    7d05e <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x272>
  1380d0:	lea    (%rsi,%rax,4),%rax
  1380d4:	cmpl   $0x1,(%rax)
  1380d7:	je     7d090 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x2a4>
  1380dd:	add    $0x4,%rdx
  1380e1:	movl   $0x2,(%rax)
  1380e7:	cmp    %rdx,%rcx
  1380ea:	jne    1380b8 <synreal::SelfCollision::initialize(synreal::Model const&)+0x1f8>
  1380ec:	test   %rdi,%rdi
  1380ef:	je     138101 <synreal::SelfCollision::initialize(synreal::Model const&)+0x241>
  1380f1:	mov    0x1a0(%rsp),%rsi
  1380f9:	sub    %rdi,%rsi
  1380fc:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  138101:	mov    0x68(%rsp),%rsi
  138106:	lea    0xd08(%r15),%rdi
  13810d:	mov    %r12,%rdx
  138110:	call   1374a0 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::range_assign<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > > >(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  138115:	mov    0x50(%rsp),%rbx
  13811a:	lea    0x90(%rsp),%rdi
  138122:	lea    0xb2e09(%rip),%r8        # 1eaf32 <_fini+0x57ee>
  138129:	mov    0x180(%rbx),%ecx
  13812f:	mov    0x188(%rbx),%rsi
  138136:	mov    0x190(%rbx),%rdx
  13813d:	call   6afd0 <std::vector<glm::vec<3, int, (glm::qualifier)0>, std::allocator<glm::vec<3, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<3, int, (glm::qualifier)0> >(synreal::Span<glm::vec<3, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  138142:	mov    0x198(%rbx),%ecx
  138148:	mov    0x1a0(%rbx),%rsi
  13814f:	lea    0xb0(%rsp),%rdi
  138157:	lea    0xb2def(%rip),%r8        # 1eaf4d <_fini+0x5809>
  13815e:	mov    0x1a8(%rbx),%rdx
  138165:	call   6c9f0 <std::vector<glm::vec<4, int, (glm::qualifier)0>, std::allocator<glm::vec<4, int, (glm::qualifier)0> > > (anonymous namespace)::copy_to_host<glm::vec<4, int, (glm::qualifier)0> >(synreal::Span<glm::vec<4, int, (glm::qualifier)0> const>, unsigned long, char const*)@plt>
  13816a:	mov    0xa8(%rbx),%ecx
  138170:	mov    0xb0(%rbx),%rsi
  138177:	lea    0xd0(%rsp),%rdi
  13817f:	lea    0xb2a5b(%rip),%r8        # 1eabe1 <_fini+0x549d>
  138186:	mov    0xb8(%rbx),%rdx
  13818d:	call   6bc20 <std::vector<int, std::allocator<int> > (anonymous namespace)::copy_to_host<int>(synreal::Span<int const>, unsigned long, char const*)@plt>
  138192:	mov    0xd0(%rsp),%rax
  13819a:	cmp    %rax,0xd8(%rsp)
  1381a2:	je     138dca <synreal::SelfCollision::initialize(synreal::Model const&)+0xf0a>
  1381a8:	mov    0x50(%rsp),%rax
  1381ad:	mov    0x748(%r15),%rcx
  1381b4:	lea    0xf0(%rsp),%rdi
  1381bc:	lea    0xb29f7(%rip),%r8        # 1eabba <_fini+0x5476>
  1381c3:	mov    0x88(%rax),%rsi
  1381ca:	mov    0x90(%rax),%rdx
  1381d1:	call   6c060 <std::vector<float, std::allocator<float> > (anonymous namespace)::copy_to_host<float>(synreal::Span<float const>, unsigned long, char const*)@plt>
  1381d6:	lea    0x138(%rsp),%rax
  1381de:	mov    0x90(%rsp),%rbx
  1381e6:	movl   $0x0,0x138(%rsp)
  1381f1:	mov    %rax,0x18(%rsp)
  1381f6:	mov    %rax,0x148(%rsp)
  1381fe:	mov    %rax,0x150(%rsp)
  138206:	lea    0x168(%rsp),%rax
  13820e:	mov    %rax,0x8(%rsp)
  138213:	mov    %rax,0x178(%rsp)
  13821b:	mov    %rax,0x180(%rsp)
  138223:	mov    0x98(%rsp),%rax
  13822b:	movq   $0x0,0x140(%rsp)
  138237:	movq   $0x0,0x158(%rsp)
  138243:	movl   $0x0,0x168(%rsp)
  13824e:	movq   $0x0,0x170(%rsp)
  13825a:	movq   $0x0,0x188(%rsp)
  138266:	mov    %rax,0x20(%rsp)
  13826b:	cmp    %rbx,%rax
  13826e:	je     138497 <synreal::SelfCollision::initialize(synreal::Model const&)+0x5d7>
  138274:	nopl   0x0(%rax)
  138278:	movslq (%rbx),%rax
  13827b:	test   %eax,%eax
  13827d:	js     7d0ce <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x2e2>
  138283:	cmp    %rax,0x748(%r15)
  13828a:	jbe    7d0ce <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x2e2>
  138290:	lea    0x130(%rsp),%rbp
  138298:	mov    %rbx,%rsi
  13829b:	mov    %rbp,%rdi
  13829e:	call   6d350 <std::pair<std::_Rb_tree_iterator<int>, bool> std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_insert_unique<int const&>(int const&)@plt>
  1382a3:	movslq 0x4(%rbx),%rax
  1382a7:	test   %eax,%eax
  1382a9:	js     7d0ce <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x2e2>
  1382af:	cmp    0x748(%r15),%rax
  1382b6:	jae    7d0ce <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x2e2>
  1382bc:	lea    0x4(%rbx),%r14
  1382c0:	mov    %rbp,%rdi
  1382c3:	mov    %r14,%rsi
  1382c6:	call   6d350 <std::pair<std::_Rb_tree_iterator<int>, bool> std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_insert_unique<int const&>(int const&)@plt>
  1382cb:	movslq 0x8(%rbx),%rax
  1382cf:	test   %eax,%eax
  1382d1:	js     7d0ce <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x2e2>
  1382d7:	cmp    0x748(%r15),%rax
  1382de:	jae    7d0ce <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x2e2>
  1382e4:	lea    0x8(%rbx),%r13
  1382e8:	mov    %rbp,%rdi
  1382eb:	mov    %r13,%rsi
  1382ee:	call   6d350 <std::pair<std::_Rb_tree_iterator<int>, bool> std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_insert_unique<int const&>(int const&)@plt>
  1382f3:	xor    %ebp,%ebp
  1382f5:	lea    0x2(%rbp),%eax
  1382f8:	mov    $0xaaaaaaab,%ecx
  1382fd:	mov    %rax,%rdx
  138300:	imul   %rcx,%rax
  138304:	shr    $0x21,%rax
  138308:	lea    (%rax,%rax,2),%ecx
  13830b:	mov    %edx,%eax
  13830d:	sub    %ecx,%eax
  13830f:	cmp    $0x1,%eax
  138312:	je     138468 <synreal::SelfCollision::initialize(synreal::Model const&)+0x5a8>
  138318:	cmp    $0x2,%eax
  13831b:	je     138458 <synreal::SelfCollision::initialize(synreal::Model const&)+0x598>
  138321:	mov    (%rbx),%esi
  138323:	mov    %rbx,%rcx
  138326:	lea    0x1(%rbp),%eax
  138329:	mov    $0xaaaaaaab,%edi
  13832e:	mov    %rax,%r12
  138331:	imul   %rdi,%rax
  138335:	shr    $0x21,%rax
  138339:	lea    (%rax,%rax,2),%edx
  13833c:	mov    %r12d,%eax
  13833f:	sub    %edx,%eax
  138341:	cmp    $0x1,%eax
  138344:	je     138478 <synreal::SelfCollision::initialize(synreal::Model const&)+0x5b8>
  13834a:	cmp    $0x2,%eax
  13834d:	je     138448 <synreal::SelfCollision::initialize(synreal::Model const&)+0x588>
  138353:	mov    (%rbx),%eax
  138355:	mov    %rbx,%rdx
  138358:	cmp    %eax,%esi
  13835a:	jl     138365 <synreal::SelfCollision::initialize(synreal::Model const&)+0x4a5>
  13835c:	mov    %rcx,%rax
  13835f:	mov    %rdx,%rcx
  138362:	mov    %rax,%rdx
  138365:	mov    (%rcx),%eax
  138367:	mov    0x8(%rsp),%rsi
  13836c:	mov    %eax,0x190(%rsp)
  138373:	mov    (%rdx),%ecx
  138375:	mov    0x170(%rsp),%rdx
  13837d:	mov    %ecx,0x194(%rsp)
  138384:	test   %rdx,%rdx
  138387:	jne    13839b <synreal::SelfCollision::initialize(synreal::Model const&)+0x4db>
  138389:	jmp    1383c3 <synreal::SelfCollision::initialize(synreal::Model const&)+0x503>
  13838b:	nopl   0x0(%rax,%rax,1)
  138390:	jle    1383a5 <synreal::SelfCollision::initialize(synreal::Model const&)+0x4e5>
  138392:	mov    0x18(%rdx),%rdx
  138396:	test   %rdx,%rdx
  138399:	je     1383b1 <synreal::SelfCollision::initialize(synreal::Model const&)+0x4f1>
  13839b:	cmp    0x20(%rdx),%eax
  13839e:	jne    138390 <synreal::SelfCollision::initialize(synreal::Model const&)+0x4d0>
  1383a0:	cmp    0x24(%rdx),%ecx
  1383a3:	jg     138392 <synreal::SelfCollision::initialize(synreal::Model const&)+0x4d2>
  1383a5:	mov    %rdx,%rsi
  1383a8:	mov    0x10(%rdx),%rdx
  1383ac:	test   %rdx,%rdx
  1383af:	jne    13839b <synreal::SelfCollision::initialize(synreal::Model const&)+0x4db>
  1383b1:	cmp    0x8(%rsp),%rsi
  1383b6:	je     1383c3 <synreal::SelfCollision::initialize(synreal::Model const&)+0x503>
  1383b8:	cmp    0x20(%rsi),%eax
  1383bb:	je     1388a0 <synreal::SelfCollision::initialize(synreal::Model const&)+0x9e0>
  1383c1:	jge    1383e8 <synreal::SelfCollision::initialize(synreal::Model const&)+0x528>
  1383c3:	mov    0x10(%rsp),%rax
  1383c8:	lea    0x110(%rsp),%rdx
  1383d0:	lea    0x160(%rsp),%rdi
  1383d8:	mov    %rax,0x110(%rsp)
  1383e0:	call   137250 <std::_Rb_tree_iterator<std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > > > std::_Rb_tree<std::pair<int, int>, std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > >, std::_Select1st<std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > > >, std::less<std::pair<int, int> >, std::allocator<std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > > > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<std::pair<int, int>&&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > > >, std::piecewise_construct_t const&, std::tuple<std::pair<int, int>&&>&&, std::tuple<>&&) [clone .isra.0]>
  1383e5:	mov    %rax,%rsi
  1383e8:	lea    0x28(%rsi),%rdi
  1383ec:	mov    %r14,%rsi
  1383ef:	cmp    $0x1,%ebp
  1383f2:	je     1383fe <synreal::SelfCollision::initialize(synreal::Model const&)+0x53e>
  1383f4:	cmp    $0x2,%ebp
  1383f7:	mov    %rbx,%rsi
  1383fa:	cmove  %r13,%rsi
  1383fe:	call   6d350 <std::pair<std::_Rb_tree_iterator<int>, bool> std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_insert_unique<int const&>(int const&)@plt>
  138403:	cmp    $0x3,%r12d
  138407:	je     138488 <synreal::SelfCollision::initialize(synreal::Model const&)+0x5c8>
  138409:	mov    %r12d,%ebp
  13840c:	jmp    1382f5 <synreal::SelfCollision::initialize(synreal::Model const&)+0x435>
  138411:	movq   $0x0,0x750(%r15)
  13841c:	mov    0x1c8(%rsp),%rax
  138424:	sub    %fs:0x28,%rax
  13842d:	jne    138ede <synreal::SelfCollision::initialize(synreal::Model const&)+0x101e>
  138433:	add    $0x1d8,%rsp
  13843a:	pop    %rbx
  13843b:	pop    %rbp
  13843c:	pop    %r12
  13843e:	pop    %r13
  138440:	pop    %r14
  138442:	pop    %r15
  138444:	ret    
  138445:	nopl   (%rax)
  138448:	mov    0x8(%rbx),%eax
  13844b:	mov    %r13,%rdx
  13844e:	jmp    138358 <synreal::SelfCollision::initialize(synreal::Model const&)+0x498>
  138453:	nopl   0x0(%rax,%rax,1)
  138458:	mov    0x8(%rbx),%esi
  13845b:	mov    %r13,%rcx
  13845e:	jmp    138326 <synreal::SelfCollision::initialize(synreal::Model const&)+0x466>
  138463:	nopl   0x0(%rax,%rax,1)
  138468:	mov    0x4(%rbx),%esi
  13846b:	mov    %r14,%rcx
  13846e:	jmp    138326 <synreal::SelfCollision::initialize(synreal::Model const&)+0x466>
  138473:	nopl   0x0(%rax,%rax,1)
  138478:	mov    0x4(%rbx),%eax
  13847b:	mov    %r14,%rdx
  13847e:	jmp    138358 <synreal::SelfCollision::initialize(synreal::Model const&)+0x498>
  138483:	nopl   0x0(%rax,%rax,1)
  138488:	add    $0xc,%rbx
  13848c:	cmp    %rbx,0x20(%rsp)
  138491:	jne    138278 <synreal::SelfCollision::initialize(synreal::Model const&)+0x3b8>
  138497:	mov    $0x4,%edi
  13849c:	call   6d150 <operator new(unsigned long)@plt>
  1384a1:	mov    %rax,%r14
  1384a4:	lea    0x4(%rax),%rax
  1384a8:	mov    0xb0(%rsp),%r13
  1384b0:	mov    %rax,0x40(%rsp)
  1384b5:	movq   %r14,%xmm0
  1384ba:	mov    %rax,0x120(%rsp)
  1384c2:	mov    0xb8(%rsp),%rax
  1384ca:	movl   $0x0,(%r14)
  1384d1:	movhps 0x40(%rsp),%xmm0
  1384d6:	mov    %rax,0x58(%rsp)
  1384db:	movaps %xmm0,0x110(%rsp)
  1384e3:	cmp    %r13,%rax
  1384e6:	je     138e5f <synreal::SelfCollision::initialize(synreal::Model const&)+0xf9f>
  1384ec:	lea    0x130(%rsp),%rax
  1384f4:	movq   $0x0,0x30(%rsp)
  1384fd:	movq   $0x0,0x28(%rsp)
  138506:	movq   $0x0,0x38(%rsp)
  13850f:	mov    %rax,0x60(%rsp)
  138514:	nopl   0x0(%rax)
  138518:	movslq 0x8(%r13),%rdx
  13851c:	test   %edx,%edx
  13851e:	js     7cdec <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]>
  138524:	movslq 0xc(%r13),%rax
  138528:	test   %eax,%eax
  13852a:	js     7cdec <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]>
  138530:	mov    0x748(%r15),%rcx
  138537:	cmp    %rcx,%rdx
  13853a:	jae    7cdec <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]>
  138540:	cmp    %rax,%rcx
  138543:	jbe    7cdec <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]>
  138549:	movslq 0x0(%r13),%rdx
  13854d:	cmp    $0xffffffff,%edx
  138550:	jl     7d026 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x23a>
  138556:	movslq 0x4(%r13),%rax
  13855a:	cmp    $0xffffffff,%eax
  13855d:	jl     7d026 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x23a>
  138563:	cmp    $0xffffffff,%edx
  138566:	je     138571 <synreal::SelfCollision::initialize(synreal::Model const&)+0x6b1>
  138568:	cmp    %rdx,%rcx
  13856b:	jbe    7d026 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x23a>
  138571:	cmp    $0xffffffff,%eax
  138574:	je     13857f <synreal::SelfCollision::initialize(synreal::Model const&)+0x6bf>
  138576:	cmp    %rax,%rcx
  138579:	jbe    7d026 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x23a>
  13857f:	mov    0x60(%rsp),%r14
  138584:	lea    0x8(%r13),%rbx
  138588:	mov    %rbx,%rsi
  13858b:	mov    %r14,%rdi
  13858e:	call   6d350 <std::pair<std::_Rb_tree_iterator<int>, bool> std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_insert_unique<int const&>(int const&)@plt>
  138593:	lea    0xc(%r13),%rbp
  138597:	mov    %r14,%rdi
  13859a:	mov    %rbp,%rsi
  13859d:	call   6d350 <std::pair<std::_Rb_tree_iterator<int>, bool> std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_insert_unique<int const&>(int const&)@plt>
  1385a2:	mov    0x8(%r13),%eax
  1385a6:	cmp    %eax,0xc(%r13)
  1385aa:	jl     1385b5 <synreal::SelfCollision::initialize(synreal::Model const&)+0x6f5>
  1385ac:	mov    %rbp,%rax
  1385af:	mov    %rbx,%rbp
  1385b2:	mov    %rax,%rbx
  1385b5:	mov    0x0(%rbp),%edx
  1385b8:	mov    0x170(%rsp),%rax
  1385c0:	mov    0x8(%rsp),%rbp
  1385c5:	mov    %edx,0x190(%rsp)
  1385cc:	mov    (%rbx),%ecx
  1385ce:	mov    %ecx,0x194(%rsp)
  1385d5:	test   %rax,%rax
  1385d8:	jne    1385eb <synreal::SelfCollision::initialize(synreal::Model const&)+0x72b>
  1385da:	jmp    138613 <synreal::SelfCollision::initialize(synreal::Model const&)+0x753>
  1385dc:	nopl   0x0(%rax)
  1385e0:	jle    1385f5 <synreal::SelfCollision::initialize(synreal::Model const&)+0x735>
  1385e2:	mov    0x18(%rax),%rax
  1385e6:	test   %rax,%rax
  1385e9:	je     138601 <synreal::SelfCollision::initialize(synreal::Model const&)+0x741>
  1385eb:	cmp    0x20(%rax),%edx
  1385ee:	jne    1385e0 <synreal::SelfCollision::initialize(synreal::Model const&)+0x720>
  1385f0:	cmp    0x24(%rax),%ecx
  1385f3:	jg     1385e2 <synreal::SelfCollision::initialize(synreal::Model const&)+0x722>
  1385f5:	mov    %rax,%rbp
  1385f8:	mov    0x10(%rax),%rax
  1385fc:	test   %rax,%rax
  1385ff:	jne    1385eb <synreal::SelfCollision::initialize(synreal::Model const&)+0x72b>
  138601:	cmp    0x8(%rsp),%rbp
  138606:	je     138613 <synreal::SelfCollision::initialize(synreal::Model const&)+0x753>
  138608:	cmp    0x20(%rbp),%edx
  13860b:	je     138cd1 <synreal::SelfCollision::initialize(synreal::Model const&)+0xe11>
  138611:	jge    13863b <synreal::SelfCollision::initialize(synreal::Model const&)+0x77b>
  138613:	mov    0x10(%rsp),%rax
  138618:	lea    0x88(%rsp),%rdx
  138620:	lea    0x160(%rsp),%rdi
  138628:	mov    %rbp,%rsi
  13862b:	mov    %rax,0x88(%rsp)
  138633:	call   137250 <std::_Rb_tree_iterator<std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > > > std::_Rb_tree<std::pair<int, int>, std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > >, std::_Select1st<std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > > >, std::less<std::pair<int, int> >, std::allocator<std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > > > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<std::pair<int, int>&&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > > >, std::piecewise_construct_t const&, std::tuple<std::pair<int, int>&&>&&, std::tuple<>&&) [clone .isra.0]>
  138638:	mov    %rax,%rbp
  13863b:	mov    0x0(%r13),%edx
  13863f:	test   %edx,%edx
  138641:	jns    138cc0 <synreal::SelfCollision::initialize(synreal::Model const&)+0xe00>
  138647:	mov    0x4(%r13),%eax
  13864b:	test   %eax,%eax
  13864d:	js     13865c <synreal::SelfCollision::initialize(synreal::Model const&)+0x79c>
  13864f:	lea    0x4(%r13),%rsi
  138653:	lea    0x28(%rbp),%rdi
  138657:	call   6d350 <std::pair<std::_Rb_tree_iterator<int>, bool> std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_insert_unique<int const&>(int const&)@plt>
  13865c:	mov    0x38(%rsp),%rbx
  138661:	mov    0x28(%rsp),%rax
  138666:	lea    0x30(%rbp),%r14
  13866a:	mov    0x40(%rbp),%r12
  13866e:	sub    %rbx,%rax
  138671:	mov    %rax,0x20(%rsp)
  138676:	mov    0x30(%rsp),%rax
  13867b:	sub    %rbx,%rax
  13867e:	mov    %rax,0x48(%rsp)
  138683:	cmp    %r14,%r12
  138686:	je     1386f1 <synreal::SelfCollision::initialize(synreal::Model const&)+0x831>
  138688:	xor    %ebx,%ebx
  13868a:	mov    %r12,%rdi
  13868d:	nopl   (%rax)
  138690:	call   6d750 <std::_Rb_tree_increment(std::_Rb_tree_node_base const*)@plt>
  138695:	add    $0x1,%rbx
  138699:	mov    %rax,%rdi
  13869c:	cmp    %rax,%r14
  13869f:	jne    138690 <synreal::SelfCollision::initialize(synreal::Model const&)+0x7d0>
  1386a1:	mov    0x28(%rsp),%r14
  1386a6:	mov    %rax,%rbp
  1386a9:	mov    0x30(%rsp),%rax
  1386ae:	sub    %r14,%rax
  1386b1:	sar    $0x2,%rax
  1386b5:	cmp    %rax,%rbx
  1386b8:	ja     138cdf <synreal::SelfCollision::initialize(synreal::Model const&)+0xe1f>
  1386be:	mov    %r12,%rdi
  1386c1:	mov    0x20(%rdi),%eax
  1386c4:	add    $0x4,%r14
  1386c8:	mov    %eax,-0x4(%r14)
  1386cc:	call   6d750 <std::_Rb_tree_increment(std::_Rb_tree_node_base const*)@plt>
  1386d1:	mov    %rax,%rdi
  1386d4:	cmp    %rax,%rbp
  1386d7:	jne    1386c1 <synreal::SelfCollision::initialize(synreal::Model const&)+0x801>
  1386d9:	mov    0x28(%rsp),%rax
  1386de:	lea    (%rax,%rbx,4),%rax
  1386e2:	mov    %rax,0x28(%rsp)
  1386e7:	sub    0x38(%rsp),%rax
  1386ec:	mov    %rax,0x20(%rsp)
  1386f1:	movabs $0x1fffffffc,%rbx
  1386fb:	mov    0x20(%rsp),%rax
  138700:	mov    %rax,%rdx
  138703:	sar    $0x2,%rdx
  138707:	cmp    %rbx,%rax
  13870a:	ja     7d19f <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x3b3>
  138710:	mov    %edx,0x190(%rsp)
  138717:	mov    0x118(%rsp),%rax
  13871f:	cmp    %rax,0x40(%rsp)
  138724:	je     138da1 <synreal::SelfCollision::initialize(synreal::Model const&)+0xee1>
  13872a:	mov    %edx,(%rax)
  13872c:	add    $0x4,%rax
  138730:	mov    %rax,0x118(%rsp)
  138738:	add    $0x10,%r13
  13873c:	cmp    %r13,0x58(%rsp)
  138741:	jne    138518 <synreal::SelfCollision::initialize(synreal::Model const&)+0x658>
  138747:	mov    0x110(%rsp),%r14
  13874f:	mov    0x40(%rsp),%r13
  138754:	mov    0x118(%rsp),%rdx
  13875c:	sub    %r14,%r13
  13875f:	lea    0xda8(%r15),%rdi
  138766:	mov    %r14,%rsi
  138769:	call   1374a0 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::range_assign<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > > >(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  13876e:	mov    0x28(%rsp),%rdx
  138773:	mov    0x38(%rsp),%rsi
  138778:	lea    0xdc8(%r15),%rdi
  13877f:	call   1374a0 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::range_assign<__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > > >(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, __gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, thrust::THRUST_200302_520_NS::random_access_traversal_tag) [clone .isra.0]>
  138784:	mov    0xd0(%rsp),%rbx
  13878c:	mov    0xd8(%rsp),%rbp
  138794:	lea    0x198(%rsp),%rax
  13879c:	movl   $0x0,0x198(%rsp)
  1387a7:	movq   $0x0,0x1a0(%rsp)
  1387b3:	mov    %rax,0x1a8(%rsp)
  1387bb:	mov    %rax,0x1b0(%rsp)
  1387c3:	movq   $0x0,0x1b8(%rsp)
  1387cf:	cmp    %rbx,%rbp
  1387d2:	je     1388d0 <synreal::SelfCollision::initialize(synreal::Model const&)+0xa10>
  1387d8:	lea    0x88(%rsp),%r12
  1387e0:	movslq (%rbx),%rax
  1387e3:	mov    %eax,0x88(%rsp)
  1387ea:	test   %eax,%eax
  1387ec:	js     7d28b <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x49f>
  1387f2:	cmp    0x748(%r15),%rax
  1387f9:	jae    7d28b <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x49f>
  1387ff:	mov    0x10(%rsp),%rdi
  138804:	mov    %r12,%rsi
  138807:	call   6d350 <std::pair<std::_Rb_tree_iterator<int>, bool> std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_insert_unique<int const&>(int const&)@plt>
  13880c:	test   %dl,%dl
  13880e:	je     7d203 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x417>
  138814:	movslq 0x88(%rsp),%rdx
  13881c:	mov    0xf0(%rsp),%rax
  138824:	pxor   %xmm1,%xmm1
  138828:	movss  (%rax,%rdx,4),%xmm0
  13882d:	mov    %rdx,%rsi
  138830:	comiss %xmm1,%xmm0
  138833:	jbe    7d1d1 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x3e5>
  138839:	andps  0xb6f60(%rip),%xmm0        # 1ef7a0 <std::_Sp_make_shared_tag::_S_ti()::__tag+0x50>
  138840:	movss  0xb6f44(%rip),%xmm2        # 1ef78c <std::_Sp_make_shared_tag::_S_ti()::__tag+0x3c>
  138848:	ucomiss %xmm0,%xmm2
  13884b:	jb     7d1d1 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x3e5>
  138851:	mov    0x140(%rsp),%rax
  138859:	mov    0x18(%rsp),%rdi
  13885e:	test   %rax,%rax
  138861:	je     1388c3 <synreal::SelfCollision::initialize(synreal::Model const&)+0xa03>
  138863:	nopl   0x0(%rax,%rax,1)
  138868:	mov    0x10(%rax),%rcx
  13886c:	mov    0x18(%rax),%rdx
  138870:	cmp    0x20(%rax),%esi
  138873:	jle    13888a <synreal::SelfCollision::initialize(synreal::Model const&)+0x9ca>
  138875:	test   %rdx,%rdx
  138878:	je     1388b0 <synreal::SelfCollision::initialize(synreal::Model const&)+0x9f0>
  13887a:	mov    %rdx,%rax
  13887d:	mov    0x10(%rax),%rcx
  138881:	mov    0x18(%rax),%rdx
  138885:	cmp    0x20(%rax),%esi
  138888:	jg     138875 <synreal::SelfCollision::initialize(synreal::Model const&)+0x9b5>
  13888a:	test   %rcx,%rcx
  13888d:	je     1388b3 <synreal::SelfCollision::initialize(synreal::Model const&)+0x9f3>
  13888f:	mov    %rax,%rdi
  138892:	mov    %rcx,%rax
  138895:	jmp    138868 <synreal::SelfCollision::initialize(synreal::Model const&)+0x9a8>
  138897:	nopw   0x0(%rax,%rax,1)
  1388a0:	cmp    0x24(%rsi),%ecx
  1388a3:	jge    1383e8 <synreal::SelfCollision::initialize(synreal::Model const&)+0x528>
  1388a9:	jmp    1383c3 <synreal::SelfCollision::initialize(synreal::Model const&)+0x503>
  1388ae:	xchg   %ax,%ax
  1388b0:	mov    %rdi,%rax
  1388b3:	cmp    0x18(%rsp),%rax
  1388b8:	je     1388c3 <synreal::SelfCollision::initialize(synreal::Model const&)+0xa03>
  1388ba:	cmp    0x20(%rax),%esi
  1388bd:	jge    7ce8c <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0xa0>
  1388c3:	add    $0x4,%rbx
  1388c7:	cmp    %rbx,%rbp
  1388ca:	jne    1387e0 <synreal::SelfCollision::initialize(synreal::Model const&)+0x920>
  1388d0:	mov    0x148(%rsp),%rbp
  1388d8:	mov    0xc30(%r15),%r12
  1388df:	cmp    0x18(%rsp),%rbp
  1388e4:	je     138e93 <synreal::SelfCollision::initialize(synreal::Model const&)+0xfd3>
  1388ea:	mov    %r12,%rdx
  1388ed:	jmp    138946 <synreal::SelfCollision::initialize(synreal::Model const&)+0xa86>
  1388ef:	nop
  1388f0:	lea    0x20(%rbp),%rsi
  1388f4:	mov    $0x1,%r8d
  1388fa:	mov    $0x1,%ecx
  1388ff:	mov    %r12,%rdi
  138902:	mov    $0x4,%edx
  138907:	call   6e0b0 <cudaMemcpyAsync@plt>
  13890c:	mov    $0x1,%edi
  138911:	mov    %eax,%ebx
  138913:	call   6d140 <cudaStreamSynchronize@plt>
  138918:	call   6c890 <cudaGetLastError@plt>
  13891d:	test   %ebx,%ebx
  13891f:	jne    7ce1e <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x32>
  138925:	mov    %rbp,%rdi
  138928:	add    $0x4,%r12
  13892c:	call   6d750 <std::_Rb_tree_increment(std::_Rb_tree_node_base const*)@plt>
  138931:	mov    %rax,%rbp
  138934:	cmp    0x18(%rsp),%rax
  138939:	je     138e17 <synreal::SelfCollision::initialize(synreal::Model const&)+0xf57>
  13893f:	mov    0xc30(%r15),%rdx
  138946:	mov    0xc40(%r15),%rax
  13894d:	lea    (%rdx,%rax,4),%rax
  138951:	cmp    %rax,%r12
  138954:	jne    1388f0 <synreal::SelfCollision::initialize(synreal::Model const&)+0xa30>
  138956:	mov    0x18(%rsp),%rcx
  13895b:	lea    0xc28(%r15),%rdi
  138962:	mov    %rbp,%rdx
  138965:	mov    %r12,%rsi
  138968:	call   6f520 <void thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::copy_insert<std::_Rb_tree_const_iterator<int> >(thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<int> >, std::_Rb_tree_const_iterator<int>, std::_Rb_tree_const_iterator<int>)@plt>
  13896d:	mov    0xc40(%r15),%rsi
  138974:	mov    0x750(%r15),%rax
  13897b:	mov    0x900(%r15),%rdx
  138982:	lea    0xc48(%r15),%rdi
  138989:	imul   %rax,%rdx
  13898d:	imul   %rax,%rsi
  138991:	mov    %rdx,0x758(%r15)
  138998:	mov    0xa90(%r15),%rdx
  13899f:	mov    %rsi,0x768(%r15)
  1389a6:	imul   %rax,%rdx
  1389aa:	imul   0xc20(%r15),%rax
  1389b2:	mov    %rdx,0x760(%r15)
  1389b9:	mov    %rax,0x770(%r15)
  1389c0:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  1389c5:	mov    0x768(%r15),%rax
  1389cc:	lea    0xc68(%r15),%rdi
  1389d3:	mov    %rax,%rsi
  1389d6:	shl    $0x5,%rsi
  1389da:	sub    %rax,%rsi
  1389dd:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  1389e2:	mov    0x770(%r15),%rsi
  1389e9:	lea    0xc88(%r15),%rdi
  1389f0:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  1389f5:	mov    0x770(%r15),%rax
  1389fc:	lea    0xca8(%r15),%rdi
  138a03:	mov    %rax,%rsi
  138a06:	shl    $0x5,%rsi
  138a0a:	sub    %rax,%rsi
  138a0d:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  138a12:	mov    0x770(%r15),%rsi
  138a19:	lea    0xcc8(%r15),%rdi
  138a20:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  138a25:	mov    0x770(%r15),%rax
  138a2c:	lea    0xce8(%r15),%rdi
  138a33:	mov    %rax,%rsi
  138a36:	shl    $0x5,%rsi
  138a3a:	sub    %rax,%rsi
  138a3d:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  138a42:	mov    0x760(%r15),%rsi
  138a49:	lea    0xd28(%r15),%rdi
  138a50:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  138a55:	mov    0x760(%r15),%rax
  138a5c:	lea    0xd48(%r15),%rdi
  138a63:	mov    %rax,%rsi
  138a66:	shl    $0x5,%rsi
  138a6a:	sub    %rax,%rsi
  138a6d:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  138a72:	mov    0x760(%r15),%rsi
  138a79:	lea    0xd68(%r15),%rdi
  138a80:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  138a85:	mov    0x760(%r15),%rax
  138a8c:	lea    0xd88(%r15),%rdi
  138a93:	mov    %rax,%rsi
  138a96:	shl    $0x5,%rsi
  138a9a:	sub    %rax,%rsi
  138a9d:	call   6be90 <thrust::THRUST_200302_520_NS::detail::vector_base<int, thrust::THRUST_200302_520_NS::device_allocator<int> >::resize(unsigned long)@plt>
  138aa2:	mov    0xe00(%r15),%rax
  138aa9:	mov    0x70(%rsp),%rbx
  138aae:	cmp    %rbx,%rax
  138ab1:	jbe    138e00 <synreal::SelfCollision::initialize(synreal::Model const&)+0xf40>
  138ab7:	mov    0xdf0(%r15),%rdx
  138abe:	lea    (%rbx,%rbx,8),%rbp
  138ac2:	lea    (%rax,%rax,8),%rbx
  138ac6:	shl    $0x2,%rbx
  138aca:	shl    $0x2,%rbp
  138ace:	lea    0x86(%rsp),%rdi
  138ad6:	lea    (%rdx,%rbx,1),%rsi
  138ada:	lea    (%rdx,%rbp,1),%rcx
  138ade:	mov    %rsi,%rdx
  138ae1:	call   6b020 <thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > > thrust::THRUST_200302_520_NS::detail::dispatch::overlapped_copy<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > > >(thrust::THRUST_200302_520_NS::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<glm::mat<3, 3, float, (glm::qualifier)0> > >)@plt>
  138ae6:	movabs $0x8e38e38e38e38e39,%rdx
  138af0:	mov    %rbx,%rax
  138af3:	sub    %rbp,%rax
  138af6:	sar    $0x2,%rax
  138afa:	imul   %rdx,%rax
  138afe:	sub    %rax,0xe00(%r15)
  138b05:	mov    0x900(%r15),%rax
  138b0c:	test   %rax,%rax
  138b0f:	je     138b26 <synreal::SelfCollision::initialize(synreal::Model const&)+0xc66>
  138b11:	mov    0xc80(%r15),%rax
  138b18:	add    0xcc0(%r15),%rax
  138b1f:	add    0xda0(%r15),%rax
  138b26:	cmpq   $0x1,0xa90(%r15)
  138b2e:	jbe    138b37 <synreal::SelfCollision::initialize(synreal::Model const&)+0xc77>
  138b30:	add    0xd60(%r15),%rax
  138b37:	cmpq   $0x1,0xc20(%r15)
  138b3f:	jbe    138b48 <synreal::SelfCollision::initialize(synreal::Model const&)+0xc88>
  138b41:	add    0xd00(%r15),%rax
  138b48:	mov    %rax,%rbx
  138b4b:	shr    $0x20,%rbx
  138b4f:	jne    7cfcb <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x1df>
  138b55:	mov    0xe30(%r15),%rbx
  138b5c:	mov    %rax,0xe10(%r15)
  138b63:	cmp    $0x1,%rbx
  138b67:	jbe    138de7 <synreal::SelfCollision::initialize(synreal::Model const&)+0xf27>
  138b6d:	mov    0xe20(%r15),%rax
  138b74:	shl    $0x2,%rbx
  138b78:	lea    0x87(%rsp),%rdi
  138b80:	lea    (%rax,%rbx,1),%rsi
  138b84:	lea    0x4(%rax),%rcx
  138b88:	mov    %rsi,%rdx
  138b8b:	call   6d0d0 <thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<unsigned int> > thrust::THRUST_200302_520_NS::detail::dispatch::overlapped_copy<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<unsigned int> >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<unsigned int> > >(thrust::THRUST_200302_520_NS::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<unsigned int> >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<unsigned int> >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<unsigned int> >)@plt>
  138b90:	lea    -0x4(%rbx),%rax
  138b94:	sar    $0x2,%rax
  138b98:	sub    %rax,0xe30(%r15)
  138b9f:	mov    0x50(%rsp),%rax
  138ba4:	mov    0x70(%rsp),%rbx
  138ba9:	xor    %esi,%esi
  138bab:	cmp    %rbx,0xa0(%rax)
  138bb2:	jb     138bbb <synreal::SelfCollision::initialize(synreal::Model const&)+0xcfb>
  138bb4:	mov    0x98(%rax),%rsi
  138bbb:	mov    %r15,%rdi
  138bbe:	call   6d3f0 <synreal::SelfCollision::build_bvhs(glm::vec<3, float, (glm::qualifier)0> const*)@plt>
  138bc3:	mov    0x1a0(%rsp),%rdi
  138bcb:	call   133730 <std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_erase(std::_Rb_tree_node<int>*) [clone .isra.0]>
  138bd0:	mov    0x38(%rsp),%rax
  138bd5:	test   %rax,%rax
  138bd8:	je     138be7 <synreal::SelfCollision::initialize(synreal::Model const&)+0xd27>
  138bda:	mov    0x48(%rsp),%rsi
  138bdf:	mov    %rax,%rdi
  138be2:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  138be7:	test   %r14,%r14
  138bea:	je     138bf7 <synreal::SelfCollision::initialize(synreal::Model const&)+0xd37>
  138bec:	mov    %r13,%rsi
  138bef:	mov    %r14,%rdi
  138bf2:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  138bf7:	mov    0x170(%rsp),%rdi
  138bff:	call   133900 <std::_Rb_tree<std::pair<int, int>, std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > >, std::_Select1st<std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > > >, std::less<std::pair<int, int> >, std::allocator<std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > > > >::_M_erase(std::_Rb_tree_node<std::pair<std::pair<int, int> const, std::set<int, std::less<int>, std::allocator<int> > > >*) [clone .isra.0]>
  138c04:	mov    0x140(%rsp),%rdi
  138c0c:	call   133730 <std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_erase(std::_Rb_tree_node<int>*) [clone .isra.0]>
  138c11:	mov    0xf0(%rsp),%rdi
  138c19:	test   %rdi,%rdi
  138c1c:	je     138c2e <synreal::SelfCollision::initialize(synreal::Model const&)+0xd6e>
  138c1e:	mov    0x100(%rsp),%rsi
  138c26:	sub    %rdi,%rsi
  138c29:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  138c2e:	mov    0xd0(%rsp),%rdi
  138c36:	test   %rdi,%rdi
  138c39:	je     138c4b <synreal::SelfCollision::initialize(synreal::Model const&)+0xd8b>
  138c3b:	mov    0xe0(%rsp),%rsi
  138c43:	sub    %rdi,%rsi
  138c46:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  138c4b:	mov    0xb0(%rsp),%rdi
  138c53:	test   %rdi,%rdi
  138c56:	je     138c68 <synreal::SelfCollision::initialize(synreal::Model const&)+0xda8>
  138c58:	mov    0xc0(%rsp),%rsi
  138c60:	sub    %rdi,%rsi
  138c63:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  138c68:	mov    0x90(%rsp),%rdi
  138c70:	test   %rdi,%rdi
  138c73:	je     138c85 <synreal::SelfCollision::initialize(synreal::Model const&)+0xdc5>
  138c75:	mov    0xa0(%rsp),%rsi
  138c7d:	sub    %rdi,%rsi
  138c80:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  138c85:	mov    0x1c8(%rsp),%rax
  138c8d:	sub    %fs:0x28,%rax
  138c96:	jne    138ede <synreal::SelfCollision::initialize(synreal::Model const&)+0x101e>
  138c9c:	mov    0x78(%rsp),%rsi
  138ca1:	mov    0x68(%rsp),%rdi
  138ca6:	add    $0x1d8,%rsp
  138cad:	pop    %rbx
  138cae:	pop    %rbp
  138caf:	pop    %r12
  138cb1:	pop    %r13
  138cb3:	pop    %r14
  138cb5:	pop    %r15
  138cb7:	jmp    6d1b0 <operator delete(void*, unsigned long)@plt>
  138cbc:	nopl   0x0(%rax)
  138cc0:	lea    0x28(%rbp),%rdi
  138cc4:	mov    %r13,%rsi
  138cc7:	call   6d350 <std::pair<std::_Rb_tree_iterator<int>, bool> std::_Rb_tree<int, int, std::_Identity<int>, std::less<int>, std::allocator<int> >::_M_insert_unique<int const&>(int const&)@plt>
  138ccc:	jmp    138647 <synreal::SelfCollision::initialize(synreal::Model const&)+0x787>
  138cd1:	cmp    0x24(%rbp),%ecx
  138cd4:	jge    13863b <synreal::SelfCollision::initialize(synreal::Model const&)+0x77b>
  138cda:	jmp    138613 <synreal::SelfCollision::initialize(synreal::Model const&)+0x753>
  138cdf:	movabs $0x1fffffffffffffff,%rdx
  138ce9:	mov    0x20(%rsp),%rax
  138cee:	sar    $0x2,%rax
  138cf2:	sub    %rax,%rdx
  138cf5:	cmp    %rdx,%rbx
  138cf8:	ja     138ed2 <synreal::SelfCollision::initialize(synreal::Model const&)+0x1012>
  138cfe:	cmp    %rax,%rbx
  138d01:	cmovb  %rax,%rbx
  138d05:	add    %rax,%rbx
  138d08:	jb     138ec6 <synreal::SelfCollision::initialize(synreal::Model const&)+0x1006>
  138d0e:	test   %rbx,%rbx
  138d11:	jne    138e98 <synreal::SelfCollision::initialize(synreal::Model const&)+0xfd8>
  138d17:	movq   $0x0,0x30(%rsp)
  138d20:	xor    %ebx,%ebx
  138d22:	xor    %r14d,%r14d
  138d25:	mov    0x38(%rsp),%rax
  138d2a:	cmp    %rax,0x28(%rsp)
  138d2f:	je     138d41 <synreal::SelfCollision::initialize(synreal::Model const&)+0xe81>
  138d31:	mov    0x20(%rsp),%rdx
  138d36:	mov    %rax,%rsi
  138d39:	mov    %r14,%rdi
  138d3c:	call   6e920 <memmove@plt>
  138d41:	mov    0x20(%rsp),%rax
  138d46:	mov    %r12,%rdi
  138d49:	add    %r14,%rax
  138d4c:	mov    %rax,%r12
  138d4f:	nop
  138d50:	mov    0x20(%rdi),%eax
  138d53:	add    $0x4,%r12
  138d57:	mov    %eax,-0x4(%r12)
  138d5c:	call   6d750 <std::_Rb_tree_increment(std::_Rb_tree_node_base const*)@plt>
  138d61:	mov    %rax,%rdi
  138d64:	cmp    %rax,%rbp
  138d67:	jne    138d50 <synreal::SelfCollision::initialize(synreal::Model const&)+0xe90>
  138d69:	mov    0x38(%rsp),%rax
  138d6e:	mov    %r12,0x28(%rsp)
  138d73:	test   %rax,%rax
  138d76:	je     138d85 <synreal::SelfCollision::initialize(synreal::Model const&)+0xec5>
  138d78:	mov    0x48(%rsp),%rsi
  138d7d:	mov    %rax,%rdi
  138d80:	call   6d1b0 <operator delete(void*, unsigned long)@plt>
  138d85:	mov    0x28(%rsp),%rax
  138d8a:	mov    %rbx,0x48(%rsp)
  138d8f:	mov    %r14,0x38(%rsp)
  138d94:	sub    %r14,%rax
  138d97:	mov    %rax,0x20(%rsp)
  138d9c:	jmp    1386f1 <synreal::SelfCollision::initialize(synreal::Model const&)+0x831>
  138da1:	mov    0x10(%rsp),%rdx
  138da6:	mov    0x40(%rsp),%rsi
  138dab:	lea    0x110(%rsp),%rdi
  138db3:	call   6e740 <void std::vector<int, std::allocator<int> >::_M_realloc_insert<int>(__gnu_cxx::__normal_iterator<int*, std::vector<int, std::allocator<int> > >, int&&)@plt>
  138db8:	mov    0x120(%rsp),%rax
  138dc0:	mov    %rax,0x40(%rsp)
  138dc5:	jmp    138738 <synreal::SelfCollision::initialize(synreal::Model const&)+0x878>
  138dca:	movq   $0x0,0x100(%rsp)
  138dd6:	pxor   %xmm0,%xmm0
  138dda:	movaps %xmm0,0xf0(%rsp)
  138de2:	jmp    1381d6 <synreal::SelfCollision::initialize(synreal::Model const&)+0x316>
  138de7:	mov    $0x1,%esi
  138dec:	lea    0xe18(%r15),%rdi
  138df3:	sub    %rbx,%rsi
  138df6:	call   6da30 <thrust::THRUST_200302_520_NS::detail::vector_base<unsigned int, thrust::THRUST_200302_520_NS::device_allocator<unsigned int> >::append(unsigned long)@plt>
  138dfb:	jmp    138b9f <synreal::SelfCollision::initialize(synreal::Model const&)+0xcdf>
  138e00:	mov    %rbx,%rsi
  138e03:	lea    0xde8(%r15),%rdi
  138e0a:	sub    %rax,%rsi
  138e0d:	call   6e4f0 <thrust::THRUST_200302_520_NS::detail::vector_base<glm::mat<3, 3, float, (glm::qualifier)0>, thrust::THRUST_200302_520_NS::device_allocator<glm::mat<3, 3, float, (glm::qualifier)0> > >::append(unsigned long)@plt>
  138e12:	jmp    138b05 <synreal::SelfCollision::initialize(synreal::Model const&)+0xc45>
  138e17:	mov    0xc30(%r15),%rax
  138e1e:	mov    0xc40(%r15),%rdx
  138e25:	lea    0x85(%rsp),%rdi
  138e2d:	mov    %r12,%rcx
  138e30:	lea    (%rax,%rdx,4),%rbx
  138e34:	mov    %rbx,%rdx
  138e37:	mov    %rbx,%rsi
  138e3a:	call   6d700 <thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<int> > thrust::THRUST_200302_520_NS::detail::dispatch::overlapped_copy<thrust::THRUST_200302_520_NS::cuda_cub::tag, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<int> >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<int> > >(thrust::THRUST_200302_520_NS::execution_policy<thrust::THRUST_200302_520_NS::cuda_cub::tag>&, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<int> >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<int> >, thrust::THRUST_200302_520_NS::detail::normal_iterator<thrust::THRUST_200302_520_NS::device_ptr<int> >)@plt>
  138e3f:	mov    %rbx,%rax
  138e42:	mov    0xc40(%r15),%rsi
  138e49:	sub    %r12,%rax
  138e4c:	sar    $0x2,%rax
  138e50:	sub    %rax,%rsi
  138e53:	mov    %rsi,0xc40(%r15)
  138e5a:	jmp    138974 <synreal::SelfCollision::initialize(synreal::Model const&)+0xab4>
  138e5f:	movq   $0x0,0x48(%rsp)
  138e68:	mov    0x40(%rsp),%rdx
  138e6d:	mov    $0x4,%r13d
  138e73:	movq   $0x0,0x30(%rsp)
  138e7c:	movq   $0x0,0x28(%rsp)
  138e85:	movq   $0x0,0x38(%rsp)
  138e8e:	jmp    13875f <synreal::SelfCollision::initialize(synreal::Model const&)+0x89f>
  138e93:	mov    %r12,%rax
  138e96:	jmp    138e1e <synreal::SelfCollision::initialize(synreal::Model const&)+0xf5e>
  138e98:	movabs $0x1fffffffffffffff,%rax
  138ea2:	cmp    %rax,%rbx
  138ea5:	cmova  %rax,%rbx
  138ea9:	shl    $0x2,%rbx
  138ead:	mov    %rbx,%rdi
  138eb0:	call   6d150 <operator new(unsigned long)@plt>
  138eb5:	mov    %rax,%r14
  138eb8:	lea    (%rax,%rbx,1),%rax
  138ebc:	mov    %rax,0x30(%rsp)
  138ec1:	jmp    138d25 <synreal::SelfCollision::initialize(synreal::Model const&)+0xe65>
  138ec6:	movabs $0x7ffffffffffffffc,%rbx
  138ed0:	jmp    138ead <synreal::SelfCollision::initialize(synreal::Model const&)+0xfed>
  138ed2:	lea    0xbe733(%rip),%rdi        # 1f760c <typeinfo name for std::_Sp_counted_ptr_inplace<synreal::SolverNewton, std::allocator<synreal::SolverNewton>, (__gnu_cxx::_Lock_policy)2>+0x770c>
  138ed9:	call   6c070 <std::__throw_length_error(char const*)@plt>
  138ede:	call   6d5c0 <__stack_chk_fail@plt>
  138ee3:	endbr64 
  138ee7:	mov    %rax,%rbp
  138eea:	jmp    7cfab <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x1bf>
  138eef:	endbr64 
  138ef3:	jmp    7d00a <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x21e>
  138ef8:	endbr64 
  138efc:	jmp    7cec2 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0xd6>
  138f01:	endbr64 
  138f05:	mov    %rax,%rbx
  138f08:	jmp    7cf51 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x165>
  138f0d:	endbr64 
  138f11:	jmp    7d136 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x34a>
  138f16:	endbr64 
  138f1a:	mov    %rax,%rbp
  138f1d:	jmp    7cf8e <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x1a2>
  138f22:	endbr64 
  138f26:	mov    %rax,%rbp
  138f29:	jmp    7cf71 <synreal::SelfCollision::initialize(synreal::Model const&) [clone .cold]+0x185>
