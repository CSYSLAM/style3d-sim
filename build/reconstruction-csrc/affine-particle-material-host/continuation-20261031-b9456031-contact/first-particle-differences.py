"""Inspect the frozen first source without running or resampling either backend."""
import hashlib
import json
from pathlib import Path

import numpy as np

base = Path(__file__).resolve().parent.parent / 'validation-8f4127f0-tet-contact'
cohort = base / 'regression-fixed-C10/particles-seed1'
old, new = cohort / 'original0.npz', cohort / 'source0.npz'
rows = []
with np.load(old) as a, np.load(new) as s:
    for key in sorted(k for k in s.files if k.startswith('n257_w1_it1_f0/')):
        x, y = a[key], s[key]
        bits = x.view('u4') != y.view('u4')
        where = np.argwhere(bits)
        row = {'array': key, 'different_words': int(bits.sum()), 'max_abs': float(np.abs(x.astype('f8') - y).max())}
        if len(where):
            index = tuple(map(int, where[0]))
            row.update(first_index=list(index), original_bits=int(x.view('u4')[index]), source_bits=int(y.view('u4')[index]))
        rows.append(row)
output = base / 'particles-seed1-fixed-first-differences.json'
assert not output.exists()
output.write_text(json.dumps({'arrays': rows, 'source0_replaced': False, 'gpu_resampled': False,
    'sha256': {str(n): hashlib.sha256(n.read_bytes()).hexdigest() for n in (old, new)}}, indent=2) + '\n')
print([(r['array'], r['different_words'], r['max_abs']) for r in rows if r['different_words']])
