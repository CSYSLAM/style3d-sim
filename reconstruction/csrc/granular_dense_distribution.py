"""Keep the first source candidate fixed, collect two more once, and reuse matching granular originals."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA
from .chaotic_source_runs import apply_dump_protocol, capture_dump_protocol


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--candidate', type=Path, required=True)
    parser.add_argument('--original-baseline', type=Path)
    parser.add_argument('--initial-original', type=Path, help='Adopt this one matching capture as original0')
    parser.add_argument('--original-runs', type=int, required=True)
    parser.add_argument('--launch-hook', type=Path,
                        help='Use the exact hook pinned by the adopted candidate; defaults to the granular hook')
    parser.add_argument('--dump-spec', type=Path, help='Preserve the first material capture\'s bounded dump protocol')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not (args.original_baseline and args.initial_original), 'Choose one original reuse method'
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    fixed = args.output/'source-fixed'
    fixed.mkdir()
    saved = (ROOT/'build/reconstruction-csrc/host-particles/build.json').read_bytes()
    (args.output/'build.json').write_bytes(saved)
    runtime = json.loads((args.candidate/'capture.runtime.json').read_text())
    assert runtime['backend'] == 'source' and runtime['image_sha256'] == json.loads(saved)['extension_sha256']
    example = Path(runtime['example']).resolve(strict=True)
    assert hashlib.sha256(example.read_bytes()).hexdigest() == runtime['example_sha256']
    hook = (args.launch_hook or ROOT/'build/reconstruction-csrc/granular-host/cudahook.so').resolve()
    assert runtime['launch_hook_sha256'] == hashlib.sha256(hook.read_bytes()).hexdigest()
    adopted = []
    for original, target in [('capture.npz', 'source0.npz'), ('capture.runtime.json', 'source0.runtime.json'),
                             ('run.log', 'source0.log')]:
        source = args.candidate/original
        shutil.copy2(source, fixed/target)
        adopted.append({'from': str(source.resolve()), 'to': target,
                        'sha256': hashlib.sha256(source.read_bytes()).hexdigest()})
    (args.output/'adopted-candidate.json').write_text(json.dumps(adopted, indent=2)+'\n')
    dump = capture_dump_protocol(args.dump_spec) if args.dump_spec else None
    if dump:
        assert capture_dump_protocol(args.candidate/'dump.json')['fields'] == dump['fields']
        (fixed/'launch-dump-spec.json').write_text(json.dumps(dump, indent=2)+'\n')
    reuse_original = []
    if args.initial_original:
        if dump:
            assert capture_dump_protocol(args.initial_original/'dump.json')['fields'] == dump['fields']
        original_runtime = json.loads((args.initial_original/'capture.runtime.json').read_text())
        assert original_runtime['backend'] == 'original' and original_runtime['image_sha256'] == REFERENCE_SHA
        for key in ('example_sha256', 'frames', 'extra', 'launch_hook_sha256'):
            assert original_runtime[key] == runtime[key], ('Original capture input differs', key)
        for original, target in [('capture.npz', 'original0.npz'), ('capture.runtime.json', 'original0.runtime.json'),
                                 ('run.log', 'original0.log')]:
            source = args.initial_original/original
            shutil.copy2(source, fixed/target)
            reuse_original.append({'from': str(source.resolve()), 'to': target,
                                   'sha256': hashlib.sha256(source.read_bytes()).hexdigest()})
        (args.output/'adopted-original.json').write_text(json.dumps(reuse_original, indent=2)+'\n')
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    apply_dump_protocol(env, dump)
    for i in (1, 2):
        assert (ROOT/'build/reconstruction-csrc/host-particles/build.json').read_bytes() == saved
        tag = f'source{i}'
        directory = fixed/(tag+'-hook')
        directory.mkdir()
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'source', '--tag', tag,
                   '--example', str(example), '--frames', str(runtime['frames']),
                   '--output', str(fixed), '--', *runtime['extra']]
        (fixed/(tag+'.command.json')).write_text(json.dumps(command, indent=2)+'\n')
        with (fixed/(tag+'.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(directory)},
                           stdout=log, stderr=subprocess.STDOUT, check=True, timeout=900)
    original_options = []
    if args.original_baseline:
        original_options = ['--original-baseline', str(args.original_baseline.resolve())]
    elif args.initial_original:
        original_options = ['--original-baseline', str(fixed), '--reuse-original-runs', '1']
    command = [sys.executable, '-m', 'reconstruction.csrc.chaotic_source_runs', '--example', str(example),
               '--frames', str(runtime['frames']), '--original-runs', str(args.original_runs), '--source-runs', '3',
               *original_options, '--source-baseline', str(fixed), '--launch-hook', str(hook),
               '--output', str(args.output/'cohort'), '--', *runtime['extra']]
    if args.dump_spec:
        command[command.index('--'):command.index('--')] = ['--dump-spec', str(args.dump_spec.resolve())]
    (args.output/'command.json').write_text(json.dumps(command, indent=2)+'\n')
    return subprocess.run(command, cwd=ROOT, env=env).returncode


if __name__ == '__main__':
    raise SystemExit(main())
