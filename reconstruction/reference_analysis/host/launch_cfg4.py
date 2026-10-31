"""最终版：先按点解析（近邻 rodata 常量），解析不到的按"函数级唯一常量"回填，并标注置信度。"""
import re, struct, collections
SO='_core.cpython-312-x86_64-linux-gnu.so'; DIS='/tmp/host.dis'
d=open(SO,'rb').read()
e_phoff,=struct.unpack_from('<Q',d,0x20); pes,pn=struct.unpack_from('<HH',d,0x36)
segs=[struct.unpack_from('<QQQ',d,e_phoff+i*pes+8) for i in range(pn) if struct.unpack_from('<I',d,e_phoff+i*pes)[0]==1]
def rd(va,n=8):
    for off,addr,sz in segs:
        if addr<=va<addr+sz: return d[off+va-addr:off+va-addr+n]
    return b''
lines=open(DIS,errors='replace').read().splitlines()
heads=[(i,re.match(r'^([0-9a-f]+) <(.*)>:$',l).group(2)) for i,l in enumerate(lines)
       if re.match(r'^([0-9a-f]+) <(.*)>:$',l)]
def func_range(i):
    prev=None; nxt=None
    for li,n in heads:
        if li<=i: prev=(li,n)
        elif nxt is None: nxt=li; break
    return prev, nxt
def dim3_at(j):
    mm=re.search(r'#\s*([0-9a-f]+)\s*<', lines[j])
    if not mm: return None
    v=rd(int(mm.group(1),16))
    if len(v)<8: return None
    lo,hi=struct.unpack('<II', v[:8])
    if 32<=lo<=1024 and 1<=hi<=64: return (lo,hi)
    return None
def kernel_after(i):
    for j in range(i+1, min(len(lines), i+90)):
        if 'cudaLaunchKernel@plt' in lines[j]:
            for k in range(j, max(i,j-25), -1):
                mm=re.search(r'#\s*[0-9a-f]+\s*<(.*)', lines[k])
                if mm and 'synreal::' in mm.group(1):
                    return mm.group(1).split('(')[0].strip()
    return None
rows=[]
for i,l in enumerate(lines):
    if '__cudaPushCallConfiguration' not in l or 'call' not in l: continue
    direct=None
    for j in range(i-1, max(-1,i-140), -1):
        c=dim3_at(j)
        if c: direct=c; break
    rows.append(dict(line=i, site=l.split(':')[0].strip(), direct=direct, kern=kernel_after(i)))
# 函数级唯一常量回填
byfunc=collections.defaultdict(list)
for r in rows:
    prev,_=func_range(r['line']); r['func']=prev[1] if prev else '?'
    byfunc[r['func']].append(r)
for f,rs in byfunc.items():
    vals={r['direct'] for r in rs if r['direct']}
    if len(vals)==1:
        v=vals.pop()
        for r in rs:
            if not r['direct']: r['filled']=v
            r['conf']='direct' if r['direct'] else 'func'
    else:
        for r in rs: r['conf']='direct' if r['direct'] else 'unknown'
md=['# kernel launch 配置（最终版）','',
    '> 两级来源：**direct** = push 点附近直接读到 dim3 常量；**func** = 该函数只用过一个 block 尺寸，按函数级回填；**unknown** = 函数内出现多个尺寸，无法归属。','']
stat=collections.Counter()
for f,rs in sorted(byfunc.items(), key=lambda kv:-len(kv[1])):
    rs=sorted(rs, key=lambda r:r['line'])
    seq=collections.Counter(r.get('direct') or r.get('filled') for r in rs)
    con=collections.Counter(r['conf'] for r in rs)
    md.append(f'## `{f[:80]}` —— {len(rs)} 次 launch')
    md.append('')
    md.append('block 分布：' + '，'.join(f'{k} × {v}' for k,v in seq.most_common()))
    md.append('置信度：' + '，'.join(f'{k} {v}' for k,v in con.items()))
    md.append('')
    md.append('| 点 | kernel | block | 置信度 |')
    md.append('|---|---|---|---|')
    for r in rs:
        b=r.get('direct') or r.get('filled')
        md.append(f"| 0x{r['site']} | `{(r['kern'] or '?')[:58]}` | {b if b else '?'} | {r['conf']} |")
        stat[r['conf']]+=1
    md.append('')
open('_re_analysis/host/LAUNCH_CONFIG.md','w').write('\n'.join(md)+'\n')
print('置信度统计:', dict(stat), '总', len(rows))
for f,rs in sorted(byfunc.items(), key=lambda kv:-len(kv[1]))[:5]:
    print(f'  {f[:56]:58s} {len(rs)} 次')
