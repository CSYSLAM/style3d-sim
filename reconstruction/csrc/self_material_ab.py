"""Capture original self/material combinations, then replay one pinned source against states, ABI and buffers."""
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
from .host_api_probe import REFERENCE_SHA
from reconstruction.demo_ab import compare


def cases():
    for material in ('spring', 'tet', 'drag', 'all'):
        for worlds in (1, 3):
            for mode in ('newton', 'pd'):
                for diagonal in (False, True):
                    yield f'{material}-w{worlds}-{mode}-d{int(diagonal)}', [
                        '--material', material, '--worlds', str(worlds), '--seed', str(worlds), '--mode', mode,
                        *(['--diagonal-only'] if diagonal else [])], worlds*20


def dump_fields(total):
    return {
        '15initialize_step': {22: total*4}, '14initialize_rhs': {9: total*12},
        '22accumulate_vertex_face': {6: total*4, 11: total*12, 12: total*36, 14: 4},
        '20accumulate_edge_edge': {6: total*4, 9: total*12, 10: total*36, 12: 4},
        '20accumulate_edge_face': {7: total*4, 10: total*12, 11: total*36, 13: 4},
        '25accumulate_particle_pairs': {5: total*4, 7: total*12, 8: total*36, 10: 4},
        '21evaluate_spring_force': {4: total*12}, '22evaluate_stretch_force': {5: total*12},
        '26evaluate_tetrahedron_force': {8: total*12}, '22evaluate_triangle_drag': {9: total*12},
        '20add_hessian_diagonal': {1: total*36}, '30add_tetrahedron_preconditioner': {6: total*36},
        '32add_triangle_drag_preconditioner': {3: total*36},
        '25multiply_contact_tangents': {3: total*12}, '25multiply_hessian_diagonal': {2: total*12},
        '28multiply_tetrahedron_tangent': {7: total*12}, '30multiply_triangle_drag_tangent': {4: total*12},
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--references', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--only-case', nargs='+')
    parser.add_argument('--frames', type=int, default=3)
    parser.add_argument('--fixture', type=Path, default=ROOT/'reconstruction/csrc/self_material_scene.py')
    parser.add_argument('--particles-per-world', type=int, default=20, help='Exact fixture layout for bounded buffer dumps')
    args = parser.parse_args()
    assert args.particles_per_world > 0
    assert args.backend == 'original' or args.references is not None
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    fixture = args.fixture.resolve(strict=True)
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    hashes = {name: hashlib.sha256(path.read_bytes()).hexdigest() for name, path in
              (('fixture', fixture), ('hook', hook), ('runner', Path(__file__)))}
    (args.output/'provenance.json').write_text(json.dumps(hashes, indent=2)+'\n')
    env = {k: v for k, v in os.environ.items() if k not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
        'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    env.update(LD_PRELOAD=str(hook), CUDAHOOK_DUMP_LIMIT='1')
    reports = []
    for name, extra, total in cases():
        if args.only_case and name not in args.only_case:
            continue
        total = total//20 * args.particles_per_world
        assert manifest.read_bytes() == saved
        assert hashlib.sha256(fixture.read_bytes()).hexdigest() == hashes['fixture']
        directory = args.output/name
        directory.mkdir()
        fields = dump_fields(total)
        env['CUDAHOOK_DIR'] = str(directory)
        env['CUDAHOOK_DUMP'] = ';'.join(key+'='+','.join(f'{i}:{size}' for i, size in sizes.items())
                                       for key, sizes in fields.items())
        (directory/'dump.json').write_text(json.dumps(fields, indent=2)+'\n')
        if args.backend == 'source':
            reference = args.references/name
            runtime = json.loads((reference/'capture.runtime.json').read_text())
            assert runtime['backend'] == 'original' and runtime['image_sha256'] == REFERENCE_SHA
            assert runtime['example_sha256'] == hashes['fixture'] and runtime['launch_hook_sha256'] == hashes['hook']
            assert runtime['frames'] == args.frames and runtime['extra'] == extra
            assert json.loads((reference/'dump.json').read_text()) == json.loads((directory/'dump.json').read_text())
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', args.backend,
                   '--tag', 'capture', '--example', str(fixture), '--frames', str(args.frames),
                   '--output', str(directory), '--', *extra]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (directory/'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, timeout=900).returncode
        row = {'case': name, 'worker_exit': code}
        if not code:
            runtime = json.loads((directory/'capture.runtime.json').read_text())
            expected = REFERENCE_SHA if args.backend == 'original' else json.loads(saved)['extension_sha256']
            assert runtime['image_sha256'] == expected and runtime['example_sha256'] == hashes['fixture']
            with np.load(directory/'capture.npz') as run:
                row['finite'] = all(np.isfinite(run[k]).all() for k in run.files)
            if args.backend == 'source':
                with np.load(reference/'capture.npz') as old, np.load(directory/'capture.npz') as new:
                    row['states'] = compare(old, new)
                row['metadata'] = compare_launches(reference/'launches.txt', directory/'launches.txt', schemas()[0])
                row['coverage'] = sum(json.loads((directory/'capture.launches.json').read_text()).values()) == \
                    row['metadata']['right_launches']
                # Pre-force buffers can be uninitialized. Only the explicitly defined pre-stiffness and post outputs count.
                checks = {}
                for key, arguments in fields.items():
                    for argument in arguments:
                        if key.startswith(('22accumulate', '20accumulate', '25accumulate')):
                            phase = 'pre' if argument == min(arguments) else 'post'
                        else:
                            phase = 'post'
                        filename = f'dump_{key}_{phase}_arg{argument}.bin'
                        a, b = reference/filename, directory/filename
                        if a.exists() or b.exists():
                            checks[f'{key}/{phase}/{argument}'] = a.exists() and b.exists() and \
                                a.read_bytes() == b.read_bytes()
                row['buffers'] = checks
                row['reference'] = str(reference.resolve())
        row['passed'] = bool(not code and row['finite'] and (args.backend == 'original' or (
            row['states']['bitwise'] and row['metadata']['equal'] and row['coverage'] and all(row['buffers'].values()))))
        reports.append(row)
        (directory/'report.json').write_text(json.dumps(row, indent=2)+'\n')
        (args.output/'report.json').write_text(json.dumps({'backend': args.backend, 'cases': reports,
            'source_sha256': json.loads(saved)['extension_sha256'],
            'library_runtime_launches_completely_observed': False}, indent=2)+'\n')
        print(name, 'exit', code, 'states', row.get('states', {}).get('bitwise'),
              'metadata', row.get('metadata', {}).get('equal'),
              'buffer_failures', [k for k, v in row.get('buffers', {}).items() if not v], flush=True)
        if code or (args.backend == 'source' and not row['metadata']['equal']):
            return 2
    assert reports
    return int(any(not row['passed'] for row in reports))


if __name__ == '__main__':
    raise SystemExit(main())
