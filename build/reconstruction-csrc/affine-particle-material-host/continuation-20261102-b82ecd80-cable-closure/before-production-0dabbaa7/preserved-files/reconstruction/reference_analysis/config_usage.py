"""Config 字段在 step 里的读取点（Config 在 this+0x8，rbx=this 已确认）"""
import re, collections
lines=open('/tmp/host.dis',errors='replace').read().splitlines()
h=[i for i,l in enumerate(lines) if l.startswith('00000000000fb160 <')][0]
e=[i for i,l in enumerate(lines) if l.startswith('0000000000102a90 <')][0]
seg=lines[h:e]
sec=open('_re_analysis/LAYOUT_RUNTIME.md').read().split('## Config')[1].split('## Model')[0]
known=[(int(m.group(1),16), m.group(3), m.group(2))
       for m in re.finditer(r'\| \+0x([0-9a-f]+) \| \d+ \| (\w+) \| `(\w+)` \|', sec)]
BASE=0x8
KIND={'movss':'f32 读','movsd':'f64 读','cmpl':'int 比较','cmpq':'64 位比较','cmp':'比较',
      'movzbl':'bool 读','movb':'bool 读','movl':'int 读','mov':'读','push':'作为实参入栈',
      'movdqu':'16B 批量拷','movups':'16B 批量拷','lea':'取地址','ucomiss':'f32 比较','comiss':'f32 比较'}
md=['# Config 字段在 `step` 里的使用点','',
    '> `Config` 位于 `SolverNewton +0x8`，`step` 里 `rbx = this`（`mov %rdi,%rbx`），',
    '> 因此 `Config+off` 表现为 `0x(8+off)(%rbx)`。统计范围：`0xfb160`–`0x102a90`。','',
    '| Config 偏移 | 字段 | 类型 | 次数 | 指令分布 | 首条示例 |','|---|---|---|---|---|---|']
nz=0; total=0
for off,name,ty in sorted(known):
    pat=re.compile(r'0x%x\(%%rbx\)' % (BASE+off))
    hits=[]
    for l in seg:
        if pat.search(l):
            m=re.search(r':\s+(\S+)\s', l)
            hits.append((m.group(1) if m else '?', l.strip()))
    if hits: nz+=1
    total += len(hits)
    dist=', '.join('%s×%d' % (KIND.get(k,k), v) for k,v in collections.Counter(k for k,_ in hits).most_common(3)) or '—'
    ex=re.sub(r'\s+',' ', hits[0][1])[:64] if hits else ''
    md.append('| +0x%03x | `%s` | %s | %d | %s | `%s` |' % (off, name, ty, len(hits), dist, ex))
md.insert(4, '共 %d 个字段，其中 **%d** 个在 `step` 内被直接访问，累计 %d 个访问点。\n' % (len(known), nz, total))
md += ['', '## 读法', '',
       '- `f32 读` / `bool 读` 多为参与内核参数打包或条件判断；',
       '- `作为实参入栈` 说明该字段被直接传给某个 kernel launch（`push` 之后紧接 `call ... cudaLaunchKernel`）；',
       '- `16B 批量拷` 通常是整个 `Config` 被拷进栈上的临时对象（例如传给 lambda 或捕获）。']
open('_re_analysis/CONFIG_USAGE.md','w').write('\n'.join(md)+'\n')
print('字段 %d，被访问 %d，总访问点 %d' % (len(known), nz, total))
