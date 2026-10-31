import sys, importlib, inspect
sys.path.insert(0, ".")
m = importlib.import_module("_core")
out = []
w = out.append
w("MODULE DOC: " + (m.__doc__ or ""))
w("\n===== NAMES =====")
for n in sorted(dir(m)):
    if n.startswith("__"): continue
    o = getattr(m, n); doc = (getattr(o, "__doc__", None) or "")
    w(f"\n### {n}  [{type(o).__name__}]")
    if doc: w(doc)
    if inspect.isclass(o):
        for mn, mv in sorted(vars(o).items()):
            if mn.startswith("__") and mn not in ("__init__", "__call__"): continue
            d = getattr(mv, "__doc__", None)
            if d: w(f"  .{mn}: {d}")
open("_re_analysis/api_surface.txt","w").write("\n".join(out))
print("written", len(out), "lines")
