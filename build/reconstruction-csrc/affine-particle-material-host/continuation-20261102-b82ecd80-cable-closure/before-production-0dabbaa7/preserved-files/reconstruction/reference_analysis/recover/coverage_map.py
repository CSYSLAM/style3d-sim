"""生成 kernel 还原覆盖表：已还原 / 已记录结构 / 未触及"""
import json, os, re
K=json.load(open('_re_analysis/kernels.json'))
sr=[k for k in K if 'synreal::' in k['pretty']]
done={f[:-3] for f in os.listdir('_re_analysis/recover/human') if f.endswith('.cu')}
done |= {f[:-3] for f in os.listdir('_re_analysis/reconstructed') if f.endswith('.cu')}
# 结构已记录的（写在 ASSEMBLY_KERNELS.md 里的）
doc=open('_re_analysis/recover/ASSEMBLY_KERNELS.md').read()
def status(k):
    d=k['disp']
    base=d.split('<')[0]
    for x in done:
        if base and (base in x or x.endswith(base)):
            return 'reconstructed'
    if base and base in doc:
        return 'documented'
    return 'todo'
rows=[]
for k in sr:
    rows.append((status(k), k['cu'], k['sass'], k['ptx_lines'], k['disp']))
by={}
for st,cu,s,p,d in rows: by.setdefault(st,[]).append((s,p,cu,d))
md=['# kernel 还原覆盖表','',
    f'总计 **{len(rows)}** 个自研 kernel。','']
for st,label in [('reconstructed','✅ 已还原为可读 C++'),('documented','📝 仅记录结构（未写代码）'),('todo','⬜ 未触及')]:
    lst=sorted(by.get(st,[]), reverse=True)
    md += [f'## {label} —— {len(lst)} 个 / {sum(x[0] for x in lst):,} SASS 指令','']
    if not lst: md+=['（无）','']; continue
    md += ['| SASS | PTX | 模块 | kernel |','|---|---|---|---|']
    for s,p,cu,d in lst:
        md.append(f'| {s:,} | {p} | `{cu}` | `{d[:78]}` |')
    md.append('')
open('_re_analysis/recover/KERNEL_COVERAGE.md','w').write('\n'.join(md)+'\n')
for st in ('reconstructed','documented','todo'):
    n=len(by.get(st,[])); s=sum(x[0] for x in by.get(st,[]))
    print(f'{st:14s} {n:3d} 个, {s:7,d} SASS')
print('总 SASS:', f"{sum(x[2] for x in rows):,}")
