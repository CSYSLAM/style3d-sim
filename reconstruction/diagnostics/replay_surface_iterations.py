"""Rebuild each native SurfaceContactView from captured bytes and isolate its contact rows.

No Newton history is reconstructed: only inputs consumed by these two contact kernels
are used. Aggregate differences include atomic order; per-row tests remove cross-row writes.
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


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--native', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    record = load(args.input)
    count = record['config']['nonlinear_iterations']
    keys = ('30evaluate_surface_contact_force', '34add_surface_contact_preconditioner')
    lines = (args.native/'launches.txt').read_text().splitlines()
    metadata = {}
    for key in keys:
        launches = [line for line in lines if f' {key} ' in line]
        if len(launches) != count:
            raise RuntimeError(f'Expected {count} launches of {key}, got {len(launches)}')
        metadata[key] = []
        for line in launches:
            words = re.findall(r'(\d+):([0-9a-f]+)\(', line.split(' Uview:', 1)[1])
            if [int(offset) for offset, _ in words] != list(range(0, 296, 8)):
                raise RuntimeError('Truncated surface view metadata')
            metadata[key].append(struct.pack('<37Q', *(int(word, 16) for _, word in words)))
    driver = Driver()
    functions = {key: driver.function(*legacy_ptx(key)) for key in keys}
    report = {'input_sha256': sha(args.input), 'iterations': [], 'scope': 'surface force/preconditioner, per-row PTX'}
    try:
        for iteration in range(count):
            raw = metadata[keys[0]][iteration]
            if raw[:292] != metadata[keys[1]][iteration][:292]:
                raise RuntimeError('Force and preconditioner views differ; cannot reuse this context')
            u64 = lambda offset: struct.unpack_from('<Q', raw, offset)[0]
            n, shapes, bodies = u64(120), u64(200), u64(264)
            if u64(216) != 1 or u64(112) != n or u64(208) != shapes:
                raise RuntimeError('Only single-world views are supported')

            def read(key, arg, phase='pre', offset=0, dtype=np.float32, shape=None):
                suffix = f'_offset{offset}' if offset else ''
                path = args.native/f'dump_{key}_call{iteration:03d}_{phase}_arg{arg}{suffix}.bin'
                data = np.fromfile(path, dtype)
                return data.reshape(shape) if shape is not None else data

            def view(offset, shape, dtype=np.float32):
                return None if u64(offset) == 0 else read(keys[0], 0, offset=offset, dtype=dtype, shape=shape)

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
            for offset, expected in ((272, c.x), (280, c.previous)):
                actual = read(keys[1], 0, offset=offset, shape=(n, 3))
                if actual.tobytes() != expected.tobytes():
                    raise RuntimeError('Positions changed between contact force and preconditioner')
            bases = {'force': read(keys[0], 1, shape=(n, 3)),
                     'preconditioner': read(keys[1], 1, shape=(n, 9))}
            aggregate = {}
            for name, key in zip(bases, keys):
                actual = bases[name].copy()
                fn = (surface_contact.evaluate_surface_contact_force if name == 'force'
                      else surface_contact.add_surface_contact_preconditioner)
                fn(c, actual)
                aggregate[name] = compare(actual, read(key, 1, 'post', shape=actual.shape))
            results = []
            for index in range(rows):
                one = copy.copy(c)
                one.count = 1
                for name in ('indices', 'barycentric', 'shape', 'body_pos', 'body_vel', 'normal'):
                    setattr(one, name, getattr(c, name)[index:index+1])
                params = surface_view(driver, one, transform)
                item = {'contact': index}
                for name, key in zip(bases, keys):
                    buf = driver.upload(bases[name])
                    driver.launch(functions[key], 1, [params, buf])
                    expected = driver.download(buf, bases[name])
                    actual = bases[name].copy()
                    fn = (surface_contact.evaluate_surface_contact_force if name == 'force'
                          else surface_contact.add_surface_contact_preconditioner)
                    fn(one, actual)
                    item[name] = compare(actual, expected)
                    item[name]['changed'] = int(np.count_nonzero(expected.view(np.uint32) != bases[name].view(np.uint32)))
                results.append(item)
                driver.free()
            summary = {'iteration': iteration, 'rows': rows, 'aggregate': aggregate, 'contacts': results,
                       'row_bitwise_equal': all(r[k]['different_bits'] == 0 for r in results for k in bases),
                       'active_rows': {k: sum(r[k]['changed'] > 0 for r in results) for k in bases}}
            report['iterations'].append(summary)
            print(json.dumps({k: v for k, v in summary.items() if k != 'contacts'}), flush=True)
    finally:
        driver.free()
    report['row_bitwise_equal'] = all(r['row_bitwise_equal'] for r in report['iterations'])
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    if not report['row_bitwise_equal']:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
