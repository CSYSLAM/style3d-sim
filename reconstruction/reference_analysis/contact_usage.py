"""step 里 Contact / Control / State 的字段访问点"""
import re, collections
lines=open('/tmp/host.dis',errors='replace').read().splitlines()
h=[i for i,l in enumerate(lines) if l.startswith('00000000000fb160 <')][0]
e=[i for i,l in enumerate(lines) if l.startswith('0000000000102a90 <')][0]
seg=lines[h:e]
def fields(sec):
    part=open('_re_analysis/LAYOUT_RUNTIME.md').read().split(f'## {sec}')[1].split('\n## ')[0]
    return [(int(m.group(1),16), m.group(3), m.group(2))
            for m in re.finditer(r'\| \+0x([0-9a-f]+) \| \d+ \| (\w+) \| `(\w+)` \|', part)]
T={'contact':(fields('Contact'),None),'control':(fields('Control'),-0xb88),
   'state_a':(fields('State'),-0xaf8),'state_b':(fields('State'),-0xb18)}
cnt=collections.defaultdict(collections.Counter)
# contact：%r14 恒定（prologue: mov %r8,%r14）
for l in seg:
    for m in re.finditer(r'0x([0-9a-f]+)\(%r14\)', l):
        off=int(m.group(1),16)
        for fo,fn,ft in T['contact'][0]:
            if fo==off: cnt['contact'][fn]+=1
# 其余：按"从栈槽装入后 30 条内"统计
for name,(flds,slot) in T.items():
    if slot is None: continue
    pat=re.compile(r'-0x%x\(%%rbp\),%%(\w+)' % (-slot))
    for i,l in enumerate(seg):
        m=pat.search(l)
        if not m: continue
        reg=m.group(1)
        for l2 in seg[i:i+30]:
            for mm in re.finditer(r'0x([0-9a-f]+)\(%%%s\)' % reg, l2):
                off=int(mm.group(1),16)
                for fo,fn,ft in flds:
                    if fo==off: cnt[name][fn]+=1
md=['# `step` 里 Contact / Control / State 的字段访问','',
    '`step(State const&, State const&, Control const&, Contact const&, float, CUstream*)`',
    '→ `rsi→-0xaf8(%rbp)`、`rdx→-0xb18(%rbp)`、`rcx→-0xb88(%rbp)`、`r8→%r14`（`Contact` 全程留在 `%r14`）。','']
for name in ('contact','control','state_a','state_b'):
    md += [f'## {name}（{len(T[name][0])} 个已知字段）','','| 字段 | 类型 | 访问次数 |','|---|---|---|']
    for fo,fn,ft in T[name][0]:
        c=cnt[name].get(fn,0)
        if c: md.append(f'| `{fn}` | {ft} | {c} |')
    if not cnt[name]: md.append('| （无命中） | — | 0 |')
    md.append('')
open('_re_analysis/CONTACT_USAGE.md','w').write('\n'.join(md)+'\n')
for n in ('contact','control','state_a','state_b'):
    print(f'{n}: {dict(cnt[n].most_common(6))}')
