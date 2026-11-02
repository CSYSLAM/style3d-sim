"""运行时差分法反推字段偏移（加强版：每字段多值变异取并集，并按类型对齐回起点）"""
import sys, ctypes, importlib, struct
sys.path.insert(0,'.')
m=importlib.import_module('_core')
HEAD=16
def holder(o): return int.from_bytes(ctypes.string_at(id(o)+HEAD,8),'little')
def snap(a,n=512): return ctypes.string_at(a,n)

ALIGN={'bool':1,'int':4,'float':4,'Span':8,'tuple':4}
def variants(cur):
    t=type(cur).__name__
    if isinstance(cur,bool): return [not cur]
    if isinstance(cur,int):    return [0x7fffffff, -0x7fffffff]
    if isinstance(cur,float):  return [1.2345678e-30, 3.4e38, -7.25e-3]
    if isinstance(cur,tuple):  return [tuple([1.2345678e-30]*len(cur)), tuple([3.4e38]*len(cur))]
    cls=type(cur)
    out=[]
    for ptr,size in [(0xdeadbeef00000000,0x1234),(0x112233445566,7)]:
        try: out.append(cls(ptr=ptr,size=size))
        except Exception:
            try: out.append(cls(ptr,size))
            except Exception: pass
    return out

def probe(obj):
    a=holder(obj); base=snap(a); rows={}
    for name in sorted(type(obj).__dict__):
        if name.startswith('_'): continue
        try: cur=getattr(obj,name)
        except Exception: continue
        if callable(cur): continue
        diff=set()
        for alt in variants(cur):
            try: setattr(obj,name,alt)
            except Exception: break
            after=snap(a)
            diff |= {i for i in range(len(base)) if base[i]!=after[i]}
            try: setattr(obj,name,cur)
            except Exception: pass
        if diff:
            lo=min(diff); hi=max(diff)
            al=ALIGN.get(type(cur).__name__,4)
            lo = lo - (lo % al)
            size={'bool':1,'int':4,'float':4,'tuple':12,'Span':16}.get(type(cur).__name__,8)
            rows[name]=(lo, size, type(cur).__name__)
    return rows

out=['# 运行时反推的字段偏移（`Config` / `Model` / `State` / `Contact` / `Control`）','',
     '> 方法：取 `shared_ptr` holder 指向的 C++ 对象地址 → 快照 → 逐属性写多个极端值 → 内存 diff。',
     '> 偏移已按类型对齐回字段起点；宽度是"观测到的变化字节数"，float 通常 4、bool 1、Span 16。','']
for cls in ['Config','Model','State','Contact','Control']:
    try: o=getattr(m,cls)()
    except Exception as e:
        out.append(f'## {cls}\n\n构造失败：{e}\n'); continue
    rows=probe(o)
    # 一致性检查：对齐 + 不重叠
    items=sorted(rows.items(), key=lambda kv: kv[1][0])
    bad=[]
    end=0
    for name,(off,w,t) in items:
        al={'bool':1,'int':4,'float':4,'tuple':4,'Span':8}.get(t,4)
        if off % al: bad.append(f'{name} 未按 {al} 对齐(0x{off:x})')
        if off < end: bad.append(f'{name} 与前一字段重叠(0x{off:x} < 0x{end:x})')
        end=max(end, off+w)
    out += [f'## {cls}（{len(rows)} 个可写字段，推断 sizeof ≈ 0x{end:x}）','']
    out += [f'> 一致性：{"全部对齐且无重叠 ✅" if not bad else "；".join(bad[:5])}','']
    out += ['| 偏移 | 宽度 | 类型 | 字段 |','|---|---|---|---|']
    for name,(off,w,t) in sorted(rows.items(), key=lambda kv: kv[1][0]):
        out.append(f'| +0x{off:03x} | {w} | {t} | `{name}` |')
    out.append('')
open('_re_analysis/LAYOUT_RUNTIME.md','w').write('\n'.join(out)+'\n')
print('written')
for cls in ['Config','Model']:
    o=getattr(m,cls)(); r=probe(o)
    print(cls, len(r), 'fields; 前5:', [(n,hex(v[0])) for n,v in sorted(r.items(), key=lambda kv: kv[1][0])[:5]])
