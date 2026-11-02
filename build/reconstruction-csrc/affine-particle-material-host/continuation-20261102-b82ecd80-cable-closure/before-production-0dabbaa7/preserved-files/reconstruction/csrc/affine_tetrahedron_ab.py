"""Capture actual SO3/tetrahedron schedules and inputs before admitting the source-host combination."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from reconstruction.demo_ab import compare
from .audit_cudahook import compare as compare_launches, schemas
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA


def cases():
    for worlds in (1, 3):
        for mode in ('newton', 'pd'):
            for block in (False, True):
                extra = ['--worlds', str(worlds), '--mode', mode] + (['--body-block'] if block else [])
                yield f'w{worlds}-{mode}-b{int(block)}', worlds, extra


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--references', type=Path)
    parser.add_argument('--frames', type=int, default=3)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    assert args.backend == 'original' or args.references
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output / 'build.json').write_bytes(saved)
    fixture = ROOT / 'reconstruction/csrc/affine_tetrahedron_scene.py'
    hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (Path(__file__), fixture, hook)}
    layout = schemas()[0]
    env = {key: value for key, value in os.environ.items()
           if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_'))
           and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD')}
    rows = []
    for name, worlds, extra in cases():
        assert build.read_bytes() == saved
        assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == sha for p, sha in hashes.items())
        n = 8 * worlds
        fields = {'15initialize_step': {19: 8 * 4, 22: n * 4}, '14initialize_rhs': {9: n * 12},
                  '51evaluate_affine_body_so3_augmented_lagrangian_force': {6: n * 12},
                  '26evaluate_tetrahedron_force': {8: n * 12},
                  '30add_tetrahedron_preconditioner': {4: 4, 6: n * 36},
                  '28multiply_tetrahedron_tangent': {7: n * 12},
                  '27invert_block_preconditioner': {3: n * 36}}
        for token, arguments in fields.items():
            assert all(schema[i] == 'pointer' for kernel, schema in layout.items() if token in kernel for i in arguments)
        folder = args.output / name
        folder.mkdir()
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', args.backend,
                   '--tag', 'capture', '--example', str(fixture), '--frames', str(args.frames),
                   '--output', str(folder), '--', *extra]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        (folder / 'fields.json').write_text(json.dumps(fields, indent=2) + '\n')
        dump = ';'.join(token + '=' + ','.join(f'{i}:{size}' for i, size in values.items())
                        for token, values in fields.items())
        with (folder / 'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, timeout=900, stdout=log, stderr=subprocess.STDOUT,
                                  env={**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder),
                                       'CUDAHOOK_DUMP': dump, 'CUDAHOOK_DUMP_LIMIT': '1'}).returncode
        row = {'case': name, 'exit': code, 'passed': False}
        if not code:
            runtime = json.loads((folder / 'capture.runtime.json').read_text())
            assert runtime['image_sha256'] == (REFERENCE_SHA if args.backend == 'original' else
                                              json.loads(saved)['extension_sha256'])
            with np.load(folder / 'capture.npz') as data:
                row['finite'] = all(np.isfinite(data[key]).all() for key in data.files)
            before = (folder / 'dump_26evaluate_tetrahedron_force_pre_arg8.bin').read_bytes()
            after = (folder / 'dump_26evaluate_tetrahedron_force_post_arg8.bin').read_bytes()
            row['tetrahedron_changes_rhs'] = before != after
            assert row['tetrahedron_changes_rhs']
            if args.references:
                ref = args.references / name
                old_runtime = json.loads((ref / 'capture.runtime.json').read_text())
                assert old_runtime['image_sha256'] == REFERENCE_SHA
                assert old_runtime['example_sha256'] == runtime['example_sha256']
                assert old_runtime['extra'] == runtime['extra'] and old_runtime['frames'] == runtime['frames']
                with np.load(ref / 'capture.npz') as old, np.load(folder / 'capture.npz') as new:
                    row['states'] = compare(old, new)
                row['metadata'] = compare_launches(ref / 'launches.txt', folder / 'launches.txt', layout)
                counts = json.loads((folder / 'capture.launches.json').read_text())
                row['coverage'] = sum(counts.values()) == row['metadata']['right_launches']
                buffers = {path.name: path.read_bytes() == (ref / path.name).read_bytes()
                           for path in folder.glob('dump_*_post_arg*.bin')}
                row['buffers'] = buffers
                row['passed'] = row['finite'] and row['states']['bitwise'] and row['metadata']['equal'] and row['coverage'] \
                    and all(buffers.values())
            else:
                row['passed'] = row['finite']
        rows.append(row)
        (args.output / 'report.json').write_text(json.dumps({
            'source_sha256': json.loads(saved)['extension_sha256'], 'cases': rows, 'whole_solver_complete': False,
            'harness_sha256': hashes}, indent=2) + '\n')
        print(name, 'exit', code, 'passed', row['passed'], flush=True)
    return int(any(not row['passed'] for row in rows))


if __name__ == '__main__':
    raise SystemExit(main())
