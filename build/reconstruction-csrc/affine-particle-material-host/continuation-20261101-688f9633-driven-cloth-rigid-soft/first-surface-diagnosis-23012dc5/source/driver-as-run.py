"""Capture actual inputs for a frozen driven-cloth surface failure without replacing its acceptance candidates."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys

import numpy as np

from .affine_tetrahedron_contact_ab import clean_env
from .audit_cudahook import compare as compare_launches, schemas
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA


TOKEN = '30evaluate_surface_contact_force'


def capture_plan(case):
    adopted = json.loads((case / 'adopted-fixed.json').read_text())
    reference = Path(adopted['original0']['path'])
    runtime = json.loads((reference / 'capture.runtime.json').read_text())
    assert runtime['image_sha256'] == REFERENCE_SHA
    assert Path(runtime['example']).name == 'driven_cloth_contact_scene.py'
    assert '--contact-kind' in runtime['extra'] and 'surface' in runtime['extra']
    line = next(row for row in (reference / 'launches.txt').read_text().splitlines() if TOKEN + ' ' in row)
    words = {int(offset): int(value, 16) for offset, value in
             re.findall(r'(\d+):([0-9a-f]+)\([^)]*\)', line.split()[5])}
    layout = json.loads(next(row.split('driven_cloth_contact_layout ', 1)[1]
                             for row in (reference / 'run.log').read_text().splitlines()
                             if row.startswith('driven_cloth_contact_layout ')))
    contacts, local, total, shapes, bodies = layout['count'], words[112], words[120], words[200], words[264]
    assert 0 < contacts <= words[8] and total == local * words[216]
    fields = {0: ('count', 4)}
    for offset, name, width in [(16, 'indices', 12), (24, 'barycentric', 12), (32, 'shape', 4),
                                (40, 'body_pos', 12), (48, 'body_vel', 12), (56, 'normal', 12)]:
        fields[offset] = (name, contacts * width)
    if words[64]:
        fields[64] = ('particle_only', words[72] * 4)
    else:
        assert words[72] == 0
    for offset, name in [(80, 'radius'), (88, 'mass'), (96, 'flags'), (104, 'kind')]:
        fields[offset] = (name, local * 4)
    for offset, name, width in [(128, 'shape_body', 4), (136, 'shape_type', 4), (144, 'transform', 28),
                                (152, 'shape_scale', 12), (160, 'shape_margin', 4), (168, 'shape_ke', 4),
                                (176, 'shape_kd', 4), (184, 'shape_kf', 4), (192, 'shape_mu', 4)]:
        fields[offset] = (name, shapes * width)
    for offset, name, width in [(240, 'body_ids', 4), (248, 'body_indices', 16), (256, 'body_com', 12)]:
        fields[offset] = (name, bodies * width)
    fields[272], fields[280] = ('x', total * 12), ('previous', total * 12)
    assert all(words[offset] and size > 0 for offset, (_, size) in fields.items())
    return adopted, runtime, words, contacts, fields


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--case', type=Path, required=True, help='Completed fixed-C8 case containing adopted-fixed.json')
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    adopted, runtime, words, count, fields = capture_plan(args.case)
    reference = Path(adopted['original0']['path'])
    for row in adopted.values():
        assert all(hashlib.sha256((Path(row['path']) / name).read_bytes()).hexdigest() == digest
                   for name, digest in row['sha256'].items())
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    metadata = json.loads(saved)
    frozen_source = json.loads((Path(adopted['source0']['path']) / 'capture.runtime.json').read_text())
    assert frozen_source['image_sha256'] == metadata['extension_sha256']
    fixture = Path(runtime['example'])
    assert hashlib.sha256(fixture.read_bytes()).hexdigest() == runtime['example_sha256']
    protocol = json.loads((args.case / 'capture-protocol.json').read_text())
    assert protocol['limit'] == 9
    extra = ','.join(f'0{f"+{offset}" if offset else ""}:{size}' for offset, (_, size) in fields.items())
    dumps = protocol['dump'].split(';')
    match = [i for i, value in enumerate(dumps) if value.startswith(TOKEN + '=')]
    assert len(match) == 1
    dumps[match[0]] += ',' + extra
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    (output / 'build.json').write_bytes(saved)
    (output / 'fields.json').write_text(json.dumps(fields, indent=2) + '\n')
    (output / 'driver-as-run.py').write_bytes(Path(__file__).read_bytes())
    hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', args.backend,
               '--tag', 'capture', '--example', str(fixture), '--frames', str(runtime['frames']),
               '--output', str(output), '--', *runtime['extra']]
    (output / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (output / 'run.log').open('w') as log:
        subprocess.run(command, cwd=ROOT, env={**clean_env(), 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(output),
                       'CUDAHOOK_DUMP': ';'.join(dumps), 'CUDAHOOK_DUMP_LIMIT': str(protocol['limit'])},
                       stdout=log, stderr=subprocess.STDOUT, check=True, timeout=1800)
    assert build.read_bytes() == saved
    actual = json.loads((output / 'capture.runtime.json').read_text())
    assert actual['image_sha256'] == (REFERENCE_SHA if args.backend == 'original' else metadata['extension_sha256'])
    assert all(actual[key] == runtime[key] for key in ('example_sha256', 'frames', 'extra', 'launch_hook_sha256'))
    metadata_check = compare_launches(reference / 'launches.txt', output / 'launches.txt', schemas()[0])
    assert metadata_check['equal'], metadata_check
    packet = output / 'first-packet'
    packet.mkdir()
    (packet / 'fields.json').write_bytes((output / 'fields.json').read_bytes())
    (packet / 'launches.txt').write_bytes((output / 'launches.txt').read_bytes())
    for offset, (_, size) in fields.items():
        suffix = f'_offset{offset}' if offset else ''
        name = f'dump_{TOKEN}_call000_pre_arg0{suffix}.bin'
        payload = (output / name).read_bytes()
        assert len(payload) == size
        (packet / name.replace('_call000', '')).write_bytes(payload)
    assert np.fromfile(packet / f'dump_{TOKEN}_pre_arg0.bin', dtype='i4').tolist() == [count]
    frozen = Path(adopted['original0' if args.backend == 'original' else 'source0']['path'])
    checks = {}
    for phase in ('pre', 'post'):
        name = f'dump_{TOKEN}_call000_{phase}_arg1.bin'
        payload = (output / name).read_bytes()
        assert len(payload) == words[120] * 12
        (packet / name.replace('_call000', '')).write_bytes(payload)
        checks[phase] = payload == (frozen / name).read_bytes()
    with np.load(output / 'capture.npz') as current, np.load(frozen / 'capture.npz') as old:
        assert set(current.files) == set(old.files)
        assert all(current[key].shape == old[key].shape and current[key].dtype == old[key].dtype
                   and np.isfinite(current[key]).all() for key in current.files)
        state_checks = {key: current[key].tobytes() == old[key].tobytes() for key in current.files}
    report = {'source_sha256': metadata['extension_sha256'], 'backend': args.backend, 'active_contacts': count,
              'complete_owned_metadata': metadata_check,
              'frozen_first_rhs_equal': checks, 'frozen_state_arrays_equal': state_checks,
              'observer_reproduced_complete_frozen_candidate': all(state_checks.values()),
              'only_call000_inputs_interpreted': True, 'undefined_contact_tail_compared': False,
              'acceptance_cohort_changed': False, 'whole_solver_complete': False,
              'packet_sha256': {p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in packet.iterdir()}}
    (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(args.backend, 'first RHS matches frozen', checks, flush=True)


if __name__ == '__main__':
    main()
