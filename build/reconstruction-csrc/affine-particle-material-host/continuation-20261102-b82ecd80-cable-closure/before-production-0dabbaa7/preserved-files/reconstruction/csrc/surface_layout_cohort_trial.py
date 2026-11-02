"""Run three predeclared source-only layout trials against the unchanged fixed original8 cohort."""
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
from .library_entries import entries


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    choice = parser.add_mutually_exclusive_group(required=True)
    choice.add_argument('--trial', type=Path)
    choice.add_argument('--module-index', type=Path, help='Index of source-only linked module groups')
    parser.add_argument('--hook', type=Path, required=True)
    parser.add_argument('--cohort', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    assert (args.cohort / 'build.json').read_bytes() == saved
    trial, hook = (args.trial or args.module_index).resolve(strict=True), args.hook.resolve(strict=True)
    if args.module_index:
        mappings = dict(line.split('\t') for line in trial.read_text().splitlines())
        mappings = {name: path for name, path in mappings.items() if name.startswith('_ZN7synreal')}
        assert len(mappings) == 129
    else:
        symbols = entries(trial.read_text())
        assert len(symbols) == 4 and all('SurfaceContactView' in name for name in symbols)
        mappings = {name: str(trial) for name in symbols}
    paths = {Path(__file__), trial, hook, *map(Path, mappings.values())}
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}
    index = args.output / 'source-trial-index.tsv'
    index.write_text(''.join(name + '\t' + path + '\n' for name, path in sorted(mappings.items())))
    status = {'planned_source_workers': 3, 'originals': 8, 'completed': [], 'complete': False,
              'source_host_sha256': json.loads(saved)['extension_sha256'], 'source_trial_ptx_sha256': hashes[str(trial)],
              'linked_source_module_layout': bool(args.module_index),
              'literal_original_ptx_used': False, 'original_sdk_used': False,
              'production_image_changed': False, 'frozen_candidate_replaced': False}
    (args.output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    env = {key: value for key, value in os.environ.items() if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_'))
           and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD')}
    for i in range(3):
        assert build.read_bytes() == saved
        assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == h for p, h in hashes.items())
        folder = args.output / f'source{i}'
        folder.mkdir()
        (folder / 'SOURCE_LAYOUT_EXPERIMENT.json').write_text(json.dumps(status, indent=2) + '\n')
        command = [sys.executable, '-m', 'reconstruction.csrc.affine_surface_graph_ab', '--worker', 'source',
                   '--frames', '60', '--output', str(folder)]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            subprocess.run(command, check=True, cwd=ROOT, timeout=1200, stdout=log, stderr=subprocess.STDOUT,
                           env={**env, 'LD_PRELOAD': str(hook), 'RECON_ORACLE_PTX_INDEX': str(index),
                                'RECON_ORACLE_PTX_LOG': str(folder / 'source-trial-functions.tsv')})
        invoked = (folder / 'source-trial-functions.tsv').read_text().splitlines()
        invoked_names = {row.split('\t')[0] for row in invoked}
        assert invoked_names <= set(mappings) and (args.module_index or invoked_names == set(mappings))
        assert all(row.split('\t')[1] == mappings[row.split('\t')[0]] for row in invoked)
        status['completed'].append(i)
        (args.output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
        print('source-only trial worker', i, 'complete', flush=True)
    results, original_hashes = {}, {}
    for path in sorted((args.output / 'source0').glob('source-*.npz')):
        case = path.stem.removeprefix('source-')
        with ExitStack() as stack:
            original_paths = [args.cohort / f'original{i}/original-{case}.npz' for i in range(8)]
            originals = [stack.enter_context(np.load(p)) for p in original_paths]
            sources = [stack.enter_context(np.load(args.output / f'source{i}/source-{case}.npz')) for i in range(3)]
            original_hashes.update({str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in original_paths})
            rows = []
            for i, source in enumerate(sources):
                assert all(np.isfinite(source[key]).all() for key in source.files)
                stats = spread_report(originals, [source], checkpoints=60)
                rows.append({'source': i, 'strict': compare(originals[0], source), 'statistics': stats,
                             'every_step_within': all(s['substeps_within_spread'] == s['substeps']
                                                      for s in stats.values())})
        results[case] = {'sources': rows, 'primary_c_passed': all(row['every_step_within'] for row in rows)}
    assert len(results) == 16
    status['complete'] = True
    (args.output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')
    (args.output / 'report.json').write_text(json.dumps({
        **status, 'cases': results, 'original_npz_sha256': original_hashes, 'harness_sha256': hashes,
        'primary_c_passed': all(row['primary_c_passed'] for row in results.values()),
        'delivered_source_accepted': False, 'whole_solver_complete': False}, indent=2) + '\n')
    print('source-only layout trial fixed C', sum(row['primary_c_passed'] for row in results.values()), '/', 16,
          flush=True)


if __name__ == '__main__':
    main()
