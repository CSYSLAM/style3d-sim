"""Locate first defined buffer differences and audit every owned launch in the unchanged large coupled demo."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from .audit_cudahook import SCALAR_WORDS, compare as compare_launches, schemas
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cohort', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    with np.load(args.cohort / 'eager-source0/states.npz') as frozen:
        count = frozen['particle_q'].shape[1]
    assert count == 1735
    size, scalar = count * 12, count * 4
    # The hook writes both phases; compare only documented initialized inputs or defined outputs below.
    fields = {
        '15initialize_step': {4: size, 5: size, **{i: scalar for i in (6, 7, 9, 11, 13, 15, 17, 18, 19)},
                              20: size, 21: size, 22: scalar},
        '14initialize_rhs': {1: size, 2: size, 7: size, 9: size},
        '30evaluate_rolling_contact_force': {0: 4, 1: size},
        '30evaluate_surface_contact_force': {0: 4, 1: size},
        '27evaluate_soft_contact_force': {36: size, 37: scalar},
        '51evaluate_affine_body_so3_augmented_lagrangian_force': {6: size},
        '22evaluate_stretch_force': {5: size}, '22evaluate_bending_force': {7: size},
        '34add_surface_contact_preconditioner': {1: count * 36},
        '34add_rolling_contact_preconditioner': {1: count * 36},
        '27invert_block_preconditioner': {0: count * 36, 3: count * 36},
        '23precondition_and_reduce': {0: count * 36, 1: size, 2: size, 6: 4},
    }
    layout = schemas()[0]
    for token, arguments in fields.items():
        matching = [kinds for name, kinds in layout.items() if token in name]
        assert matching, 'Unknown kernel dump token: ' + token
        for kinds in matching:
            for arg in arguments:
                kind = kinds[arg]
                assert kind == 'pointer' or (arg == 0 and kind in SCALAR_WORDS and 0 not in SCALAR_WORDS[kind]), \
                    ('A device-memory dump requires a pointer argument', token, arg, kind)
    defined = {}
    for token, arguments in fields.items():
        for arg in arguments:
            phases = ('pre', 'post')
            if token == '15initialize_step' and arg in (20, 21, 22) or token == '14initialize_rhs' and arg == 9:
                phases = ('post',)
            if token == '23precondition_and_reduce' and arg == 2:
                phases = ('post',)
            for phase in phases:
                defined[f'dump_{token}_{phase}_arg{arg}.bin'] = token
    (args.output / 'fields.json').write_text(json.dumps(fields, indent=2) + '\n')
    (args.output / 'defined-files.json').write_text(json.dumps(defined, indent=2) + '\n')
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    assert (args.cohort / 'build.json').read_bytes() == saved
    (args.output / 'build.json').write_bytes(saved)
    hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    example = ROOT / 'examples/example_cloth_balls.py'
    hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (Path(__file__), hook, example)}
    env = {key: value for key, value in os.environ.items() if key not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP',
        'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    dump = ';'.join(token + '=' + ','.join(f'{i}:{n}' for i, n in arguments.items())
                    for token, arguments in fields.items())
    for backend in ('original', 'source'):
        assert build.read_bytes() == saved
        assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == h for p, h in hashes.items())
        folder = args.output / backend
        folder.mkdir()
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend, '--tag', 'capture',
                   '--example', str(example), '--frames', '1', '--output', str(folder)]
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            subprocess.run(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder),
                'CUDAHOOK_DUMP': dump, 'CUDAHOOK_DUMP_LIMIT': '1', 'DEMO_POINTERS': '1'},
                stdout=log, stderr=subprocess.STDOUT, check=True, timeout=1800)
        runtime = json.loads((folder / 'capture.runtime.json').read_text())
        assert runtime['image_sha256'] == (REFERENCE_SHA if backend == 'original' else
                                          json.loads(saved)['extension_sha256'])
        assert runtime['example_sha256'] == hashes[str(example)]
    metadata = compare_launches(args.output / 'original/launches.txt', args.output / 'source/launches.txt', schemas()[0])
    lines = (args.output / 'original/launches.txt').read_text().splitlines()
    checks = []
    for filename, token in defined.items():
        a, b = args.output / 'original' / filename, args.output / 'source' / filename
        assert a.exists() and b.exists(), 'Declared coverage missing: ' + filename
        x, y = a.read_bytes(), b.read_bytes()
        assert len(x) == len(y)
        checks.append({'file': filename, 'bitwise_equal': x == y, 'bytes': len(x),
                       'different_words': int(np.count_nonzero(np.frombuffer(x, 'u4') != np.frombuffer(y, 'u4'))),
                       'first_launch_index': next(i for i, line in enumerate(lines) if token in line)})
    checks.sort(key=lambda row: (row['first_launch_index'], '_post_' in row['file'], row['file']))
    report = {'source_sha256': json.loads(saved)['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
              'metadata': metadata, 'defined_buffers': checks,
              'first_defined_buffer_difference': next((row for row in checks if not row['bitwise_equal']), None),
              'harness_sha256': hashes, 'undefined_outputs_before_write_compared': False,
              'diagnostic_replaces_frozen_source0': False, 'whole_solver_complete': False}
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print('owned ABI', metadata['equal'], 'first defined buffer difference',
          report['first_defined_buffer_difference'], flush=True)
    return 2 if not metadata['equal'] else int(report['first_defined_buffer_difference'] is not None)


if __name__ == '__main__':
    raise SystemExit(main())
