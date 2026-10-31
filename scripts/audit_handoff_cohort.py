#!/usr/bin/env python3
"""Recompute the saved fixed C8 cohort without a GPU, without replacing any candidate."""
import argparse
from contextlib import ExitStack
import json
from pathlib import Path
import sys

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from reconstruction.demo_ab import compare, spread_report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--case', default='w3-newton-b1-d1-c1-s1-p1-1')
    args = parser.parse_args()
    base = ROOT / 'build/reconstruction-csrc/affine-particle-material-host/validation-8fb9d2ee'
    base = base / 'body-cloth-graph-cohort8'
    saved = json.loads((base / 'report.json').read_text())['cases'][args.case]
    rows = {}
    with ExitStack() as stack:
        originals = [stack.enter_context(np.load(base / f'original{i}' / f'original-{args.case}.npz'))
                     for i in range(8)]
        for i in range(3):
            source = stack.enter_context(np.load(base / f'source{i}' / f'source-{args.case}.npz'))
            stats = spread_report(originals, [source], checkpoints=60)
            rows[f'source{i}'] = {
                'statistics': stats,
                'all_steps_within': {k: v['substeps_within_spread'] == v['substeps'] for k, v in stats.items()},
                'exact_actual_original_trajectory_matches': [
                    j for j, original in enumerate(originals) if compare(original, source)['bitwise']],
            }
    actual = {'sources': rows, 'primary_c_passed': all(all(row['all_steps_within'].values()) for row in rows.values())}
    actual = json.loads(json.dumps(actual))
    assert actual == saved, 'Saved cohort report does not reproduce from the frozen actual worker arrays'
    print(json.dumps({'case': args.case, 'saved_report_reproduced': True,
                      'primary_c_passed': actual['primary_c_passed'], 'source0_replaced': False}, indent=2))
    # A zero exit validates faithful transfer of the evidence, not acceptance of the solver.
    return 0


if __name__ == '__main__':
    sys.exit(main())
