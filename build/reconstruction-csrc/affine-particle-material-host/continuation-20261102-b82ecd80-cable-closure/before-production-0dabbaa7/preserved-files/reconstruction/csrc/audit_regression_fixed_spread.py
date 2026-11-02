"""Recompute a frozen regression C10 report on CPU without replacing candidates or collecting more originals."""
import argparse
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

from reconstruction.demo_ab import spread_report
from .regression_fixed_spread import ArraySteps


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cohort', type=Path, required=True)
    parser.add_argument('--report', default='report-array-steps.json')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists()
    saved = json.loads((args.cohort / args.report).read_text())
    checks = []
    for row in saved['cases']:
        folder = args.cohort / row['case']
        source_path = folder / 'source0.npz'
        assert hashlib.sha256(source_path.read_bytes()).hexdigest() == row['fixed_source_npz_sha256']
        assert row['original_runs'] == 10 and row['source0_replaced'] is False
        with ExitStack() as stack:
            original = [stack.enter_context(np.load(folder / f'original{i}.npz')) for i in range(10)]
            source = stack.enter_context(np.load(source_path))
            assert all(set(run.files) == set(source.files) for run in original)
            assert all(np.isfinite(run[key]).all() for run in original + [source] for key in run.files)
            actual = spread_report([ArraySteps(run) for run in original], [ArraySteps(source)], checkpoints=1)
        # JSON stores integer checkpoint keys as strings; compare both reports in their serialized schema.
        actual = json.loads(json.dumps(actual))
        assert actual == row['statistics'], 'Saved statistics do not reproduce: ' + row['case']
        outside = [key for key, value in actual.items() if value['substeps_within_spread'] != value['substeps']]
        assert outside == row['outside']
        assert row['every_array_and_step_within'] == (not outside)
        checks.append({'case': row['case'], 'saved_report_reproduced': True,
                       'every_array_and_step_within': not outside, 'outside': outside})
    args.output.write_text(json.dumps({'cases': checks, 'GPU_used': False, 'source0_replaced': False,
        'additional_originals_collected': 0, 'whole_solver_complete': False,
        'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}, indent=2) + '\n')
    print(json.dumps(checks), flush=True)


if __name__ == '__main__':
    main()
