"""反推按值 View 结构的字段布局（支持向量化 ld.param.v2/v4）"""
import re, glob, collections
rows=collections.defaultdict(lambda: collections.defaultdict(lambda: collections.Counter()))
where=collections.defaultdict(set)
WIDTH={'u8':1,'s8':1,'b8':1,'u16':2,'b16':2,'f16':2,'u32':4,'s32':4,'b32':4,'f32':4,'u64':8,'s64':8,'b64':8,'f64':8}
PAT=re.compile(r'ld\.param\.(?:(v[24])\.)?(\w+) (?:\{(%[\w, %]+)\}|(%\w+)), \[([^\]\s+]+)(?:\+(\d+))?\]')
for f in glob.glob('_re_analysis/kernels/*/*.ptx'):
    if re.search(r'cuda_cub|thrust', open(f).readline()): continue
    txt=open(f).read()
    for m in re.finditer(r'\.param \.align \d+ \.b8 (\S+_param_(\d+))\[(\d+)\]', txt):
        name,size=m.group(1),int(m.group(3))
        bases={name}
        bases |= set(re.findall(r'mov\.b64 %(rd\d+), '+re.escape(name), txt))
        bases |= set(re.findall(r'cvta\.param[\w.]* %(rd\d+), %'+re.escape(name), txt))
        for mm in PAT.finditer(txt):
            vec,ty,regs,r1,base,off=mm.groups()
            if base not in bases: continue
            n = 2 if vec=='v2' else (4 if vec=='v4' else 1)
            w=WIDTH.get(ty,4)
            base_off=int(off or 0)
            for i in range(n):
                o=base_off+i*w
                rows[size][o][ty]+=1
                where[(size,o)].add(f.split('/')[-2])
md=['# 按值结构（View）的字段布局反推','',
    '> 扫描 PTX 里对 byval 形参（含 `mov.b64`/`cvta.param` 派生的别名寄存器）的 `ld.param` 访问，',
    '> **支持 `ld.param.v2/v4` 向量形式**（按元素宽度展开成多个偏移）。',
    '> 宽度是分类依据：**u64 → 指针**、**u32 → 计数/索引**、**f32 → 标量**。','']
for size in sorted(rows):
    md += [f'## sizeof = {size} B（{len(rows[size])} 个偏移）','',
           '| 偏移 | 宽度 | 次数 | 模块 | 推断 |','|---|---|---|---|---|']
    for off in sorted(rows[size]):
        t=rows[size][off]
        if 'u64' in t and not (set(t)&{'u32','f32'}): g='**指针**'
        elif 'u64' in t: g='指针 / {u32,u32}'
        elif 'f32' in t and 'u32' not in t: g='标量 f32'
        else: g='计数/索引'
        md.append(f'| +0x{off:03x} | {"、".join(f"{k}×{v}" for k,v in t.most_common(3))} | {sum(t.values())} | '
                  f'{", ".join(sorted(where[(size,off)]))} | {g} |')
    md.append('')
    print(f'{size} B: {len(rows[size])} 个偏移')
open('_re_analysis/VIEW_LAYOUT.md','w').write('\n'.join(md)+'\n')
