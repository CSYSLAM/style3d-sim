"""Keep the first actual graph trajectory fixed while observing matching original graphs and two more sources."""
import argparse
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
    parser.add_argument('--baseline', type=Path, required=True)
    parser.add_argument('--mode', choices=('newton', 'pd'), required=True)
    parser.add_argument('--suite', choices=('mesh', 'self-fluid', 'self-granular'), default='mesh')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    image = json.loads(saved)['extension_sha256']
    (args.output/'build.json').write_bytes(saved)
    fixture = {'mesh': 'self_mesh_mixed_scene.py', 'self-fluid': 'self_fluid_material_scene.py',
               'self-granular': 'self_granular_scene.py'}[args.suite]
    fixture_sha = hashlib.sha256((ROOT/'reconstruction/csrc'/fixture).read_bytes()).hexdigest()
    name = f'w3-{args.mode}-d0'
    sample = name+'-g1' if args.suite == 'mesh' else f'v2-{args.mode}-1'
    adopted = []
    baseline_runtime = {}
    for backend in ('original', 'source'):
        runtime = json.loads((args.baseline/(backend+'.runtime.json')).read_text())
        assert runtime['backend'] == backend and runtime['frames'] == 60
        assert runtime['fixture_sha256'] == fixture_sha and runtime['suite'] == args.suite
        assert runtime['image_sha256'] == (REFERENCE_SHA if backend == 'original' else image)
        baseline_runtime[backend] = runtime
        source = args.baseline/f'{backend}-{sample}.npz'
        shutil.copy2(source, args.output/f'{backend}0.npz')
        shutil.copy2(args.baseline/(backend+'.runtime.json'), args.output/f'{backend}0.runtime.json')
        adopted.append({'from': str(source.resolve()), 'to': backend+'0.npz',
                        'sha256': hashlib.sha256(source.read_bytes()).hexdigest()})
    (args.output/'adopted-candidates.json').write_text(json.dumps(adopted, indent=2)+'\n')
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    jobs = [('original', i) for i in range(1, 8)] + [('source', i) for i in (1, 2)]
    for backend, i in jobs:
        assert manifest.read_bytes() == saved
        directory = args.output/f'{backend}{i}-worker'
        directory.mkdir()
        runner = 'self_particle_graph_ab' if args.suite == 'mesh' else 'fluid_graph_ab'
        command = [sys.executable, '-m', 'reconstruction.csrc.'+runner, '--worker', backend,
                   '--suite', args.suite, '--frames', '60', '--output', str(directory)]
        if args.suite == 'mesh':
            command += ['--case-name', name]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (directory/'run.log').open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=900)
        runtime = json.loads((directory/(backend+'.runtime.json')).read_text())
        assert runtime['fixture_sha256'] == fixture_sha and runtime['suite'] == args.suite
        if args.suite == 'mesh':
            assert runtime['case_name'] == name
        else:
            for key in ('runner_sha256', 'base_fixture_sha256', 'frames'):
                assert runtime[key] == baseline_runtime[backend][key], 'Repeated graph-worker protocol changed'
        assert runtime['image_sha256'] == (REFERENCE_SHA if backend == 'original' else image)
        shutil.copy2(directory/f'{backend}-{sample}.npz', args.output/f'{backend}{i}.npz')
        shutil.copy2(directory/(backend+'.runtime.json'), args.output/f'{backend}{i}.runtime.json')
        print(backend, i, 'complete', flush=True)
    originals = [np.load(args.output/f'original{i}.npz') for i in range(8)]
    sources = [np.load(args.output/f'source{i}.npz') for i in range(3)]
    assert all(np.isfinite(run[key]).all() for run in originals+sources for key in run.files)
    stats = {f'source{i}': spread_report(originals, [run]) for i, run in enumerate(sources)}
    own = {f'original{i}': spread_report(originals[:i]+originals[i+1:], [run]) for i, run in enumerate(originals)}
    observations = {tag: {key: {
        'within_count_at_least_original_worst': value['substeps_within_spread'] >=
            min(v[key]['substeps_within_spread'] for v in own.values()),
        'ratio_no_larger_than_original_worst': value['ratio_max'] <= max(v[key]['ratio_max'] for v in own.values()),
    } for key, value in fields.items()} for tag, fields in stats.items()}
    report = {'source_sha256': image, 'mode': args.mode, 'source_statistics': stats,
              'suite': args.suite,
              'all_steps_within': {tag: {key: value['substeps_within_spread'] == value['substeps']
                                       for key, value in fields.items()} for tag, fields in stats.items()},
              'original_leave_one_out_statistics': own, 'observations': observations,
              'strict_sources': [compare(originals[0], run) for run in sources],
              'whole_trajectory_membership': {f'source{i}': [j for j, o in enumerate(originals)
                   if all(run[k].tobytes() == o[k].tobytes() for k in run.files)] for i, run in enumerate(sources)},
              'acceptance_requires_separate_capture_evidence': True}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    primary_c = all(all(fields.values()) for fields in report['all_steps_within'].values())
    outside = [(tag, key, test) for tag, fields in observations.items() for key, values in fields.items()
               for test, passed in values.items() if not passed]
    print('outside', outside, 'exact original members', report['whole_trajectory_membership'], flush=True)
    return int(bool(outside) or (args.suite != 'mesh' and not primary_c))


if __name__ == '__main__':
    raise SystemExit(main())
