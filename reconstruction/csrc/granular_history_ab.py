"""Compare real granular histories after accepted steps, and assert that the named branches actually fire."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from .audit_cudahook import compare as compare_launches, schemas
from .demo_source_ab import ROOT
from reconstruction.demo_ab import compare

COMMIT = '15granular_kernel12commit_bonds'
FORM = '15granular_kernel10form_bonds'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=30)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    hook = ROOT/'build/reconstruction-csrc/granular-host/cudahook.so'
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(hook), CUDAHOOK_DUMP_LIMIT=str(args.frames))
    reports = []
    for history in ('plastic', 'break', 'form'):
        for mode in ('newton', 'pd'):
            case = args.output/f'{history}-{mode}'
            count = 24 if history == 'form' else 2
            spec = COMMIT+f'=1:96,2:{count*8},3:{count*4},4:{count*4},5:{count*4}'
            if history == 'form':
                spec += ';'+FORM+f'=2:36,4:{count*4},5:{count*8},6:{count*4},7:{count*4},8:{count*4}'
            for backend in ('original', 'source'):
                assert build.read_bytes() == saved
                directory = case/backend
                directory.mkdir(parents=True)
                env.update(CUDAHOOK_DIR=str(directory), CUDAHOOK_DUMP=spec)
                command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                           '--tag', 'capture', '--example', 'reconstruction/csrc/granular_history_scene.py',
                           '--frames', str(args.frames), '--output', str(directory), '--',
                           '--history-case', history, '--mode', mode]
                (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
                with (directory/'run.log').open('w') as log:
                    subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                   check=True, timeout=900)
            left, right = case/'original', case/'source'
            checks, events = {}, {}

            def data(directory, key, step, phase, argument, dtype='f4'):
                path = directory/f'dump_{key}_call{step:03d}_{phase}_arg{argument}.bin'
                return np.fromfile(path, dtype=dtype)

            for backend, directory in (('original', left), ('source', right)):
                shortened = broken = formed = 0
                for step in range(args.frames):
                    rest = data(directory, COMMIT, step, 'pre', 3)
                    before = data(directory, COMMIT, step, 'pre', 4)
                    after = data(directory, COMMIT, step, 'post', 4)
                    active_before = data(directory, COMMIT, step, 'pre', 5, 'i4')
                    active_after = data(directory, COMMIT, step, 'post', 5, 'i4')
                    shortened += int(((after < before) & (active_after != 0)).sum())
                    broken += int(((active_before != 0) & (active_after == 0)).sum())
                    if history == 'form':
                        formed += int(((data(directory, FORM, step, 'pre', 8, 'i4') == 0) &
                                       (data(directory, FORM, step, 'post', 8, 'i4') != 0)).sum())
                    else:
                        assert np.all(after[active_after != 0] >= (rest*.7)[active_after != 0])
                events[backend] = {'plastic_updates': shortened, 'fractures': broken, 'formations': formed}
            for step in range(args.frames):
                for phase in ('pre', 'post'):
                    active = data(left, COMMIT, step, phase, 5, 'i4')
                    other = data(right, COMMIT, step, phase, 5, 'i4')
                    checks[f'commit/{step}/{phase}/active'] = active.tobytes() == other.tobytes()
                    mask = active != 0
                    for argument, width, dtype in ((2, 2, 'i4'), (3, 1, 'f4'), (4, 1, 'f4')):
                        a = data(left, COMMIT, step, phase, argument, dtype).reshape(count, width)
                        b = data(right, COMMIT, step, phase, argument, dtype).reshape(count, width)
                        checks[f'commit/{step}/{phase}/{argument}'] = a[mask].tobytes() == b[mask].tobytes()
                    if history == 'form':
                        for argument in (2, 4, 8):
                            a = data(left, FORM, step, phase, argument, 'i4')
                            b = data(right, FORM, step, phase, argument, 'i4')
                            checks[f'form/{step}/{phase}/{argument}'] = a.tobytes() == b.tobytes()
                        live = data(left, FORM, step, phase, 8, 'i4') != 0
                        for argument, width, dtype in ((5, 2, 'i4'), (6, 1, 'f4'), (7, 1, 'f4')):
                            a = data(left, FORM, step, phase, argument, dtype).reshape(count, width)
                            b = data(right, FORM, step, phase, argument, dtype).reshape(count, width)
                            checks[f'form/{step}/{phase}/{argument}'] = a[live].tobytes() == b[live].tobytes()
            expected = {'plastic': 'plastic_updates', 'break': 'fractures', 'form': 'formations'}[history]
            assert all(e[expected] > 0 for e in events.values()), (case.name, events)
            state = compare(np.load(left/'capture.npz'), np.load(right/'capture.npz'))
            metadata = compare_launches(left/'launches.txt', right/'launches.txt', schemas()[0])
            row = {'case': case.name, 'states': state, 'metadata': metadata, 'events': events,
                   'buffer_checks': len(checks), 'buffer_failures': [k for k, v in checks.items() if not v]}
            (case/'report.json').write_text(json.dumps(row, indent=2)+'\n')
            reports.append(row)
            (args.output/'report.json').write_text(json.dumps({'source_sha256': json.loads(saved)['extension_sha256'],
                'hook_sha256': hashlib.sha256(hook.read_bytes()).hexdigest(), 'cases': reports}, indent=2)+'\n')
            print(case.name, state['bitwise'], metadata['equal'], len(row['buffer_failures']), events, flush=True)
    return int(any(not r['states']['bitwise'] or not r['metadata']['equal'] or r['buffer_failures'] for r in reports))


if __name__ == '__main__':
    raise SystemExit(main())
