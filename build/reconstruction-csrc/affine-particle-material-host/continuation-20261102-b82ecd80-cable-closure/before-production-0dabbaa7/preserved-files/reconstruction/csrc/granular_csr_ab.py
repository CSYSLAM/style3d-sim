"""Observe actual initial-bond exclusion CSR, including cohesion zero while adhesion remains enabled."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from .audit_cudahook import compare as compare_launches, schemas
from .demo_source_ab import ROOT
from reconstruction.demo_ab import compare

FORM = '15granular_kernel10form_bonds'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--worlds', type=int, nargs='+', default=[1, 2, 3])
    parser.add_argument('--frames', type=int, default=30)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    hook = ROOT/'build/reconstruction-csrc/granular-host/cudahook.so'
    env = {key: value for key, value in os.environ.items() if key not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(hook), CUDAHOOK_DUMP_LIMIT='1')
    reports = []
    for worlds in args.worlds:
        for cohesion in (200, 0):
            for mode in ('newton', 'pd'):
                name = f'w{worlds}-cohesion{cohesion}-{mode}'
                subset = worlds == 2
                points, authored = (4 if subset else 8)*worlds, 2*worlds
                capacity = points*3
                sizes = {2: (points+1)*4, 3: authored*4, 4: capacity*4,
                         5: capacity*8, 6: capacity*4, 7: capacity*4, 8: capacity*4}
                env['CUDAHOOK_DUMP'] = FORM+'='+','.join(f'{i}:{size}' for i, size in sizes.items())
                extra = ['--bonds', 'mixed', '--worlds', str(worlds), '--seed', str(worlds),
                         '--cohesion', str(cohesion), '--mode', mode, *(['--subset'] if subset else []),
                         *(['--reverse-authored'] if worlds == 3 else [])]
                case = args.output/name
                failed = {}
                for backend in ('original', 'source'):
                    assert build.read_bytes() == saved
                    directory = case/backend
                    directory.mkdir(parents=True)
                    env['CUDAHOOK_DIR'] = str(directory)
                    command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                               '--tag', 'capture', '--example', 'reconstruction/csrc/granular_disabled_bonds_scene.py',
                               '--frames', str(args.frames), '--output', str(directory), '--', *extra]
                    (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
                    with (directory/'run.log').open('w') as log:
                        code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                              timeout=900).returncode
                    if code:
                        failed[backend] = code
                row = {'case': name, 'failed_workers': failed, 'checks': {}, 'frames': args.frames}
                if not failed:
                    left, right = case/'original', case/'source'
                    with np.load(left/'capture.npz') as original, np.load(right/'capture.npz') as source:
                        row['states_finite'] = bool(all(np.isfinite(r[k]).all() for r in (original, source) for k in r.files))
                        row['states'] = compare(original, source)
                    row['metadata'] = compare_launches(left/'launches.txt', right/'launches.txt', schemas()[0])
                    for phase in ('pre', 'post'):
                        arrays = {}
                        for backend, folder in (('original', left), ('source', right)):
                            arrays[backend] = {}
                            for i, size in sizes.items():
                                raw = (folder/f'dump_{FORM}_{phase}_arg{i}.bin').read_bytes()
                                assert len(raw) == size, (folder, i)
                                arrays[backend][i] = raw
                            offsets = np.frombuffer(arrays[backend][2], dtype='i4')
                            row['checks'][f'{backend}/{phase}/logical_columns'] = int(offsets[-1]) == authored
                        for i in (2, 3, 4, 8):
                            row['checks'][f'{phase}/{i}'] = arrays['original'][i] == arrays['source'][i]
                        active = np.frombuffer(arrays['original'][8], dtype='i4') != 0
                        for i, width in ((5, 2), (6, 1), (7, 1)):
                            a = np.frombuffer(arrays['original'][i], dtype='u4').reshape(capacity, width)
                            b = np.frombuffer(arrays['source'][i], dtype='u4').reshape(capacity, width)
                            row['checks'][f'{phase}/{i}/live'] = a[active].tobytes() == b[active].tobytes()
                reports.append(row)
                (args.output/'report.json').write_text(json.dumps({'source_sha256': json.loads(saved)['extension_sha256'],
                    'first_form_only': True, 'cases': reports}, indent=2)+'\n')
                print(name, 'failed', failed, 'checks', [k for k, v in row['checks'].items() if not v],
                      'states', row.get('states', {}).get('bitwise'), flush=True)
    return int(any(row['failed_workers'] or not row['states_finite'] or not row['states']['bitwise'] or
                   not row['metadata']['equal'] or not all(row['checks'].values()) for row in reports))


if __name__ == '__main__':
    raise SystemExit(main())
