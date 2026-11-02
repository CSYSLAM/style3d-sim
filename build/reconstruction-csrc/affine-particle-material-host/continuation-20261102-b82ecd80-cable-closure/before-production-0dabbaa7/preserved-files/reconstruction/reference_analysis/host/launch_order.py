import re, subprocess, collections
DIS='/tmp/host.dis'
funcs=[]; cur=None
callre=re.compile(r'^\s*([0-9a-f]+):\s+call\s+([0-9a-f]+)\s+<(.*?)>')
for line in open(DIS, errors='replace'):
    m=re.match(r'^([0-9a-f]+) <(.*)>:$', line)
    if m: cur=dict(addr=m.group(1), name=m.group(2), calls=[]); funcs.append(cur); continue
    c=callre.match(line)
    if c and cur is not None: cur['calls'].append((c.group(1), c.group(2), c.group(3)))
byaddr={f['addr']:f for f in funcs}

def dem(names):
    if not names: return []
    return subprocess.run(['c++filt'], input='\n'.join(names), capture_output=True, text=True).stdout.splitlines()

def collect(name_re):
    for f in funcs:
        if re.search(name_re, f['name']) and '.cold' not in f['name'] and 'lambda' not in f['name']:
            rows=[]
            for site, tgt, nm in f['calls']:
                ap=byaddr.get(tgt)
                real=re.sub(r'@plt$','', ap['name'] if ap else nm)
                if not real.startswith('synreal::'): continue
                rows.append((site, real))
            return f, rows
    return None, []

def pretty(sig):
    head=sig.split('(')[0]
    head=re.sub(r'^(__device_stub__)','',head)
    head=re.sub(r'^synreal::(kernel|fluid_kernel|granular_kernel|self_collision_kernel)::','',head)
    head=re.sub(r'^synreal::','',head)
    return head

def doc():
    out=['# 主机侧 kernel 发射顺序（从 `SolverNewton::step` 反汇编恢复）','',
         '> 内核由**导出的 host wrapper** 发射（`call <synreal::kernel::x(...)@plt>` → `__device_stub__` → `cudaLaunchKernel`）。',
         '> 顺序＝函数体内 call 指令地址顺序；标记 KERNEL 的是发射点，host 是宿主侧成员函数调用。','']
    for pat, label in [(r'SolverNewton::step\(synreal::State const&, synreal::State const&, synreal::Control const&','SolverNewton::step'),
                       (r'SolverNewton::solve_newton_system\(','SolverNewton::solve_newton_system'),
                       (r'SolverNewton::solve_pd_newton_system\(','SolverNewton::solve_pd_newton_system'),
                       (r'SolverNewton::precompute_matrices\(','SolverNewton::precompute_matrices')]:
        f, rows = collect(pat)
        if not f: continue
        names=[r[1] for r in rows]
        d=[re.sub(r'@plt$','',x) for x in names]
        nk=sum(1 for (site,raw),dd in zip(rows,d) if re.match(r'^synreal::(\w*_kernel|kernel)::', re.sub(r'^__device_stub__','',re.sub(r'@plt$','',dd)).split('(')[0]))
        out += [f'## {label}', '', f'`0x{f["addr"]}` — 共 {len(rows)} 次调用：**{nk} 次 kernel launch** + {len(rows)-nk} 次宿主调用（去重目标 {len(set(names))} 个）','',
                '| # | 调用点 | 类型 | 目标 |','|---|---|---|---|']
        for i,((site, raw), disp) in enumerate(zip(rows, d), 1):
            nm=disp
            head=re.sub(r'^__device_stub__','',nm).split('(')[0]
            is_k = bool(re.match(r'^synreal::(\w*_kernel|kernel)::', head))
            tag='**KERNEL**' if is_k else 'host'
            out.append(f'| {i} | 0x{site} | {tag} | `{head.replace("synreal::","")[:100]}` |')
        out.append('')
    open('_re_analysis/host/LAUNCH_ORDER.md','w').write('\n'.join(out)+'\n')
    print('LAUNCH_ORDER.md 写好')

doc()
