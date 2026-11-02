import re, os, json, glob, struct, subprocess, collections
OUT='_re_analysis'; KDIR=f'{OUT}/kernels'
raw=open(f'{OUT}/cuda/all.ptx').read()

def elf_sections(path):
    d=open(path,'rb').read()
    shoff,=struct.unpack_from('<Q',d,0x28)
    sz,shnum,shstrndx=struct.unpack_from('<HHH',d,0x3a)
    base=shoff+shstrndx*sz; stroff,=struct.unpack_from('<Q',d,base+0x18)
    out={}
    for i in range(shnum):
        o=shoff+i*sz
        no,=struct.unpack_from('<I',d,o); size,=struct.unpack_from('<Q',d,o+0x20)
        out[d[stroff+no:d.index(b'\0',stroff+no)].decode()]=size
    return out

sass={}
for c in glob.glob('/tmp/cubins/*.cubin'):
    for k,v in elf_sections(c).items():
        if k.startswith('.text._ZN'):
            n=k[len('.text.'):]
            sass[n]=max(sass.get(n,0), v//16)

res={}; cur=None
for line in open(f'{OUT}/cuda/res_usage.txt', errors='replace'):
    m=re.match(r'\s*Function (\S+):', line)
    if m: cur=m.group(1); res[cur]={}
    elif cur and 'REG:' in line:
        for k,v in re.findall(r'(\w+(?:\[\d+\])?):(\d+)', line): res[cur][k]=int(v)

kernels=[]
for chunk in raw.split('Fatbin ptx code:')[1:]:
    tag=re.search(r'_INTERNAL_[0-9a-f]+_[0-9]+_([a-z0-9_]+_cu)', chunk)
    cu=tag.group(1).replace('_cu','.cu') if tag else 'unknown.cu'
    for part in re.split(r'(?m)^\.visible \.entry ', chunk)[1:]:
        name=part.split('(')[0].strip()
        m=re.search(r'(?m)^\.visible \.entry '+re.escape(name)+r'\(.*?\n\}\n', part, re.S)
        body=m.group(0) if m else part
        mx=re.search(r'\.maxntid ([\d, ]+)', body)
        kernels.append(dict(cu=cu, mangled=name, body=body, ptx_lines=body.count('\n'),
            params=re.findall(r'^\.param \.(\S+) ', body, re.M),
            maxntid=mx.group(1).strip() if mx else '',
            res=res.get(name,{}), sass=sass.get(name,0),
            n_atomic=len(re.findall(r'\bred\.global|\batom\.', body)),
            n_div=len(re.findall(r'\bdiv\.rn\.f32', body)),
            n_sqrt=len(re.findall(r'\bsqrt\.rn\.f32|\brsqrt\.', body)),
            n_sync=len(re.findall(r'\bbar\.sync', body)),
            n_local=len(re.findall(r'(?m)^\.local', body)),
            n_branch=len(re.findall(r'(?m)^\s*(?:@%\w+ )?bra', body))))
dem=subprocess.run(['c++filt'], input='\n'.join(k['mangled'] for k in kernels),
                   capture_output=True, text=True).stdout.splitlines()
for k,d in zip(kernels,dem): k['pretty']=d.strip()

def conv_vec(m):
    n,ty=int(m.group(1)),m.group(2).strip()
    if ty=='float': return {2:'glm::vec2',3:'glm::vec3',4:'glm::vec4'}[n]
    return f'glm::{"u" if ty.startswith("unsigned") else "i"}vec{n}'
def conv_mat(m):
    a,b=int(m.group(1)),int(m.group(2))
    return f'glm::mat{a}x{b}' if a!=b else f'glm::mat{a}'
def norm(t):
    t=re.sub(r'glm::vec<(\d+), ([\w ]+?), \(glm::qualifier\)\d+>', conv_vec, t)
    t=re.sub(r'glm::mat<(\d+), (\d+), float, \(glm::qualifier\)\d+>', conv_mat, t)
    return t.replace('unsigned long','size_t').strip()
def split_args(s):
    out=[];d=0;cur=''
    for ch in s:
        if ch in '<([': d+=1
        elif ch in '>)]': d-=1
        if ch==',' and d==0: out.append(cur); cur=''
        else: cur+=ch
    if cur.strip(): out.append(cur)
    return out
def proto(k):
    head,rest=split_head(k['pretty'])
    if not rest: return k['pretty']
    inner=rest[1:rest.rfind(')')]
    return head+'('+', '.join(norm(a) for a in split_args(inner))+')'

def split_head(p):
    """在尖括号深度为 0 处切出 名字 / 形参表，避免 glm::qualifier(...) 里的 '(' 误伤"""
    d=0
    for i,ch in enumerate(p):
        if ch=='<': d+=1
        elif ch=='>': d-=1
        elif ch=='(' and d==0: return p[:i], p[i:]
    return p, ''

def disp(k):
    p=split_head(k['pretty'])[0].strip()
    p=re.sub(r'^void\s+','',p)
    if '::{lambda' in p: p=p.split('::{lambda')[0]+'::lambda'
    p=re.sub(r'^(?:synreal::)?(?:kernel|fluid_kernel|granular_kernel|self_collision_kernel|pcg|lbvh\w*)::','',p)
    p=re.sub(r'^synreal::','',p)
    p=re.sub(r'synreal::','',p)
    p=re.sub(r'\b(?:THRUST_\d+_\d+_NS|cub|thrust)::','',p)
    return p
def basename(k):
    return re.sub(r'[^A-Za-z0-9_<>:]','_',disp(k))[:95]

os.makedirs(KDIR, exist_ok=True)
groups=collections.defaultdict(list)
for k in kernels: groups[k['cu']].append(k)
for cu, ks in groups.items():
    d=os.path.join(KDIR, cu.replace('.cu','')); os.makedirs(d, exist_ok=True)
    ks.sort(key=lambda k:k['pretty'])
    for i,k in enumerate(ks,1):
        fn=os.path.join(d, f'{i:03d}_{basename(k)}.ptx'); k['file']=fn
        hdr=[f'// [{cu}] kernel {i}/{len(ks)}   PTX {k["ptx_lines"]} 行   SASS {k["sass"]} 条指令',
             f'// 签名: {k["pretty"]}',
             f'// 归一化原型: {proto(k)}',
             f'// maxntid: {k["maxntid"] or "(未指定)"}   ptxas: REG={k["res"].get("REG","?")} SHARED={k["res"].get("SHARED",0)} LOCAL={k["res"].get("LOCAL",0)}',
             f'// 计数: atomic={k["n_atomic"]} div={k["n_div"]} sqrt={k["n_sqrt"]} barrier={k["n_sync"]} local={k["n_local"]} branch={k["n_branch"]}']
        open(fn,'w').write('\n'.join(hdr)+'\n\n'+k['body']+'\n')
for k in kernels: k['disp']=disp(k)
json.dump([{kk:vv for kk,vv in k.items() if kk!='body'} for k in kernels], open(f'{OUT}/kernels.json','w'), indent=1)

# ---- index ----
def diff(k):
    s=k['sass']
    if s<200: return '☆☆☆☆'
    if s<800: return '★☆☆☆'
    if s<2500: return '★★☆☆'
    if s<5000: return '★★★☆'
    return '★★★★'
order=['solver_newton.cu','fluid.cu','granular.cu','pcg_solver.cu','self_collision.cu','lbvh_builder.cu']
md=['# CUDA kernel 全量清单','',
    f'从 `.nv_fatbin` 的 6 份 PTX 中提取，共 **{len(kernels)} 个 entry**，其中 `synreal::` 自研 {sum(1 for k in kernels if "synreal::" in k["pretty"])} 个；'
    '其余为 thrust/cub 实例（`DeviceRadixSort*`、`_kernel_agent<...>` 等），单独列出便于排除。','',
    '每个 kernel 的完整 PTX：`_re_analysis/kernels/<模块>/NNN_<名>.ptx`（文件头带签名/原型/maxntid/ptxas 资源/指令计数）。','',
    '`体量` 按 SASS 指令数分档（☆☆☆☆ <200，★☆☆☆ <800，★★☆☆ <2500，★★★☆ <5000，★★★★ ≥5000）——★越多越值得先对公式、后对细节。','']
md += ['## 总览','','| 源文件 | entry | 自研 | SASS 指令合计 | 最大单 kernel |','|---|---|---|---|---|']
for cu in order:
    ks=groups[cu]; sr=[k for k in ks if 'synreal::' in k['pretty']]
    md.append(f'| `{cu}` | {len(ks)} | {len(sr)} | {sum(k["sass"] for k in ks):,} | {max(ks,key=lambda k:k["sass"])["sass"]:,} |')
md.append(f'| **合计** | **{len(kernels)}** | **{sum(1 for k in kernels if "synreal::" in k["pretty"])}** | **{sum(k["sass"] for k in kernels):,}** | |')
md.append('')
for cu in order:
    ks=sorted(groups[cu], key=lambda k:-k['sass'])
    sr=[k for k in ks if 'synreal::' in k['pretty']]; tp=[k for k in ks if 'synreal::' not in k['pretty']]
    md += [f'## `{cu}` — {len(sr)} 个自研 kernel' + (f' + {len(tp)} 个第三方实例' if tp else ''), '',
           '| # | kernel | SASS | PTX 行 | REG | maxntid | 关键特征 | 体量 |','|---|---|---|---|---|---|---|---|']
    for i,k in enumerate(sr,1):
        f=[]
        if k['n_atomic']: f.append(f'atomic×{k["n_atomic"]}')
        if k['n_div']: f.append(f'div×{k["n_div"]}')
        if k['n_sqrt']: f.append(f'sqrt×{k["n_sqrt"]}')
        if k['n_sync']: f.append(f'bar×{k["n_sync"]}')
        if k['n_local']: f.append('local数组')
        md.append(f'| {i} | `{disp(k)}` | {k["sass"]:,} | {k["ptx_lines"]} | {k["res"].get("REG","")} | {k["maxntid"] or "-"} | {", ".join(f) or "-"} | {diff(k)} |')
    if tp:
        md += ['', f'<details><summary>第三方实例 {len(tp)} 个（点击展开）</summary>','']
        md += [f'- `{disp(k)[:120]}` — SASS {k["sass"]}' for k in tp[:40]]
        md += ['','</details>']
    md.append('')
open(f'{OUT}/KERNEL_INDEX.md','w').write('\n'.join(md))

# ---- prototypes ----
h=['// 从 PTX 形参类型 + mangled 名还原的精确原型（参数名不可恢复）',
   '// 类型已归一化：glm::vec<3,float,(glm::qualifier)0> -> glm::vec3，unsigned long -> size_t',
   '// 行尾 SASS 指令数用于判断体量；可按模块逐个与源码对签。','',
   '#include <glm/glm.hpp>','#include <cstddef>','']
for cu in order:
    h.append(f'// ===================== {cu} =====================')
    for k in sorted(groups[cu], key=lambda k:k['pretty']):
        if 'synreal::' not in k['pretty']: continue
        h.append(f'{proto(k)};   // SASS {k["sass"]}')
    h.append('')
open(f'{OUT}/kernel_prototypes.h','w').write('\n'.join(h))

# ---- checklist ----
c=['# 源码对照清单','','逐行对完就在 `[ ]` 打勾；`PTX` 列是行数，`SASS` 是真实指令数（按 cubin 段大小算）。','']
for cu in order:
    ks=sorted([k for k in groups[cu] if 'synreal::' in k['pretty']], key=lambda k:-k['sass'])
    c += [f'## {cu}（{len(ks)}）','', '| 对齐 | kernel | PTX | SASS |', '|---|---|---|---|']
    for k in ks:
        c.append(f'| [ ] | `{disp(k)}` | {k["ptx_lines"]} | {k["sass"]:,} |')
    c.append('')
open(f'{OUT}/CHECKLIST.md','w').write('\n'.join(c))
print('kernels', len(kernels), 'sass total', sum(k["sass"] for k in kernels))
print('median sass', sorted(k["sass"] for k in kernels)[len(kernels)//2])
