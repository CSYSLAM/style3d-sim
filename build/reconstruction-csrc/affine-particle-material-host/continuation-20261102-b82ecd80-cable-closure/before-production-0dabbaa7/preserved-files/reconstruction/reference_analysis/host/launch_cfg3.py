"""精确版：对每个 push 点解析 block 的 dim3（rdx={bx,by}, rcx={bz}）。
   规则：reg ← 立即数 / rodata 常量 / 栈槽(再回溯一次) / 其它寄存器。"""
import re, struct, collections
SO='_core.cpython-312-x86_64-linux-gnu.so'; DIS='/tmp/host.dis'
d=open(SO,'rb').read()
e_phoff,=struct.unpack_from('<Q',d,0x20); pes,pn=struct.unpack_from('<HH',d,0x36)
segs=[struct.unpack_from('<QQQ',d,e_phoff+i*pes+8) for i in range(pn) if struct.unpack_from('<I',d,e_phoff+i*pes)[0]==1]
def rd(va,n=8):
    for off,addr,sz in segs:
        if addr<=va<addr+sz: return d[off+va-addr:off+va-addr+n]
    return b''
LINE=re.compile(r'^\s*([0-9a-f]+):\s+(\S+)\s*(.*)$')
def canon(x):
    n=x.lstrip('%')
    m=re.fullmatch(r'r(1[0-5]|[89])d?', n)
    if m: return m.group(1)
    m=re.fullmatch(r'[er]?(ax|bx|cx|dx|si|di|sp|bp)', n)
    return m.group(1) if m else n
def parse(op):
    op=op.strip().lstrip('$')
    if re.fullmatch(r'-?0x[0-9a-f]+|-?\d+', op): return ('imm', int(op,16) if 'x' in op else int(op))
    m=re.fullmatch(r'%(\w+)', op)
    if m: return ('reg', m.group(1))
    m=re.fullmatch(r'(-?0x[0-9a-f]+|-?\d+)\(%(\w+)\)', op)
    if m: return ('mem', int(m.group(1),16) if 'x' in m.group(1) else int(m.group(1)), m.group(2))
    return ('other', op)
def val(t, lines, idx, depth=0):
    if t is None or depth>5: return None
    kind=t[0]
    if kind=='imm': return t[1]
    if kind=='reg': return val(def_of(t[1], lines, idx), lines, idx, depth+1)
    if kind=='mem':
        off,base=t[1],t[2]
        if base=='rip':
            mm=re.search(r'#\s*([0-9a-f]+)', lines[idx])
            if mm:
                v=rd(int(mm.group(1),16))
                return struct.unpack('<Q',v)[0] if len(v)>=8 else None
            return None
        if base=='rsp': return val(store_of(off, lines, idx), lines, idx, depth+1)
    return None
def def_of(reg, lines, idx):
    for j in range(idx-1, max(-1,idx-300), -1):
        m=LINE.match(lines[j])
        if not m: continue
        op=m.group(2); args=m.group(3)
        parts=[a.strip() for a in args.split(',')]
        if op in ('mov','movabs','movl','movq','lea') and parts and canon(parts[-1])==canon(reg):
            if op=='lea': return ('other','lea')
            return parse(parts[0])
    return None
def store_of(off, lines, idx):
    for j in range(idx-1, max(-1,idx-300), -1):
        m=LINE.match(lines[j])
        if not m: continue
        op=m.group(2); args=m.group(3)
        parts=[a.strip() for a in args.split(',')]
        if op in ('mov','movl','movq','movabs') and len(parts)==2:
            t=parse(parts[1])
            if t[0]=='mem' and t[2]=='rsp' and t[1]==off:
                return parse(parts[0])
    return None
lines=open(DIS,errors='replace').read().splitlines()
res=[]
for i,l in enumerate(lines):
    if '__cudaPushCallConfiguration' not in l or 'call' not in l: continue
    bx_by=val(def_of('dx',lines,i), lines, i)
    bz=val(def_of('cx',lines,i), lines, i)
    gx_gy=val(def_of('di',lines,i), lines, i)
    gz=val(def_of('si',lines,i), lines, i)
    res.append((i, gx_gy, gz, bx_by, bz))
def dim(pair, z):
    if pair is None: return ('?','?','?')
    x=pair & 0xffffffff; y=(pair>>32)&0xffffffff
    return (x,y, z if z is not None else '?')
cnt=collections.Counter()
detail=[]
for i,g,gz,b,bz in res:
    blk=dim(b,bz); grd=dim(g,gz)
    cnt[blk]+=1
    detail.append((i,grd,blk))
print('push 点:', len(res))
for k,v in cnt.most_common(8): print(f'  block={k}: {v}')
known=sum(v for k,v in cnt.items() if k[0]!='?')
print(f'解析成功: {known}/{len(res)} ({known/len(res)*100:.0f}%)')
open('/tmp/launch_cfg3.txt','w').write('\n'.join(f'{i}\t{grd}\t{blk}' for i,grd,blk in detail))
