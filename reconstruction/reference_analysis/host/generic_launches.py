"""解析直接调用 cudaLaunchKernel 的通用发射路径：从 GOT 加载的内核指针反查 kernel 名。"""
import re, collections
DIS='/tmp/host.dis'
lines=open(DIS,errors='replace').read().splitlines()
heads=[(i,re.match(r'^([0-9a-f]+) <(.*)>:$',l).group(2)) for i,l in enumerate(lines)
       if re.match(r'^([0-9a-f]+) <(.*)>:$',l)]
def func_of(i):
    cur='?'
    for li,n in heads:
        if li<=i: cur=n
        else: break
    return cur
rows=[]
for i,l in enumerate(lines):
    if 'cudaLaunchKernel@plt' not in l or 'call' not in l: continue
    kern=None; got=None
    for j in range(i-1, max(-1,i-40), -1):
        mm=re.search(r'mov\s+0x[0-9a-f]+\(%rip\),%rdi\s+#\s*([0-9a-f]+)\s*<(.*)', lines[j])
        if mm:
            got=mm.group(2)
            m2=re.search(r'(synreal::(?:kernel|\w+_kernel)::[^(]*)', got)
            kern=m2.group(1) if m2 else got[:60]
            break
    rows.append((func_of(i), l.split(':')[0].strip(), kern))
print('cudaLaunchKernel 调用点:', len(rows))
named=[r for r in rows if r[2] and 'synreal::' in r[2]]
print('可识别为 synreal kernel 的:', len(named))
per=collections.Counter(r[2].split('(')[0] for r in named)
print('\n按 kernel 统计（前 15）:')
for k,v in per.most_common(15): print(f'  {v:2d}  {k}')
print('\n按函数统计:')
for f,v in collections.Counter(r[0] for r in rows).most_common(8):
    print(f'  {v:2d}  {f[:78]}')
open('/tmp/generic_launches.txt','w').write('\n'.join('\t'.join(map(str,r)) for r in rows))
