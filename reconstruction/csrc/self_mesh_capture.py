"""Capture safe prefixes and complete owned launch metadata from isolated original mesh self-collision scenes."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import sys

from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--backend', choices=('original', 'source'), default='original')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(hook), CUDAHOOK_DUMP_LIMIT='2')
    rows = []
    for kind, local, edges in (('particle-face', 4, 0), ('vertex-face', 6, 0), ('edge-edge', 4, 2), ('edge-face', 7, 1)):
        for mode, worlds, diagonal in (('newton', 1, False), ('pd', 1, False),
                                       ('newton', 3, False), ('newton', 1, True)):
            total = local*worlds
            fields = {
                '17query_vertex_face': {1: 4, 2: local*4, 4: local*4, 12: 4, 13: 31*4},
                '15query_edge_edge': {2: local*4, 8: 4, 9: 31*4},
                '15query_edge_face': {3: local*4, 9: 4, 10: 31*4},
                '22accumulate_vertex_face': {1: 4, 4: 4, 5: 31*4, 6: total*4,
                                            11: total*12, 12: total*36, 13: 60, 14: 4},
                '20accumulate_edge_edge': {2: (edges+1)*4, 6: total*4, 9: total*12, 10: total*36, 11: 60, 12: 4},
                '20accumulate_edge_face': {2: (edges+1)*4, 3: 8, 7: total*4,
                                          10: total*12, 11: total*36, 12: 60, 13: 4},
                '20add_hessian_diagonal': {0: total*36, 1: total*36},
                '25multiply_contact_tangents': {0: 60, 1: 4, 2: total*12, 3: total*12},
                '25multiply_hessian_diagonal': {0: total*36, 1: total*12, 2: total*12},
            }
            env['CUDAHOOK_DUMP'] = ';'.join(key+'='+','.join(f'{i}:{size}' for i, size in sizes.items())
                                           for key, sizes in fields.items())
            directory = args.output/f'{kind}-{mode}-w{worlds}-d{int(diagonal)}'
            directory.mkdir()
            env['CUDAHOOK_DIR'] = str(directory)
            extra = ['--kind', kind, '--mode', mode, '--worlds', str(worlds),
                     *(['--diagonal-only'] if diagonal else [])]
            command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', args.backend,
                       '--tag', 'capture', '--example', 'reconstruction/csrc/self_mesh_scene.py', '--frames', '3',
                       '--output', str(directory), '--', *extra]
            (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
            (directory/'dump.json').write_text(json.dumps({'fields': fields, 'total_particles': total,
                'local_particles': local, 'only_safe_prefixes': True}, indent=2)+'\n')
            with (directory/'run.log').open('w') as log:
                code = subprocess.run(command, cwd=ROOT, env=env, stdout=log,
                                      stderr=subprocess.STDOUT, timeout=900).returncode
            rows.append({'case': directory.name, 'exit': code})
            (args.output/'status.json').write_text(json.dumps(rows, indent=2)+'\n')
            print(directory.name, code, flush=True)
    return int(any(row['exit'] for row in rows))


if __name__ == '__main__':
    raise SystemExit(main())
