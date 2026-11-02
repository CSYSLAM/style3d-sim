"""追踪 SolverNewton::initialize 里每次 resize 的尺寸来源（轻量数据流，深度≤4）"""
import re, sys
lines=open('/tmp/host.dis',errors='replace').read().splitlines()
heads=[(i,re.match(r'^([0-9a-f]+) <(.*)>:$',l).group(2)) for i,l in enumerate(lines)
       if re.match(r'^([0-9a-f]+) <(.*)>:$',l)]
i0=next(i for i,n in heads if 'SolverNewton::initialize(' in n and '.cold' not in n)
end=next(i for i,n in heads if i>i0)
seg=[]
for l in lines[i0:end]:
    m=re.match(r'^\s*([0-9a-f]+):\s+(\S+)\s*(.*)$', l)
    if m: seg.append((int(m.group(1),16), m.group(2), m.group(3).split('#')[0].strip()))

def canon(x):
    n=x.lstrip('%')
    m=re.fullmatch(r'r(1[0-5]|[89])d?', n)
    if m: return m.group(1)
    m=re.fullmatch(r'[er]?(ax|bx|cx|dx|si|di|sp|bp)', n)
    return m.group(1) if m else n

def def_of(reg, idx):
    for j in range(idx-1, max(-1, idx-400), -1):
        a,op,args=seg[j]
        parts=[p.strip() for p in args.split(',')] if args else []
        if op in ('mov','movl','movq','movabs','lea','imul','add','sub','shl','movslq','movzbl') and parts and canon(parts[-1])==canon(reg):
            return j, op, parts
    return None

def expr_of(reg, idx, depth=0, seen=None):
    if depth>4: return '…'
    seen=seen or set()
    d=def_of(reg, idx)
    if not d: return canon(reg)
    j,op,parts=d
    src=parts[0]
    if (j,canon(reg)) in seen: return canon(reg)
    seen.add((j,canon(reg)))
    if op in ('mov','movl','movq','movabs'):
        m=re.fullmatch(r'\$?(0x[0-9a-f]+|\d+)', src)
        if m: return src
        m=re.fullmatch(r'(-?0x[0-9a-f]+)\(%(\w+)\)', src)
        if m:
            off,base=int(m.group(1),16) if 'x' in m.group(1) else int(m.group(1)), m.group(2)
            if base in ('rsp','rbp'):   # 栈槽：找最后一次写
                return slot_of(off, j, depth+1, seen)
            return f'[{base}{off:+#x}]'
        m=re.fullmatch(r'%(\w+)', src)
        if m: return expr_of(m.group(1), j, depth+1, seen)
        return src
    if op in ('imul','add','sub','shl'):
        if op=='shl':   # shl $imm, %reg  → reg << imm
            imm=parts[0]; tgt=parts[1] if len(parts)>1 else '?'
            base=expr_of(tgt, j, depth+1, seen) if tgt.startswith('%') else tgt
            return f'({base}<<{imm})'
        a=expr_of(parts[0], j, depth+1, seen) if parts[0].startswith('%') else parts[0]
        b=expr_of(parts[1], j, depth+1, seen) if len(parts)>1 and parts[1].startswith('%') else (parts[1] if len(parts)>1 else '?')
        sym={'imul':'*','add':'+','sub':'-'}[op]
        return f'({a}{sym}{b})'
    if op=='lea':
        m=re.fullmatch(r'(-?0x[0-9a-f]+)\(%(\w+)(?:,%(\w+),(\d))?\)', src)
        if m:
            off=int(m.group(1),16); base=m.group(2)
            if m.group(3):
                return f'({expr_of(base,j,depth+1,seen)}+{expr_of(m.group(3),j,depth+1,seen)}*{m.group(4)}+{off:#x})'
            return f'({expr_of(base,j,depth+1,seen)}+{off:#x})'
    return canon(reg)

def slot_of(off, idx, depth, seen):
    for j in range(idx-1, max(-1, idx-400), -1):
        a,op,args=seg[j]
        parts=[p.strip() for p in args.split(',')] if args else []
        if len(parts)==2 and re.fullmatch(r'(-?0x[0-9a-f]+)\(%r(?:sp|bp)\)', parts[1]):
            m=re.fullmatch(r'(-?0x[0-9a-f]+)\(%r(?:sp|bp)\)', parts[1])
            if int(m.group(1),16)==off:
                if parts[0].startswith('%'):
                    return expr_of(parts[0], j, depth+1, seen)
                return parts[0]
    return f'[slot{off:x}]'

rows=[]
for idx,(a,op,args) in enumerate(seg):
    m=re.search(r'call\s+\S+ <([^>]+)>', 'call '+args if op=='call' else '')
    if op!='call': continue
    mm=re.search(r'<([^>]+)>', args)
    if not mm or 'vector_base' not in mm.group(1): continue
    full=mm.group(1)
    ty=re.search(r'vector_base<([^,]+)', full)
    ty=re.sub(r'thrust::THRUST_\d+_\d+_NS::','',ty.group(1)) if ty else '?'
    opn=full.split('::')[-1].split('(')[0]
    off=None
    for j in range(idx-1, max(-1, idx-8), -1):
        r=re.match(r'0x([0-9a-f]+)\(%r(?:ax|bx|12|13|14|15)\),%rdi', seg[j][2])
        if r: off=int(r.group(1),16); break
    size=expr_of('rsi', idx)
    rows.append((off,ty,opn,size))
known=[r for r in rows if r[0]]
known.sort()
md=['## 3.1 `initialize` 里每次 `resize` 的尺寸来源','',
    '对 `%rsi` 做深度≤4 的反向数据流（`mov` 立即数/栈槽/内存、`imul/add/shl/lea`）。','',
    '| Solver 偏移 | 元素类型 | 操作 | 尺寸表达式 |','|---|---|---|---|']
for off,ty,opn,size in known:
    md.append(f'| `+0x{off:04x}` | `{ty[:26]}` | `{opn}` | `{size[:56]}` |')
open('/tmp/size_table.md','w').write('\n'.join(md)+'\n')
res=sum(1 for r in known if not r[3].startswith('rsi') and '…' not in r[3])
print(f'{len(rows)} 次操作，{len(known)} 个有偏移，{res} 个尺寸可解析')
for r in known[:10]: print(f'  +0x{r[0]:04x} {r[1][:18]:18s} {r[3][:50]}')
