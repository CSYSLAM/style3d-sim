"""step 里每次 kernel launch 的实参来源（Solver 成员偏移）"""
import re, collections
lines=open('/tmp/host.dis',errors='replace').read().splitlines()
h=[i for i,l in enumerate(lines) if l.startswith('00000000000fb160 <')][0]
e=[i for i,l in enumerate(lines) if l.startswith('0000000000102a90 <')][0]
seg=[]
for l in lines[h:e]:
    m=re.match(r'^\s*([0-9a-f]+):\s+(\S+)\s{1,}(.*)$', l)
    if not m: continue
    seg.append((int(m.group(1),16), m.group(2), m.group(3)))
MEM=re.compile(r'\b0x([0-9a-f]+)\(%rbx\)')
rows=[]
for i,(a,op,args) in enumerate(seg):
    if op!='call' or '<synreal::' not in args: continue
    tail=args.split('<synreal::',1)[1]
    ns_name=tail.split('(',1)[0]
    if 'kernel::' not in ns_name: continue      # 排除宿主成员函数调用
    kname=ns_name.split('::')[-1]
    src=[]
    for j in range(max(0,i-20), i):
        for mm in MEM.finditer(seg[j][2]): src.append(int(mm.group(1),16))
    rows.append((kname, sorted(set(src))))
agg=collections.defaultdict(collections.Counter)
for k,srcs in rows:
    for s in srcs: agg[k][s]+=1
md=['# `step` 里 kernel 实参的 Solver 成员偏移来源','',
    '对每次 launch 向前扫 20 条指令，收集 `0xNNNN(%rbx)` 形式的成员访问（`rbx = this`）。','',
    '| kernel | 成员偏移 |','|---|---|']
for k in sorted(agg):
    offs=', '.join(f'+0x{o:04x}' for o in sorted(agg[k]))
    md.append(f'| `{k}` | {offs[:120]} |')
open('_re_analysis/host/DATA_FLOW.md','w').write('\n'.join(md)+'\n')
print(f'launch {len(rows)} 次，覆盖 {len(agg)} 个 kernel')
pool=set()
for k in agg:
    for o in agg[k]:
        if 0x2ee8<=o<=0x3600: pool.add(o)
print('落在设备缓冲池 (0x2ee8–0x3600) 的不同偏移:', len(pool))
for k in sorted(agg)[:8]:
    print(f'  {k[:34]:36s} {sorted(agg[k])[:6]}')
