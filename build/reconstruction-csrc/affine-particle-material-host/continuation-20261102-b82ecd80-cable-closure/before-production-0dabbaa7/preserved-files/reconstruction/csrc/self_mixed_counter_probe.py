"""Verify that every collision channel contributes real contacts in the mixed fixture's first iteration."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from .audit_cudahook import compare as compare_launches, schemas
from .demo_source_ab import ROOT
from reconstruction.demo_ab import compare


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    fields = {'22accumulate_vertex_face': 14, '25accumulate_particle_pairs': 10,
              '20accumulate_edge_edge': 12, '20accumulate_edge_face': 13}
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(hook), CUDAHOOK_DUMP_LIMIT='2',
               CUDAHOOK_DUMP=';'.join(f'{key}={argument}:4' for key, argument in fields.items()))
    counters = {}
    for backend in ('original', 'source'):
        directory = args.output/backend
        directory.mkdir()
        assert manifest.read_bytes() == saved
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                   '--tag', 'capture', '--example', 'reconstruction/csrc/self_mesh_mixed_scene.py',
                   '--frames', '1', '--output', str(directory)]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (directory/'run.log').open('w') as log:
            subprocess.run(command, cwd=ROOT, env={**env, 'CUDAHOOK_DIR': str(directory)},
                           stdout=log, stderr=subprocess.STDOUT, check=True, timeout=900)
        values = []
        for key, call in (('22accumulate_vertex_face', 0), ('22accumulate_vertex_face', 1),
                          ('25accumulate_particle_pairs', 0), ('20accumulate_edge_edge', 0),
                          ('20accumulate_edge_face', 0)):
            data = (directory/f'dump_{key}_call{call:03d}_post_arg{fields[key]}.bin').read_bytes()
            assert len(data) == 4
            values.append(int.from_bytes(data, 'little'))
        counters[backend] = {'after_each_channel': values,
                             'new_contacts': [values[0], *[b-a for a, b in zip(values, values[1:])]]}
    with np.load(args.output/'original/capture.npz') as original, np.load(args.output/'source/capture.npz') as source:
        states = compare(original, source)
    metadata = compare_launches(args.output/'original/launches.txt', args.output/'source/launches.txt', schemas()[0])
    report = {'source_sha256': json.loads(saved)['extension_sha256'], 'channels': ['vf_mesh', 'vf_free', 'pp', 'ee', 'ef'],
              'counters': counters, 'strict_states': states, 'metadata': metadata}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    passed = counters['original'] == counters['source'] and all(v > 0 for v in counters['original']['new_contacts'])
    print('contact counters', counters, 'states', states['bitwise'], 'metadata', metadata['equal'], flush=True)
    return int(not passed or not states['bitwise'] or not metadata['equal'])


if __name__ == '__main__':
    raise SystemExit(main())
