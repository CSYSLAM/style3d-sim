"""CFG 感知的尺寸追踪：基本块 + 前向数据流（寄存器/栈槽抽象值 = 表达式字符串）"""
import re, sys, collections
lines=open('/tmp/host.dis',errors='replace').read().splitlines()
heads=[(i,re.match(r'^([0-9a-f]+) <(.*)>:$',l).group(2)) for i,l in enumerate(lines)
       if re.match(r'^([0-9a-f]+) <(.*)>:$',l)]
i0=next(i for i,n in heads if 'SolverNewton::initialize(' in n and '.cold' not in n)
i1=next(i for i,n in heads if i>i0)
ins=[]
for l in lines[i0:i1]:
    m=re.match(r'^\s*([0-9a-f]+):\s+(\S+)\s*(.*)$', l)
    if not m: continue
    args=m.group(3).split('#')[0].strip()
    ins.append([int(m.group(1),16), m.group(2), args])
addr2i={a:i for i,(a,_,_) in enumerate(ins)}

def canon(x):
    n=x.lstrip('%')
    m=re.fullmatch(r'r(1[0-5]|[89])d?', n)
    if m: return 'r'+m.group(1)
    m=re.fullmatch(r'[er]?(ax|bx|cx|dx|si|di|sp|bp)', n)
    return 'r'+m.group(1) if m else n

def is_branch(op): return op.startswith('j') or op in ('ret','call')

leaders={0}
for i,(a,op,args) in enumerate(ins):
    if op.startswith('j'):
        m=re.match(r'^([0-9a-f]+)', args)
        if m and int(m.group(1),16) in addr2i: leaders.add(addr2i[int(m.group(1),16)])
        if i+1<len(ins): leaders.add(i+1)
    elif op=='ret' and i+1<len(ins): leaders.add(i+1)
leaders=sorted(leaders)
blocks=[]
for k,st in enumerate(leaders):
    en=leaders[k+1] if k+1<len(leaders) else len(ins)
    blocks.append((st,en))
def block_of(i):
    for k,(a,b) in enumerate(blocks):
        if a<=i<b: return k
    return len(blocks)-1
succ=collections.defaultdict(set)
for k,(a,b) in enumerate(blocks):
    last=ins[b-1]
    if last[1].startswith('j'):
        m=re.match(r'^([0-9a-f]+)', last[2])
        if m and int(m.group(1),16) in addr2i: succ[k].add(block_of(addr2i[int(m.group(1),16)]))
        if not last[2].startswith('jmp') and b<len(ins): succ[k].add(block_of(b))
    elif last[1]=='ret':
        pass
    elif b<len(ins):
        succ[k].add(block_of(b))

def merge(a,b):
    out=dict(a)
    for k,v in b.items():
        if k in out and out[k]!=v: out[k]='φ'
        elif k not in out: out[k]=v
    return out

def run_block(state, a, b):
    st=dict(state)
    for i in range(a,b):
        _,op,args=ins[i]
        parts=[p.strip() for p in args.split(',')] if args else []
        if op in ('mov','movl','movq','movabs') and len(parts)==2:
            dst,src=parts
            # 源表达式
            if re.fullmatch(r'\$?(0x[0-9a-f]+|\d+)', src): val=src
            elif re.fullmatch(r'-?0x[0-9a-f]+\(%r(?:sp|bp)\)', src):
                val=st.get(canon(src).replace('%',''), '?')
                val=st.get(src.replace('%r','r').replace('%',''), '?')
            elif re.fullmatch(r'-?0x[0-9a-f]+\(%r\w+\)', src):
                val=src
            elif src.startswith('%'):
                val=st.get(canon(src), canon(src))
            else: val=src
            key = dst.replace('%','') if dst.startswith('%') else dst
            k=canon(dst) if dst.startswith('%') else dst
            st[k]=val
        elif op in ('imul','add','sub','shl') and len(parts)>=2:
            tgt=canon(parts[-1])
            if op=='shl':
                st[tgt]=f'({st.get(canon(parts[1]),canon(parts[1]))}<<{parts[0]})'
            else:
                a1=st.get(canon(parts[0]),canon(parts[0])) if parts[0].startswith('%') else parts[0]
                a2=st.get(canon(parts[1]),canon(parts[1])) if len(parts)>1 and parts[1].startswith('%') else (parts[1] if len(parts)>1 else '?')
                st[tgt]=f'({a1}{ {"imul":"*","add":"+","sub":"-"}[op] }{a2})'
        elif op=='lea' and len(parts)==2:
            dst=canon(parts[0]); m=re.fullmatch(r'(-?0x[0-9a-f]+)\(%(\w+)(?:,%(\w+),(\d))?\)', parts[1])
            if m:
                base=st.get('r'+m.group(2) if not m.group(2).startswith('r') else m.group(2), '%'+m.group(2))
                st[canon(parts[0])]=f'({base}+{m.group(1)})'
    return st

instate={k:{} for k in range(len(blocks))}
instate[0]={}
for _ in range(12):
    changed=False
    for k,(a,b) in enumerate(blocks):
        st=run_block(instate[k], a, b)
        for s in succ[k]:
            new=merge(instate[s], st)
            if new!=instate[s]: instate[s]=new; changed=True
    if not changed: break

def resolve(exp, depth=0):
    return re.sub(r'\s+','', exp)[:70]

rows=[]
for i,(a,op,args) in enumerate(ins):
    if op!='call': continue
    m=re.search(r'<([^>]+)>', args)
    if not m or 'vector_base' not in m.group(1): continue
    full=m.group(1)
    ty=re.search(r'vector_base<([^,]+)', full); ty=ty.group(1) if ty else '?'
    ty=re.sub(r'thrust::THRUST_\d+_\d+_NS::','',ty).replace('glm::','')
    k=block_of(i)
    st=instate[k]
    # 找 call 前最后一条设置 rsi 的指令
    size=None
    for j in range(i-1, max(block_of(i) and blocks[k][0] or 0, i-12), -1):
        _,o2,ar2=ins[j]
        if o2 in ('mov','movl','movq','movabs') and ar2.strip().endswith('%rsi'):
            src=ar2.split(',')[0].strip()
            size=st.get(canon(src), src) if src.startswith('%') else src
            break
    off=None
    for j in range(i-1, max(0,i-8), -1):
        r=re.match(r'0x([0-9a-f]+)\(%r(?:ax|bx|12|13|14|15)\),%rdi', ins[j][2])
        if r: off=int(r.group(1),16); break
    rows.append((off,ty,size))
known=sorted([r for r in rows if r[0] is not None], key=lambda r:r[0])
good=[r for r in known if r[2] and r[2] not in ('?','φ') and not r[2].startswith('%')]
print(f'共 {len(rows)} 次，带偏移 {len(known)}，尺寸解析成功 {len(good)}')
for off,ty,sz in known[:18]:
    print(f'  +0x{off:04x} {ty[:14]:14s} {str(sz)[:60]}')
md=['## 3.3 CFG 感知后的尺寸解析','',
    '做法：按分支/调用切基本块 → 前向数据流（寄存器 + 栈槽的抽象值，汇合处取 φ）→ 迭代到不动点。','',
    f'**{len(known)} 个带偏移的 resize 中，{len(good)} 个尺寸解析成功**（线性回溯时只有 10 个）。','',
    '| Solver 偏移 | 元素类型 | 尺寸表达式 |','|---|---|---|']
for off,ty,sz in known:
    md.append(f'| `+0x{off:04x}` | `{ty[:20]}` | `{str(sz)[:44]}` |')
open('/tmp/size_table2.md','w').write('\n'.join(md)+'\n')
