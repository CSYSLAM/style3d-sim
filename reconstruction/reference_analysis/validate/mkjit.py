"""从 all.ptx 里切出单个 kernel，补上 PTX 头部，产出可 JIT 的 .ptx"""
import re, sys
ALL='../cuda/all.ptx'
src=open(ALL).read()
GLOBALS=None
def globals_block():
    """把 all.ptx 里的 .global 数据定义取出来（kernel 会引用它们的地址）"""
    global GLOBALS
    if GLOBALS is None:
        GLOBALS=[]
        for line in src.splitlines():
            if line.startswith('.global'):
                GLOBALS.append(line)
        GLOBALS='\n'.join(GLOBALS)
    return GLOBALS

def extract(name):
    i=src.find('.visible .entry '+name+'(')
    if i<0: raise SystemExit('not found: '+name)
    j=src.index('{', i); depth=0; k=j
    while k<len(src):
        if src[k]=='{': depth+=1
        elif src[k]=='}':
            depth-=1
            if depth==0: break
        k+=1
    body=src[i:k+1]
    return f".version 8.4\n.target sm_52\n.address_size 64\n\n{globals_block()}\n\n{body}\n"
if __name__=='__main__':
    name=sys.argv[1]; out=sys.argv[2]
    open(out,'w').write(extract(name))
    print('wrote', out, len(extract(name)), 'bytes')
