"""Compare isolated mesh self-collision states, complete owned launch arguments and defined captured prefixes."""
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

QUERIES = {'17query_vertex_face': (12, 13), '15query_edge_edge': (8, 9), '15query_edge_face': (9, 10)}
FORCES = {'22accumulate_vertex_face': (6, 11, 12, 13, 14),
          '20accumulate_edge_edge': (6, 9, 10, 11, 12), '20accumulate_edge_face': (7, 10, 11, 12, 13)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--references', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    fixture = ROOT/'reconstruction/csrc/self_mesh_scene.py'
    fixture_sha = hashlib.sha256(fixture.read_bytes()).hexdigest()
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    hook_sha = hashlib.sha256(hook.read_bytes()).hexdigest()
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(hook), CUDAHOOK_DUMP_LIMIT='2')
    reports = []
    for path in sorted(args.references.glob('*/capture.runtime.json')):
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
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'source', '--tag', 'capture',
                   '--example', str(fixture), '--frames', str(runtime['frames']), '--output', str(directory),
                   '--', *runtime['extra']]
        assert manifest.read_bytes() == saved
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

            def raw(folder, key, call, phase, argument):
                p = folder/f'dump_{key}_call{call:03d}_{phase}_arg{argument}.bin'
                return p.read_bytes() if p.exists() else None

            def check(key, call, phase, argument):
                a, b = [raw(folder, key, call, phase, argument) for folder in (reference, directory)]
                if a is not None or b is not None:
                    row['checks'][f'{key}/{call}/{phase}/{argument}'] = a == b

            for call in (0, 1):
                for key, (counts, slots) in QUERIES.items():
                    groups = {'17query_vertex_face': 4, '15query_edge_edge': 2, '15query_edge_face': 3}[key]
                    check(key, call, 'pre', groups)
                    if key == '17query_vertex_face':
                        check(key, call, 'pre', 1)
                        check(key, call, 'pre', 2)
                    check(key, call, 'post', counts)
                    data = raw(reference, key, call, 'post', counts)
                    if data is not None:
                        count = int(np.frombuffer(data, dtype='i4')[0])
                        assert 0 <= count <= 31
                        a, b = [raw(folder, key, call, 'post', slots) for folder in (reference, directory)]
                        row['checks'][f'{key}/{call}/written_slots_first_row'] = \
                            a is not None and b is not None and a[:count*4] == b[:count*4]
                for key, (mass, force, hessian, contacts, counter) in FORCES.items():
                    check(key, call, 'pre', mass)
                    if key != '22accumulate_vertex_face':
                        check(key, call, 'pre', 2)
                    if key == '20accumulate_edge_face':
                        check(key, call, 'pre', 3)
                    for argument in (force, hessian, counter):
                        check(key, call, 'post', argument)
                    data = raw(reference, key, call, 'post', counter)
                    if data is not None and int(np.frombuffer(data, dtype='u4')[0]):
                        a, b = [raw(folder, key, call, 'post', contacts) for folder in (reference, directory)]
                        if a is not None or b is not None:
                            row['checks'][f'{key}/{call}/first_written_contact'] = a == b
                for key, phase, arguments in (('20add_hessian_diagonal', 'post', (1,)),
                                              ('25multiply_contact_tangents', 'post', (3,)),
                                              ('25multiply_hessian_diagonal', 'post', (2,))):
                    for argument in arguments:
                        check(key, call, phase, argument)
        row['passed'] = bool(not code and row['states']['bitwise'] and row['finite'] and
                             row['metadata']['equal'] and row['hook_coverage'] and all(row['checks'].values()))
        reports.append(row)
        (directory/'report.json').write_text(json.dumps(row, indent=2)+'\n')
        (args.output/'report.json').write_text(json.dumps({
            'source_sha256': json.loads(saved)['extension_sha256'], 'cases': reports,
            'library_runtime_launches_completely_observed': False}, indent=2)+'\n')
        print(reference.name, 'passed', row['passed'], 'states', row.get('states', {}).get('bitwise'),
              'metadata', row.get('metadata', {}).get('equal'),
              'buffers', [k for k, v in row['checks'].items() if not v], flush=True)
    assert reports
    return int(any(not row['passed'] for row in reports))


if __name__ == '__main__':
    raise SystemExit(main())
