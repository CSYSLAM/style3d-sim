#!/usr/bin/env bash
# 批量编译全部还原出的 kernel，统计编译成功率
set -u
export PATH=/usr/local/cuda/bin:$PATH
OUT=build_logs; mkdir -p $OUT
ok=0; fail=0
: > $OUT/summary.txt
for f in src/*/*.cu; do
  b=$(basename "$f" .cu)
  if nvcc -arch=sm_52 -cubin -o "$OUT/$b.cubin" "$f" -I. >"$OUT/$b.log" 2>&1; then
    ok=$((ok+1))
  else
    fail=$((fail+1))
    echo "FAIL $f" >> $OUT/summary.txt
    grep -m1 'error' "$OUT/$b.log" >> $OUT/summary.txt
  fi
done
echo "OK=$ok FAIL=$fail" | tee -a $OUT/summary.txt
