"""按"被引用"而不是"长得像"来提取 .rodata 常量：
   扫描反汇编里 rip 相对寻址的注释地址，只保留 synreal 相关函数里的引用，再读值分类。"""
import re, struct, collections
SO='_core.cpython-312-x86_64-linux-gnu.so'; DIS='/tmp/host.dis'
d=open(SO,'rb').read()
e_phoff,=struct.unpack_from('<Q',d,0x20); pes,pn=struct.unpack_from('<HH',d,0x36)
segs=[struct.unpack_from('<QQQ',d,e_phoff+i*pes+8) for i in range(pn) if struct.unpack_from('<I',d,e_phoff+i*pes)[0]==1]
e_shoff,=struct.unpack_from('<Q',d,0x28); sz,shnum,shstr=struct.unpack_from('<HHH',d,0x3a)
base=e_shoff+shstr*sz; stroff,=struct.unpack_from('<Q',d,base+0x18)
secmap={}
for i in range(shnum):
    o=e_shoff+i*sz
    no,=struct.unpack_from('<I',d,o); addr,off,size=struct.unpack_from('<QQQ',d,o+0x10)
    secmap[(addr,addr+size)]=d[stroff+no:d.index(b'\0',stroff+no)].decode()
def which(va):
    for (a,b),n in secmap.items():
        if a<=va<b: return n
    return '?'
def rd(va,n=16):
    for off,addr,sz in segs:
        if addr<=va<addr+sz: return d[off+va-addr: off+va-addr+n]
    return b''
lines=open(DIS,errors='replace').read().splitlines()
refs=collections.Counter(); ctx=collections.defaultdict(list); ops=collections.defaultdict(collections.Counter)
cur=''
for l in lines:
    m=re.match(r'^[0-9a-f]+ <(.*)>:$', l)
    if m: cur=m.group(1)
    mm=re.search(r'#\s*([0-9a-f]+)\s*(?:<([^>]*)>)?', l)
    if not mm: continue
    mop=re.search(r':\s+(\S+)\s', l); opcode=mop.group(1) if mop else '?'
    va=int(mm.group(1),16)
    sec=which(va)
    if sec not in ('.rodata','.data.rel.ro'): continue
    refs[(va,sec)]+=1
    ops.setdefault((va,sec), collections.Counter())[opcode]+=1
    if len(ctx[(va,sec)])<2 and ('Solver' in cur or 'kernel' in cur):
        ctx[(va,sec)].append(cur[:70])
rows=[]
for (va,sec),n in refs.most_common(60):
    b=rd(va,16)
    u=struct.unpack('<4I',b) if len(b)>=16 else ()
    f=struct.unpack('<4f',b) if len(b)>=16 else ()
    rows.append((va,sec,n,u,f,ctx[(va,sec)]))
fl=[r for r in rows if ops[(r[0],r[1])].get('movss',0) or ops[(r[0],r[1])].get('movsd',0)]
it=[r for r in rows if not (ops[(r[0],r[1])].get('movss',0) or ops[(r[0],r[1])].get('movsd',0))
              and (ops[(r[0],r[1])].get('mov',0)+ops[(r[0],r[1])].get('movl',0)+ops[(r[0],r[1])].get('movq',0))>0]
out=['# 被真实引用的 `.rodata` 常量（按引用点分类）','',
     '> 来源：反汇编 rip 相对寻址的注释地址；按**引用它的指令**分类，避免把字符串当浮点解读。','',
     '## 浮点常量（引用指令为 `movss`/`movsd`）','','| 地址 | 值 | 引用次数 | 首个引用者 |','|---|---|---|---|']
for va,sec,n,u,f,c in fl[:40]:
    out.append(f'| 0x{va:x} | ' + ', '.join(f'{x:g}' for x in f[:2]) + f' | {n} | `{(c[0] if c else "")[:46]}` |')
out += ['', '## 整型 / dim3 常量（`mov`/`movl` 直接取 8 字节）','','| 地址 | u32 | 引用次数 | 首个引用者 |','|---|---|---|---|']
for va,sec,n,u,f,c in it[:30]:
    out.append(f'| 0x{va:x} | {u[:3]} | {n} | `{(c[0] if c else "")[:46]}` |')
open('_re_analysis/host/RODATA_REFS.md','w').write('\n'.join(out)+'\n')
print('引用到的常量地址数:', len(refs))
for va,sec,n,u,f,c in rows[:12]:
    print(f'  0x{va:x} {sec} x{n}  u32={u[:3]}  f32={tuple(round(x,4) for x in f[:3])}')
