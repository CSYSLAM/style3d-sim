"""Capture actual PP-scene PCG buffers and preserve the first difference; full launch checks are separate."""
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
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--count', type=int, default=2115)
    parser.add_argument('--mode', choices=('newton', 'pd'), default='pd')
    parser.add_argument('--scene', choices=('particles', 'mixed'), default='particles')
    parser.add_argument('--frames', type=int, default=3)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    observer = ROOT/'build/reconstruction-csrc/host-particles/host_trace.so'
    fixture = 'self_mesh_mixed_scene.py' if args.scene == 'mixed' else 'self_particle_variants.py'
    scene = 'self_mixed_trace_scene.py' if args.scene == 'mixed' else 'self_particle_trace_scene.py'
    (args.output/'build.json').write_bytes(saved)
    (args.output/'provenance.json').write_text(json.dumps({
        'observer_sha256': hashlib.sha256(observer.read_bytes()).hexdigest(),
        'fixture_sha256': hashlib.sha256((ROOT/'reconstruction/csrc'/fixture).read_bytes()).hexdigest(),
        'trace_scene_sha256': hashlib.sha256(
            (ROOT/'reconstruction/csrc'/scene).read_bytes()).hexdigest(),
        'complete_owned_launch_coverage': False, 'physics_fixture_modified': False,
    }, indent=2)+'\n')
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    for backend, folder in (('original', 'legacy'), ('source', 'source')):
        directory = args.output/folder
        directory.mkdir()
        assert build.read_bytes() == saved
        options = ['--worlds', '3', '--seed', '3'] if args.scene == 'mixed' else ['--count', str(args.count)]
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend, '--tag', 'capture',
                   '--example', 'reconstruction/csrc/'+scene, '--frames', str(args.frames),
                   '--output', str(directory), '--', *options, '--mode', args.mode]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (directory/'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(observer),
                'SELF_PARTICLE_TRACE_DIR': str(directory/'actual')},
                stdout=log, stderr=subprocess.STDOUT, timeout=900).returncode
        assert not code, (backend, code)
    report = compare(args.output/'legacy/actual', args.output/'source/actual')
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print('Observed launches', report['launches'], 'first difference', report['first_difference'], flush=True)
    return int(not report['bitwise_equal'])


if __name__ == '__main__':
    raise SystemExit(main())
