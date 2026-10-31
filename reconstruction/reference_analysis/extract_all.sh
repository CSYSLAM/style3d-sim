#!/usr/bin/env bash
# 一键复现：PTX/SASS -> 每 kernel 拆分 -> 索引/原型/类型尺寸
set -euo pipefail
cd "$(dirname "$0")/.."
F="${1:-_core.cpython-312-x86_64-linux-gnu.so}"
export PATH=/usr/local/cuda/bin:$PATH
OUT=_re_analysis

echo "[1/6] ELF 结构";  readelf -SW "$F" | grep -Ei 'debug|symtab|nv_fatbin' || true
echo "[2/6] 主机符号";  nm -a -C "$F" | grep -E 'synreal|s3dnet' | sort -u > "$OUT/host_symbols.txt" || true
echo "[3/6] PTX / SASS"
cuobjdump -ptx  "$F" > "$OUT/cuda/all.ptx"
cuobjdump -sass "$F" > "$OUT/cuda/all.sass"
cuobjdump -res-usage "$F" > "$OUT/cuda/res_usage.txt"
grep -oE '\.visible \.entry [^(]+' "$OUT/cuda/all.ptx" | sed 's/.visible .entry //' \
  | c++filt | grep 'synreal' | sort -u > "$OUT/cuda/kernels_pretty.txt"
echo "[4/6] 抽 cubin"; rm -rf /tmp/cubins; mkdir -p /tmp/cubins
( cd /tmp/cubins && cuobjdump -xelf all "$OLDPWD/$F" >/dev/null )
echo "[5/6] 按 kernel 拆分 + 索引"
python3 "$OUT/build_all.py"
echo "[6/6] 类型尺寸表"
python3 "$OUT/make_types.py" > /dev/null
echo "完成：$OUT/KERNEL_INDEX.md  $OUT/kernel_prototypes.h  $OUT/kernels/"
