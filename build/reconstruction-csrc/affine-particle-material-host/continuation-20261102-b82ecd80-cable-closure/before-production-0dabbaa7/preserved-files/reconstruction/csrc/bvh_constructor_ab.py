"""Run the complete three-stage constructor probe workflow on one pinned source build, strictly serially."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    (args.output/'harness.json').write_text(json.dumps({
        'probe_sha256': hashlib.sha256((ROOT/'reconstruction/csrc/bvh_constructor_probe.py').read_bytes()).hexdigest(),
        'hook_sha256': hashlib.sha256(hook.read_bytes()).hexdigest()}, indent=2)+'\n')
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    rows = []
    for backend in ('original', 'solver-source', 'compare-native'):
        assert manifest.read_bytes() == saved
        command = [sys.executable, '-m', 'reconstruction.csrc.bvh_constructor_probe', '--worker', backend,
                   '--output', str(args.output/backend)]
        if backend == 'compare-native':
            command += ['--original', str(args.output/'original'), '--source', str(args.output/'solver-source')]
        (args.output/(backend+'.command.json')).write_text(json.dumps(command, indent=2)+'\n')
        with (args.output/(backend+'.log')).open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DUMP_LIMIT': '9'},
                                  stdout=log, stderr=subprocess.STDOUT, timeout=900).returncode
        rows.append({'worker': backend, 'exit': code})
        (args.output/'status.json').write_text(json.dumps(rows, indent=2)+'\n')
        print(backend, code, flush=True)
        if code:
            return code
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
