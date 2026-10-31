"""恢复 SolverNewton::step 的循环骨架：找回边，判定每次 launch 属于哪个循环"""
import re, collections
DIS='/tmp/host.dis'
lines=open(DIS,errors='replace').read().splitlines()
heads=[(i,int(m.group(1),16),m.group(2)) for i,l in enumerate(lines)
       if (m:=re.match(r'^([0-9a-f]+) <(.*)>:$',l))]
def find_func(pat):
    for li,addr,name in heads:
        if re.search(pat,name) and '.cold' not in name and 'lambda' not in name:
            end=next((a for l2,a,n2 in heads if l2>li), 10**9)
            return addr, end, li, name
    return None
target=find_func(r'SolverNewton::step\(synreal::State const&')
addr,end,start,name=target
print('step:', hex(addr), '→', hex(end), '| name:', name[:60])
seg=[(i,l) for i,l in enumerate(lines[start:]) if i+start < next(li for li,a,n in heads if li>start)]
seg=[(int(m.group(1),16), m.group(2), m.group(3)) for i,l in seg if (m:=re.match(r'^\s*([0-9a-f]+):\s+(\S+)\s*(.*)$', l))]
# 回边
back=[]
for i,(a,op,args) in enumerate(seg):
    if op.startswith('j'):
        m=re.match(r'^([0-9a-f]+)', args)
        if m:
            t=int(m.group(1),16)
            if t < a and t >= addr: back.append((t,a,op))
print('回边数:', len(back))
loops=[]
for t,a,op in back:
    if t==addr: continue
    loops.append((t,a))
# 合并嵌套
loops.sort()
print('\n最内层循环（按起点）:')
inner=[]
for t,a in loops:
    inside=[l for l in loops if l!=(t,a) and l[0]>=t and l[1]<=a]
    if not inside: inner.append((t,a))
for t,a in sorted(inner):
    print(f'  0x{t:x} .. 0x{a:x}   {a-t} 字节')
# launch 归属
launch=collections.defaultdict(list)
for a,op,args in seg:
    line=f'{op} {args}'
    m=re.search(r'call\s+[0-9a-f]+ <synreal::(?:kernel|\w+_kernel)::([^(]+)', line)
    if not m: continue
    k=m.group(1)
    inside=[(t,e) for t,e in loops if t<=a<=e]
    inside.sort(key=lambda x:x[1]-x[0])
    key=f'loop[{hex(inside[0][0])}..{hex(inside[0][1])}]' if inside else 'toplevel'
    launch[key].append((a,k))
print()
for k,v in launch.items():
    print(f'{k}: {len(v)} 次 launch')
    for a,n in v[:6]: print(f'     0x{a:x} {n[:64]}')
