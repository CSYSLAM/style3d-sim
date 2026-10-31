"""Locate the first actual intermediate-buffer difference in one dense granular Solver step."""
import argparse
import json
import os
from pathlib import Path
import re
import struct
import subprocess
import sys

import numpy as np

from .audit_cudahook import compare, parameter_types, schemas
from .demo_source_ab import ROOT
from .granular_grid_probe import FORCE, view_bytes


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
    parser.add_argument('--example', default='reconstruction/csrc/granular_host_scene.py')
    parser.add_argument('--frames', type=int, default=1)
    parser.add_argument('--template-log', type=Path)
    parser.add_argument('--launch-hook', type=Path, default=ROOT/'build/reconstruction-csrc/granular-host/cudahook.so')
    parser.add_argument('extra', nargs='*')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    n, points, slots = 64, 64, 128
    if args.template_log:
        lines = args.template_log.read_text().splitlines()
        points, slots = struct.unpack_from('<2i', view_bytes(next(l for l in lines if l.split()[1] == FORCE)), 88)
        grid_line = next(l for l in lines if l.split()[1] == '15granular_kernel10build_grid')
        word = int(re.search(r'Mview:.*?24:([0-9a-f]+)\(', grid_line).group(1), 16)
        n = word >> 32
        assert 0 < points <= n and slots > 0
    # Bond fields use the two-entry prefix, valid for both authored and reserved dynamic arrays.
    layouts = {
        '15initialize_step': ({4: n*12, 5: n*12, 6: n*4, 17: n*4, 18: n*4,
                               20: n*12, 21: n*12, 22: n*4}, [20, 21, 22], [4, 5, 6, 17, 18]),
        '14initialize_rhs': ({1: n*12, 2: n*12, 3: n*4, 4: n*4, 7: n*12, 8: n*4, 9: n*12}, [9], [1, 2, 3, 4, 7, 8]),
        '15granular_kernel10build_grid': ({1: n*12, 2: n*12, 4: points*12, 5: points*12, 6: points*4,
                                          7: points*4, 8: points*4, 9: points*12, 10: slots*4, 11: points*4},
                                         list(range(4, 12)), [1, 2]),
        '15granular_kernel19accumulate_contacts': ({1: n*12, 2: n*36, 3: points*4,
                                                   4: points*32*4, 5: points*32*16},
                                                  [1, 2, 3], [1, 2]),
        '27evaluate_soft_contact_force': ({32: n*12, 33: n*12, 34: n*12, 36: n*12, 37: n*4,
                                            40: n*36, 41: n*36}, [36, 37, 40, 41], [32, 33, 34]),
        '42multiply_soft_contact_hessian_off_diagonal': ({23: n*12, 24: n*12, 25: n*12}, [25], [23, 24]),
        '15granular_kernel16accumulate_bonds': ({1: n*12, 2: n*12, 4: 16, 5: 8, 6: 8, 7: 8,
                                               10: n*12, 11: n*36, 12: 72}, [10, 11, 12], [1, 2, 4, 5, 6, 7, 10, 11]),
        '25initialize_block_diagonal': ({0: n*4, 1: n*36, 2: n*36}, [1, 2], [0]),
        '15granular_kernel12add_diagonal': ({0: n*36, 1: n*36}, [1], [0, 1]),
        '27invert_block_preconditioner': ({0: n*36, 3: n*36}, [3], [0]),
        '23precondition_and_reduce': ({0: n*36, 1: n*12, 2: n*12, 6: 4}, [2, 6], [0, 1, 6]),
        '19update_cg_direction': ({1: n*12, 4: 4, 5: 4, 6: n*12}, [6], [1, 4, 5]),
        '15granular_kernel17multiply_contacts': ({1: n*12, 2: n*12}, [2], [1, 2]),
        '15granular_kernel14multiply_bonds': ({0: 16, 1: 8, 2: 72, 4: n*12, 5: n*12}, [5], [0, 1, 2, 4, 5]),
        '26multiply_matrix_and_reduce': ({0: n*4, 3: n*36, 4: n*12, 5: n*12, 6: n*12, 9: 4},
                                        [6, 9], [0, 3, 4, 5, 9]),
        '28update_solution_and_residual': ({2: 4, 3: 4, 4: n*12, 5: n*12, 6: n*12, 7: n*12},
                                          [6, 7], [2, 3, 4, 5, 6, 7]),
        '20apply_nonlinear_step': ({0: n*12, 1: n*12, 2: n*12}, [1], [0, 2]),
        '15update_velocity': ({1: n*12, 2: n*12, 3: n*12}, [3], [1, 2]),
    }
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    kernels = json.loads(saved)['kernels']
    for key, (sizes, _, _) in layouts.items():
        names = [name for name in kernels if key in name]
        assert names, ('Missing kernel ABI', key)
        for name in names:
            types = parameter_types(name)
            assert all('*' in types[i] for i in sizes), ('Dump must target a pointer argument', key, sizes, types)
    specification = ';'.join(key+'='+','.join(f'{i}:{size}' for i, size in sizes.items())
                              for key, (sizes, _, _) in layouts.items())
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(args.launch_hook.resolve(strict=True)),
               CUDAHOOK_DUMP=specification, CUDAHOOK_DUMP_LIMIT='100')
    (args.output/'settings.json').write_text(json.dumps({'mode': args.mode, 'dump': specification,
        'example': args.example, 'frames': args.frames, 'particles': n, 'points': points, 'slots': slots,
        'template_log': str(args.template_log), 'layouts': layouts, 'dynamic_bond_prefix_only': True}, indent=2)+'\n')
    (args.output/'build.json').write_bytes(saved)
    extra = args.extra
    if args.example == 'reconstruction/csrc/granular_host_scene.py':
        extra = ['--layout', 'fallback', '--bonds', 'mixed', '--mode', args.mode, *extra]
    for backend in ('original', 'source'):
        assert build.read_bytes() == saved, 'Source image changed during this batch'
        directory = args.output/backend
        directory.mkdir()
        env['CUDAHOOK_DIR'] = str(directory)
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                   '--tag', 'capture', '--example', args.example, '--frames', str(args.frames),
                   '--output', str(directory), '--', *extra]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (directory/'run.log').open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=600)
    left, right = args.output/'original', args.output/'source'
    metadata = compare(left/'launches.txt', right/'launches.txt', schemas()[0])
    seen, comparisons, differences = {}, [], []
    for line in (left/'launches.txt').read_text().splitlines():
        symbol = line.split()[-2][7:]
        matches = [key for key in layouts if key in symbol]
        if not matches:
            continue
        assert len(matches) == 1
        key = matches[0]
        ordinal = seen.get(key, 0)
        seen[key] = ordinal+1
        _, outputs, inputs = layouts[key]

        def get(folder, phase, index):
            path = folder/f'dump_{key}_call{ordinal:03d}_{phase}_arg{index}.bin'
            return path.read_bytes() if path.exists() else None

        before = {str(i): get(left, 'pre', i) == get(right, 'pre', i) for i in inputs}
        for i in outputs:
            a, b = get(left, 'post', i), get(right, 'post', i)
            if a is None and b is None:
                continue
            same = a == b
            row = {'launch': int(line.split()[0]), 'key': key, 'ordinal': ordinal, 'output': i,
                   'bitwise': same, 'inputs_equal': before}
            if not same:
                assert a is not None and b is not None and len(a) == len(b)
                x, y = np.frombuffer(a, dtype='u4'), np.frombuffer(b, dtype='u4')
                locations = np.flatnonzero(x != y)
                row['different_words'] = int(len(locations))
                row['first_words'] = [{'index': int(j), 'original': hex(int(x[j])), 'source': hex(int(y[j]))}
                                      for j in locations[:8]]
                differences.append(row)
            comparisons.append(row)
    report = {'metadata': metadata, 'comparisons': comparisons, 'first_differences': differences[:20],
              'different_buffers': len(differences), 'partial_dynamic_bond_buffers': True}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({'metadata_equal': metadata['equal'], 'different_buffers': len(differences),
                      'first': differences[:2]}))


if __name__ == '__main__':
    main()
