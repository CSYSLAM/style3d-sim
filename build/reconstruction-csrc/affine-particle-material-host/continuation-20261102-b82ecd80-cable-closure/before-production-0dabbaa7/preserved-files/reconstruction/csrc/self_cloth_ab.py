"""Compare actual material/self-collision states, complete owned launch arguments, forces and stiffness buffers."""
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


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--references', type=Path, nargs='+', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    fixture = ROOT/'reconstruction/csrc/self_cloth_scene.py'
    fixture_sha = hashlib.sha256(fixture.read_bytes()).hexdigest()
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    hook_sha = hashlib.sha256(hook.read_bytes()).hexdigest()
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(hook), CUDAHOOK_DUMP_LIMIT='1')
    reports = []
    for path in sorted(p for root in args.references for p in root.glob('*/capture.runtime.json')):
        reference = path.parent
        runtime = json.loads(path.read_text())
        assert runtime['backend'] == 'original' and runtime['image_sha256'] == REFERENCE_SHA
        assert runtime['example_sha256'] == fixture_sha and runtime['launch_hook_sha256'] == hook_sha
        settings = json.loads((reference/'dump.json').read_text())
        env['CUDAHOOK_DUMP'] = ';'.join(key+'='+','.join(f'{i}:{size}' for i, size in sizes.items())
                                       for key, sizes in settings['fields'].items())
        directory = args.output/reference.name
        directory.mkdir()
        env['CUDAHOOK_DIR'] = str(directory)
        assert manifest.read_bytes() == saved
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
                row['finite'] = bool(all(np.isfinite(run[k]).all() for run in (original, source) for k in run.files))
            row['metadata'] = compare_launches(reference/'launches.txt', directory/'launches.txt', schemas()[0])
            row['hook_coverage'] = sum(json.loads((directory/'capture.launches.json').read_text()).values()) == \
                row['metadata']['right_launches']
            fields = [('15initialize_step', 'post', (20, 21, 22)), ('14initialize_rhs', 'post', (9,)),
                      ('22accumulate_vertex_face', 'pre', (6,)), ('22accumulate_vertex_face', 'post', (11, 12, 14)),
                      ('20accumulate_edge_edge', 'pre', (6,)), ('20accumulate_edge_edge', 'post', (9, 10, 12)),
                      ('20accumulate_edge_face', 'pre', (7,)), ('20accumulate_edge_face', 'post', (10, 11, 13)),
                      ('25accumulate_particle_pairs', 'pre', (5,)), ('25accumulate_particle_pairs', 'post', (7, 8, 10)),
                      ('22evaluate_stretch_force', 'pre', (5,)), ('22evaluate_stretch_force', 'post', (5,)),
                      ('22evaluate_bending_force', 'pre', (7,)), ('22evaluate_bending_force', 'post', (7,)),
                      ('27evaluate_soft_contact_force', 'post', (36, 37)),
                      ('35add_surface_contact_stiffness_scale', 'post', (1,)), ('20add_hessian_diagonal', 'post', (1,))]
            for key, phase, arguments in fields:
                for argument in arguments:
                    filename = f'dump_{key}_{phase}_arg{argument}.bin'
                    a, b = reference/filename, directory/filename
                    if a.exists() or b.exists():
                        row['checks'][f'{key}/{phase}/{argument}'] = a.exists() and b.exists() and \
                            a.read_bytes() == b.read_bytes()
        row['passed'] = bool(not code and row['states']['bitwise'] and row['finite'] and
                             row['metadata']['equal'] and row['hook_coverage'] and all(row['checks'].values()))
        reports.append(row)
        (directory/'report.json').write_text(json.dumps(row, indent=2)+'\n')
        (args.output/'report.json').write_text(json.dumps({
            'source_sha256': json.loads(saved)['extension_sha256'], 'cases': reports,
            'library_runtime_launches_completely_observed': False}, indent=2)+'\n')
        print(reference.name, 'exit', code, 'states', row.get('states', {}).get('bitwise'),
              'metadata', row.get('metadata', {}).get('equal'),
              'buffers', [k for k, v in row['checks'].items() if not v], flush=True)
    assert reports
    return int(any(not row['passed'] for row in reports))


if __name__ == '__main__':
    raise SystemExit(main())
