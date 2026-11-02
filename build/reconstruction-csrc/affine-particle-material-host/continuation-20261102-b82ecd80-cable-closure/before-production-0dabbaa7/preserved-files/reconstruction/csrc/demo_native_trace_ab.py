"""Trace the first native substeps of an unchanged demo; this is separate from fixed distribution candidates."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

from .compare_host_trace import compare
from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--example', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=3)
    parser.add_argument('--substeps', type=int, default=1)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--observer', type=Path, default=ROOT/'build/reconstruction-csrc/host-particles/host_trace.so')
    parser.add_argument('extra', nargs='*')
    args = parser.parse_args()
    assert args.frames > 0 and args.substeps > 0
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    example = args.example.resolve(strict=True)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    observer = args.observer.resolve(strict=True)
    files = [observer, example, Path(__file__), ROOT/'reconstruction/csrc/demo_source_ab.py',
             ROOT/'reconstruction/csrc/native/host_trace.cpp']
    asset = ROOT/'assets/plastic_bag.usd'
    if example.name == 'example_plastic_bag.py':
        files.append(asset)
    (args.output/'build.json').write_bytes(saved)
    (args.output/'provenance.json').write_text(json.dumps({
        'files': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in files},
        'complete_owned_launch_coverage': False, 'physics_fixture_modified': False,
        'observed_native_substeps': args.substeps,
        'synchronizing_observer': True, 'replaces_fixed_distribution_candidate': False,
    }, indent=2)+'\n')
    env = {k: v for k, v in os.environ.items() if k not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
        'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT', 'SELF_PARTICLE_TRACE_DIR',
        'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    for backend, folder in (('original', 'legacy'), ('source', 'source')):
        directory = args.output/folder
        directory.mkdir()
        assert build.read_bytes() == saved
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                   '--tag', 'capture', '--example', str(example), '--frames', str(args.frames),
                   '--output', str(directory), '--', *args.extra]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (directory/'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(observer),
                'DEMO_NATIVE_TRACE_DIR': str(directory/'actual'),
                'DEMO_NATIVE_TRACE_SUBSTEPS': str(args.substeps)},
                stdout=log, stderr=subprocess.STDOUT, timeout=1800).returncode
        assert not code, (backend, code)
    assert build.read_bytes() == saved
    report = compare(args.output/'legacy/actual', args.output/'source/actual')
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print('Observed launches', report['launches'], 'metadata equal', report['launch_metadata_equal'],
          'first difference', report['first_difference'], flush=True)
    return int(not report['bitwise_equal'])


if __name__ == '__main__':
    raise SystemExit(main())
