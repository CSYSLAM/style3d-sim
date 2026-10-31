"""枚举 kernel 侧对 Model（按值 1864 B）的字段访问，并与 Python 侧已知偏移对照。"""
import re, glob, collections, sys
sys.path.insert(0,'_re_analysis/recover')
from ptx2c import parse, parse_mem

# Python 侧已知 Model 字段
known={}
sec=open('_re_analysis/LAYOUT_RUNTIME.md').read().split('## Model')[1].split('## State')[0]
for m in re.finditer(r'\| \+0x([0-9a-f]+) \| \d+ \| (\w+) \| `(\w+)` \|', sec):
    known[int(m.group(1),16)]=(m.group(3), m.group(2))

files=[f for f in glob.glob('_re_analysis/kernels/*/*.ptx') if not re.search(r'cub|thrust', f)]
acc=collections.defaultdict(lambda: collections.defaultdict(collections.Counter))
models=collections.Counter()
for f in files:
    k=parse(f)
    byval={p['index']:p for p in k.params if p['ptx']=='b8' and p['size']>=1000}
    if not byval: continue
    cu=f.split('/')[-2]
    for idx,p in byval.items():
        models[(cu, p['size'])]+=1
        # Model 常先被 mov.b64 到一个寄存器（得到参数区地址），再按 [reg+off] 访问
        alias=set()
        for ins in k.instrs:
            mm=re.match(r'mov\.b64 %(\w+), '+re.escape(p['name']), ins)
            if mm: alias.add('%'+mm.group(1))
        # 跟随一层 add.s64 %rdX, %rdY, K 的基址偏移
        addoff={}
        for ins in k.instrs:
            mm=re.match(r'add\.s64 %(\w+), %(\w+), (\d+)', ins)
            if mm: addoff['%'+mm.group(1)]=('%'+mm.group(2), int(mm.group(3)))
        for ins in k.instrs:
            for mm in re.finditer(r'\[([^\]]+)\]', ins):
                parsed=parse_mem('['+mm.group(1)+']')
                if not parsed: continue
                base,off=parsed
                if base in addoff:
                    b2,k2=addoff[base]
                    if b2 in alias or b2==p['name']:
                        off += k2; base = b2
                if base!=p['name'] and base not in alias: continue
                ty=re.search(r'ld\.(?:param|global)\.(\w+)', ins)
                acc[off][cu][ty.group(1) if ty else '?']+=1

rows=[(o, sum(sum(cc.values()) for cc in v.values()), dict(v)) for o,v in acc.items()]
rows.sort()
print(f'Model 形参出现次数: {sum(models.values())}（{len(models)} 个 kernel）')
print(f'访问到的不同偏移: {len(rows)}')
print(f'{"偏移":>8s} {"次数":>4s}  类型(Python 已知)        读取它的模块')
spans={o:v for o,v in known.items() if v[1]=='Span'}
for o,cnt,mods in rows:
    k=known.get(o)
    if not k and (o-8) in spans: k=(spans[o-8][0]+'.size','size_t')
    tag=f'{k[0]}({k[1]})' if k else '—'
    print(f'  0x{o:03x} {cnt:4d}  {tag:24s} {", ".join(f"{m}×{sum(v.values())}" for m,v in mods.items())}')

md=['# Model 字段访问图（kernel 侧）','',
    '> 来源：PTX 里对按值 `Model`（1864 B）形参的 `[param+off]` 访问；只统计真正被读/写的偏移。','',
    f'共 **{len(rows)}** 个不同偏移被访问，其中 **{sum(1 for o,_,_ in rows if o in known)}** 个能与 Python 侧字段对上。','',
    '| 偏移 | 次数 | Python 侧字段 | 访问模块 |','|---|---|---|---|']
spans={o:v for o,v in known.items() if v[1]=='Span'}
for o,cnt,mods in rows:
    k=known.get(o)
    if not k and (o-8) in spans: k=(spans[o-8][0]+'.size','size_t')
    tag=f'`{k[0]}` ({k[1]})' if k else '**未暴露**'
    md.append(f'| +0x{o:03x} | {cnt} | {tag} | {", ".join(mods)} |')
open('_re_analysis/MODEL_ACCESS.md','w').write('\n'.join(md)+'\n')
