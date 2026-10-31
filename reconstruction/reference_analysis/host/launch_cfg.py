"""从 __cudaPushCallConfiguration 调用点恢复每次 launch 的 grid/block。
思路：SysV ABI 下 dim3(12B) 用两个寄存器传：rdi={gx,gy}, rsi={gz}, rdx={bx,by}, rcx={bz}。
对该点做反向切片，解析 mov/movabs/读 rodata/栈槽。
"""
import re, struct, sys, subprocess, collections

SO='_core.cpython-312-x86_64-linux-gnu.so'
DIS='/tmp/host.dis'

# ---- ELF vaddr -> file offset ----
def load_phdrs(path):
    d=open(path,'rb').read()
    e_phoff,=struct.unpack_from('<Q',d,0x20)
    e_phentsize,e_phnum=struct.unpack_from('<HH',d,0x36)
    segs=[]
    for i in range(e_phnum):
        o=e_phoff+i*e_phentsize
        p_type,=struct.unpack_from('<I',d,o)
        if p_type!=1: continue
        p_offset,=struct.unpack_from('<Q',d,o+0x08)
        p_vaddr,=struct.unpack_from('<Q',d,o+0x10)
        p_filesz,=struct.unpack_from('<Q',d,o+0x20)
        segs.append((p_vaddr,p_offset,p_filesz))
    return d,segs
DATA,SEGS=load_phdrs(SO)
def read_vaddr(vaddr,n=8):
    for va,off,sz in SEGS:
        if va<=vaddr<va+sz:
            fo=off+(vaddr-va)
            return DATA[fo:fo+n]
    return b''
def u64(v): return struct.unpack('<Q',v)[0] if len(v)>=8 else None

# ---- 反向切片 ----
LINE=re.compile(r'^\s*([0-9a-f]+):\s+(\S+)\s*(.*)$')

def canon(name):
    n=name.lstrip('%')
    m=re.fullmatch(r'r(1[0-5]|[89])d?', n)
    if m: return m.group(1)
    m=re.fullmatch(r'[er]?(ax|bx|cx|dx|si|di|sp|bp)', n)
    if m: return m.group(1)
    if n in ('eax','ebx','ecx','edx','esi','edi','esp','ebp'): return n[1:]
    return n
def parse_arg(op):
    op=op.strip().lstrip('$')
    m=re.match(r'^(-?0x[0-9a-f]+|-?\d+)$', op)
    if m: return ('imm', int(op,16) if 'x' in op else int(op))
    m=re.match(r'^%(\w+)$', op)
    if m: return ('reg', m.group(1))
    m=re.match(r'^(-?0x[0-9a-f]+|-?\d+)\(%(\w+)\)$', op)
    if m: return ('mem', int(m.group(1),16) if 'x' in m.group(1) else int(m.group(1)), m.group(2))
    return ('other', op)

def resolve(reg, idx, lines, depth=0):
    """从 idx 往前找 reg 的最后一次定义并求值"""
    if depth>4: return None
    for j in range(idx-1, max(-1, idx-400), -1):
        m=LINE.match(lines[j])
        if not m: continue
        op=m.group(2); args=m.group(3)
        parts=[a.strip() for a in args.split(',')] if args.strip() else []
        if op=='call' and canon(reg)=='ax':
            mm=re.search(r'<([^>]+)>', args)
            return ('call', mm.group(1).split('(')[0] if mm else '?')
        # 跳过与 reg 无关的写
        if op in ('mov','movabs','movl','movq','movss','xor','lea'):
            if parts and canon(parts[-1])==canon(reg):
                src=parts[0]
                if op=='xor' and parts[0]==parts[-1]: return ('imm',0)
                if op=='lea': return ('expr', src)
                t=parse_arg(src)
                if t[0]=='imm': return t
                if t[0]=='reg':
                    return resolve(t[1], j, lines, depth+1)
                if t[0]=='mem':
                    off,base=t[1],t[2]
                    if base=='rip':
                        mm=re.search(r'#\s*([0-9a-f]+)', lines[j])
                        if mm:
                            v=u64(read_vaddr(int(mm.group(1),16)))
                            return ('imm64', v)
                        return None
                    # 栈槽：找最后一次写
                    return resolve_slot(off, j, lines, depth+1)
                return None
        # 目标不是 reg 的指令忽略
    return None

def resolve_slot(off, idx, lines, depth=0):
    """找最后一次写入栈槽 off(%rsp) 的值"""
    for j in range(idx-1, max(-1, idx-400), -1):
        m=LINE.match(lines[j])
        if not m: continue
        op=m.group(2); args=m.group(3)
        parts=[a.strip() for a in args.split(',')]
        if op not in ('mov','movl','movq','movabs') or len(parts)!=2: continue
        t=parse_arg(parts[1])
        if t[0]=='mem' and t[2]=='rsp' and t[1]==off:
            src=parse_arg(parts[0])
            if src[0]=='imm': return src
            if src[0]=='reg': return resolve(src[1], j, lines, depth+1)
            return None
    return None

def val(t):
    if isinstance(t, tuple) and t and t[0] in ('imm','imm64'):
        return t[1]
    return None

def dim3(lo, hi):
    v=val(lo); z=val(hi)
    if v is None: gx=gy='?'
    else: gx,gy = v & 0xffffffff, (v>>32)&0xffffffff
    return (gx,gy, z if z is not None else '?')

def main():
    lines=open(DIS,errors='replace').read().splitlines()
    # 函数区间
    heads=[(i,re.match(r'^([0-9a-f]+) <(.*)>:$', l).groups()) for i,l in enumerate(lines)
           if re.match(r'^([0-9a-f]+) <(.*)>:$', l)]
    def func_of(i):
        cur=None
        for k,(li,(a,n)) in enumerate(heads):
            if li<=i: cur=(a,n,k)
            else: break
        return cur
    rows=[]
    for i,l in enumerate(lines):
        if '__cudaPushCallConfiguration' in l and 'call' in l:
            f=func_of(i)
            g_lo=resolve('di', i, lines); g_hi=resolve('si', i, lines)
            b_lo=resolve('dx', i, lines); b_hi=resolve('cx', i, lines)
            # 找 push 之后最近的一次 kernel 调用
            kern=None
            for j in range(i+1, min(len(lines), i+40)):
                if re.search(r'call\s+[0-9a-f]+ <(synreal::(?:kernel|\w+_kernel)::|__device_stub__)', lines[j]):
                    mm=re.search(r'<([^(]+)', lines[j]); kern=mm.group(1); break
            rows.append(dict(func=f[1] if f else '?', site=l.split(':')[0].strip(),
                             grid=dim3(g_lo,g_hi), block=dim3(b_lo,b_hi), kernel=kern))
    # 汇总
    out=['# 每次 kernel launch 的 grid / block（从 `__cudaPushCallConfiguration` 恢复）','',
         '> ABI：`dim3`(12B) 拆成两个寄存器，`rdi={gx,gy}`、`rsi={gz}`、`rdx={bx,by}`、`rcx={bz}`。',
         '> 值来自立即数、`.rodata` 常量或栈槽；`block_count(n)` 是编译期生成的 `ceil(n/block)` 辅助函数。','']
    seen=collections.Counter()
    for r in rows:
        gx,gy,gz=r['grid']; bx,by,bz=r['block']
        key=(bx,by,bz)
        seen[key]+=1
        out.append(f"- `{r['site']}`  {r['kernel'] or '(?)':<60} grid=({gx},{gy},{gz})  block=({bx},{by},{bz})")
    out += ['', '## block 尺寸分布', '']
    for k,v in seen.most_common():
        out.append(f'- block=({k[0]},{k[1]},{k[2]}) : {v} 次')
    open('_re_analysis/host/LAUNCH_CONFIG.md','w').write('\n'.join(out)+'\n')
    print(f'push 点 {len(rows)} 个，已写 LAUNCH_CONFIG.md')
    for k,v in seen.most_common(6): print('  block', k, 'x', v)

main()
