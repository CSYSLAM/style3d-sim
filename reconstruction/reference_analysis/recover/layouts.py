"""从 PTX 的按值 struct 参数访问反推字段布局：偏移 / 宽度 / 访问类型"""
import sys, re, glob, collections, json
sys.path.insert(0,'.')
from ptx2c import parse, parse_mem

SIZE={'u8':1,'s8':1,'b8':1,'u16':2,'s16':2,'b16':2,'u32':4,'s32':4,'b32':4,
      'f32':4,'u64':8,'s64':8,'b64':8,'f64':8,'pred':4}
TOTALS={}  # 由 TYPE_SIZES 提供（可选）

def split_head(p):
    d=0
    for i,ch in enumerate(p):
        if ch=='<': d+=1
        elif ch=='>': d-=1
        elif ch=='(' and d==0: return p[:i], p[i:]
    return p,''
def split_args(s):
    out=[];d=0;cur=''
    for ch in s:
        if ch in '<([': d+=1
        elif ch in '>)]': d-=1
        if ch==',' and d==0: out.append(cur);cur=''
        else: cur+=ch
    if cur.strip(): out.append(cur)
    return out
def argtypes(sig):
    head,rest=split_head(sig)
    return [a.strip() for a in split_args(rest[1:rest.rfind(')')])] if rest else []

files=[f for f in sorted(glob.glob('../kernels/*/*.ptx'))
       if not re.search(r'(CUB_|cuda_cub|thrust)', f)]
fields=collections.defaultdict(lambda: collections.defaultdict(collections.Counter))

for f in files:
    k=parse(f); args=argtypes(k.sig)
    byval={p['index']:p for p in k.params if p['size'] and p['ptx']=='b8'}
    for idx,p in byval.items():
        t=args[idx] if idx<len(args) else f'param{idx}'
        if t.endswith(('*','&')): continue
        for s in k.instrs:
            m=re.match(r'^(ld|st)\.(.+?)(;|$|\s)', s)
            if not m: continue
            parts=[x for x in m.group(2).split('.') if x]
            nvec=next((int(x[1:]) for x in parts if re.fullmatch(r'v\d',x)), 1)
            ty=next((x for x in parts if x in SIZE), None)
            if not ty: continue
            for mm in re.finditer(r'\[([^\]]+)\]', s):
                parsed=parse_mem('['+mm.group(1)+']')
                if not parsed: continue
                base,off=parsed
                if base!=p['name']: continue
                for i in range(nvec):
                    fields[t][off+i*SIZE[ty]][ty]+=1

order={'f32':0,'u32':1,'s32':1,'b32':1,'u64':2,'s64':2,'b64':2,'f64':2,'u16':3,'u8':4}
out=['# 结构体字段布局（从 PTX 的参数访问反推）','',
     '> 每个条目是"某 kernel 通过按值参数访问到该结构体的 +偏移"，因此只覆盖**真正被读到的字段**；',
     '> 未被任何 kernel 访问的字段不会出现（这是下界，不是完整定义）。','']
for t in sorted(fields):
    offs=sorted(fields[t])
    out.append(f'## `{t}`')
    out.append('')
    out.append('| 偏移 | 宽度 | 访问类型 | 命中次数 |')
    out.append('|---|---|---|---|')
    for o in offs:
        for ty,n in sorted(fields[t][o].items(), key=lambda kv: order.get(kv[0],9)):
            out.append(f'| +0x{o:03x} | {SIZE[ty]} | {ty} | {n} |')
    out.append('')
    # 连续字段合并提示
    span=max(offs)+4
    out.append(f'访问覆盖：0x000–0x{max(offs):03x}（{len(offs)} 个偏移，跨度 {span} B）')
    out.append('')
open('LAYOUTS.md','w').write('\n'.join(out)+'\n')
print(f'struct 类型 {len(fields)} 个，已写入 LAYOUTS.md')
for t in sorted(fields): print(f'  {t:45s} {len(fields[t])} 个偏移, 最高 0x{max(fields[t]):x}')
