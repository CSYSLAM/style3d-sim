"""Compare two final-state files written by run_demo.py --save-final.

    .venv/bin/python -m reconstruction.compare_final original.npz source.npz
"""
import sys

import numpy as np


def main(left, right):
    a, b = np.load(left), np.load(right)
    for name in sorted(set(a.files) | set(b.files)):
        if name not in a.files or name not in b.files:
            print(f'{name}: only in {"left" if name in a.files else "right"}')
            continue
        x, y = a[name], b[name]
        if x.shape != y.shape:
            print(f'{name}: shape {x.shape} vs {y.shape}')
            continue
        same = x.tobytes() == y.tobytes()
        diff = float(np.abs(x.astype(np.float64) - y.astype(np.float64)).max()) if x.size else 0.0
        print(f'{name}: {"bitwise identical" if same else f"max |diff| = {diff:.3e}"}  shape={x.shape}')


if __name__ == '__main__':
    main(*sys.argv[1:3])
