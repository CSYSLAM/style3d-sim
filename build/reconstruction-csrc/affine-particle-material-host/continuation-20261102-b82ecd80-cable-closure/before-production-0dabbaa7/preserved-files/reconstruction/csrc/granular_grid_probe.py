"""Capture real dense granular grids, then replay contacts and their fallback tangent through the source .so."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import struct
import subprocess
import sys

import numpy as np

from .demo_source_ab import ROOT

GRID = '15granular_kernel10build_grid'
FORCE = '15granular_kernel19accumulate_contacts'
PRODUCT = '15granular_kernel17multiply_contacts'


def view_bytes(line):
    words = dict((int(offset), int(value, 16)) for offset, value in re.findall(r'(\d+):([0-9a-f]+)\(', line))
    assert len(words) == 15
    return bytearray(struct.pack('<15Q', *(words[offset] for offset in range(0, 120, 8))))


def replay(directory, output):
    from .host_particles_ab import native_source
    core = native_source()
    driver = core._KernelDriver()
    results, point_reference, rhs_reference = [], None, None
    for folder in sorted(p for p in directory.iterdir() if (p/'launches.txt').is_file()):
        lines = (folder/'launches.txt').read_text().splitlines()
        line = next(line for line in lines if line.split()[1] == FORCE)
        view = view_bytes(line)
        count, slots = struct.unpack_from('<2i', view, 88)
        runtime = json.loads((folder/'capture.runtime.json').read_text())

        def raw(key, phase, argument, offset=0):
            suffix = f'_offset{offset}' if offset else ''
            return (folder/f'dump_{key}_{phase}_arg{argument}{suffix}.bin').read_bytes()

        head = np.frombuffer(raw(FORCE, 'pre', 0), dtype='i4')
        next_ = np.frombuffer(raw(FORCE, 'pre', 0, 8), dtype='i4')
        cells = np.frombuffer(raw(FORCE, 'pre', 0, 32), dtype='i4').reshape(-1, 3)
        assert len(head) == slots and len(next_) == count
        visited = []
        for bucket in range(slots):
            current, chain = int(head[bucket]), []
            while current >= 0:
                assert current < count and current not in chain
                cell = cells[current]
                expected = (int(cell[0])*73856093 ^ int(cell[1])*19349663 ^ int(cell[2])*83492791) & (slots-1)
                assert expected == bucket
                chain.append(current)
                current = int(next_[current])
            visited.extend(chain)
        assert sorted(visited) == list(range(count))
        fields = [raw(FORCE, 'pre', 0, offset) for offset in (16, 24, 32, 40, 48, 56)]
        if point_reference is None:
            point_reference = fields
            rhs_reference = raw(FORCE, 'pre', 1)
        assert fields == point_reference and raw(FORCE, 'pre', 1) == rhs_reference
        pointers = []

        def upload(payload):
            pointer = driver.upload(payload)
            pointers.append(pointer)
            return pointer

        for offset in range(0, 64, 8):
            struct.pack_into('<Q', view, offset, upload(raw(FORCE, 'pre', 0, offset)))
        outputs = {i: upload(raw(FORCE, 'pre', i)) for i in range(1, 6)}
        for offset, argument in ((64, 3), (72, 4), (80, 5)):
            struct.pack_into('<Q', view, offset, outputs[argument])
        name = re.search(r' symbol:(\S+)', line).group(1)
        driver.launch(driver.function(name), (count+127)//128, 128,
                      [bytes(view), *(struct.pack('<Q', outputs[i]) for i in range(1, 6))])
        driver.synchronize()
        expected = {i: raw(FORCE, 'post', i) for i in outputs}
        actual = {i: driver.download(pointer, len(expected[i])) for i, pointer in outputs.items()}
        checks = {str(i): actual[i] == expected[i] for i in (1, 2, 3)}
        counts = np.frombuffer(expected[3], dtype='i4')
        assert np.all(counts >= 0) and len(counts) == count
        live = np.arange(32)[:, None] < np.minimum(counts[None, :], 32)
        for i, width in ((4, 1), (5, 4)):
            a = np.frombuffer(actual[i], dtype='u4').reshape(32, count, width)
            b = np.frombuffer(expected[i], dtype='u4').reshape(32, count, width)
            checks[str(i)+'-written-slots'] = a[live].tobytes() == b[live].tobytes()
        assert all(checks.values()), (folder.name, checks)
        # Use the captured cache and direction, so this replay is independent of the force replay's output.
        for offset, argument in ((64, 3), (72, 4), (80, 5)):
            struct.pack_into('<Q', view, offset, upload(expected[argument]))
        line = next(line for line in lines if line.split()[1] == PRODUCT)
        captured_view = view_bytes(line)
        assert view[88:116] == captured_view[88:116]
        direction, product = upload(raw(PRODUCT, 'pre', 1)), upload(raw(PRODUCT, 'pre', 2))
        name = re.search(r' symbol:(\S+)', line).group(1)
        driver.launch(driver.function(name), (count+127)//128, 128,
                      [bytes(view), struct.pack('<Q', direction), struct.pack('<Q', product)])
        driver.synchronize()
        target = raw(PRODUCT, 'post', 2)
        tangent_equal = driver.download(product, len(target)) == target
        assert tangent_equal, folder.name
        results.append({'capture': folder.name, 'runtime': runtime, 'grid_chain_valid': True,
                        'grid_point_fields_equal': True, 'initial_rhs_equal': True,
                        'grid_order_sha256': hashlib.sha256(head.tobytes()+next_.tobytes()).hexdigest(),
                        'force_outputs_bitwise': checks, 'tangent_output_bitwise': tangent_equal,
                        'neighbor_min': int(counts.min()), 'neighbor_max': int(counts.max()),
                        'fallback_rows': int((counts > 32).sum()), 'written_cache_slots': int(live.sum())})
        for pointer in pointers:
            driver.release(pointer)
    assert len(results) == 4
    assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    build = json.loads((ROOT/'build/reconstruction-csrc/host-particles/build.json').read_text())
    report = {'source_sha256': build['extension_sha256'], 'captures': results,
              'grid_orders': len({r['grid_order_sha256'] for r in results}), 'whole_solver_bitwise_equal': False}
    (output/'replay.json').write_text(json.dumps(report, indent=2)+'\n')
    print('four dense-grid contact/tangent replays passed; grid orders', report['grid_orders'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--template-log', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    lines = args.template_log.read_text().splitlines()
    count, slots = struct.unpack_from('<2i', view_bytes(next(l for l in lines if l.split()[1] == FORCE)), 88)
    model = next(l for l in lines if l.split()[1] == GRID)
    word = int(re.search(r'Mview:.*?24:([0-9a-f]+)\(', model).group(1), 16)
    particles = (word >> 32) or (word & 0xffffffff)
    inputs = {0: slots*4, 8: count*4, 16: count*4, 24: count*4, 32: count*12,
              40: count*12, 48: count*12, 56: count*4}
    outputs = {1: particles*12, 2: particles*36, 3: count*4, 4: count*32*4, 5: count*32*16}
    spec = FORCE+'='+','.join([f'0+{off}:{size}' for off, size in inputs.items()] +
                              [f'{i}:{size}' for i, size in outputs.items()])
    spec += ';'+PRODUCT+f'=1:{particles*12},2:{particles*12}'
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(ROOT/'build/reconstruction-csrc/granular-host/cudahook.so'),
               CUDAHOOK_DUMP=spec, CUDAHOOK_DUMP_LIMIT='1')
    (args.output/'settings.json').write_text(json.dumps({'points': count, 'slots': slots, 'particles': particles,
        'mode': args.mode, 'dump_specification': spec}, indent=2)+'\n')
    captures = args.output/'captures'
    captures.mkdir()
    for backend, tag in [('original', 'original0'), ('original', 'original1'), ('original', 'original2'),
                         ('source', 'source0')]:
        directory = captures/tag
        directory.mkdir()
        env['CUDAHOOK_DIR'] = str(directory)
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                   '--tag', 'capture', '--example', 'reconstruction/csrc/granular_host_scene.py', '--frames', '1',
                   '--output', str(directory), '--', '--layout', 'fallback', '--bonds', 'mixed', '--mode', args.mode]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (directory/'run.log').open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=600)
    replay(captures, args.output)


if __name__ == '__main__':
    main()
