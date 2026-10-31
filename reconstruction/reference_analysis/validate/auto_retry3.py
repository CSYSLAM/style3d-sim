"""对 src/ 里的机械还原做批量 A/B：自动生成 spec（无脑填充），跑不通就归类。
   每个 kernel 独立进程，避免一次非法访存毁掉整个上下文。"""
import os, re, json, subprocess, sys
sys.path.insert(0,'.')
from mkjit import extract
NVCC='/usr/local/cuda/bin/nvcc'; CUOBJ='/usr/local/cuda/bin/cuobjdump'
SRC='../recover/src'; OUT='auto_cubins'; os.makedirs(OUT, exist_ok=True)
K={k['mangled']:k for k in json.load(open('../kernels.json'))}

def cubin_entry(path):
    s=subprocess.run([CUOBJ,'-symbols',path],capture_output=True,text=True).stdout
    for l in s.splitlines():
        if 'STT_FUNC' in l and 'STO_ENTRY' in l: return l.split()[-1]
    return None

def build(cu):
    out=os.path.join(OUT, os.path.basename(cu).replace('.cu','.cubin'))
    r=subprocess.run([NVCC,'-O3','-arch=sm_120','-cubin','-o',out,cu,'-I','../recover'],
                     capture_output=True,text=True)
    return (out,None) if r.returncode==0 else (None, r.stderr[:120])

def spec_for(label, cu, cubin, fill='idx'):
    name=cubin_entry(cubin)
    # 从 .cu 的注释里拿 mangled（机械还原文件头写了原签名，但没有 mangled）
    # 改用 kernels.json 按 kernel 短名匹配
    head=open(cu).readline().strip()
    sig=head.split('机械还原自 PTX：')[-1].strip()
    cand=[m for m,k in K.items() if k['pretty']==sig]
    if not cand:
        base=os.path.basename(cu)[:-3]
        cand=[m for m,k in K.items() if re.sub(r'[^A-Za-z0-9_]','_',k['disp'].split('<')[0])[:50] in base]
    if not cand: return None
    mangled=cand[0]
    # 形参表
    pt=open(os.path.join('../kernels', K[mangled]['file'].split('/kernels/')[1])).read() if False else None
    ptx_path='_auto.ptx'
    open(ptx_path,'w').write(extract(mangled))
    params=re.findall(r'^\.param(?: \.align \d+)? \.(\S+) \S+_param_(\d+)', open(ptx_path).read(), re.M)
    sizes=re.findall(r'^\.param \.align \d+ \.b8 \S+_param_(\d+)\[(\d+)\]', open(ptx_path).read(), re.M)
    byval={int(i):int(s) for i,s in sizes}
    lines=[f'label {label}', f'ptx {ptx_path}', f'cubin {cubin}', f'name_ptx {mangled}', f'name_cubin {name}',
           'grid 1 1 1', 'block 64 1 1']
    # 用 demangled 签名区分"指针"与"u64 标量"（PTX 里两者都是 .u64）
    def split_args(x):
        out=[];d=0;cur=''
        for ch in x:
            if ch in '<([': d+=1
            elif ch in '>)]': d-=1
            if ch==',' and d==0: out.append(cur); cur=''
            else: cur+=ch
        if cur.strip(): out.append(cur)
        return [a.strip() for a in out]
    pretty=K[mangled]['pretty']
    arglist=[]
    if '(' in pretty:
        k=pretty.rfind('>(')          # 参数表从最后一个 ">(" 开始（前面的括号属于模板实参）
        i0 = k+1 if k>=0 else pretty.index('(')
        i1=pretty.rfind(')')
        arglist=split_args(pretty[i0+1:i1])
    for ty,idx in params:
        i=int(idx)
        t=arglist[i] if i < len(arglist) else ''
        if i in byval: lines.append(f'byval {byval[i]}')
        elif t.endswith('*'):
            # 按元素类型给足缓冲：n=64
            n=64
            if 'BlockNonZeroEntry' in t: sz=n*64*40     # 覆盖 max_nnz ≤ 64
            elif 'NonZeroEntry' in t: sz=n*64*8
            elif 'mat<3, 3' in t or 'mat<3,3' in t: sz=n*36
            elif 'vec<4' in t: sz=n*16
            elif 'vec<3' in t: sz=n*12
            elif 'float' in t: sz=n*4
            elif 'int' in t: sz=n*4
            elif 'unsigned long' in t: sz=(n+1)*8   # CSR 需要 n+1 个
            else: sz=n*4
            u64arr = ('unsigned long' in t) or ('size_t' in t) or ('Span' in t)
            farr   = ('float' in t) or ('double' in t)
            if fill=='zero': lines.append(f'ptr zero {sz}')
            elif farr: lines.append(f'ptr small {sz}')          # 浮点数组填 0.5~0.66，避免次正规数
            elif u64arr: lines.append(f'ptr idx64 {sz} {64 if fill!="idx4" else 4}')
            elif fill=='idx4': lines.append(f'ptr idx {sz} 4')
            else: lines.append(f'ptr idx {sz} 64')
        elif 'float' in t: lines.append('f32 0.5')
        elif 'bool' in t: lines.append('u32 1')
        elif 'int' in t: lines.append('u32 64')
        elif ty in ('u64','s64','b64'): lines.append('u64 64')   # 标量
        else: lines.append('u64 64')
    return '\n'.join(lines)+'\n'

ALL=sorted(os.path.join(d,f) for d,_,fs in os.walk(SRC) for f in fs if f.endswith('.cu'))
files=[f for f in ALL if any(k in f for k in ('evaluate_cables','prepare_cable_tangents','update_cable_penalties'))]
limit=int(sys.argv[1]) if len(sys.argv)>1 else 999
res=[]
for i,f in enumerate(files[:limit]):
    label=os.path.basename(f)[:-3]; cu=f
    cubin,err=build(cu)
    if not cubin: res.append((label,'COMPILE_FAIL',err)); print(f'[{i+1}/{limit}] COMPILE_FAIL {label}', flush=True); continue
    best=('FAIL','')
    for fill in ('zero','idx','idx4'):
        spec=spec_for(label,cu,cubin, fill)
        if not spec: break
        open(f'_auto.spec','w').write(spec)
        try:
            r=subprocess.run(['./ab','_auto.spec'],capture_output=True,text=True,timeout=20)
            tail=(r.stdout+r.stderr).strip().splitlines()[-1] if (r.stdout+r.stderr).strip() else ''
            st='PASS' if 'RESULT PASS ' in tail else ('PASS_TOL' if 'PASS_TOL' in tail else 'FAIL')
            if 'illegal memory' in tail or 'invalid argument' in tail: st='OOB'
        except subprocess.TimeoutExpired:
            subprocess.run(['pkill','-9','-x','ab']); st='TIMEOUT'; tail='timeout'
        # 只有"输出非零"的通过才算强证据；全零输出视为空转，继续换填充
        m_nz=re.search(r'写入 (\d+)/(\d+)', tail)
        has_work = bool(m_nz and int(m_nz.group(1))>0)
        if st in ('PASS','PASS_TOL') and has_work:
            best=(st, f'{fill}:{tail[:140]}'); break
        if st in ('PASS','PASS_TOL') and not has_work:
            if best[0] not in ('PASS','PASS_TOL'):
                best=('PASS_EMPTY' if st=='PASS' else 'PASS_EMPTY_TOL', f'{fill}:{tail[:140]}')
            continue
        if best[0] in ('FAIL',):
            best=(st, f'{fill}:{tail[:140]}')
    st, tail = best
    if spec is None: res.append((label,'NO_MANGLED','')); print(f'[{i+1}/{limit}] NO_MANGLED {label}', flush=True); continue
    res.append((label,st,tail[:110]))
    print(f'[{i+1}/{min(limit,len(files))}] {st:10s} {label[:52]}', flush=True)
json.dump([{'kernel':a,'status':b,'detail':c} for a,b,c in res], open('auto_results.json','w'), indent=1)
from collections import Counter
print('\n', dict(Counter(r[1] for r in res)))
