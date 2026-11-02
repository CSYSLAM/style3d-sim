"""Capture nonempty body/tetrahedron full-surface contact before admitting this source-host scope."""
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
                for diagonal in (False, True):
                    extra = ['--worlds', str(worlds), '--mode', mode]
                    if block:
                        extra.append('--body-block')
                    if diagonal:
                        extra.append('--diagonal-only')
                    yield f'w{worlds}-{mode}-b{int(block)}-d{int(diagonal)}', worlds, extra


def clean_env():
    return {key: value for key, value in os.environ.items()
            if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
            and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD')}


def fixture_path(kind):
    stem = 'affine_tetrahedron_contact_scene' if kind == 'surface' else 'affine_tetrahedron_legacy_contact_scene'
    return ROOT / 'reconstruction/csrc' / (stem + '.py')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--references', type=Path)
    parser.add_argument('--frames', type=int, default=3)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--contact-kind', choices=('surface', 'legacy'), default='surface')
    args = parser.parse_args()
    assert args.frames > 0 and (args.backend == 'original' or args.references)
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    if args.references:
        args.references = args.references.resolve(strict=True)
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output / 'build.json').write_bytes(saved)
    fixture = fixture_path(args.contact_kind)
    hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    paths = (Path(__file__), fixture, hook, ROOT / 'reconstruction/csrc/demo_source_ab.py',
             ROOT / 'reconstruction/csrc/host_bodies_ab.py')
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}
    (args.output / 'provenance.json').write_text(json.dumps(hashes, indent=2) + '\n')
    layout = schemas()[0]
    rows = []
    for name, worlds, extra in cases():
        assert build.read_bytes() == saved
        assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == sha for p, sha in hashes.items())
        n = 8 * worlds
        fields = {'15initialize_step': {22: n * 4}, '14initialize_rhs': {9: n * 12},
                  '26evaluate_tetrahedron_force': {8: n * 12},
                  '30add_tetrahedron_preconditioner': {6: n * 36},
                  '28multiply_tetrahedron_tangent': {7: n * 12},
                  '27invert_block_preconditioner': {0: n * 36}}
        if args.contact_kind == 'surface':
            fields.update({'30evaluate_surface_contact_force': {0: 4, 1: n * 12},
                           '34add_surface_contact_preconditioner': {1: n * 36},
                           '32multiply_surface_contact_tangent': {2: n * 12}})
            force_token, rhs_index = '30evaluate_surface_contact_force', 1
        else:
            fields['27evaluate_soft_contact_force'] = {0: 4, 36: n * 12, 37: n * 4}
            if '--diagonal-only' not in extra:
                fields['42multiply_soft_contact_hessian_off_diagonal'] = {25: n * 12}
            force_token, rhs_index = '27evaluate_soft_contact_force', 36
        for token, arguments in fields.items():
            matches = [schema for kernel, schema in layout.items() if token in kernel]
            assert matches
            for schema in matches:
                for i, size in arguments.items():
                    # SurfaceContactView starts with the device count pointer; the hook dereferences that word.
                    view_count = token == '30evaluate_surface_contact_force' and i == 0 and schema[i] == 'U' and size == 4
                    assert schema[i] == 'pointer' or view_count, (token, i, schema[i])
        folder = args.output / name
        folder.mkdir()
        (folder / 'fields.json').write_text(json.dumps(fields, indent=2) + '\n')
        ref = args.references / name if args.references else None
        if ref:
            runtime = json.loads((ref / 'capture.runtime.json').read_text())
            assert runtime['image_sha256'] == REFERENCE_SHA and runtime['example_sha256'] == hashes[str(fixture)]
            assert runtime['frames'] == args.frames and runtime['extra'] == extra
            assert runtime['launch_hook_sha256'] == hashes[str(hook)]
            assert json.loads((ref / 'fields.json').read_text()) == json.loads((folder / 'fields.json').read_text())
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', args.backend,
                   '--tag', 'capture', '--example', str(fixture), '--frames', str(args.frames),
                   '--output', str(folder), '--', *extra]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        dump = ';'.join(token + '=' + ','.join(f'{i}:{size}' for i, size in values.items())
                        for token, values in fields.items())
        with (folder / 'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, timeout=900, stdout=log, stderr=subprocess.STDOUT,
                                  env={**clean_env(), 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder),
                                       'CUDAHOOK_DUMP': dump, 'CUDAHOOK_DUMP_LIMIT': '1', 'DEMO_POINTERS': '1'}).returncode
        row = {'case': name, 'exit': code, 'passed': False}
        if not code:
            runtime = json.loads((folder / 'capture.runtime.json').read_text())
            assert runtime['image_sha256'] == (REFERENCE_SHA if args.backend == 'original' else
                                              json.loads(saved)['extension_sha256'])
            with np.load(folder / 'capture.npz') as data:
                row['finite'] = all(np.isfinite(data[key]).all() for key in data.files)
            row['active_surface_contacts'] = int(np.fromfile(
                folder / f'dump_{force_token}_post_arg0.bin', dtype='i4')[0])
            before, after = [np.fromfile(folder / f'dump_{force_token}_{phase}_arg{rhs_index}.bin',
                                         dtype='f4').reshape(worlds, 8, 3) for phase in ('pre', 'post')]
            row['surface_tetrahedron_rhs_changed'] = before[:, :4].tobytes() != after[:, :4].tobytes()
            row['surface_body_rhs_changed'] = before[:, 4:].tobytes() != after[:, 4:].tobytes()
            row['tetrahedron_changes_rhs'] = (folder / 'dump_26evaluate_tetrahedron_force_pre_arg8.bin').read_bytes() != \
                (folder / 'dump_26evaluate_tetrahedron_force_post_arg8.bin').read_bytes()
            assert row['active_surface_contacts'] > 0 and row['surface_tetrahedron_rhs_changed']
            assert row['surface_body_rhs_changed'] and row['tetrahedron_changes_rhs']
            row['contact_kind'] = args.contact_kind
            if ref:
                with np.load(ref / 'capture.npz') as old, np.load(folder / 'capture.npz') as new:
                    row['states'] = compare(old, new)
                row['metadata'] = compare_launches(ref / 'launches.txt', folder / 'launches.txt', layout)
                counts = json.loads((folder / 'capture.launches.json').read_text())
                row['coverage'] = sum(counts.values()) == row['metadata']['right_launches']
                expected = {f'dump_{token}_post_arg{i}.bin' for token, arguments in fields.items() for i in arguments}
                actual = {p.name for p in folder.glob('dump_*_post_arg*.bin')}
                assert expected == actual == {p.name for p in ref.glob('dump_*_post_arg*.bin')}
                row['buffers'] = {n: (folder / n).read_bytes() == (ref / n).read_bytes() for n in sorted(expected)}
            row['passed'] = row['finite'] and (not ref or (row['states']['bitwise'] and row['metadata']['equal']
                              and row['coverage'] and all(row['buffers'].values())))
        rows.append(row)
        (folder / 'report.json').write_text(json.dumps(row, indent=2) + '\n')
        (args.output / 'report.json').write_text(json.dumps({
            'source_sha256': json.loads(saved)['extension_sha256'], 'cases': rows, 'whole_solver_complete': False,
            'contact_kind': args.contact_kind, 'harness_sha256': hashes}, indent=2) + '\n')
        print(name, 'exit', code, 'passed', row['passed'], flush=True)
        if code:
            return 2
    return int(any(not row['passed'] for row in rows))


if __name__ == '__main__':
    raise SystemExit(main())
