import json, re, collections
K=json.load(open('_re_analysis/kernels.json'))
def split_head(p):
    d=0
    for i,ch in enumerate(p):
        if ch=='<': d+=1
        elif ch=='>': d-=1
        elif ch=='(' and d==0: return p[:i],p[i:]
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
def norm(t):
    t=re.sub(r'glm::vec<(\d+), ([\w ]+?), \(glm::qualifier\)\d+>',
             lambda m: ({'float':{2:'glm::vec2',3:'glm::vec3',4:'glm::vec4'}}.get(m.group(2).strip(),{}).get(int(m.group(1)))
                        or f'glm::{"u" if m.group(2).startswith("unsigned") else "i"}vec{m.group(1)}'), t)
    t=re.sub(r'glm::mat<(\d+), (\d+), float, \(glm::qualifier\)\d+>',
             lambda m: f'glm::mat{m.group(1)}x{m.group(2)}' if m.group(1)!=m.group(2) else f'glm::mat{m.group(1)}', t)
    return t.replace('unsigned long','size_t')
sizes=collections.defaultdict(set); where=collections.defaultdict(set)
for k in K:
    if 'synreal::' not in k['pretty']: continue
    head,rest=split_head(k['pretty'])
    args=[a.strip() for a in split_args(rest[1:rest.rfind(')')])] if rest else []
    for align,idx,sz in re.findall(r'^\.param \.align (\d+) \.b8 \S+_param_(\d+)\[(\d+)\]', k['body'], re.M):
        i=int(idx)
        if i<len(args) and not args[i].endswith('*'):
            t=norm(args[i]); sizes[t].add(int(sz)); where[t].add(k['cu'])
rows=['# 按值传递的自定义类型尺寸（从 PTX `.param .b8 name[N]` 反出）','',
      '> 判据：kernel 形参若是 `.param .b8 ..._[N]` 而非 `.param .u64`，说明该类型按值传递，N 就是 `sizeof(T)`。',
      '> 这张表可以直接和你的 `struct` 定义对——差 1 字节就说明字段/对齐对不上。',
      '> 带 `&` 的（如 `synreal::Model&`）在 kernel 侧是按值拷贝进 1864 字节参数区，核对时注意源码签名与 ABI 的差异。','',
      '| 类型 | sizeof | 出现在 |','|---|---|---|']
for t in sorted(sizes, key=lambda x: min(sizes[x])):
    rows.append(f'| `{t}` | {"/".join(str(x) for x in sorted(sizes[t]))} | {", ".join(sorted(where[t]))} |')
open('_re_analysis/TYPE_SIZES.md','w').write('\n'.join(rows)+'\n')
print('\n'.join(rows))
