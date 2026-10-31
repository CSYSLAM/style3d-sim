import re, sys, collections, subprocess
DIS='/tmp/host.dis'
funcs={}; order=[]; cur=None
callre=re.compile(r'^\s*([0-9a-f]+):\s+call\s+([0-9a-f]+)\s+<(.*?)>')
for line in open(DIS, errors='replace'):
    m=re.match(r'^([0-9a-f]+) <(.*)>:$', line)
    if m:
        cur=dict(addr=m.group(1), name=m.group(2), calls=[])
        funcs[m.group(1)]=cur; order.append(cur); continue
    c=callre.match(line)
    if c and cur is not None:
        cur['calls'].append((c.group(2), c.group(3)))

byaddr=funcs
def demangle(names):
    if not names: return []
    out=subprocess.run(['c++filt'], input='\n'.join(names), capture_output=True, text=True).stdout.splitlines()
    return out

def is_kernel_launch(name):
    return name.startswith('__device_stub__')

def short(n):
    n=re.sub(r'^__device_stub__','',n)
    return n

# 按名字找根
roots=[f for f in order if re.search(r'SolverNewton::(step|initialize)\b', f['name'])]
print('roots:', len(roots))
seen=set()
def walk(f, depth, maxdepth, out):
    if depth>maxdepth or f['addr'] in seen: return
    seen.add(f['addr'])
    names=[byaddr[a]['name'] if a in byaddr else n for a,n in f['calls']]
    for (a,n),nm in zip(f['calls'], names):
        tgt=byaddr.get(a)
        mark='[KERNEL] ' if is_kernel_launch(nm) else ''
        out.append('  '*depth + f"{mark}{short(nm) if mark else nm}")
        if tgt and not mark:
            walk(tgt, depth+1, maxdepth, out)
for r in roots[:2]:
    print('\n==== ', r['name'][:120])
    out=[]; seen.clear(); walk(r,0,3,out)
    print('\n'.join(out[:60]))
