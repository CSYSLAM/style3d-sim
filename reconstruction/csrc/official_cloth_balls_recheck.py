"""Validate a new source image against the exact frozen eight original trajectories, without expanding that cohort."""
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

from reconstruction.demo_ab import compare, spread_report
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--baseline', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    baseline = json.loads((args.baseline / 'status.json').read_text())
    assert baseline['complete'] and baseline['originals_per_mode'] == 8 and baseline['sources_per_mode'] == 3
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    metadata = json.loads(saved)
    (args.output / 'build.json').write_bytes(saved)
    harness = ROOT / 'reconstruction/csrc/official_cloth_balls_ab.py'
    example = ROOT / 'examples/example_cloth_balls.py'
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (harness, example, Path(__file__))}
    (args.output / 'harness-sha256.json').write_text(json.dumps(hashes, indent=2) + '\n')
    env = {key: value for key, value in os.environ.items() if key not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP',
        'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    adopted, report = [], {'source_sha256': metadata['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
                           'originals_expanded': False, 'full_solver_complete': False, 'modes': {}}
    for mode in ('eager', 'graph'):
        for index in range(8):
            original = args.baseline / f'{mode}-original{index}'
            runtime = json.loads((original / 'runtime.json').read_text())
            assert runtime['image_sha256'] == REFERENCE_SHA and runtime['frames'] == baseline['frames']
            assert runtime['harness_sha256'] == hashes[str(harness)]
            assert runtime['example_sha256'] == hashes[str(example)]
            assert json.loads((original / 'physical.json').read_text())['physical_test_passed']
            folder = args.output / original.name
            folder.mkdir()
            for name in ('states.npz', 'runtime.json', 'physical.json', 'command.json', 'run.log'):
                sha = hashlib.sha256((original / name).read_bytes()).hexdigest()
                shutil.copy2(original / name, folder / name)
                assert hashlib.sha256((folder / name).read_bytes()).hexdigest() == sha
                adopted.append({'from': str(original / name), 'to': str(folder / name), 'sha256': sha})
        (args.output / 'adopted-originals.json').write_text(json.dumps(adopted, indent=2) + '\n')
        for index in range(3):
            assert build.read_bytes() == saved
            assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == h for p, h in hashes.items())
            folder = args.output / f'{mode}-source{index}'
            folder.mkdir()
            command = [sys.executable, '-m', 'reconstruction.csrc.official_cloth_balls_ab', '--worker', 'source',
                       '--mode', mode, '--frames', str(baseline['frames']), '--output', str(folder)]
            (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
            with (folder / 'run.log').open('w') as log:
                subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=3600)
            runtime = json.loads((folder / 'runtime.json').read_text())
            assert runtime['image_sha256'] == metadata['extension_sha256']
            assert runtime['harness_sha256'] == hashes[str(harness)] and runtime['example_sha256'] == hashes[str(example)]
            assert json.loads((folder / 'physical.json').read_text())['physical_test_passed']
            print(folder.name, 'physical/finite passed', flush=True)
        with ExitStack() as stack:
            originals = [stack.enter_context(np.load(args.output / f'{mode}-original{i}/states.npz')) for i in range(8)]
            sources = [stack.enter_context(np.load(args.output / f'{mode}-source{i}/states.npz')) for i in range(3)]
            rows = []
            for index, source in enumerate(sources):
                stats = spread_report(originals, [source], checkpoints=baseline['frames'])
                outside = [key for key, value in stats.items() if value['substeps_within_spread'] != value['substeps']]
                rows.append({'source': index, 'strict': compare(originals[0], source), 'statistics': stats,
                             'every_step_within_spread': not outside, 'outside': outside})
        report['modes'][mode] = {'sources': rows, 'primary_c_passed': all(row['every_step_within_spread'] for row in rows)}
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    report['complete'] = True
    report['primary_c_passed'] = all(row['primary_c_passed'] for row in report['modes'].values())
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print('fixed existing original C', report['primary_c_passed'], flush=True)
    return int(not report['primary_c_passed'])


if __name__ == '__main__':
    raise SystemExit(main())
