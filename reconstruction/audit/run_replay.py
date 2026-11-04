"""Run replay_hook over closed demos (source image, eager stepping), one process at a time.

    .venv/bin/python -m reconstruction.audit.run_replay OUT_DIR [demo ...]
"""
import os
import re
import subprocess
import sys
from pathlib import Path

from reconstruction.csrc.demo_closure import default_frames

ROOT = Path(__file__).resolve().parents[2]
EXTRA = {'example_fluid': ['--no-capture'], 'example_granular_beaf': ['--no-capture'], 'example_snow': ['--no-capture'],
         'example_robot_microduck': ['--disable-cuda-graph']}


def main(out, demos):
    out = Path(out).resolve()
    out.mkdir(parents=True, exist_ok=True)
    spec = out/'spec.txt'
    if not spec.exists():   # a hand-narrowed spec.txt in OUT_DIR is kept
        subprocess.run([sys.executable, '-m', 'reconstruction.audit.make_spec', str(spec)], cwd=ROOT, check=True)
    hook = ROOT/'build/reconstruction-csrc/bodies/replay_hook.so'
    if not demos:
        table = (ROOT/'reconstruction/csrc/DEMO_CLOSURE_TABLE.md').read_text()
        demos = re.findall(r'^\| (example_\w+) \| \d+ \| 闭环', table, re.M)
    env = {k: v for k, v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
    for demo in demos:
        log = out/f'{demo}.audit'
        if log.exists():
            continue
        example = ROOT/'examples'/f'{demo}.py'
        frames = default_frames(str(example))
        work = out/demo
        work.mkdir(exist_ok=True)
        cmd = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'source', '--tag', 'audit',
               '--example', str(example), '--frames', str(frames), '--output', str(work), '--'] + EXTRA.get(demo, [])
        partial = out/f'{demo}.partial'
        partial.unlink(missing_ok=True)
        with (work/'run.log').open('w') as f:
            code = subprocess.run(cmd, cwd=ROOT, stdout=f, stderr=subprocess.STDOUT, timeout=4*3600,
                                  env={**env, 'LD_PRELOAD': str(hook), 'AUDIT_SPEC': str(spec),
                                       'AUDIT_LOG': str(partial)}).returncode
        partial.rename(log) if partial.exists() else log.write_text('')
        (work/'audit.npz').unlink(missing_ok=True)   # the state history is not needed here
        print(demo, frames, 'exit', code, flush=True)


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2:])
