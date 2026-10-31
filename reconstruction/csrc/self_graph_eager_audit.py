"""Audit the eager samples already recorded by a graph cohort, keeping its original first source candidate."""
import argparse
import hashlib
import json
from pathlib import Path

import numpy as np

from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA
from reconstruction.demo_ab import compare, spread_report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--baseline', type=Path, required=True)
    parser.add_argument('--cohort', type=Path, required=True)
    parser.add_argument('--mode', choices=('newton', 'pd'), required=True)
    parser.add_argument('--suite', choices=('mesh', 'self-fluid', 'self-granular'), default='mesh')
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--original-runs', type=int, default=8)
    parser.add_argument('--additional-originals', type=Path)
    args = parser.parse_args()
    assert args.original_runs >= 8 and (args.original_runs == 8 or args.additional_originals is not None)
    assert not args.output.exists()
    builds = [json.loads((p/'build.json').read_text()) for p in (args.baseline, args.cohort)]
    image = builds[0]['extension_sha256']
    assert builds[1]['extension_sha256'] == image
    fixture = {'mesh': 'self_mesh_mixed_scene.py', 'self-fluid': 'self_fluid_material_scene.py',
               'self-granular': 'self_granular_scene.py'}[args.suite]
    fixture_sha = hashlib.sha256((ROOT/'reconstruction/csrc'/fixture).read_bytes()).hexdigest()
    name = f'w3-{args.mode}-d0'
    sample = name+'-g0' if args.suite == 'mesh' else f'v2-{args.mode}-0'
    loaded, provenance = {}, []
    for backend, count in (('original', args.original_runs), ('source', 3)):
        baseline_runtime = json.loads((args.baseline/(backend+'.runtime.json')).read_text())
        samples = []
        for i in range(count):
            directory = args.baseline if i == 0 else args.cohort/f'{backend}{i}-worker'
            if backend == 'original' and i >= 8:
                directory = args.additional_originals/f'original{i}-worker'
            runtime_file = directory/(backend+'.runtime.json')
            runtime = json.loads(runtime_file.read_text())
            assert runtime['image_sha256'] == (REFERENCE_SHA if backend == 'original' else image)
            assert runtime['fixture_sha256'] == fixture_sha and runtime['frames'] == 60 and runtime['suite'] == args.suite
            if args.suite == 'mesh':
                assert runtime['case_name'] == (None if i == 0 else name)
            else:
                for key in ('runner_sha256', 'base_fixture_sha256'):
                    assert runtime[key] == baseline_runtime[key], 'Repeated eager-worker protocol changed'
            path = directory/f'{backend}-{sample}.npz'
            arrays = np.load(path)
            assert all(np.isfinite(arrays[key]).all() for key in arrays.files)
            samples.append(arrays)
            provenance.append({'tag': backend+str(i), 'npz': str(path.resolve()),
                               'sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
                               'runtime_sha256': hashlib.sha256(runtime_file.read_bytes()).hexdigest()})
        loaded[backend] = samples
    originals, sources = loaded['original'], loaded['source']
    assert all(set(run.files) == set(originals[0].files) for run in originals+sources)
    stats = {f'source{i}': spread_report(originals, [run]) for i, run in enumerate(sources)}
    own = {f'original{i}': spread_report(originals[:i]+originals[i+1:], [run]) for i, run in enumerate(originals)}
    observations = {tag: {key: {
        'within_count_at_least_original_worst': value['substeps_within_spread'] >=
            min(v[key]['substeps_within_spread'] for v in own.values()),
        'ratio_no_larger_than_original_worst': value['ratio_max'] <= max(v[key]['ratio_max'] for v in own.values()),
    } for key, value in fields.items()} for tag, fields in stats.items()}
    report = {'source_sha256': image, 'mode': args.mode, 'graph': False, 'new_gpu_runs': 0,
              'suite': args.suite,
              'all_steps_within': {tag: {key: value['substeps_within_spread'] == value['substeps']
                                       for key, value in fields.items()} for tag, fields in stats.items()},
              'provenance': provenance, 'source_statistics': stats, 'original_leave_one_out_statistics': own,
              'observations': observations,
              'strict_sources': [compare(originals[0], run) for run in sources],
              'whole_trajectory_membership': {f'source{i}': [j for j, old in enumerate(originals)
                  if all(run[key].tobytes() == old[key].tobytes() for key in run.files)] for i, run in enumerate(sources)},
              'acceptance_requires_separate_capture_evidence': True}
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    primary_c = all(all(fields.values()) for fields in report['all_steps_within'].values())
    for run in originals+sources:
        run.close()
    outside = [(tag, key, test) for tag, fields in observations.items() for key, values in fields.items()
               for test, passed in values.items() if not passed]
    print('outside', outside, 'exact original members', report['whole_trajectory_membership'], flush=True)
    return int(bool(outside) or (args.suite != 'mesh' and not primary_c))


if __name__ == '__main__':
    raise SystemExit(main())
