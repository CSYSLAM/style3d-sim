"""Independently replay every dense contact evaluation and CG contact product from an actual step trace."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct

import numpy as np

from .granular_grid_probe import GRID, FORCE, PRODUCT, view_bytes
from .host_particles_ab import native_source


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--trace', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--linear-iterations', type=int, default=5)
    parser.add_argument('--nonlinear-iterations', type=int, default=3)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    core = native_source()
    driver = core._KernelDriver()
    reports = []
    for backend in ('original', 'source'):
        directory = args.trace/backend
        lines = (directory/'launches.txt').read_text().splitlines()
        forces = [l for l in lines if l.split()[1] == FORCE]
        products = [l for l in lines if l.split()[1] == PRODUCT]
        runtime = json.loads((directory/'capture.runtime.json').read_text())
        assert len(forces) == runtime['frames']*args.nonlinear_iterations
        assert len(products) == len(forces)*args.linear_iterations
        preceding_grid, grid_index = [], -1
        for line in lines:
            if line.split()[1] == GRID:
                grid_index += 1
            if line.split()[1] == FORCE:
                assert grid_index >= 0
                preceding_grid.append(grid_index)
        assert len(preceding_grid) == len(forces)

        def raw(key, call, phase, argument):
            return (directory/f'dump_{key}_call{call:03d}_{phase}_arg{argument}.bin').read_bytes()

        for iteration, force_line in enumerate(forces):
            view = view_bytes(force_line)
            count, slots = struct.unpack_from('<2i', view, 88)
            inputs = {offset: raw(GRID, preceding_grid[iteration], 'post', argument) for offset, argument in
                      ((0, 10), (8, 11), (16, 7), (24, 8), (32, 9), (40, 4), (48, 5), (56, 6))}
            head, next_ = [np.frombuffer(inputs[o], dtype='i4') for o in (0, 8)]
            cells = np.frombuffer(inputs[32], dtype='i4').reshape(-1, 3)
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
            allocations = []

            def upload(payload):
                pointer = driver.upload(payload)
                allocations.append(pointer)
                return pointer

            for offset, payload in inputs.items():
                struct.pack_into('<Q', view, offset, upload(payload))
            outputs = {i: upload(raw(FORCE, iteration, 'pre', i)) for i in range(1, 6)}
            for offset, argument in ((64, 3), (72, 4), (80, 5)):
                struct.pack_into('<Q', view, offset, outputs[argument])
            function = driver.function(re.search(r' symbol:(\S+)', force_line).group(1))
            driver.launch(function, (count+127)//128, 128,
                          [bytes(view), *(struct.pack('<Q', outputs[i]) for i in range(1, 6))])
            driver.synchronize()
            expected = {i: raw(FORCE, iteration, 'post', i) for i in outputs}
            actual = {i: driver.download(pointer, len(expected[i])) for i, pointer in outputs.items()}
            checks = {str(i): actual[i] == expected[i] for i in (1, 2, 3)}
            counts = np.frombuffer(expected[3], dtype='i4')
            live = np.arange(32)[:, None] < np.minimum(counts[None, :], 32)
            for i, width in ((4, 1), (5, 4)):
                a = np.frombuffer(actual[i], dtype='u4').reshape(32, count, width)
                b = np.frombuffer(expected[i], dtype='u4').reshape(32, count, width)
                checks[str(i)+'-written'] = a[live].tobytes() == b[live].tobytes()
            assert all(checks.values()), (backend, iteration, checks)
            for offset, argument in ((64, 3), (72, 4), (80, 5)):
                struct.pack_into('<Q', view, offset, upload(expected[argument]))
            tangent_checks = []
            for k in range(args.linear_iterations):
                index = iteration*args.linear_iterations+k
                line = products[index]
                assert view[88:116] == view_bytes(line)[88:116]
                direction = upload(raw(PRODUCT, index, 'pre', 1))
                product = upload(raw(PRODUCT, index, 'pre', 2))
                function = driver.function(re.search(r' symbol:(\S+)', line).group(1))
                driver.launch(function, (count+127)//128, 128,
                              [bytes(view), struct.pack('<Q', direction), struct.pack('<Q', product)])
                driver.synchronize()
                target = raw(PRODUCT, index, 'post', 2)
                equal = driver.download(product, len(target)) == target
                assert equal, (backend, iteration, k)
                tangent_checks.append(equal)
            reports.append({'backend': backend, 'iteration': iteration, 'grid_valid': True,
                            'grid_order_sha256': hashlib.sha256(inputs[0]+inputs[8]).hexdigest(),
                            'force_outputs_bitwise': checks, 'tangent_outputs_bitwise': tangent_checks,
                            'fallback_rows': int((counts > 32).sum()), 'written_cache_slots': int(live.sum())})
            for pointer in allocations:
                driver.release(pointer)
    assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    build = json.loads(Path('build/reconstruction-csrc/host-particles/build.json').read_text())
    (args.output/'report.json').write_text(json.dumps({'source_sha256': build['extension_sha256'],
        'captures': reports, 'whole_solver_bitwise_equal': False}, indent=2)+'\n')
    print(len(reports), 'contact evaluations and', sum(len(r['tangent_outputs_bitwise']) for r in reports),
          'contact products bitwise equal on their actual captured inputs')


if __name__ == '__main__':
    main()
