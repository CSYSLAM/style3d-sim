"""Capture all kernel-read full-surface inputs for the fixed W3 SO3 fixture, using only initialized contacts."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--self-suite', action='store_true', help='Use the already recorded body-block/self/spring case')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    # The already recorded first contact count is 15 per world; assert it again before interpreting any payload.
    contacts, worlds, local, bodies, local_shapes = 45, 3, 12, 1, 1
    fields = {
        0: ('count', 4), 16: ('indices', contacts * 12), 24: ('barycentric', contacts * 12),
        32: ('shape', contacts * 4), 40: ('body_pos', contacts * 12), 48: ('body_vel', contacts * 12),
        56: ('normal', contacts * 12), 80: ('radius', local * 4), 88: ('mass', local * 4),
        96: ('flags', local * 4), 104: ('kind', local * 4),
        128: ('shape_body', local_shapes * 4), 136: ('shape_type', local_shapes * 4),
        144: ('transform', local_shapes * 28), 152: ('shape_scale', local_shapes * 12),
        160: ('shape_margin', local_shapes * 4), 168: ('shape_ke', local_shapes * 4),
        176: ('shape_kd', local_shapes * 4), 184: ('shape_kf', local_shapes * 4),
        192: ('shape_mu', local_shapes * 4),
        240: ('body_ids', bodies * 4), 248: ('body_indices', bodies * 16), 256: ('body_com', bodies * 12),
        272: ('x', worlds * local * 12), 280: ('previous', worlds * local * 12),
    }
    (args.output / 'fields.json').write_text(json.dumps(fields, indent=2) + '\n')
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output / 'build.json').write_bytes(saved)
    hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    fixture = ROOT / 'reconstruction/csrc/affine_surface_scene.py'
    command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', args.backend,
               '--tag', 'capture', '--example', str(fixture), '--frames', '3', '--output', str(args.output),
               '--', '--contacts', '--worlds', '3']
    if args.self_suite:
        command += ['--body-block', '--diagonal-only', '--self', '--springs']
    dump = '30evaluate_surface_contact_force=' + ','.join(
        f'0{f"+{offset}" if offset else ""}:{size}' for offset, (_, size) in fields.items())
    dump += f',1:{worlds * local * 12}'
    dump += f';35add_surface_contact_stiffness_scale=1:{worlds * local * 4}'
    dump += f';34add_surface_contact_preconditioner=1:{worlds * local * 36}'
    dump += f';32multiply_surface_contact_tangent=1:{worlds * local * 12},2:{worlds * local * 12}'
    env = {key: value for key, value in os.environ.items() if key not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP',
        'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    (args.output / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (args.output / 'run.log').open('w') as log:
        subprocess.run(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(args.output),
                       'CUDAHOOK_DUMP': dump, 'CUDAHOOK_DUMP_LIMIT': '1', 'DEMO_POINTERS': '1'},
                       stdout=log, stderr=subprocess.STDOUT, check=True, timeout=900)
    assert build.read_bytes() == saved
    runtime = json.loads((args.output / 'capture.runtime.json').read_text())
    assert runtime['image_sha256'] == (REFERENCE_SHA if args.backend == 'original' else
                                      json.loads(saved)['extension_sha256'])
    count = np.fromfile(args.output / 'dump_30evaluate_surface_contact_force_pre_arg0.bin', dtype='i4')
    assert count.tolist() == [contacts], 'Do not interpret undefined contact tail bytes'
    paths = [Path(__file__), fixture, hook, *args.output.glob('dump_*.bin')]
    report = {'backend': args.backend, 'active_contacts': contacts, 'no_contact_tail_compared': True,
              'runtime': runtime, 'fixed_candidate_replaced': False,
              'sha256': {str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}}
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(args.backend, 'all initialized full-surface inputs captured', contacts, flush=True)


if __name__ == '__main__':
    main()
