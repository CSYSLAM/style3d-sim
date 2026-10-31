"""Validate captured fluid hash lists and replay each original evaluate_rows input through the source .so."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct

import numpy as np

from .host_particles_ab import native_source


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--captures', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    core = native_source()
    driver = core._KernelDriver()
    reports = []
    reference_points = None
    for directory in sorted(p for p in args.captures.iterdir() if (p/'launches.txt').exists()):
        lines = (directory/'launches.txt').read_text().splitlines()
        line = next(line for line in lines if line.split()[1] == '12fluid_kernel13evaluate_rows')
        words = dict((int(offset), int(value, 16)) for offset, value in re.findall(r'(\d+):([0-9a-f]+)\(', line))
        assert len(words) == 14
        view = bytearray(struct.pack('<14Q', *(words[offset] for offset in range(0, 112, 8))))
        slots, stride, local, rows = struct.unpack_from('<4i', view, 80)
        points = (directory/'dump_12fluid_kernel10build_grid_post_arg2.bin').stat().st_size // 12

        def grid(argument, dtype='i4', width=1):
            data = np.fromfile(directory/f'dump_12fluid_kernel10build_grid_post_arg{argument}.bin', dtype=dtype)
            return data.reshape(-1, width) if width > 1 else data

        head, next_, cells = grid(7), grid(8), grid(6, width=3)
        assert len(head) == slots and len(next_) == points
        visited = []
        for bucket in range(slots):
            current, chain = int(head[bucket]), []
            while current >= 0:
                assert current < points and current not in chain, 'Invalid or cyclic hash list'
                cell = cells[current]
                expected = (int(cell[0])*73856093 ^ int(cell[1])*19349663 ^ int(cell[2])*83492791) & (slots - 1)
                assert expected == bucket
                chain.append(current)
                current = int(next_[current])
            visited.extend(chain)
        assert sorted(visited) == list(range(points)), 'A grid point is missing or appears twice'
        point_fields = [grid(2, 'f4', 3), grid(3, 'f4'), grid(4), grid(5), cells]
        if reference_points is None:
            reference_points = point_fields
        assert all(a.tobytes() == b.tobytes() for a, b in zip(reference_points, point_fields))

        allocations = []

        def upload(data):
            pointer = driver.upload(data)
            allocations.append(pointer)
            return pointer

        key = '12fluid_kernel13evaluate_rows'
        for offset in range(0, 56, 8):
            suffix = f'_offset{offset}' if offset else ''
            data = (directory/f'dump_{key}_pre_arg0{suffix}.bin').read_bytes()
            struct.pack_into('<Q', view, offset, upload(data))
        sizes = {1: rows*12, 2: rows*4, 3: rows*4, 4: rows*4, 5: rows*64*4, 6: rows*64*16}
        output = {argument: upload(bytes(size)) for argument, size in sizes.items()}
        for offset, argument in ((56, 4), (64, 5), (72, 6)):
            struct.pack_into('<Q', view, offset, output[argument])
        name = re.search(r' symbol:(\S+)', line).group(1)
        driver.launch(driver.function(name), (rows + 127)//128, 128,
                      [bytes(view), *(struct.pack('<Q', output[i]) for i in range(1, 7))])
        driver.synchronize()
        actual = {argument: driver.download(pointer, sizes[argument]) for argument, pointer in output.items()}
        expected = {argument: (directory/f'dump_{key}_post_arg{argument}.bin').read_bytes() for argument in output}
        checks = {str(i): actual[i] == expected[i] for i in range(1, 5)}
        counts = np.frombuffer(expected[4], dtype='i4')
        assert np.all(counts >= 0)
        live = np.arange(64)[None, :] < np.minimum(counts[:, None], 64)
        for argument, width in ((5, 1), (6, 4)):
            a = np.frombuffer(actual[argument], dtype='u4').reshape(rows, 64, width)
            b = np.frombuffer(expected[argument], dtype='u4').reshape(rows, 64, width)
            checks[str(argument)+'-written-prefix'] = a[live].tobytes() == b[live].tobytes()
        row = {'capture': directory.name, 'points': points, 'rows': rows, 'stride': stride, 'local_fluid': local,
               'grid_chain_valid': True, 'grid_point_fields_equal': True,
               'grid_order_sha256': hashlib.sha256(head.tobytes()+next_.tobytes()).hexdigest(),
               'row_outputs_bitwise': checks, 'written_cache_entries': int(live.sum())}
        reports.append(row)
        for pointer in allocations:
            driver.release(pointer)
        assert all(checks.values()), row
    assert len(reports) >= 4
    assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    manifest = json.loads(Path('build/reconstruction-csrc/host-particles/build.json').read_text())
    report = {'captures': reports, 'source_sha256': manifest['extension_sha256'],
              'unique_grid_orders': len({r['grid_order_sha256'] for r in reports}),
              'whole_solver_bitwise_equal': False, 'original_solver_mapped': False}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report))


if __name__ == '__main__':
    main()
