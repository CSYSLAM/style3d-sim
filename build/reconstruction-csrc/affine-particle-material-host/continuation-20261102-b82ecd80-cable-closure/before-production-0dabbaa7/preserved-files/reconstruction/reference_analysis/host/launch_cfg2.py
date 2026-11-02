"""启发式版：对每个 __cudaPushCallConfiguration 点，
   1) 找最近的 .rodata 常量（多为 dim3 父常量 256/1/1）
   2) 找最近的 block_count() 调用（grid.x = ceil(n/block)）
   3) 找 push 之后最近的内核调用"""
import re, struct, collections
SO='_core.cpython-312-x86_64-linux-gnu.so'; DIS='/tmp/host.dis'
d=open(SO,'rb').read()
e_phoff,=struct.unpack_from('<Q',d,0x20); pes,pn=struct.unpack_from('<HH',d,0x36)
segs=[]
for i in range(pn):
    o=e_phoff+i*pes
    if struct.unpack_from('<I',d,o)[0]!=1: continue
    segs.append(struct.unpack_from('<QQQ',d,o+8))
def rd(va,n=8):
    for off,addr,sz in segs:
        if addr<=va<addr+sz: return d[off+va-addr:off+va-addr+n]
    return b''
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
    if '__cudaPushCallConfiguration' not in l or 'call' not in l: continue
    block=None; gridx=None
    for j in range(i-1, max(-1,i-140), -1):
        mm=re.search(r'#\s*([0-9a-f]+)\s*<', lines[j])
        if mm and block is None:
            v=rd(int(mm.group(1),16))
            if len(v)>=8:
                lo,hi=struct.unpack('<II', v[:8])
                if 32<=lo<=1024 and 1<=hi<=64: block=(lo,hi)
        if 'block_count' in lines[j] and gridx is None: gridx='block_count(n)'
    kern=None
    # 找 push 之后第一次 cudaLaunchKernel，再回看它前面加载的内核指针符号
    launch=None
    for j in range(i+1, min(len(lines), i+80)):
        if 'cudaLaunchKernel@plt' in lines[j] and 'call' in lines[j]:
            launch=j; break
    if launch:
        for j in range(launch, max(i, launch-25), -1):
            mm=re.search(r'#\s*[0-9a-f]+\s*<(.*)', lines[j])
            if mm and 'synreal::' in mm.group(1):
                kern=mm.group(1).split('(')[0].strip(); break
    rows.append(dict(f=func_of(i), site=l.split(':')[0].strip(), block=block, gridx=gridx, k=kern))
cnt=collections.Counter(r['block'] for r in rows)
out=['# 每次 kernel launch 的 grid / block（启发式恢复）','',
     '> 机制：调用方 `__cudaPushCallConfiguration(grid, block, smem, stream)` → stub 内 `__cudaPopCallConfiguration`。',
     '> block 从 push 前引用的 `.rodata` dim3 常量读出；grid.x 多为 `block_count(n)=ceil(n/block)`。','',
     f'push 点 {len(rows)} 个；block 分布如下：','']
for b,n in cnt.most_common(): out.append(f'- block={b} : {n} 次')
out += ['','## 明细（前 60 条）','','| 函数 | 点 | kernel | block | grid.x |','|---|---|---|---|---|']
for r in rows[:60]:
    out.append(f"| `{r['f'][:44]}` | 0x{r['site']} | `{(r['k'] or '?')[:56]}` | {r['block']} | {r['gridx'] or '?'} |")
open('_re_analysis/host/LAUNCH_CONFIG.md','w').write('\n'.join(out)+'\n')
print(f'push 点 {len(rows)}')
for b,n in cnt.most_common(5): print('  block', b, n)
print('kernel 可识别:', sum(1 for r in rows if r['k']))
print('grid.x=block_count:', sum(1 for r in rows if r['gridx']))
