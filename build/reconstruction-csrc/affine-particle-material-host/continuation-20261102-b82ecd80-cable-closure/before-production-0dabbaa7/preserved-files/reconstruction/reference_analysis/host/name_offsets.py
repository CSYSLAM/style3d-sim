"""把 step 里的 Solver 成员偏移翻译成可读名字（Config 字段 / 设备缓冲槽）"""
import re, collections
# 1) Config：Solver+0x8+off
cfg={}
sec=open('_re_analysis/LAYOUT_RUNTIME.md').read().split('## Config')[1].split('\n## ')[0]
for m in re.finditer(r'\| \+0x([0-9a-f]+) \| \d+ \| (\w+) \| `(\w+)` \|', sec):
    cfg[0x8+int(m.group(1),16)]=(m.group(3), m.group(2))
# 2) 设备缓冲池：initialize 里 resize 的偏移
pool={}
lines=open('/tmp/host.dis',errors='replace').read().splitlines()
heads=[(i,re.match(r'^([0-9a-f]+) <(.*)>:$',l).group(2)) for i,l in enumerate(lines)
       if re.match(r'^([0-9a-f]+) <(.*)>:$',l)]
i0=next(i for i,n in heads if 'SolverNewton::initialize(' in n and '.cold' not in n)
i1=next(i for i,n in heads if i>i0)
for idx,l in enumerate(lines[i0:i1]):
    m=re.search(r'call\s+\S+ <([^>]+)>', l)
    if not m or 'vector_base' not in m.group(1): continue
    t=re.search(r'vector_base<([^,]+)', m.group(1))
    ty=re.sub(r'thrust::THRUST_\d+_\d+_NS::','',t.group(1)).replace('glm::','') if t else '?'
    off=None
    for j in range(idx-1, max(-1,idx-8), -1):
        r=re.match(r'\s*\w+:\s+lea\s+0x([0-9a-f]+)\(%r(?:ax|bx|12|13|14|15)\),%rdi', lines[i0+j])
        if r: off=int(r.group(1),16); break
    if off is not None: pool[off]=ty
# 3) 解析 DATA_FLOW.md 并把偏移换成名字
rows=re.findall(r'\| `([^`]+)` \| ([^|]+) \|', open('_re_analysis/host/DATA_FLOW.md').read())
md=['# `step` → kernel 的实参来源（带名字）','',
    '把 `DATA_FLOW.md` 里的裸偏移翻译成"Config 字段"或"设备缓冲槽 + 元素类型"。',
    f'（Config 命中 {len(cfg)} 个偏移，缓冲池命中 {len(pool)} 个槽位）','',
    '| kernel | 实参来源 |','|---|---|']
for k, offs in rows:
    parts=[]
    for o in re.findall(r'\+0x([0-9a-f]+)', offs):
        v=int(o,16)
        if v in cfg: parts.append(f'`{cfg[v][0]}`(Config·{cfg[v][1]})')
        elif v in pool: parts.append(f'buf@+0x{v:04x}({pool[v]})')
        else: parts.append(f'+0x{v:04x}')
    md.append(f'| `{k}` | ' + ', '.join(parts) + ' |')
open('_re_analysis/host/DATA_FLOW.md','w').write('\n'.join(md)+'\n')
hit=sum(1 for k,offs in rows for o in re.findall(r'\+0x([0-9a-f]+)', offs) if int(o,16) in cfg or int(o,16) in pool)
tot=sum(len(re.findall(r'\+0x([0-9a-f]+)', offs)) for k,offs in rows)
print(f'偏移总数 {tot}，其中能翻译成名字的 {hit}（{hit/tot*100:.0f}%）')
print('示例:', md[7][:150] if len(md)>7 else '')
