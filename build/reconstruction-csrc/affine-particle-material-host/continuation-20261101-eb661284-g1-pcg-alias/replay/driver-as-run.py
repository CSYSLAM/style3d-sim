"""Replay captured PCG calls with their real overlapping pointer spans and original pre-call bytes."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

from reconstruction import kernel_ab as k
from .demo_source_ab import ROOT
from .host_api_probe import load_reference, REFERENCE, REFERENCE_SHA
from .host_particles_ab import native_source
from .library_entries import entries
from .pcg_alias_capture import TOKENS
from .pcg_same_buffer_probe import Dim3


def span_groups(values, bindings):
    """Merge only intersecting captured spans, rejecting inconsistent bytes in their intersection."""
    intervals = sorted((values[index], values[index] + len(data), index) for index, data in bindings.items())
    groups = []
    for start, end, index in intervals:
        assert start and end > start
        if not groups or start >= groups[-1]['end']:
            groups.append({'start': start, 'end': end, 'indices': [index]})
        else:
            groups[-1]['end'] = max(groups[-1]['end'], end)
            groups[-1]['indices'].append(index)
    for group in groups:
        size = group['end'] - group['start']
        data, covered = np.zeros(size, dtype='u1'), np.zeros(size, dtype=bool)
        for index in group['indices']:
            offset = values[index] - group['start']
            incoming = np.frombuffer(bindings[index], dtype='u1')
            actual, seen = data[offset:offset + len(incoming)], covered[offset:offset + len(incoming)]
            assert np.all(actual[seen] == incoming[seen]), ('Conflicting overlapping pre-call bytes', index)
            actual[:] = incoming
            seen[:] = True
        assert np.all(covered), 'A merged span contains uncaptured bytes'
        group['initial'] = data
    return groups


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert sys.byteorder == 'little' and ct.sizeof(ct.c_void_p) == 8
    output, capture = args.output.resolve(), args.capture.resolve(strict=True)
    output.mkdir(parents=True, exist_ok=False)
    saved = (capture / 'solver-build.json').read_bytes()
    build = json.loads(saved)
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    assert build_path.read_bytes() == saved
    (output / 'build.json').write_bytes(saved)
    provenance = json.loads((capture / 'provenance.json').read_text())
    assert json.loads((capture / 'status.json').read_text())['complete']
    hashes, rows = {}, []

    def read(path):
        data = path.read_bytes()
        hashes[str(path)] = hashlib.sha256(data).hexdigest()
        return data

    for path in (capture / 'provenance.json', capture / 'status.json', Path(__file__)):
        read(path)
    for path, sha in provenance['files'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    launch_runtime = runtime.cudaLaunchKernel
    launch_runtime.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    launch_runtime.restype = ct.c_int
    core = native_source()
    assert hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest() == build['extension_sha256']
    source = core._KernelDriver()
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    originals, functions = {}, {}
    for path in (ROOT / 'build/reconstruction-ptx' / REFERENCE_SHA[:16]).glob('*.ptx'):
        text = path.read_text()
        names = [name for name in entries(text) if any(token in name for token in TOKENS)]
        if names:
            read(path)
            for name in names:
                assert name not in originals
                originals[name] = text
    try:
        for side in ('legacy', 'source'):
            folder = capture / side / 'actual'
            paths = sorted(folder.glob('*.json'))
            assert paths and all(any(token in path.name for token in TOKENS) for path in paths)
            for number, path in enumerate(paths):
                assert build_path.read_bytes() == saved
                metadata = json.loads(read(path))
                name, prefix = metadata['name'], path.name[:-4]
                spec = provenance['schema'][name]
                assert spec['widths'] == build['kernels'][name]['parameters']

                def payload(label):
                    return read(folder / (prefix + label + '.bin'))

                raw = [payload('before.param_' + str(index)) for index in range(len(spec['widths']))]
                assert list(map(len, raw)) == spec['widths']
                values = [int.from_bytes(data, 'little') for data in raw]
                precondition = TOKENS[0] in name
                n = values[7 if precondition else 10]
                world_index, divisor_index = (4, 5) if precondition else (7, 8)
                assert 0 < n <= 1000000
                assert raw[divisor_index] == payload('before.per_group') and values[divisor_index] > 0
                bindings, labels = {}, {}

                def bind(index, label, size, required=False):
                    labels[index] = label
                    filename = folder / (prefix + 'before.' + label + '.bin')
                    if not values[index]:
                        assert not required and not filename.exists(), (name, index)
                        return
                    data = read(filename)
                    assert len(data) == size, (name, index, len(data), size)
                    bindings[index] = data

                bind(world_index, 'world', n * 4)
                if values[world_index]:
                    world = np.frombuffer(bindings[world_index], dtype='<i4')
                    assert np.all(world >= 0) and int(world.max()) < n
                    bins = int(world.max()) + 1
                else:
                    bins = (n + values[divisor_index] - 1) // values[divisor_index]
                if precondition:
                    assert raw[3] == payload('before.precomputed') and values[3] in (0, 1)
                    bind(0, 'inverse', n * 36, required=not values[3])
                    bind(1, 'r', n * 12, required=True)
                    bind(2, 'z', n * 12, required=True)
                    bind(6, 'numerator', bins * 4, required=True)
                    pointwise, aggregate = 2, 6
                else:
                    maximum, local_rows = values[2], values[11]
                    assert raw[2] == payload('before.max_count') and raw[11] == payload('before.rows')
                    assert maximum > 0 and local_rows > 0, 'This diagnostic requires nonempty captured ELL spans'
                    bind(0, 'row_count', local_rows * 4, required=True)
                    bind(1, 'entries', maximum * local_rows * 40, required=True)
                    bind(3, 'blocks', n * 36, required=True)
                    bind(4, 'p', n * 12, required=True)
                    bind(5, 'extra', n * 12)
                    bind(6, 'ap', n * 12, required=True)
                    bind(9, 'denominator', bins * 4, required=True)
                    pointwise, aggregate = 6, 9
                assert set(labels) == set(spec['pointer_indices'])
                assert set(bindings) == {index for index in spec['pointer_indices'] if values[index]}
                expected = {index: payload('after.' + labels[index]) for index in (pointwise, aggregate)}
                assert all(len(expected[index]) == len(bindings[index]) for index in expected)
                groups = span_groups(values, bindings)
                pointers = {}
                group_report = []
                for group in groups:
                    # Keep pointer alignment as well as overlap offsets; disjoint allocation spacing is not reproduced.
                    padding = group['start'] % 256
                    initial = np.zeros(padding + len(group['initial']), dtype='u1')
                    initial[padding:] = group['initial']
                    pointer = driver.upload(initial)
                    assert pointer.value % 256 == 0
                    group.update(device=pointer, upload=initial, padding=padding)
                    output_mask = np.zeros(len(group['initial']), dtype=bool)
                    for index in group['indices']:
                        offset = values[index] - group['start']
                        pointers[index] = pointer.value + padding + offset
                        assert pointers[index] % 256 == values[index] % 256
                        if index in expected:
                            output_mask[offset:offset + len(bindings[index])] = True
                    group['output_mask'] = output_mask
                    group_report.append({'bytes': len(group['initial']), 'indices': group['indices'],
                        'offsets': {str(i): values[i] - group['start'] for i in group['indices']},
                        'original_start_mod256': padding})
                overlaps = []
                for left in bindings:
                    for right in bindings:
                        if left >= right:
                            continue
                        size = min(values[left] + len(bindings[left]), values[right] + len(bindings[right])) - max(
                            values[left], values[right])
                        if size > 0:
                            overlaps.append({'left': left, 'right': right, 'bytes': size,
                                             'right_minus_left': values[right] - values[left]})
                parameters = [(ct.c_ubyte * len(data)).from_buffer_copy(
                    pointers.get(index, 0).to_bytes(8, 'little') if index in spec['pointer_indices'] else data)
                    for index, data in enumerate(raw)]
                holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(p), ct.c_void_p) for p in parameters])
                if name not in functions:
                    functions[name] = {
                        'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                        'original-ptx': driver.function(originals[name], name),
                        'source-ptx': ct.c_void_p(source.function(name)),
                    }
                backends = list(functions[name])
                backends = backends[number % 3:] + backends[:number % 3]
                checks = []
                grid, block, shared = metadata['grid_xyz'], metadata['block_xyz'], metadata['shared_bytes']
                assert grid[0] == metadata['grid'] and block[0] == metadata['block']
                assert len(grid) == len(block) == 3 and all(v > 0 for v in grid + block) and shared >= 0
                for backend in backends:
                    for group in groups:
                        data = group['upload']
                        driver.check(driver.cu.cuMemcpyHtoD_v2(group['device'], ct.c_void_p(data.ctypes.data), data.nbytes))
                    function = functions[name][backend]
                    if backend == 'original-runtime':
                        assert launch_runtime(function, Dim3(*grid), Dim3(*block), holders, shared, stream) == 0
                    else:
                        driver.check(driver.cu.cuLaunchKernel(function, *grid, *block, shared, stream, holders, None))
                    driver.check(driver.cu.cuStreamSynchronize(stream))
                    actual = {index: driver.download(ct.c_uint64(pointers[index]),
                              np.frombuffer(bindings[index], dtype='u1')) for index in expected}
                    untouched = True
                    for group in groups:
                        after = driver.download(group['device'], group['upload'])[group['padding']:]
                        mask = ~group['output_mask']
                        untouched &= bool(np.all(after[mask] == group['initial'][mask]))
                    equal = actual[pointwise].tobytes() == expected[pointwise]
                    checks.append({'backend': backend, 'pointwise_equal': equal,
                        'pointwise_sha256': hashlib.sha256(actual[pointwise].tobytes()).hexdigest(),
                        'captured_aggregate_equal': actual[aggregate].tobytes() == expected[aggregate],
                        'aggregate_bits': actual[aggregate].view('<u4').tolist(), 'unwritten_bytes_unchanged': untouched})
                    if not equal or not untouched:
                        np.savez_compressed(output / (side + '-' + prefix + backend + '.npz'),
                                            **{labels[index]: data for index, data in actual.items()})
                rows.append({'side': side, 'launch': path.name, 'particles': n, 'groups': group_report,
                             'overlaps': overlaps, 'captured_aggregate_bits': np.frombuffer(
                                 expected[aggregate], dtype='<u4').tolist(), 'checks': checks})
                driver.free()
                if number % 100 == 0:
                    print('replayed exact spans', side, number + 1, '/', len(paths), flush=True)
        report = {'source_sha256': build['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
            'packets': rows, 'input_sha256': hashes,
            'all_pointwise_equal': all(c['pointwise_equal'] for row in rows for c in row['checks']),
            'all_unwritten_bytes_unchanged': all(c['unwritten_bytes_unchanged'] for row in rows for c in row['checks']),
            'overlapping_pointer_spans_preserved': True, 'pointer_alignment_mod256_preserved': True,
            'all_raw_scalars_preserved': True, 'whole_allocation_layout_preserved': False,
            'diagnostic_intentionally_maps_original': True, 'production_changed': False,
            'frozen_candidate_replaced': False, 'frozen_failure_path_reproduced': False,
            'whole_solver_complete': False}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        print('PCG actual-span packets', len(rows), 'pointwise', report['all_pointwise_equal'],
              'unwritten bytes', report['all_unwritten_bytes_unchanged'], flush=True)
        return int(not (report['all_pointwise_equal'] and report['all_unwritten_bytes_unchanged']))
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    raise SystemExit(main())
