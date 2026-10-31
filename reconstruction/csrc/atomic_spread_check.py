"""Criterion C of the user-approved atomic-order acceptance (see WORK_LOG 2026-10-30): for every state array whose
strict original/source comparison fails, the source's deviation from the mean of K original runs must not exceed
the original's own leave-one-out spread.

    .venv/bin/python -m reconstruction.csrc.atomic_spread_check --scenario particles --adapter --seed 1 --runs 5

Runs the normal original->source comparison once (host_particles_ab), then K-1 further original-only runs, keeping
every original result. Criteria A (pointwise replay) and B (summation-order reproduction) are checked by
replay_host_pcg.py and the atomic audits; this script does not replace them. Exits 1 if any array fails C.
"""
import argparse
import hashlib
import json
import shutil
import subprocess
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT/'build/reconstruction-csrc/host-particles'


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--scenario', default='particles')
    parser.add_argument('--adapter', action='store_true')
    parser.add_argument('--seed', type=int, default=1)
    parser.add_argument('--runs', type=int, default=5)
    parser.add_argument('--baseline', type=Path, help='Use a saved comparison and fixed source candidate')
    parser.add_argument('--output', type=Path, help='Independent result directory; required with --baseline')
    parser.add_argument('--extend-originals', type=Path,
                        help='Reuse every original from this earlier criterion-C report, keeping the source fixed')
    args = parser.parse_args()
    if args.runs < 5:
        raise SystemExit('criterion C requires at least 5 original runs')
    if args.baseline and not args.output:
        parser.error('--baseline requires an independent --output directory')
    if args.extend_originals and not args.baseline:
        parser.error('--extend-originals requires the original fixed --baseline')
    base = args.baseline or (OUT if args.scenario == 'particles' else OUT/args.scenario)
    keep = args.output or base/f'atomic-spread-seed{args.seed}'
    keep.mkdir(parents=True, exist_ok=not bool(args.baseline))
    common = [sys.executable, '-m', 'reconstruction.csrc.host_particles_ab', '--scenario', args.scenario,
              '--seed', str(args.seed)] + (['--adapter'] if args.adapter else [])
    # Full comparison (original then source, strictly serialised); non-zero exit is expected when strict fails.
    if not args.baseline:
        subprocess.run(common, cwd=ROOT, stdout=(keep/'compare.log').open('w'), stderr=subprocess.STDOUT)
    shutil.copy(base/f'legacy-seed{args.seed}.npz', keep/'legacy0.npz')
    shutil.copy(base/f'source-seed{args.seed}.npz', keep/'source.npz')
    strict = json.loads((base/f'comparison-seed{args.seed}.json').read_text())
    assert strict['scenario'] == args.scenario and strict['adapter_demo'] == args.adapter
    source_digest = hashlib.sha256((keep/'source.npz').read_bytes()).hexdigest()
    first_new = 1
    reused = []
    if args.extend_originals:
        previous = json.loads((args.extend_originals/'criterion-c.json').read_text())
        assert previous['scenario'] == args.scenario and previous['seed'] == args.seed
        assert Path(previous['baseline']).resolve() == args.baseline.resolve()
        assert previous['fixed_source_npz_sha256'] == source_digest, 'Do not replace the failed source candidate'
        first_new = previous['original_runs']
        assert first_new < args.runs, 'The extension must add original observations'
        for run in range(first_new):
            path = args.extend_originals/f'legacy{run}.npz'
            if run == 0:
                assert path.read_bytes() == (keep/'legacy0.npz').read_bytes()
            else:
                shutil.copy2(path, keep/path.name)
            reused.append({'path': str(path.resolve()), 'sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
        (keep/'reused-originals.json').write_text(json.dumps(reused, indent=2)+'\n')
    for run in range(first_new, args.runs):
        destination = keep/f'run{run}' if args.baseline else base
        options = ['--output', str(destination)] if args.baseline else []
        subprocess.run(common + ['--legacy-only', *options], cwd=ROOT, check=True,
                       stdout=(keep/f'legacy{run}.log').open('w'), stderr=subprocess.STDOUT)
        shutil.copy(destination/f'legacy-seed{args.seed}.npz', keep/f'legacy{run}.npz')
    originals = [np.load(keep/f'legacy{run}.npz') for run in range(args.runs)]
    source = np.load(keep/'source.npz')
    failing = sorted(strict['failures'])
    report = {}
    for name in failing:
        runs = np.stack([o[name].astype(np.float64) for o in originals])
        assert np.isfinite(runs).all() and np.isfinite(source[name]).all(), 'Nonfinite states cannot pass criterion C'
        total = runs.sum(0)
        axes = tuple(range(1, runs.ndim))
        spread = max(float(np.abs(runs[i]-(total-runs[i])/(len(runs)-1)).max()) for i in range(len(runs)))
        deviation = float(np.abs(source[name].astype(np.float64)-total/len(runs)).max())
        repeat_differs = any(not np.array_equal(originals[0][name].view('u4'), o[name].view('u4'))
                             for o in originals[1:])
        report[name] = {'source_deviation': deviation, 'original_spread': spread,
                        'original_repeats_differ': repeat_differs, 'within': deviation <= spread and repeat_differs}
    passed = all(r['within'] for r in report.values())
    summary = {'scenario': args.scenario, 'seed': args.seed, 'original_runs': args.runs,
               'strict_failures': len(failing), 'criterion_c_passed': passed,
               'fixed_source_npz_sha256': source_digest, 'baseline': str(args.baseline) if args.baseline else None,
               'source_runtime': strict.get('source_runtime'),
               'reused_originals': reused, 'outside': [n for n, r in report.items() if not r['within']], 'arrays': report}
    (keep/'criterion-c.json').write_text(json.dumps(summary, indent=1)+'\n')
    print(json.dumps({k: v for k, v in summary.items() if k != 'arrays'}))
    return 0 if passed else 1


if __name__ == '__main__':
    sys.exit(main())
