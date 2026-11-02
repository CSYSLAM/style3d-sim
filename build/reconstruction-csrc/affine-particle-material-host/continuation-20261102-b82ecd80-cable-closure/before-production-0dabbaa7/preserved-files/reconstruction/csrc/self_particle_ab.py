"""Compare actual particle self-collision states, complete owned launches and defined first-call buffers."""
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

QUERY = '20query_particle_pairs'
FORCE = '25accumulate_particle_pairs'
FULL = '25multiply_contact_tangents'
DIAGONAL = '25multiply_hessian_diagonal'
ADD = '20add_hessian_diagonal'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--references', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    fixture = ROOT/'reconstruction/csrc/self_particle_scene.py'
    env = {key: value for key, value in os.environ.items() if key not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(hook), CUDAHOOK_DUMP_LIMIT='1')
    reports = []
    for path in sorted(args.references.glob('*/capture.runtime.json')):
        reference = path.parent
        runtime = json.loads(path.read_text())
        assert runtime['backend'] == 'original' and runtime['image_sha256'] == REFERENCE_SHA
        assert runtime['example_sha256'] == hashlib.sha256(fixture.read_bytes()).hexdigest()
        assert runtime['launch_hook_sha256'] == hashlib.sha256(hook.read_bytes()).hexdigest()
        settings = json.loads((reference/'dump.json').read_text())
        total = settings['total_particles']
        env['CUDAHOOK_DUMP'] = ';'.join(key+'='+','.join(f'{i}:{size}' for i, size in sizes.items())
                                       for key, sizes in settings['fields'].items())
        directory = args.output/reference.name
        directory.mkdir()
        env['CUDAHOOK_DIR'] = str(directory)
        assert build.read_bytes() == saved
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'source', '--tag', 'capture',
                   '--example', str(fixture), '--frames', str(runtime['frames']), '--output', str(directory),
                   '--', *runtime['extra']]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (directory/'run.log').open('w') as log:
            code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, timeout=900).returncode
        row = {'case': reference.name, 'worker_exit': code, 'checks': {}, 'reference': str(reference.resolve())}
        if not code:
            with np.load(reference/'capture.npz') as original, np.load(directory/'capture.npz') as source:
                row['states'] = compare(original, source)
                row['finite'] = bool(all(np.isfinite(r[k]).all() for r in (original, source) for k in r.files))
            row['metadata'] = compare_launches(reference/'launches.txt', directory/'launches.txt', schemas()[0])
            row['hook_coverage'] = sum(json.loads((directory/'capture.launches.json').read_text()).values()) == \
                row['metadata']['right_launches']

            def raw(folder, key, phase, argument):
                p = folder/f'dump_{key}_{phase}_arg{argument}.bin'
                return p.read_bytes() if p.exists() else None

            for key, phase, arguments in ((QUERY, 'post', (3, 4, 11)), (FORCE, 'pre', (5, 10)),
                                           (FORCE, 'post', (7, 8, 10)), (ADD, 'post', (1,)),
                                           (FULL, 'post', (3,)), (DIAGONAL, 'post', (2,))):
                for argument in arguments:
                    a, b = raw(reference, key, phase, argument), raw(directory, key, phase, argument)
                    if a is not None or b is not None:
                        row['checks'][f'{key}/{phase}/{argument}'] = a == b
            counts = raw(reference, QUERY, 'post', 11)
            if counts is not None:
                counts = np.frombuffer(counts, dtype='i4')
                mask = np.arange(31) < counts[:, None]
                a, b = [np.frombuffer(raw(folder, QUERY, 'post', 12), dtype='i4').reshape(total, 31)
                        for folder in (reference, directory)]
                row['checks']['written_query_slots'] = a[mask].tobytes() == b[mask].tobytes()
            counter = raw(reference, FORCE, 'post', 10)
            if counter is not None:
                live = int(np.frombuffer(counter, dtype='u4')[0])
                row['first_active_contacts'] = live
                assert live <= total, 'Recapture with a larger valid contact prefix'
                a, b = raw(reference, FORCE, 'post', 9), raw(directory, FORCE, 'post', 9)
                if a is not None or b is not None:
                    row['checks']['written_contact_records'] = a is not None and b is not None and a[:live*60] == b[:live*60]
        reports.append(row)
        (directory/'report.json').write_text(json.dumps(row, indent=2)+'\n')
        (args.output/'report.json').write_text(json.dumps({'source_sha256': json.loads(saved)['extension_sha256'],
            'cases': reports, 'library_runtime_launches_completely_observed': False}, indent=2)+'\n')
        print(reference.name, 'exit', code, 'states', row.get('states', {}).get('bitwise'),
              'metadata', row.get('metadata', {}).get('equal'),
              'buffers', [k for k, v in row['checks'].items() if not v], flush=True)
    assert reports
    return int(any(row['worker_exit'] or not row['states']['bitwise'] or not row['finite'] or not row['metadata']['equal'] or
                   not row['hook_coverage'] or not all(row['checks'].values()) for row in reports))


if __name__ == '__main__':
    raise SystemExit(main())
