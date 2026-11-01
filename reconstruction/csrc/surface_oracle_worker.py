"""Diagnostic source-host trajectories using literal reference PTX; these are never source acceptance candidates."""
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
from .host_api_probe import REFERENCE, REFERENCE_SHA
from .library_entries import entries


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cohort', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--runtime', action='store_true', help='Use actual SDK kernel stubs instead of literal PTX')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest() == REFERENCE_SHA
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    assert (args.cohort / 'build.json').read_bytes() == saved
    (args.output / 'build.json').write_bytes(saved)
    cpp = ROOT / 'reconstruction/csrc/native/ptx_oracle_probe.cpp'
    hook = args.output / 'ptx_oracle_probe.so'
    command = ['c++', '-std=c++17', '-shared', '-fPIC', '-O2',
               '-I' + str(ROOT / 'build/toolchains/cuda-12.4/include'), str(cpp),
               '-l:libcuda.so.1', '-ldl', '-o', str(hook)]
    subprocess.run(command, check=True)
    (args.output / 'build-command.json').write_text(json.dumps(command, indent=2) + '\n')
    inventory = json.loads(saved)['kernels']
    mappings, hashes = {}, {}
    for path in (ROOT / 'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx'):
        text = path.read_text()
        for name in entries(text).keys() & inventory.keys():
            if name.startswith('_ZN7synreal'):
                assert name not in mappings
                mappings[name] = path.resolve()
                hashes[str(path.relative_to(ROOT))] = hashlib.sha256(path.read_bytes()).hexdigest()
    assert len(mappings) == 129
    env = {key: value for key, value in os.environ.items() if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_'))
           and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD')}
    report = {'source_host_sha256': json.loads(saved)['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
              'literal_original_ptx_used': not args.runtime, 'actual_original_runtime_used': args.runtime,
              'source_acceptance_candidate': False,
              'frozen_candidates_replaced': False, 'original_cohort_expanded': False,
              'module_loading_can_change_allocation_layout': True, 'whole_solver_complete': False, 'modes': {}}
    for mode in ('surface', 'owned'):
        folder = args.output / mode
        folder.mkdir()
        selected = {name: path for name, path in mappings.items() if mode == 'owned' or 'SurfaceContactView' in name}
        assert len(selected) == (129 if mode == 'owned' else 4)
        index = folder / 'oracle-index.tsv'
        index.write_text(''.join(name + '\t' + str(path) + '\n' for name, path in sorted(selected.items())))
        command = ([sys.executable, '-m', 'reconstruction.csrc.surface_runtime_oracle_adapter',
                    '--output', str(folder)] if args.runtime else
                   [sys.executable, '-m', 'reconstruction.csrc.affine_surface_graph_ab', '--worker', 'source',
                    '--frames', '60', '--output', str(folder)])
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        (folder / 'ORACLE_DIAGNOSTIC.json').write_text(json.dumps({
            'literal_original_ptx_used': not args.runtime, 'actual_original_runtime_used': args.runtime,
            'source_acceptance_candidate': False,
            'requested_entries': len(selected), 'host_sha256': report['source_host_sha256']}, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            runtime_env = {'RECON_ORACLE_RUNTIME': str(REFERENCE)} if args.runtime else {}
            subprocess.run(command, check=True, cwd=ROOT, timeout=1200, stdout=log, stderr=subprocess.STDOUT,
                           env={**env, 'LD_PRELOAD': str(hook), 'RECON_ORACLE_PTX_INDEX': str(index),
                                'RECON_ORACLE_PTX_LOG': str(folder / 'oracle-functions.tsv'), **runtime_env})
        assert build.read_bytes() == saved
        invoked = (folder / 'oracle-functions.tsv').read_text().splitlines()
        assert invoked
        checks = {}
        prefix = 'oracle-' if args.runtime else 'source-'
        for path in sorted(folder.glob(prefix + '*.npz')):
            case = path.stem.removeprefix(prefix)
            with ExitStack() as stack:
                originals = [stack.enter_context(np.load(args.cohort / f'original{i}/original-{case}.npz'))
                             for i in range(8)]
                source = stack.enter_context(np.load(path))
                fixed = stack.enter_context(np.load(args.cohort / f'source0/source-{case}.npz'))
                stats = spread_report(originals, [source], checkpoints=60)
                checks[case] = {'against_original0': compare(originals[0], source),
                                'against_frozen_source0': compare(fixed, source),
                                'statistics': stats,
                                'all_steps_within': all(s['substeps_within_spread'] == s['substeps']
                                                        for s in stats.values())}
        assert len(checks) == 16
        report['modes'][mode] = {'replaced_functions_invoked': invoked, 'cases': checks}
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        print('DIAGNOSTIC ONLY', mode, 'strict', sum(c['against_original0']['bitwise'] for c in checks.values()),
              'within saved C', sum(c['all_steps_within'] for c in checks.values()), '/', len(checks), flush=True)
    report['provenance'] = {**hashes, **{str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
                                       for p in (Path(__file__), cpp, hook)}}
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
