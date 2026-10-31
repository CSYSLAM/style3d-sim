"""Check each frozen regression failure against ten actual originals, at every array and recorded step."""
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
from reconstruction.demo_ab import spread_report


class ArraySteps:
    """The worker encodes each recorded time step in its key; each value is a single spatial snapshot."""
    def __init__(self, arrays):
        self.arrays, self.files = arrays, arrays.files

    def __getitem__(self, key):
        return self.arrays[key][None]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--validation', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    metadata = json.loads(saved)
    assert (args.validation / 'build.json').read_bytes() == saved
    (args.output / 'build.json').write_bytes(saved)
    status = json.loads((args.validation / 'regression74/status.json').read_text())
    assert status['complete'] and status['source_sha256'] == metadata['extension_sha256']
    jobs = [row for row in status['completed'] if row['exit']]
    harnesses = [Path(__file__), ROOT / 'reconstruction/csrc/host_particles_ab.py',
                 *sorted((ROOT / 'reconstruction/csrc').glob('*host_cases.py'))]
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in harnesses}
    (args.output / 'harness-sha256.json').write_text(json.dumps(hashes, indent=2) + '\n')
    env = {key: value for key, value in os.environ.items() if key not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP',
        'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    reports = []
    for row in jobs:
        folder = args.validation / 'regression74' / row['name']
        candidates = list(folder.glob('comparison-seed*.json'))
        assert len(candidates) == 1, 'A failed non-particle regression requires its own trajectory protocol'
        seed = int(candidates[0].stem.rsplit('seed', 1)[1])
        comparison = json.loads(candidates[0].read_text())
        assert comparison['reference_sha256'] == REFERENCE_SHA
        assert comparison['source_runtime']['extension_sha256'] == metadata['extension_sha256']
        assert not comparison['source_runtime']['original_solver_mapped']
        keep = args.output / row['name']
        keep.mkdir()
        source_path = folder / f'source-seed{seed}.npz'
        source_hash = hashlib.sha256(source_path.read_bytes()).hexdigest()
        shutil.copy2(source_path, keep / 'source0.npz')
        shutil.copy2(folder / f'legacy-seed{seed}.npz', keep / 'original0.npz')
        expected_status = json.loads((folder / f'legacy-seed{seed}.json').read_text())
        assert expected_status == json.loads((folder / f'source-seed{seed}.json').read_text())
        for index in range(1, 10):
            assert build.read_bytes() == saved
            assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == h for p, h in hashes.items())
            output = keep / f'original{index}-worker'
            command = [sys.executable, '-m', 'reconstruction.csrc.host_particles_ab', '--worker', 'legacy',
                       '--scenario', comparison['scenario'], '--seed', str(seed), '--output', str(output)]
            if comparison['adapter_demo']:
                command.append('--adapter')
            (keep / f'original{index}.command.json').write_text(json.dumps(command, indent=2) + '\n')
            with (keep / f'original{index}.log').open('w') as log:
                subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                               check=True, timeout=1800)
            assert json.loads((output / f'legacy-seed{seed}.json').read_text()) == expected_status
            shutil.copy2(output / f'legacy-seed{seed}.npz', keep / f'original{index}.npz')
        with ExitStack() as stack:
            originals = [stack.enter_context(np.load(keep / f'original{i}.npz')) for i in range(10)]
            source = stack.enter_context(np.load(keep / 'source0.npz'))
            assert all(set(run.files) == set(source.files) for run in originals)
            assert all(run[key].shape == source[key].shape for run in originals for key in source.files)
            assert all(np.isfinite(run[key]).all() for run in originals + [source] for key in source.files)
            statistics = spread_report([ArraySteps(run) for run in originals], [ArraySteps(source)], checkpoints=1)
        assert hashlib.sha256(source_path.read_bytes()).hexdigest() == source_hash
        assert hashlib.sha256((keep / 'source0.npz').read_bytes()).hexdigest() == source_hash
        failed = {key: value for key, value in statistics.items()
                  if value['substeps_within_spread'] != value['substeps']}
        result = {'case': row['name'], 'source_sha256': metadata['extension_sha256'],
                  'fixed_source_npz_sha256': source_hash, 'original_runs': 10, 'source0_replaced': False,
                  'every_array_and_step_within': not failed, 'outside': list(failed), 'statistics': statistics}
        (keep / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
        reports.append(result)
        (args.output / 'report.json').write_text(json.dumps({'cases': reports,
            'source_sha256': metadata['extension_sha256'], 'full_solver_complete': False}, indent=2) + '\n')
        print(row['name'], 'per-step C10', not failed, 'outside', list(failed), flush=True)
    return int(any(not row['every_array_and_step_within'] for row in reports))


if __name__ == '__main__':
    raise SystemExit(main())
