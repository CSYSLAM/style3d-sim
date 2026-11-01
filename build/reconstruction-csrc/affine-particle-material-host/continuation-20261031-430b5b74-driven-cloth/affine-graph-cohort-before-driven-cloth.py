"""Fixed three-source/eight-original full-worker graph cohort; retain the original first candidates verbatim."""
import argparse
from contextlib import ExitStack
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

import numpy as np

from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA
from reconstruction.demo_ab import compare, spread_report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--suite', choices=('surface', 'cloth', 'surface_rolling', 'tetrahedron_self'), required=True)
    parser.add_argument('--baseline', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--diagonal-only', action='store_true')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    if args.suite == 'surface':
        from .affine_surface_ab import cases
    elif args.suite == 'surface_rolling':
        from .affine_surface_rolling_ab import cases
    elif args.suite == 'tetrahedron_self':
        from .affine_tetrahedron_ab import cases
    else:
        from .affine_cloth_ab import cases
    expected = {f'{case[0]}-{mode}' for case in cases() for mode in (0, 1)}
    module = f'reconstruction.csrc.affine_{args.suite}_graph_ab'
    worker_extra = []
    if args.suite == 'tetrahedron_self':
        module = 'reconstruction.csrc.affine_tetrahedron_graph_ab'
        worker_extra = ['--fixture', str(ROOT / 'reconstruction/csrc/affine_tetrahedron_self_scene.py'),
                        '--particles-per-world', '24']
        if args.diagonal_only:
            worker_extra.append('--diagonal-only')
    else:
        assert not args.diagonal_only, 'This switch is specific to the tetrahedron/self fixture'
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    metadata = json.loads(saved)
    assert (args.baseline / 'build.json').read_bytes() == saved
    (args.output / 'build.json').write_bytes(saved)
    baseline_runtime = {}
    adopted = []
    for backend in ('original', 'source'):
        runtime = json.loads((args.baseline / (backend + '.runtime.json')).read_text())
        assert runtime['image_sha256'] == (REFERENCE_SHA if backend == 'original' else metadata['extension_sha256'])
        assert runtime['frames'] == 60
        if args.suite == 'tetrahedron_self':
            assert runtime['diagonal_only'] == args.diagonal_only and runtime['particles_per_world'] == 24
            fixture = str(ROOT / 'reconstruction/csrc/affine_tetrahedron_self_scene.py')
            assert fixture in runtime['sha256']
        assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == h for p, h in runtime['sha256'].items())
        baseline_runtime[backend] = runtime
        folder = args.output / (backend + '0')
        folder.mkdir()
        files = list(args.baseline.glob(backend + '-*.npz'))
        assert {p.stem[len(backend) + 1:] for p in files} == expected
        files += [args.baseline / (backend + '.runtime.json'), args.baseline / (backend + '.log')]
        for path in files:
            target = folder / path.name
            shutil.copy2(path, target)
            sha = hashlib.sha256(path.read_bytes()).hexdigest()
            assert hashlib.sha256(target.read_bytes()).hexdigest() == sha
            adopted.append({'source': str(path.resolve()), 'target': str(target), 'sha256': sha})
    assert baseline_runtime['original']['sha256'] == baseline_runtime['source']['sha256']
    (args.output / 'adopted-first-workers.json').write_text(json.dumps(adopted, indent=2) + '\n')
    env = {key: value for key, value in os.environ.items() if key not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP',
        'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    jobs = [('source', 1), ('source', 2), *[('original', i) for i in range(1, 8)]]
    completed = []
    for backend, index in jobs:
        assert build.read_bytes() == saved
        folder = args.output / f'{backend}{index}'
        folder.mkdir()
        command = [sys.executable, '-m', module, '--worker', backend, '--frames', '60', '--output', str(folder),
                   *worker_extra]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                  timeout=7200).returncode
        assert code == 0, (backend, index, code)
        runtime = json.loads((folder / (backend + '.runtime.json')).read_text())
        assert runtime == baseline_runtime[backend]
        assert {p.stem[len(backend) + 1:] for p in folder.glob(backend + '-*.npz')} == expected
        completed.append({'backend': backend, 'index': index, 'exit': code})
        (args.output / 'status.json').write_text(json.dumps(completed, indent=2) + '\n')
        print(backend, index, code, flush=True)
    results = {}
    for case in sorted(expected):
        with ExitStack() as stack:
            originals = [stack.enter_context(np.load(args.output / f'original{i}' / f'original-{case}.npz'))
                         for i in range(8)]
            sources = [stack.enter_context(np.load(args.output / f'source{i}' / f'source-{case}.npz'))
                       for i in range(3)]
            assert all(set(run.files) == set(originals[0].files) for run in originals + sources)
            assert all(np.isfinite(run[key]).all() for run in originals + sources for key in run.files)
            rows = {}
            for index, source in enumerate(sources):
                stats = spread_report(originals, [source], checkpoints=60)
                rows[f'source{index}'] = {'statistics': stats,
                    'all_steps_within': {key: value['substeps_within_spread'] == value['substeps']
                                         for key, value in stats.items()},
                    'exact_actual_original_trajectory_matches': [i for i, old in enumerate(originals)
                                                                 if compare(old, source)['bitwise']]}
            results[case] = {'sources': rows,
                             'primary_c_passed': all(all(row['all_steps_within'].values()) for row in rows.values())}
    report = {'source_sha256': metadata['extension_sha256'], 'suite': args.suite, 'originals': 8, 'sources': 3,
              'diagonal_only': args.diagonal_only,
              'cases': results, 'primary_c_passed': all(row['primary_c_passed'] for row in results.values()),
              'source0_replaced': False, 'full_worker_context_preserved': True, 'full_solver_complete': False}
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print('primary C', sum(row['primary_c_passed'] for row in results.values()), '/', len(results), flush=True)
    return int(not report['primary_c_passed'])


if __name__ == '__main__':
    raise SystemExit(main())
