
../_core.cpython-312-x86_64-linux-gnu.so：     文件格式 elf64-x86-64


Disassembly of section .text:

00000000000f1550 <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)>:
   f1550:	endbr64 
   f1554:	push   %rbp
   f1555:	lea    0x7d8(%rdi),%r10
   f155c:	mov    %rsp,%rbp
   f155f:	push   %r15
   f1561:	mov    %rcx,%r15
   f1564:	push   %r14
   f1566:	mov    %rdx,%r14
   f1569:	push   %r13
   f156b:	push   %r12
   f156d:	mov    %r8,%r12
   f1570:	push   %rbx
   f1571:	mov    %rdi,%rbx
   f1574:	sub    $0x78,%rsp
   f1578:	mov    %rsi,-0x88(%rbp)
   f157f:	mov    0x10(%rbp),%r8
   f1583:	mov    0x18(%rbp),%rcx
   f1587:	mov    %fs:0x28,%rax
   f1590:	mov    %rax,-0x38(%rbp)
   f1594:	xor    %eax,%eax
   f1596:	test   %r9b,%r9b
   f1599:	jne    f1670 <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)+0x120>
   f159f:	mov    0x24(%rdi),%r8d
   f15a3:	sub    $0x8,%rsp
   f15a7:	lea    -0x60(%rbp),%r13
   f15ab:	pxor   %xmm0,%xmm0
   f15af:	mov    0x3050(%rdi),%rsi
   f15b6:	mov    0x2f50(%rbx),%rax
   f15bd:	xor    %r9d,%r9d
   f15c0:	mov    %r10,%rdi
   f15c3:	mov    0x2f10(%rbx),%r11
   f15ca:	lea    -0x80(%rbp),%rbx
   f15ce:	push   %r13
   f15d0:	push   %rcx
   f15d1:	mov    %r12,%rcx
   f15d4:	push   %rbx
   f15d5:	mov    %r11,%rdx
   f15d8:	push   %r8
   f15da:	xor    %r8d,%r8d
   f15dd:	push   %r12
   f15df:	push   %r12
   f15e1:	push   %rsi
   f15e2:	mov    -0x88(%rbp),%rsi
   f15e9:	push   %r12
   f15eb:	push   %rax
   f15ec:	push   %r15
   f15ee:	push   %r14
   f15f0:	movq   $0x0,-0x50(%rbp)
   f15f8:	movq   $0x0,-0x48(%rbp)
   f1600:	movq   $0x0,-0x70(%rbp)
   f1608:	movq   $0x0,-0x68(%rbp)
   f1610:	movaps %xmm0,-0x60(%rbp)
   f1614:	movaps %xmm0,-0x80(%rbp)
   f1618:	call   6dcc0 <synreal::PcgSolver::solve(synreal::SparseMatrixELL const&, synreal::Span<float const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<float const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >, unsigned long, int, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&)@plt>
   f161d:	mov    -0x70(%rbp),%rax
   f1621:	add    $0x60,%rsp
   f1625:	test   %rax,%rax
   f1628:	je     f1637 <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)+0xe7>
   f162a:	mov    $0x3,%edx
   f162f:	mov    %rbx,%rsi
   f1632:	mov    %rbx,%rdi
   f1635:	call   *%rax
   f1637:	mov    -0x50(%rbp),%rax
   f163b:	test   %rax,%rax
   f163e:	je     f164d <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)+0xfd>
   f1640:	mov    $0x3,%edx
   f1645:	mov    %r13,%rsi
   f1648:	mov    %r13,%rdi
   f164b:	call   *%rax
   f164d:	mov    -0x38(%rbp),%rax
   f1651:	sub    %fs:0x28,%rax
   f165a:	jne    f1717 <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)+0x1c7>
   f1660:	lea    -0x28(%rbp),%rsp
   f1664:	pop    %rbx
   f1665:	pop    %r12
   f1667:	pop    %r13
   f1669:	pop    %r14
   f166b:	pop    %r15
   f166d:	pop    %rbp
   f166e:	ret    
   f166f:	nop
   f1670:	lea    -0x60(%rbp),%r13
   f1674:	mov    %rcx,%rdx
   f1677:	mov    %rdi,%rsi
   f167a:	mov    %r8,-0xa0(%rbp)
   f1681:	mov    %r13,%rdi
   f1684:	mov    %rcx,-0x90(%rbp)
   f168b:	mov    %r10,-0x98(%rbp)
   f1692:	call   6c780 <synreal::SolverNewton::affine_body_preconditioner(CUstream_st*)@plt>
   f1697:	mov    0x24(%rbx),%r9d
   f169b:	sub    $0x8,%rsp
   f169f:	mov    0x2f90(%rbx),%rsi
   f16a6:	mov    0x3050(%rbx),%rax
   f16ad:	mov    -0x90(%rbp),%rcx
   f16b4:	mov    -0xa0(%rbp),%r8
   f16bb:	mov    0x2f70(%rbx),%r11
   f16c2:	push   %r13
   f16c4:	push   %rcx
   f16c5:	mov    -0x98(%rbp),%rdi
   f16cc:	mov    %r12,%rcx
   f16cf:	push   %r8
   f16d1:	mov    %r11,%rdx
   f16d4:	xor    %r8d,%r8d
   f16d7:	push   %r9
   f16d9:	xor    %r9d,%r9d
   f16dc:	push   %r12
   f16de:	push   %r12
   f16e0:	push   %rax
   f16e1:	push   %r12
   f16e3:	push   %rsi
   f16e4:	mov    -0x88(%rbp),%rsi
   f16eb:	push   %r15
   f16ed:	push   %r14
   f16ef:	call   6b9c0 <synreal::PcgSolver::solve(synreal::SparseMatrixELL const&, synreal::Span<glm::mat<3, 3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::mat<3, 3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >, unsigned long, int, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&)@plt>
   f16f4:	mov    -0x50(%rbp),%rax
   f16f8:	add    $0x60,%rsp
   f16fc:	test   %rax,%rax
   f16ff:	je     f164d <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)+0xfd>
   f1705:	mov    $0x3,%edx
   f170a:	mov    %r13,%rsi
   f170d:	mov    %r13,%rdi
   f1710:	call   *%rax
   f1712:	jmp    f164d <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)+0xfd>
   f1717:	call   6d630 <__stack_chk_fail@plt>
   f171c:	endbr64 
   f1720:	mov    %rax,%r15
   f1723:	jmp    763a0 <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*) [clone .cold]>
   f1728:	endbr64 
   f172c:	mov    %rax,%rbx
   f172f:	jmp    763d4 <synreal::SolverNewton::solve_pd_newton_system(synreal::SparseMatrixELL const&, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, bool, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*) [clone .cold]+0x34>
   f1734:	data16 cs nopw 0x0(%rax,%rax,1)
   f173f:	nop

00000000000f1740 <synreal::SolverNewton::solve_newton_system(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)>:
   f1740:	endbr64 
   f1744:	push   %rbp
   f1745:	mov    %rsp,%rbp
   f1748:	push   %r15
   f174a:	mov    %rdx,%r15
   f174d:	mov    %r9,%rdx
   f1750:	push   %r14
   f1752:	mov    %rsi,%r14
   f1755:	mov    %rdi,%rsi
   f1758:	push   %r13
   f175a:	mov    %r9,%r13
   f175d:	push   %r12
   f175f:	mov    %rcx,%r12
   f1762:	push   %rbx
   f1763:	mov    %rdi,%rbx
   f1766:	sub    $0x48,%rsp
   f176a:	mov    %r8,-0x70(%rbp)
   f176e:	mov    %fs:0x28,%rax
   f1777:	mov    %rax,-0x38(%rbp)
   f177b:	xor    %eax,%eax
   f177d:	lea    -0x60(%rbp),%rax
   f1781:	mov    %rax,%rdi
   f1784:	mov    %rax,-0x68(%rbp)
   f1788:	call   6c780 <synreal::SolverNewton::affine_body_preconditioner(CUstream_st*)@plt>
   f178d:	mov    0x2f70(%rbx),%rcx
   f1794:	mov    0x24(%rbx),%r9d
   f1798:	lea    0x2bb8(%rbx),%r11
   f179f:	mov    0x3050(%rbx),%rsi
   f17a6:	mov    -0x70(%rbp),%r8
   f17aa:	sub    $0x8,%rsp
   f17ae:	lea    0x7d8(%rbx),%r10
   f17b5:	mov    0x2f90(%rbx),%rax
   f17bc:	mov    -0x68(%rbp),%rbx
   f17c0:	mov    %rcx,%rdx
   f17c3:	mov    %r10,%rdi
   f17c6:	mov    %r12,%rcx
   f17c9:	push   %rbx
   f17ca:	push   %r13
   f17cc:	push   %r8
   f17ce:	xor    %r8d,%r8d
   f17d1:	push   %r9
   f17d3:	xor    %r9d,%r9d
   f17d6:	push   %r12
   f17d8:	push   %r12
   f17da:	push   %rsi
   f17db:	mov    %r11,%rsi
   f17de:	push   %r12
   f17e0:	push   %rax
   f17e1:	push   %r15
   f17e3:	push   %r14
   f17e5:	call   6d330 <synreal::PcgSolver::solve(synreal::SparseBlockMatrixELL const&, synreal::Span<glm::mat<3, 3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::mat<3, 3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >, unsigned long, int, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&)@plt>
   f17ea:	mov    -0x50(%rbp),%rax
   f17ee:	add    $0x60,%rsp
   f17f2:	test   %rax,%rax
   f17f5:	je     f1804 <synreal::SolverNewton::solve_newton_system(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)+0xc4>
   f17f7:	mov    $0x3,%edx
   f17fc:	mov    %rbx,%rsi
   f17ff:	mov    %rbx,%rdi
   f1802:	call   *%rax
   f1804:	mov    -0x38(%rbp),%rax
   f1808:	sub    %fs:0x28,%rax
   f1811:	jne    f1822 <synreal::SolverNewton::solve_newton_system(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*)+0xe2>
   f1813:	lea    -0x28(%rbp),%rsp
   f1817:	pop    %rbx
   f1818:	pop    %r12
   f181a:	pop    %r13
   f181c:	pop    %r14
   f181e:	pop    %r15
   f1820:	pop    %rbp
   f1821:	ret    
   f1822:	call   6d630 <__stack_chk_fail@plt>
   f1827:	endbr64 
   f182b:	mov    %rax,%r12
   f182e:	jmp    763f2 <synreal::SolverNewton::solve_newton_system(synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, unsigned long, std::function<void (synreal::Span<glm::vec<3, float, (glm::qualifier)0> const>, synreal::Span<glm::vec<3, float, (glm::qualifier)0> >)> const&, CUstream_st*) [clone .cold]>
   f1833:	data16 cs nopw 0x0(%rax,%rax,1)
   f183e:	xchg   %ax,%ax
