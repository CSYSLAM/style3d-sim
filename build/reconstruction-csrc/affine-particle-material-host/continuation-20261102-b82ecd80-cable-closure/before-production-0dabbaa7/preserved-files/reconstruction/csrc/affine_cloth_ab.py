"""Capture actual body/cloth shared templates and real two-way legacy soft-contact calls."""
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
    for worlds, mode, block, diagonal, contacts, self_contact, springs in (
        (1, 'newton', False, False, False, False, False), (1, 'pd', False, True, False, False, False),
        (3, 'newton', False, False, False, True, False), (1, 'newton', True, False, False, False, True),
        (3, 'pd', True, True, False, True, True), (1, 'newton', False, False, True, False, False),
        (1, 'pd', True, False, True, True, False), (3, 'newton', True, True, True, True, True),
    ):
        name = f'w{worlds}-{mode}-b{int(block)}-d{int(diagonal)}-c{int(contacts)}-s{int(self_contact)}-p{int(springs)}'
        extra = ['--worlds', str(worlds), '--mode', mode]
        for flag, enabled in (('--body-block', block), ('--diagonal-only', diagonal), ('--contacts', contacts),
                              ('--self', self_contact), ('--springs', springs)):
            if enabled:
                extra.append(flag)
        yield name, worlds, diagonal, extra


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
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    fixture = ROOT/'reconstruction/csrc/affine_cloth_scene.py'
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    paths = [Path(__file__), fixture, hook, ROOT/'reconstruction/csrc/demo_source_ab.py',
             ROOT/'reconstruction/csrc/host_bodies_ab.py']
    hashes = {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths}
    (args.output/'provenance.json').write_text(json.dumps(hashes, indent=2)+'\n')
    env = {key: value for key, value in os.environ.items() if key not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP',
        'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    rows = []
    for name, worlds, diagonal, extra in cases():
        assert manifest.read_bytes() == saved
        assert all(hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha for path, sha in hashes.items())
        # Eight cloth vertices plus the body's four affine proxy particles per world.
        total = 12*worlds
        fields = {
            # Template dimensions will be read from actual launch scalars; only one initialized entry is copied here.
            '15initialize_step': {6: 4, 22: total*4}, '27combine_system_non_diagonal': {6: 8, 13: 8},
            '14initialize_rhs': {9: total*12}, '27invert_block_preconditioner': {0: total*36},
        }
        if '--contacts' in extra:
            fields['27evaluate_soft_contact_force'] = {0: 4, 36: total*12, 37: total*4}
        if '--self' in extra:
            fields.update({'25accumulate_particle_pairs': {5: total*4, 7: total*12, 8: total*36},
                           '20add_hessian_diagonal': {1: total*36},
                           '25multiply_contact_tangents': {3: total*12},
                           '25multiply_hessian_diagonal': {2: total*12}})
            if not diagonal:
                fields['25accumulate_particle_pairs'][10] = 4
        directory = args.output/name
        directory.mkdir()
        (directory/'dump.json').write_text(json.dumps(fields, indent=2)+'\n')
        reference = args.references/name if args.references else None
        if reference:
            runtime = json.loads((reference/'capture.runtime.json').read_text())
            assert runtime['backend'] == 'original' and runtime['image_sha256'] == REFERENCE_SHA
            assert runtime['example_sha256'] == hashes[str(fixture)] and runtime['extra'] == extra
            assert runtime['frames'] == args.frames and runtime['launch_hook_sha256'] == hashes[str(hook)]
            assert json.loads((reference/'dump.json').read_text()) == json.loads((directory/'dump.json').read_text())
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', args.backend,
                   '--tag', 'capture', '--example', str(fixture), '--frames', str(args.frames),
                   '--output', str(directory), '--', *extra]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        dump = ';'.join(key+'='+','.join(f'{index}:{size}' for index, size in values.items())
                        for key, values in fields.items())
        with (directory/'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook),
                'CUDAHOOK_DIR': str(directory), 'CUDAHOOK_DUMP': dump, 'CUDAHOOK_DUMP_LIMIT': '1'},
                stdout=log, stderr=subprocess.STDOUT, timeout=900).returncode
        row = {'case': name, 'worker_exit': code, 'checks': {}}
        if not code:
            runtime = json.loads((directory/'capture.runtime.json').read_text())
            expected = REFERENCE_SHA if args.backend == 'original' else json.loads(saved)['extension_sha256']
            assert runtime['image_sha256'] == expected
            with np.load(directory/'capture.npz') as run:
                row['finite'] = all(np.isfinite(run[key]).all() for key in run.files)
                row['state_shapes'] = {key: list(run[key].shape) for key in run.files}
            launch_rows = [line.split() for line in (directory/'launches.txt').read_text().splitlines()]
            start = next(line[5:-2] for line in launch_rows if line[1] == '15initialize_step')
            combine = next(line[5:-2] for line in launch_rows if line[1] == '27combine_system_non_diagonal')
            row['native_layout'] = {'count': int(start[23][2:], 16), 'per_world': int(start[24][2:], 16),
                                    'local_ell_entries': int(combine[14][2:], 16)}
            row['checks']['actual_state_count'] = row['native_layout']['count'] == total
            if (not diagonal and '--self' in extra and
                    (directory/'dump_25accumulate_particle_pairs_post_arg10.bin').exists()):
                row['first_pp_contact_increment'] = (
                    int(np.fromfile(directory/'dump_25accumulate_particle_pairs_post_arg10.bin', dtype='u4')[0]) -
                    int(np.fromfile(directory/'dump_25accumulate_particle_pairs_pre_arg10.bin', dtype='u4')[0]))
            if '--contacts' in extra:
                active = int(np.fromfile(directory/'dump_27evaluate_soft_contact_force_post_arg0.bin', dtype='i4')[0])
                row['active_soft_contacts'] = active
                before, after = [np.fromfile(directory/f'dump_27evaluate_soft_contact_force_{phase}_arg36.bin',
                                            dtype='f4') for phase in ('pre', 'post')]
                assert row['native_layout']['per_world'] == 12
                delta = (after-before).reshape(-1, 12, 3)
                row['checks']['actual_two_way_soft_contacts'] = (
                    active > 0 and bool(np.any(delta[:, :8])) and bool(np.any(delta[:, 8:])))
            if reference:
                with np.load(reference/'capture.npz') as old, np.load(directory/'capture.npz') as new:
                    row['states'] = compare(old, new)
                row['metadata'] = compare_launches(reference/'launches.txt', directory/'launches.txt', schemas()[0])
                counts = json.loads((directory/'capture.launches.json').read_text())
                row['coverage'] = sum(counts.values()) == row['metadata']['right_launches']
                for kernel, arguments in fields.items():
                    for argument in arguments:
                        phase = 'pre' if kernel == '25accumulate_particle_pairs' and argument == 5 else 'post'
                        path = f'dump_{kernel}_{phase}_arg{argument}.bin'
                        old, new = reference/path, directory/path
                        if old.exists() or new.exists():
                            row['checks'][path] = old.exists() and new.exists() and old.read_bytes() == new.read_bytes()
            row['passed'] = row['finite'] and all(row['checks'].values()) and (not reference or
                row['states']['bitwise'] and row['metadata']['equal'] and row['coverage'])
        else:
            row['passed'] = False
        rows.append(row)
        (directory/'report.json').write_text(json.dumps(row, indent=2)+'\n')
        (args.output/'report.json').write_text(json.dumps({'cases': rows,
            'source_sha256': json.loads(saved)['extension_sha256'], 'full_solver_complete': False}, indent=2)+'\n')
        print(name, 'exit', code, 'passed', row['passed'], flush=True)
    return int(any(not row['passed'] for row in rows))


if __name__ == '__main__':
    raise SystemExit(main())
