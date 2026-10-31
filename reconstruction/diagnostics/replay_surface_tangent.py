"""Replay captured surface tangents; isolate rows at selected CG calls against legacy PTX.

All calls receive aggregate checks. Per-row PTX checks sample the first and last CG
call of each Newton iteration by default, and are reported separately from aggregate differences.
"""
import argparse
import copy
import json
from pathlib import Path
import re
import struct

import numpy as np

from reconstruction import surface_contact
from reconstruction.contact_replay import load
from reconstruction.diagnostics.compare_contact_stages import compare
from reconstruction.kernel_ab import Driver, legacy_ptx, surface_view
from reconstruction.rigid_contact import Bodies
from reconstruction.validate import sha

KEY = '32multiply_surface_contact_tangent'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--native', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--row-calls', type=int, nargs='+', help='Call indices for individual-row PTX comparisons')
    args = parser.parse_args()
    record = load(args.input)
    linear, iterations = record['config']['linear_iterations'], record['config']['nonlinear_iterations']
    total = linear*iterations
    selected = set(args.row_calls if args.row_calls is not None else
                   [i*linear+k for i in range(iterations) for k in (0, linear-1)])
    if not selected or min(selected) < 0 or max(selected) >= total:
        raise ValueError('Invalid row-call selection')
    lines = [line for line in (args.native/'launches.txt').read_text().splitlines() if f' {KEY} ' in line]
    if len(lines) != total:
        raise RuntimeError(f'Expected {total} tangent launches, got {len(lines)}')
    driver = Driver()
    function = driver.function(*legacy_ptx(KEY))
    report = {'input_sha256': sha(args.input), 'row_calls': sorted(selected), 'calls': [],
              'scope': 'aggregate on every native call; per-row PTX only at explicitly listed call indices'}
    read_only_checks = 0
    try:
        for call, line in enumerate(lines):
            words = re.findall(r'(\d+):([0-9a-f]+)\(', line.split(' Uview:', 1)[1])
            if [int(offset) for offset, _ in words] != list(range(0, 296, 8)):
                raise RuntimeError('Truncated surface view metadata')
            raw = struct.pack('<37Q', *(int(word, 16) for _, word in words))
            u64 = lambda offset: struct.unpack_from('<Q', raw, offset)[0]
            n, shapes, bodies = u64(120), u64(200), u64(264)
            if u64(216) != 1 or u64(112) != n or u64(208) != shapes:
                raise RuntimeError('Only single-world captures are supported')

            def read(arg, phase='pre', offset=0, dtype=np.float32, shape=None):
                suffix = f'_offset{offset}' if offset else ''
                path = args.native/f'dump_{KEY}_call{call:03d}_{phase}_arg{arg}{suffix}.bin'
                data = np.fromfile(path, dtype)
                return data.reshape(shape) if shape is not None else data

            def view(offset, shape, dtype=np.float32):
                nonlocal read_only_checks
                if u64(offset) == 0:
                    return None
                before = read(0, offset=offset, dtype=dtype, shape=shape)
                after = read(0, 'post', offset=offset, dtype=dtype, shape=shape)
                if before.tobytes() != after.tobytes():
                    raise RuntimeError(f'Input view changed at call {call}, offset {offset}')
                read_only_checks += 1
                return before

            rows = int(view(0, (1,), np.int32)[0])
            if rows != u64(8):
                raise RuntimeError('This capture expects compact contact buffers')
            transform = view(144, (shapes, 7))
            body = Bodies(view(240, (bodies,), np.int32), view(248, (bodies, 4), np.int32), view(256, (bodies, 3)))
            c = surface_contact.SurfaceContacts(
                rows, view(16, (rows, 3), np.int32), view(24, (rows, 3)), view(32, (rows,), np.int32),
                view(40, (rows, 3)), view(48, (rows, 3)), view(56, (rows, 3)), view(80, (n,)), view(88, (n,)),
                view(96, (n,), np.int32), view(104, (n,), np.int32), view(128, (shapes,), np.int32),
                view(136, (shapes,), np.int32), transform[:, :3], view(152, (shapes, 3)), view(160, (shapes,)),
                view(168, (shapes,)), view(176, (shapes,)), view(184, (shapes,)), view(192, (shapes,)),
                *struct.unpack_from('<4f', raw, 224), body, view(272, (n, 3)), view(280, (n, 3)),
                struct.unpack_from('<f', raw, 288)[0], particle_only=view(64, (u64(72),), np.int32))
            direction, base = read(1, shape=(n, 3)), read(2, shape=(n, 3))
            if direction.tobytes() != read(1, 'post', shape=(n, 3)).tobytes():
                raise RuntimeError('Native direction changed during the kernel')
            read_only_checks += 1
            if c.previous.tobytes() != record['particle_q'].tobytes():
                raise RuntimeError('Previous positions differ from the captured step input')
            actual = base.copy()
            surface_contact.multiply_surface_contact_tangent(c, direction, actual)
            item = {'call': call, 'iteration': call//linear, 'k': call % linear, 'rows': rows,
                    'aggregate': compare(actual, read(2, 'post', shape=(n, 3)))}
            if call in selected:
                results = []
                for index in range(rows):
                    one = copy.copy(c)
                    one.count = 1
                    for name in ('indices', 'barycentric', 'shape', 'body_pos', 'body_vel', 'normal'):
                        setattr(one, name, getattr(c, name)[index:index+1])
                    params = surface_view(driver, one, transform)
                    buf = driver.upload(base)
                    driver.launch(function, 1, [params, driver.upload(direction), buf])
                    expected = driver.download(buf, base)
                    actual = base.copy()
                    surface_contact.multiply_surface_contact_tangent(one, direction, actual)
                    row = {'contact': index, **compare(actual, expected),
                           'changed': int(np.count_nonzero(expected.view(np.uint32) != base.view(np.uint32)))}
                    results.append(row)
                    driver.free()
                item['row_results'] = results
                item['row_bitwise_equal'] = all(row['different_bits'] == 0 for row in results)
                item['active_rows'] = sum(row['changed'] > 0 for row in results)
                print(json.dumps({k: v for k, v in item.items() if k != 'row_results'}), flush=True)
            report['calls'].append(item)
            if call % 25 == 24:
                print(f'aggregate progress: {call+1}/{total}', flush=True)
    finally:
        driver.free()
    report['read_only_checks'] = read_only_checks
    report['row_bitwise_equal'] = all(row.get('row_bitwise_equal', True) for row in report['calls'])
    report['aggregate_bitwise_equal'] = all(row['aggregate']['different_bits'] == 0 for row in report['calls'])
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    if not report['row_bitwise_equal']:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
