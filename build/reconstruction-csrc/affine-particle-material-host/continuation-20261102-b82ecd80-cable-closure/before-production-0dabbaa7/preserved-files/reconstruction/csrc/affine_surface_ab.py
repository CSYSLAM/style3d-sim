"""Capture actual body/full-surface schedules before enabling this source solver branch."""
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
    for worlds, mode, block, diagonal, self_contact, springs in (
        (1, 'newton', False, False, False, False), (1, 'newton', True, False, False, True),
        (1, 'newton', True, True, True, True), (1, 'pd', False, False, False, False),
        (1, 'pd', True, True, True, True), (3, 'newton', False, False, False, False),
        (3, 'newton', True, True, True, True), (3, 'pd', True, True, True, True),
    ):
        name = f'w{worlds}-{mode}-b{int(block)}-d{int(diagonal)}-s{int(self_contact)}-p{int(springs)}'
        extra = ['--worlds', str(worlds), '--mode', mode, '--contacts']
        for flag, value in (('--body-block', block), ('--diagonal-only', diagonal),
                            ('--self', self_contact), ('--springs', springs)):
            if value:
                extra.append(flag)
        yield name, worlds, extra


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--references', type=Path)
    parser.add_argument('--frames', type=int, default=3)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert args.frames > 0 and (args.backend == 'original' or args.references is not None)
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output / 'build.json').write_bytes(saved)
    fixture = ROOT / 'reconstruction/csrc/affine_surface_scene.py'
    hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    paths = [Path(__file__), fixture, hook, ROOT / 'reconstruction/csrc/demo_source_ab.py',
             ROOT / 'reconstruction/csrc/host_bodies_ab.py']
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}
    (args.output / 'provenance.json').write_text(json.dumps(hashes, indent=2) + '\n')
    env = {k: v for k, v in os.environ.items() if k not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP',
        'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    rows = []
    for name, worlds, extra in cases():
        assert build.read_bytes() == saved
        assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == h for p, h in hashes.items())
        directory = args.output / name
        directory.mkdir()
        total = 12 * worlds
        fields = {'15initialize_step': {22: total * 4}, '14initialize_rhs': {9: total * 12},
                  '30evaluate_surface_contact_force': {0: 4, 1: total * 12},
                  '34add_surface_contact_preconditioner': {1: total * 36},
                  '32multiply_surface_contact_tangent': {2: total * 12},
                  '35add_surface_contact_stiffness_scale': {1: total * 4},
                  '27invert_block_preconditioner': {0: total * 36}}
        (directory / 'dump.json').write_text(json.dumps(fields, indent=2) + '\n')
        reference = args.references / name if args.references else None
        if reference:
            runtime = json.loads((reference / 'capture.runtime.json').read_text())
            assert runtime['image_sha256'] == REFERENCE_SHA and runtime['example_sha256'] == hashes[str(fixture)]
            assert runtime['frames'] == args.frames and runtime['extra'] == extra
            assert runtime['launch_hook_sha256'] == hashes[str(hook)]
            assert json.loads((reference / 'dump.json').read_text()) == json.loads((directory / 'dump.json').read_text())
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', args.backend,
                   '--tag', 'capture', '--example', str(fixture), '--frames', str(args.frames),
                   '--output', str(directory), '--', *extra]
        dump = ';'.join(key + '=' + ','.join(f'{index}:{size}' for index, size in values.items())
                        for key, values in fields.items())
        (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (directory / 'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook),
                'CUDAHOOK_DIR': str(directory), 'CUDAHOOK_DUMP': dump, 'CUDAHOOK_DUMP_LIMIT': '1', 'DEMO_POINTERS': '1'},
                stdout=log, stderr=subprocess.STDOUT, timeout=900).returncode
        row = {'case': name, 'worker_exit': code, 'passed': False}
        if not code:
            runtime = json.loads((directory / 'capture.runtime.json').read_text())
            assert runtime['image_sha256'] == (REFERENCE_SHA if args.backend == 'original' else
                                              json.loads(saved)['extension_sha256'])
            with np.load(directory / 'capture.npz') as values:
                row['finite'] = all(np.isfinite(values[k]).all() for k in values.files)
            row['active_surface_contacts'] = int(np.fromfile(
                directory / 'dump_30evaluate_surface_contact_force_post_arg0.bin', dtype='i4')[0])
            before, after = [np.fromfile(directory / f'dump_30evaluate_surface_contact_force_{phase}_arg1.bin',
                                         dtype='f4').reshape(worlds, 12, 3) for phase in ('pre', 'post')]
            row['surface_cloth_rhs_changed'] = before[:, :8].tobytes() != after[:, :8].tobytes()
            row['surface_body_rhs_changed'] = before[:, 8:].tobytes() != after[:, 8:].tobytes()
            assert row['active_surface_contacts'] > 0
            assert row['surface_cloth_rhs_changed'] and row['surface_body_rhs_changed']
            if reference:
                with np.load(reference / 'capture.npz') as old, np.load(directory / 'capture.npz') as new:
                    row['states'] = compare(old, new)
                row['metadata'] = compare_launches(reference / 'launches.txt', directory / 'launches.txt', schemas()[0])
                counts = json.loads((directory / 'capture.launches.json').read_text())
                row['coverage'] = sum(counts.values()) == row['metadata']['right_launches']
                checks = {}
                for token, arguments in fields.items():
                    for index in arguments:
                        filename = f'dump_{token}_post_arg{index}.bin'
                        a, b = reference / filename, directory / filename
                        if a.exists() or b.exists():
                            checks[filename] = a.exists() and b.exists() and a.read_bytes() == b.read_bytes()
                row['buffers'] = checks
            row['passed'] = row['finite'] and (not reference or (
                row['states']['bitwise'] and row['metadata']['equal'] and row['coverage'] and all(row['buffers'].values())))
        rows.append(row)
        (directory / 'report.json').write_text(json.dumps(row, indent=2) + '\n')
        (args.output / 'report.json').write_text(json.dumps({'cases': rows, 'source_sha256':
            json.loads(saved)['extension_sha256'], 'full_solver_complete': False}, indent=2) + '\n')
        print(name, 'exit', code, 'passed', row['passed'], flush=True)
        if code:
            return 2
    return int(any(not row['passed'] for row in rows))


if __name__ == '__main__':
    raise SystemExit(main())
