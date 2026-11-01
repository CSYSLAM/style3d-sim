"""Diagnose fixed C8 sensitivity with three independent unchanged-reference workers; never expand its baseline."""
import argparse
from contextlib import ExitStack
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from reconstruction.demo_ab import compare, spread_report
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cohort', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    originals = sorted(args.cohort.glob('original*/original-*.npz'))
    assert len(originals) == 8 * 16
    frozen = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in originals}
    baseline_runtime = json.loads((args.cohort / 'original0/original.runtime.json').read_text())
    assert baseline_runtime['image_sha256'] == REFERENCE_SHA and baseline_runtime['frames'] == 60
    state = {'planned_holdout_workers': 3, 'completed': [], 'complete': False,
             'baseline_originals': 8, 'baseline_expanded': False, 'source_candidates_reclassified': False}
    (args.output / 'status.json').write_text(json.dumps(state, indent=2) + '\n')
    env = {key: value for key, value in os.environ.items()
           if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_'))
           and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD')}
    for i in range(3):
        folder = args.output / f'holdout{i}'
        folder.mkdir()
        command = [sys.executable, '-m', 'reconstruction.csrc.affine_surface_graph_ab', '--worker', 'original',
                   '--frames', '60', '--output', str(folder)]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            subprocess.run(command, check=True, timeout=1200, env=env, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
        runtime = json.loads((folder / 'original.runtime.json').read_text())
        assert runtime == baseline_runtime
        state['completed'].append(i)
        (args.output / 'status.json').write_text(json.dumps(state, indent=2) + '\n')
        print('unchanged-reference holdout', i, 'complete', flush=True)
    results = {}
    for path in sorted((args.output / 'holdout0').glob('original-*.npz')):
        case = path.stem.removeprefix('original-')
        with ExitStack() as stack:
            base = [stack.enter_context(np.load(args.cohort / f'original{i}/original-{case}.npz')) for i in range(8)]
            rows = []
            for i in range(3):
                value = stack.enter_context(np.load(args.output / f'holdout{i}/original-{case}.npz'))
                statistics = spread_report(base, [value], checkpoints=60)
                rows.append({'holdout': i, 'against_original0': compare(base[0], value), 'statistics': statistics,
                             'within_saved_spread': all(s['substeps_within_spread'] == s['substeps']
                                                        for s in statistics.values())})
        results[case] = rows
    assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == sha for p, sha in frozen.items())
    state['complete'] = True
    (args.output / 'status.json').write_text(json.dumps(state, indent=2) + '\n')
    (args.output / 'report.json').write_text(json.dumps({
        **state, 'cases': results, 'baseline_npz_sha256': frozen, 'reference_sha256': REFERENCE_SHA,
        'no_launch_or_memory_observer': True, 'whole_solver_complete': False,
        'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}, indent=2) + '\n')
    print('reference holdouts outside saved C', sum(not row['within_saved_spread']
                                                  for rows in results.values() for row in rows), '/', 48, flush=True)


if __name__ == '__main__':
    main()
