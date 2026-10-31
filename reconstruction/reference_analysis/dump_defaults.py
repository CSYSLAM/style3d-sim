import sys, importlib
sys.path.insert(0,'.')
m = importlib.import_module('_core')
out=[]
def dump(obj, title):
    out.append(f'## {title}')
    for n in sorted(dir(obj)):
        if n.startswith('_'): continue
        try: v = getattr(obj, n)
        except Exception as e: v = f'<{type(e).__name__}>'
        if callable(v) and not isinstance(v,(int,float,str,bool)):
            continue
        out.append(f'{n} = {v!r}')
    out.append('')

dump(m.Config(), 'Config 默认值')
for enum in ['InertiaMode','JointConstraintMode','NonlinearSolver','AffineBodyRigidityModel','LogLevel']:
    cls=getattr(m, enum)
    vals=[]
    for n in dir(cls):
        if n.isupper():
            v=getattr(cls,n); vals.append(f'{n}={int(v)}')
    out.append(f'## {enum}\n' + ', '.join(vals) + '\n')
open('_re_analysis/CONFIG_DEFAULTS.md','w').write('# 运行时导出的默认配置与枚举值\n\n> 直接 import `_core` 读取，非推测。\n\n' + '\n'.join(out))
print('\n'.join(out[:40]))
