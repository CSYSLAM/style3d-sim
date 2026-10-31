"""Replay the selected compiled-so grid kernel on real captured one-world, full-selection inputs."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct

import numpy as np

from .granular_grid_probe import GRID, view_bytes
from .host_particles_ab import native_source


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--trace', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    core = native_source()
    driver = core._KernelDriver()
    reports = []
    for backend in ('original', 'source'):
        directory = args.trace/backend
        lines = [l for l in (directory/'launches.txt').read_text().splitlines() if l.split()[1] == GRID]
        assert len(lines) == 4
        for iteration, line in enumerate(lines):
            model = bytearray((directory/f'model_{line.split()[0]}.bin').read_bytes())
            # The trace has one world and all particle IDs selected; do not infer model arrays for other layouts.
            world_particles, state_particles = struct.unpack_from('<2I', model, 24)
            assert world_particles == state_particles and world_particles > 0
            token = next(t for t in line.split() if t.startswith('gview:'))
            view = view_bytes(token)
            count, slots = struct.unpack_from('<2i', view, 88)
            assert count == world_particles

            def raw(phase, argument):
                return (directory/f'dump_{GRID}_call{iteration:03d}_{phase}_arg{argument}.bin').read_bytes()

            ids = np.frombuffer(raw('post', 7), dtype='i4')
            assert np.array_equal(ids, np.arange(count))
            allocations = []

            def upload(data):
                pointer = driver.upload(data)
                allocations.append(pointer)
                return pointer

            for offset, data in ((120, raw('post', 8)), (136, raw('post', 6)), (280, ids.tobytes())):
                struct.pack_into('<Q', model, offset, upload(data))
            x, previous = upload(raw('pre', 1)), upload(raw('pre', 2))
            expected = {i: raw('post', i) for i in range(4, 12)}
            output = {i: upload(np.full(slots, -1, dtype='i4').tobytes() if i == 10 else bytes(len(data)))
                      for i, data in expected.items()}
            for offset, argument in ((0, 10), (8, 11), (16, 7), (24, 8), (32, 9), (40, 4), (48, 5), (56, 6)):
                struct.pack_into('<Q', view, offset, output[argument])
            name = re.search(r' symbol:(\S+)', line).group(1)
            driver.launch(driver.function(name), (count+127)//128, 128,
                          [bytes(model), struct.pack('<Q', x), struct.pack('<Q', previous), bytes(view),
                           *(struct.pack('<Q', output[i]) for i in range(4, 12))])
            driver.synchronize()
            actual = {i: driver.download(p, len(expected[i])) for i, p in output.items()}
            checks = {str(i): actual[i] == expected[i] for i in range(4, 10)}
            assert all(checks.values()), (backend, iteration, checks)
            head, next_ = [np.frombuffer(actual[i], dtype='i4') for i in (10, 11)]
            cells = np.frombuffer(actual[9], dtype='i4').reshape(count, 3)
            visited = []
            for bucket in range(slots):
                current, chain = int(head[bucket]), []
                while current >= 0:
                    assert current < count and current not in chain
                    cell = cells[current]
                    hashed = (int(cell[0])*73856093 ^ int(cell[1])*19349663 ^ int(cell[2])*83492791) & (slots-1)
                    assert hashed == bucket
                    chain.append(current)
                    current = int(next_[current])
                visited.extend(chain)
            assert sorted(visited) == list(range(count))
            reports.append({'backend': backend, 'iteration': iteration, 'point_fields_bitwise': checks,
                            'grid_valid': True, 'grid_order_equal': actual[10]+actual[11] == expected[10]+expected[11],
                            'grid_order_sha256': hashlib.sha256(actual[10]+actual[11]).hexdigest()})
            for pointer in allocations:
                driver.release(pointer)
    assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    build = json.loads(Path('build/reconstruction-csrc/host-particles/build.json').read_text())
    (args.output/'report.json').write_text(json.dumps({'source_sha256': build['extension_sha256'],
        'cuda_source_digest': build['cuda_source_digest'], 'captures': reports}, indent=2)+'\n')
    print('eight actual grid inputs replayed: point fields bitwise equal, every hash list valid')


if __name__ == '__main__':
    main()
