"""Compare fluid/self-contact scheduling and defined buffers, retaining each first source trajectory."""
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


def cases(family='fluid'):
    if family == 'granular':
        for layout, worlds, mode, diagonal, subset, bonds, contacts in (
            ('cached', 1, 'newton', False, False, 'none', False),
            ('cached', 1, 'pd', True, False, 'none', False),
            ('cached', 3, 'newton', False, True, 'none', False),
            ('cached', 1, 'newton', False, True, 'authored', True),
            ('cached', 1, 'pd', True, True, 'mixed', True),
            ('cached', 3, 'newton', False, True, 'dynamic', False),
            ('fallback', 1, 'newton', False, False, 'none', False),
            ('cached', 3, 'pd', True, True, 'none', False),
        ):
            local = 64 if layout == 'fallback' else 8
            name = f'{layout}-w{worlds}-{mode}-d{int(diagonal)}-subset{int(subset)}-{bonds}'
            yield name, 'self_granular_scene.py', local, worlds, diagonal, [
                '--layout', layout, '--worlds', str(worlds), '--seed', str(worlds), '--mode', mode, '--bonds', bonds,
                *(['--diagonal-only'] if diagonal else []), *(['--subset'] if subset else []),
                *(['--contacts'] if contacts else [])]
        return
    for layout, worlds, mode, diagonal in (
        ('cached', 1, 'newton', False), ('fallback', 1, 'newton', False),
        ('fallback', 1, 'pd', True), ('cached', 3, 'newton', False),
    ):
        local = 8 if layout == 'cached' else 125
        yield f'{layout}-w{worlds}-{mode}-d{int(diagonal)}', 'self_fluid_scene.py', local, worlds, diagonal, [
            '--layout', layout, '--worlds', str(worlds), '--seed', str(worlds), '--mode', mode,
            *(['--diagonal-only'] if diagonal else [])]
    for worlds, mode, diagonal in ((1, 'newton', False), (1, 'pd', True),
                                   (3, 'newton', False), (3, 'pd', True)):
        yield f'material-w{worlds}-{mode}-d{int(diagonal)}', 'self_fluid_material_scene.py', 20, worlds, diagonal, [
            '--material', 'all', '--worlds', str(worlds), '--seed', str(worlds), '--mode', mode,
            *(['--diagonal-only'] if diagonal else [])]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--references', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=3)
    parser.add_argument('--family', choices=('fluid', 'granular'), default='fluid')
    args = parser.parse_args()
    assert args.frames > 0 and (args.backend == 'original' or args.references is not None)
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    paths = [Path(__file__), hook, *[ROOT/'reconstruction/csrc'/name for name in (
        'self_fluid_scene.py', 'self_fluid_material_scene.py', 'fluid_host_scene.py', 'fluid_material_scene.py',
        'self_granular_scene.py', 'granular_host_scene.py')]]
    hashes = {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths}
    (args.output/'provenance.json').write_text(json.dumps(hashes, indent=2)+'\n')
    env = {k: v for k, v in os.environ.items() if k not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
        'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS',
        'DEMO_MEMORY_TRACE_DIR')}
    reports = []
    for name, file, local, worlds, diagonal, extra in cases(args.family):
        assert manifest.read_bytes() == saved
        assert all(hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha for path, sha in hashes.items())
        fixture, total = ROOT/'reconstruction/csrc'/file, local*worlds
        fields = {
            '15initialize_step': {22: total*4}, '14initialize_rhs': {9: total*12},
            # Only one count is read: material stencils remove some particles from the PP query set.
            '20query_particle_pairs': {4: local*4, 11: 4},
            '25accumulate_particle_pairs': {5: total*4, 7: total*12, 8: total*36},
            '20add_hessian_diagonal': {1: total*36},
            '25multiply_contact_tangents': {3: total*12}, '25multiply_hessian_diagonal': {2: total*12},
        }
        if not diagonal:
            fields['25accumulate_particle_pairs'][10] = 4
        directory = args.output/name
        directory.mkdir()
        (directory/'dump.json').write_text(json.dumps(fields, indent=2)+'\n')
        reference = args.references/name if args.references else None
        if args.backend == 'source':
            runtime = json.loads((reference/'capture.runtime.json').read_text())
            assert runtime['backend'] == 'original' and runtime['image_sha256'] == REFERENCE_SHA
            assert runtime['example_sha256'] == hashes[str(fixture)] and runtime['extra'] == extra
            assert runtime['frames'] == args.frames and runtime['launch_hook_sha256'] == hashes[str(hook)]
            assert json.loads((reference/'dump.json').read_text()) == json.loads((directory/'dump.json').read_text())
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', args.backend,
                   '--tag', 'capture', '--example', str(fixture), '--frames', str(args.frames),
                   '--output', str(directory), '--', *extra]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        dump = ';'.join(key+'='+','.join(f'{i}:{size}' for i, size in values.items()) for key, values in fields.items())
        with (directory/'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook),
                'CUDAHOOK_DIR': str(directory), 'CUDAHOOK_DUMP': dump, 'CUDAHOOK_DUMP_LIMIT': '1'},
                stdout=log, stderr=subprocess.STDOUT, timeout=900).returncode
        row = {'case': name, 'worker_exit': code, 'checks': {}, 'reference': str(reference)}
        if not code:
            runtime = json.loads((directory/'capture.runtime.json').read_text())
            expected = REFERENCE_SHA if args.backend == 'original' else json.loads(saved)['extension_sha256']
            assert runtime['image_sha256'] == expected
            groups = np.fromfile(directory/'dump_20query_particle_pairs_post_arg4.bin', dtype='i4')
            if args.family == 'granular':
                expected_groups = np.zeros(local, dtype='i4')
                expected_groups[::2 if '--subset' in extra else 1] = 2
            else:
                expected_groups = np.ones(local, dtype='i4')
                if file == 'self_fluid_material_scene.py':
                    expected_groups[8:] = 0
            row['checks']['actual_'+args.family+'_groups'] = groups.tobytes() == expected_groups.tobytes()
            if not diagonal:
                prefix = directory/'dump_25accumulate_particle_pairs'
                before, after = [int(np.fromfile(str(prefix)+f'_{phase}_arg10.bin', dtype='u4')[0])
                                 for phase in ('pre', 'post')]
                row['first_pp_contact_increment'] = after-before
            with np.load(directory/'capture.npz') as run:
                row['finite'] = all(np.isfinite(run[k]).all() for k in run.files)
            if args.backend == 'source':
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
                            row['checks'][f'{kernel}/{phase}/{argument}'] = (
                                old.exists() and new.exists() and old.read_bytes() == new.read_bytes())
            row['passed'] = row['finite'] and all(row['checks'].values()) and (
                args.backend == 'original' or row['states']['bitwise'] and row['metadata']['equal'] and row['coverage'])
        else:
            row['passed'] = False
        reports.append(row)
        (directory/'report.json').write_text(json.dumps(row, indent=2)+'\n')
        (args.output/'report.json').write_text(json.dumps({'cases': reports,
            'source_sha256': json.loads(saved)['extension_sha256'], 'full_solver_complete': False}, indent=2)+'\n')
        print(name, 'exit', code, 'passed', row['passed'], flush=True)
    return int(any(not row['passed'] for row in reports))


if __name__ == '__main__':
    raise SystemExit(main())
