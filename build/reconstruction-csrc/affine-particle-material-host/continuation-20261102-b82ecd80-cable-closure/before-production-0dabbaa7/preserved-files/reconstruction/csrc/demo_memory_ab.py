"""Capture original/source native allocation, copy and clear sequences alongside full launch pointer arguments."""
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
    parser.add_argument('--example', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=3)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--memory-observer', type=Path,
                        default=ROOT/'build/reconstruction-csrc/self-host/memory-observer/memory_trace.so')
    parser.add_argument('--parameter-layout', type=Path)
    parser.add_argument('extra', nargs='*')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    memory = args.memory_observer.resolve(strict=True)
    launches = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    example = args.example.resolve(strict=True)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    files = [memory, launches, example, Path(__file__), ROOT/'reconstruction/csrc/demo_source_ab.py',
             ROOT/'reconstruction/csrc/native/memory_trace.cpp', ROOT/'reconstruction/csrc/native/memory_trace_full.cpp',
             ROOT/'reconstruction/csrc/native/cupti_trace.cpp', ROOT/'reconstruction/csrc/native/payload_trace.cpp']
    if args.parameter_layout:
        args.parameter_layout = args.parameter_layout.resolve(strict=True)
        files.append(args.parameter_layout)
    (args.output/'provenance.json').write_text(json.dumps({
        'sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in files},
        'standalone_memory_diagnostic': True, 'replaces_first_failed_source': False,
        'library_runtime_launches_completely_observed': False,
    }, indent=2)+'\n')
    env = {k: v for k, v in os.environ.items() if k not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
        'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR',
        'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    if args.parameter_layout:
        env['CUPTI_KERNEL_LAYOUT_FILE'] = str(args.parameter_layout)
    for backend in ('original', 'source'):
        directory = args.output/backend
        directory.mkdir()
        assert manifest.read_bytes() == saved
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                   '--tag', 'capture', '--example', str(example), '--frames', str(args.frames),
                   '--output', str(directory), '--', *args.extra]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (directory/'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(memory)+':'+str(launches),
                'CUDAHOOK_DIR': str(directory), 'DEMO_MEMORY_TRACE_DIR': str(directory)},
                stdout=log, stderr=subprocess.STDOUT, timeout=900).returncode
        assert not code, (backend, code)
        rows = [json.loads(line) for line in (directory/'memory.jsonl').read_text().splitlines()]
        assert rows[0]['event'] == 'begin_initialize' and rows[-1]['event'] == 'end'
        assert any(v.get('event') == 'end_initialize' for v in rows)
        assert all(v.get('status', 0) == 0 for v in rows)
        print(backend, 'memory events', len(rows), flush=True)


if __name__ == '__main__':
    main()
