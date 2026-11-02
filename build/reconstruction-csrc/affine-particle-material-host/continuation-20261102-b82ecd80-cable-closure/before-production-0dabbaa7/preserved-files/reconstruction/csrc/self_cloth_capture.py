"""Capture actual material/self-collision force ordering and stiffness scalars from the pinned original."""
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
    parser.add_argument('--only-case', nargs='+', help='Capture selected unchanged cases into a new result directory')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(hook), CUDAHOOK_DUMP_LIMIT='1')
    cases = [('membrane-newton', []), ('membrane-pd', ['--mode', 'pd']),
             ('membrane-world3', ['--worlds', '3', '--seed', '3']), ('membrane-diagonal', ['--diagonal-only']),
             ('hinge-newton', ['--hinges']), ('hinge-pd', ['--hinges', '--mode', 'pd']),
             ('hinge-world3', ['--hinges', '--worlds', '3', '--seed', '3']),
             ('hinge-pinned', ['--hinges', '--pinned']), ('hinge-free', ['--hinges', '--free']),
             ('contact-newton', ['--contacts']), ('contact-pd', ['--contacts', '--mode', 'pd']),
             ('contact-hinge-newton', ['--contacts', '--hinges']),
             ('contact-hinge-pd', ['--contacts', '--hinges', '--mode', 'pd']),
             ('contact-pd-diagonal', ['--contacts', '--mode', 'pd', '--diagonal-only']),
             ('hinge-pd-diagonal', ['--hinges', '--mode', 'pd', '--diagonal-only']),
             ('contact-hinge-pd-diagonal', ['--contacts', '--hinges', '--mode', 'pd', '--diagonal-only'])]
    status = []
    for name, extra in cases:
        if args.only_case and name not in args.only_case:
            continue
        local = (8 if '--hinges' in extra else 6) + (2 if '--free' in extra else 0)
        total = local * (3 if '--worlds' in extra else 1)
        fields = {
            '15initialize_step': {20: total*12, 21: total*12, 22: total*4},
            '14initialize_rhs': {9: total*12},
            '22accumulate_vertex_face': {6: total*4, 11: total*12, 12: total*36, 14: 4},
            '20accumulate_edge_edge': {6: total*4, 9: total*12, 10: total*36, 12: 4},
            '20accumulate_edge_face': {7: total*4, 10: total*12, 11: total*36, 13: 4},
            '25accumulate_particle_pairs': {5: total*4, 7: total*12, 8: total*36, 10: 4},
            '22evaluate_stretch_force': {5: total*12}, '22evaluate_bending_force': {7: total*12},
            '27evaluate_soft_contact_force': {36: total*12, 37: total*4},
            '35add_surface_contact_stiffness_scale': {1: total*4},
            '20add_hessian_diagonal': {0: total*36, 1: total*36},
        }
        out = args.output/name
        out.mkdir()
        env['CUDAHOOK_DIR'] = str(out)
        env['CUDAHOOK_DUMP'] = ';'.join(key+'='+','.join(f'{i}:{size}' for i, size in sizes.items())
                                       for key, sizes in fields.items())
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'original', '--tag', 'capture',
                   '--example', 'reconstruction/csrc/self_cloth_scene.py', '--frames', '3', '--output', str(out),
                   '--', *extra]
        (out/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        (out/'dump.json').write_text(json.dumps({'fields': fields, 'total_particles': total}, indent=2)+'\n')
        with (out/'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, timeout=900).returncode
        status.append({'case': name, 'exit': code})
        (args.output/'status.json').write_text(json.dumps(status, indent=2)+'\n')
        print(name, code, flush=True)
    return int(any(row['exit'] for row in status))


if __name__ == '__main__':
    raise SystemExit(main())
