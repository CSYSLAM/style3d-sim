#!/usr/bin/env python3
"""Translate this repository's PTX entries to auditable CUDA control/data flow.

CUDA owns parameters, buffers, labels and predicates. Scalar arithmetic uses
small inline PTX expressions to preserve signedness, width, rounding, NaN rules,
bit moves and approximate instructions. Unsupported syntax is a hard error.
Each generated statement retains its source PTX line. No placeholder symbols.
"""
from pathlib import Path
import collections
import hashlib
import json
import os
import re

ROOT = Path(__file__).resolve().parents[1]
GLOBALS = {}
CTYPE = {'u8':'unsigned char','s8':'signed char','b8':'unsigned char',
         'u16':'unsigned short','s16':'short','b16':'unsigned short',
         'u32':'unsigned','s32':'int','b32':'unsigned',
         'u64':'unsigned long long','s64':'long long','b64':'unsigned long long',
         'f32':'float','f64':'double','pred':'int'}
SIZEOF = {t: int(t[1:])//8 for t in CTYPE if t != 'pred'} | {'pred':4}
CONSTRAINT = {2:'h',4:'r',8:'l'}
SPECIAL = {f'%{ptx}.{axis}':f'{cuda}.{axis}' for ptx,cuda in
           [('tid','threadIdx'),('ntid','blockDim'),('ctaid','blockIdx'),('nctaid','gridDim')]
           for axis in 'xyz'}
SPECIAL.update({'%laneid':'(threadIdx.x & 31u)','%warpid':'(threadIdx.x >> 5u)'})
CMP = {'eq':'==','ne':'!=','lt':'<','le':'<=','gt':'>','ge':'>=',
       'lo':'<','ls':'<=','hi':'>','hs':'>=','ltu':'<','leu':'<=',
       'gtu':'>','geu':'>=','equ':'==','neu':'!='}


def load_globals(path=None):
    path = Path(path) if path else ROOT/'cuda/all.ptx'
    GLOBALS.clear()
    for line in path.read_text().splitlines():
        m = re.fullmatch(r'\.global \.align (\d+) \.b8 (\w+)\[(\d+)\](?: = \{([^}]*)\})?;',line)
        if m:
            align,name,size,values=m.groups()
            item=(int(size),int(align),values or '0')
            if name in GLOBALS and GLOBALS[name]!=item:raise ValueError(f'Conflicting global: {name}')
            GLOBALS[name]=item


def split_top(s):
    out=[];depth=0;start=0
    for i,ch in enumerate(s):
        if ch in '{[(':depth+=1
        elif ch in '}])':depth-=1
        elif ch==',' and depth==0:out.append(s[start:i].strip());start=i+1
    if s[start:].strip():out.append(s[start:].strip())
    return out


def parse_mem(s):
    m=re.fullmatch(r'\[([^\[\]]+)\]',s)
    if not m:raise ValueError(f'Memory operand: {s}')
    inner=m[1]
    m=re.fullmatch(r'([%\w.$]+)(?:([+-])(-?\d+))?',inner)
    if not m:raise ValueError(f'Address expression: {s}')
    base,sign,offset=m.groups()
    return base, (int(offset)*(1 if sign=='+' else -1)) if sign else 0


class Kernel:
    def __init__(self):
        self.name='';self.sig='';self.params=[];self.regs={};self.reg_types={}
        self.locals=[];self.shared=[];self.instrs=[];self.lines=[];self.extra_regs=[]
        self.extern_syms=set();self.labels={};self.path=None


def parse(path):
    k=Kernel();k.path=Path(path);lines=k.path.read_text().splitlines()
    for line in lines:
        if line.startswith('// 签名:'):k.sig=line.split(':',1)[1].strip()
    i=next(i for i,s in enumerate(lines) if s.strip() and not s.strip().startswith('//'))
    k.name=re.sub(r'^\.visible\s+\.entry\s+','',lines[i].strip()).split('(')[0]
    i+=1
    while lines[i].strip()!=')':
        line=lines[i].strip().rstrip(',')
        m=re.fullmatch(r'\.param(?:\s+\.align (\d+))?\s+\.(\w+)\s+(\w+)(?:\[(\d+)\])?',line)
        if not m:raise ValueError(f'{path}:{i+1}: parameter: {line}')
        align,ty,name,size=m.groups();size=int(size) if size else SIZEOF[ty]
        k.params.append(dict(index=len(k.params),ptx=ty,name=name,size=size,align=int(align) if align else size));i+=1
    for line_no,line in enumerate(lines[i+1:],i+2):
        s=line.strip()
        if not s or s.startswith('//') or s in ('{','}'):continue
        m=re.fullmatch(r'\.reg \.(\w+) %(\w+)(?:<(\d+)>)?;',s)
        if m:
            ty,name,count=m.groups()
            if count:
                k.regs[ty]=(name,int(count))
                for j in range(int(count)):k.reg_types['%'+name+str(j)]=ty
            else:k.extra_regs.append((ty,name));k.reg_types['%'+name]=ty
            continue
        m=re.fullmatch(r'\.(local|shared) \.align (\d+) \.b8 (\w+)\[(\d+)\];',s)
        if m:
            space,align,name,size=m.groups();getattr(k,space if space=='shared' else 'locals').append((name,int(size),int(align)));continue
        if re.fullmatch(r'\.pragma "(?:nounroll|used_bytes_mask \d+)";',s):continue
        if s.startswith('.') or (s.startswith('{') and 'shfl.sync.down.b32' not in s):
            raise ValueError(f'{path}:{line_no}: unsupported syntax: {s}')
        s=s.rstrip(';');k.instrs.append(s);k.lines.append(line_no)
        if s.endswith(':'):k.labels[s[:-1]]=len(k.instrs)-1
    localnames={name for name,_,_ in k.locals+k.shared}
    for s in k.instrs:
        for name in re.findall(r'(?<![%\w])(__\w+)',s):
            if name not in localnames:k.extern_syms.add(name)
    return k


def constraint(ty):return 'f' if ty=='f32' else 'd' if ty=='f64' else CONSTRAINT[SIZEOF[ty]]
def regtype(k,s):return 'u32' if s in SPECIAL else k.reg_types[s]


def rend(s,k,sign_ok=True):
    if s in SPECIAL:return SPECIAL[s]
    if s.startswith('%'):return s[1:]
    for i,p in enumerate(k.params):
        if s==p['name']:return f'(unsigned long long)(uintptr_t)&param{i}'
    for name,_,_ in k.shared:
        if s==name:return f'(unsigned)__cvta_generic_to_shared({name})'
    for name,_,_ in k.locals:
        if s==name:return f'(unsigned long long)__cvta_generic_to_local({name})'
    if s in k.extern_syms:
        if s not in GLOBALS:raise ValueError(f'Missing global: {s}')
        return f'(unsigned long long)(uintptr_t)px_tbl_{s}'
    if re.fullmatch(r'0f[0-9a-fA-F]{8}',s):return f'as_f32(0x{s[2:]}u)'
    if re.fullmatch(r'0d[0-9a-fA-F]{16}',s):return f'as_f64(0x{s[2:]}ull)'
    if re.fullmatch(r'-?\d+|0[xX][\da-fA-F]+',s):return s
    raise ValueError(f'Operand: {s}')


def generic_address(k,base,offset,space):
    # ld.param uses the addressable CUDA parameter object; dynamic parameter
    # pointers also point to this object, not to a hardware parameter address.
    for i,p in enumerate(k.params):
        if base==p['name']:return f'((uintptr_t)&param{i} + ({offset}))'
    address=f'((uintptr_t)({rend(base,k)}) + ({offset}))'
    if space in ('local','shared','global'):
        return f'__cvta_{space}_to_generic({address})'
    return address


def scalar_asm(k,op,args):
    outputs=[];inputs=[]
    dsts=split_top(args[0][1:-1]) if args[0].startswith('{') else [args[0]]
    for dst in dsts:outputs.append(f'"={constraint(regtype(k,dst))}"({rend(dst,k)})')
    operands=['{'+', '.join('%'+str(j) for j in range(len(dsts)))+'}' if len(dsts)>1 else '%0']
    for operand in args[1:]:
        vals=split_top(operand[1:-1]) if operand.startswith('{') else [operand]
        parts=[]
        for v in vals:
            if v.startswith('%'):
                inputs.append(f'"{constraint(regtype(k,v))}"({rend(v,k)})');parts.append('%'+str(len(outputs)+len(inputs)-1))
            else:
                if not re.fullmatch(r'-?\d+|0[fFdD][\da-fA-F]+|0[xX][\da-fA-F]+',v):raise ValueError(v)
                parts.append(v)
        operands.append('{'+', '.join(parts)+'}' if operand.startswith('{') else parts[0])
    return f'asm("{op} '+', '.join(operands)+';" : '+', '.join(outputs)+' : '+', '.join(inputs)+');'



def translate(k,s):
    # Keep the compound warp instruction in one scoped assembly statement.
    if s.startswith('{'):
        pattern=r'\{ \.reg \.f32 r0; \.reg \.pred p; shfl.sync.down.b32 r0\|p, (%\w+), (%\w+), (%\w+), (%\w+); @p add.f32 r0, r0, \1; mov.f32 (%\w+), r0;\}'
        m=re.fullmatch(pattern,s)
        if not m:raise ValueError(f'Compound block: {s}')
        x,delta,clamp,mask,dst=m.groups()
        code='asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }"'
        code+=f' : "=f"({rend(dst,k)}) : "f"({rend(x,k)}), "r"({rend(delta,k)}), "r"({rend(clamp,k)}), "r"({rend(mask,k)}));'
        return code,True
    pred=None
    m=re.match(r'^@(!?%\w+)\s+(.*)$',s)
    if m:pred=m[1].replace('%','');s=m[2]
    op,_,rest=s.partition(' ');args=split_top(rest.strip());tail=op.split('.')[1:];base=op.split('.')[0]
    wrap=lambda c:f'if ({pred}) {{ {c} }}' if pred else c
    types=[t for t in tail if t in CTYPE];ty=types[-1] if types else None
    if base in ('ld','st'):
        space=next((t for t in tail if t in ('param','global','shared','local','const')),'generic')
        mem=args[1] if base=='ld' else args[0];b,off=parse_mem(mem)
        value=args[0] if base=='ld' else args[1]
        vals=split_top(value[1:-1]) if value.startswith('{') else [value]
        result=[]
        for j,v in enumerate(vals):
            addr=generic_address(k,b,off+j*SIZEOF[ty],space)
            # A volatile typed access preserves ordering across the C++/asm
            # boundary, including tree publication after atomics/membar.
            access=f'(*reinterpret_cast<volatile {CTYPE[ty]}*>({addr}))'
            if base=='ld':result.append(f'{rend(v,k)} = {access};')
            else:result.append(f'{access} = ({CTYPE[ty]})({rend(v,k)});')
        return wrap(' '.join(result)),True
    if base in ('atom','red'):
        b,off=parse_mem(args[0] if base=='red' else args[1]);addr=generic_address(k,b,off,'global')
        operation=next(t for t in tail if t in ('add','min','max','exch','cas','and','or','xor'))
        intrinsic={'add':'atomicAdd','min':'atomicMin','max':'atomicMax','exch':'atomicExch','cas':'atomicCAS','and':'atomicAnd','or':'atomicOr','xor':'atomicXor'}[operation]
        values=args[1:] if base=='red' else args[2:]
        call=f'{intrinsic}(reinterpret_cast<{CTYPE[ty]}*>({addr}), '+', '.join(f'({CTYPE[ty]})({rend(v,k)})' for v in values)+');'
        return wrap((rend(args[0],k)+' = ' if base=='atom' else '')+call),True
    if base=='bra':
        if args[0] not in k.labels:raise ValueError(f'Unknown label {args[0]}')
        return wrap('goto '+args[0].replace('$L__','L_')+';'),True
    if base=='ret':return wrap('return;'),True
    if base=='bar':
        if op!='bar.sync' or args!=['0']:raise ValueError(s)
        return wrap('__syncthreads();'),True
    if base=='membar':
        if op!='membar.gl':raise ValueError(s)
        return wrap('__threadfence();'),True
    if base=='cvta':
        space=next(t for t in tail if t in ('global','local','shared'))
        fn=f'__cvta_generic_to_{space}' if 'to' in tail else f'__cvta_{space}_to_generic'
        a=rend(args[1],k)
        a=f'reinterpret_cast<const void*>({a})' if 'to' in tail else a
        return wrap(f'{rend(args[0],k)} = (unsigned long long)(uintptr_t){fn}({a});'),True
    if base=='setp':
        if len(args)!=3 or '|' in args[0]:raise ValueError(s)
        cmp=tail[0];ct=CTYPE[ty];a=f'(({ct})({rend(args[1],k)}))';b=f'(({ct})({rend(args[2],k)}))'
        if cmp not in CMP:raise ValueError(s)
        expr=f'({a} {CMP[cmp]} {b})'
        if ty.startswith('f'):
            unordered=f'(isnan({a}) || isnan({b}))'
            expr=f'({unordered} || {expr})' if cmp.endswith('u') else f'(!{unordered} && {expr})'
        return wrap(f'{rend(args[0],k)} = {expr};'),True
    if ty=='pred':
        a=rend(args[1],k)
        if base=='mov':expr=f'(({a}) != 0)'
        elif base=='not':expr=f'!({a})'
        elif base in ('and','or','xor'):
            sym={'and':'&&','or':'||','xor':'!='}[base];expr=f'(({a}) {sym} ({rend(args[2],k)}))'
        else:raise ValueError(s)
        return wrap(f'{rend(args[0],k)} = {expr};'),True
    if base=='selp':
        return wrap(f'{rend(args[0],k)} = {rend(args[3],k)} ? {rend(args[1],k)} : {rend(args[2],k)};'),True
    if base=='mov' and not args[1].startswith(('%','{')) and not re.fullmatch(r'-?\d+|0[fFdDxX][\da-fA-F]+',args[1]):
        return wrap(f'{rend(args[0],k)} = {rend(args[1],k)};'),True
    if base in {'mov','add','sub','mul','div','rem','min','max','and','or','xor','shl','shr','mad','fma','abs','neg','not','clz','popc','brev','sqrt','rsqrt','rcp','ex2','lg2','sin','cos','bfe','bfi','cvt'}:
        return wrap(scalar_asm(k,op,args)),True
    raise ValueError(f'Unsupported instruction: {s}')


def symbol_name(k):
    sig=re.sub(r'^void\s+','',k.sig.split('(')[0])
    return re.sub(r'[^A-Za-z0-9_]','_',sig)[-90:] or 'kernel'


def emit(k,out_dir,mod):
    def pdecl(p,i):
        return (f'ByVal<{p["size"]}, {p["align"]}> ' if p['ptx']=='b8' else CTYPE[p['ptx']]+' ')+f'param{i}'
    lines=[f'// 机械还原自 PTX：{k.sig}',f'// PTX SHA256: {hashlib.sha256(k.path.read_bytes()).hexdigest()}',
           '// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.', '#include "px_common.h"','']
    for sym in sorted(k.extern_syms):
        if sym not in GLOBALS:raise ValueError(f'Missing global {sym}')
        size,align,values=GLOBALS[sym]
        lines.append(f'__device__ __align__({align}) unsigned char px_tbl_{sym}[{size}] = {{{values}}};')
    lines.append('extern "C" __global__ void '+symbol_name(k)+'('+', '.join(pdecl(p,i) for i,p in enumerate(k.params))+') {')
    bytype=collections.defaultdict(list)
    for name,ty in k.reg_types.items():bytype[ty].append(name[1:])
    for ty,names in bytype.items():lines.append('  '+CTYPE[ty]+' '+', '.join(names)+';')
    for name,size,align in k.locals:lines.append(f'  __align__({align}) unsigned char {name}[{size}];')
    for name,size,align in k.shared:lines.append(f'  __shared__ __align__({align}) unsigned char {name}[{size}];')
    count=0
    for s,line_no in zip(k.instrs,k.lines):
        lines.append(f'  // PTX:{line_no} {s}')
        if s.endswith(':'):lines.append(s.replace('$L__','L_')+';');continue
        code,ok=translate(k,s)
        if not ok:raise ValueError(f'{k.path}:{line_no}')
        lines.append('  '+code);count+=1
    lines.append('}')
    fn=Path(out_dir)/(symbol_name(k)+'.cu');fn.parent.mkdir(parents=True,exist_ok=True);fn.write_text('\n'.join(lines)+'\n')
    return str(fn),count,0,collections.Counter()


def main():
    load_globals();rows=[];seen=set()
    for meta in json.loads((ROOT/'kernels.json').read_text()):
        if 'synreal::' not in meta['pretty'] or '_kernel_agent' in meta['pretty']:continue
        path=ROOT/meta['file'].removeprefix('_re_analysis/');k=parse(path);mod=meta['cu'].removesuffix('.cu')
        fn,ok,bad,_=emit(k,ROOT/'recover/src'/mod,mod)
        if fn in seen:raise ValueError(f'Duplicate output: {fn}')
        seen.add(fn);rows.append(dict(file=str(Path(fn).relative_to(ROOT/'recover')),sig=k.sig,ok=ok,bad=bad,ptx=ok))
    (ROOT/'recover/coverage.json').write_text(json.dumps(rows,indent=1)+'\n')
    print(f'kernels={len(rows)} statements={sum(r["ok"] for r in rows)} unsupported=0')


if __name__=='__main__':main()
