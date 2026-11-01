"""Replay the actual complete granular View on SDK/PTX/candidate2, preserving aliases and all guard bytes."""
from collections import Counter
import ctypes as ct
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import struct
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.granular_grid_probe import FORCE, view_bytes
from reconstruction.csrc.pcg_alias_replay import span_groups

BACKENDS = ('original-runtime', 'original-ptx', 'source-ptx')
SIZES = [1024, 324, 324, 324, 972, 972, 972, 324, 324, 10368, 41472, 1116, 3348, 324, 10368, 41472]


def packet(folder):
    line = next(s for s in (folder / 'launches.txt').read_text().splitlines() if s.split()[1] == FORCE)
    view = bytes(view_bytes(line))
    assert struct.unpack_from('<2i', view, 88) == (81, 256)
    tokens = line.split(' symbol:', 1)[0].split()[5:]
    assert len(tokens) == 6 and all(t.startswith('u:') for t in tokens[1:])
    raw = [view, *[int(t[2:], 16).to_bytes(8, 'little') for t in tokens[1:]]]
    values = list(struct.unpack_from('<11Q', view)) + [int.from_bytes(v, 'little') for v in raw[1:]]
    geometry = [int(v, 0) for v in line.rsplit('launch:', 1)[1].split(',')]
    assert geometry[:7] == [1, 1, 1, 128, 1, 1, 0]
    bindings, expected = {}, {}
    for i, size in enumerate(SIZES):
        argument, offset = (0, i * 8) if i < 11 else (i - 10, 0)
        suffix = '_offset' + str(offset) if offset else ''
        path = folder / ('dump_' + FORCE + '_pre_arg' + str(argument) + suffix + '.bin')
        bindings[i] = path.read_bytes()
        assert len(bindings[i]) == size and values[i]
        if i >= 11:
            expected[i] = (folder / ('dump_' + FORCE + '_post_arg' + str(argument) + '.bin')).read_bytes()
            assert len(expected[i]) == size
    for a, b in ((8, 13), (9, 14), (10, 15)):
        assert values[a] == values[b] and bindings[a] == bindings[b]
    head, next_ = [np.frombuffer(bindings[i], dtype='<i4') for i in (0, 1)]
    cells = np.frombuffer(bindings[4], dtype='<i4').reshape(81, 3)
    visited = []
    for bucket, start in enumerate(head):
        chain, current = [], int(start)
        while current >= 0:
            assert current < 81 and current not in chain
            cell = cells[current]
            slot = (int(cell[0]) * 73856093 ^ int(cell[1]) * 19349663 ^ int(cell[2]) * 83492791) & 255
            assert slot == bucket
            chain.append(current)
            current = int(next_[current])
        visited.extend(chain)
    assert sorted(visited) == list(range(81))
    ids = np.frombuffer(bindings[2], dtype='<i4')
    assert len(np.unique(ids)) == 81 and ids.min() >= 0 and ids.max() < 93
    return {'raw': raw, 'values': values, 'bindings': bindings, 'expected': expected,
            'name': re.search(r' symbol:(\S+)', line).group(1), 'geometry': geometry}


def inputs():
    phase = BASE / 'first-force'
    plan = json.loads((phase / 'plan.json').read_text())
    for name, digest in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
    status = json.loads((phase / 'capture.status.json').read_text())
    assert status['complete'] and status['running'] is None and len(status['completed']) == 6
    assert all(r['actual_exit'] == 0 for r in status['completed'])
    packets = {r['label']: packet(phase / r['label']) for r in plan['runs']}
    baseline = packets['original0']
    for p in packets.values():
        assert p['name'] == baseline['name'] and p['raw'][0][88:116] == baseline['raw'][0][88:116]
        assert all(p['bindings'][i] == baseline['bindings'][i] for i in range(2, 16))
    return phase, plan, packets, baseline


def replay():
    from reconstruction import kernel_ab as k
    from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
    from reconstruction.csrc.host_api_probe import load_reference, REFERENCE
    from reconstruction.csrc.pcg_same_buffer_probe import Dim3

    phase, plan, packets, baseline = inputs()
    output = phase / 'replay'
    output.mkdir(exist_ok=False)
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    runtime.cudaLaunchKernel.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    runtime.cudaLaunchKernel.restype = ct.c_int
    build = json.loads((BASE / 'candidate2/build.json').read_text())
    path = Path(build['image'])
    assert hashlib.sha256(path.read_bytes()).hexdigest() == build['image_sha256']
    spec = importlib.util.spec_from_file_location('_source_solver', path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    assert module.source_only
    source = module._KernelDriver()
    inventory = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
    texts, _ = kernel_texts(inventory, baseline['name'])
    functions = {'original-runtime': ct.cast(getattr(runtime, baseline['name']), ct.c_void_p),
                 'original-ptx': driver.function(texts['original'], baseline['name']),
                 'source-ptx': ct.c_void_p(source.function(baseline['name']))}
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows, complete = [], False
    try:
        for label, p in packets.items():
            for mode in ('captured-grid', 'common-grid'):
                bindings = dict(p['bindings'])
                if mode == 'common-grid':
                    bindings.update({i: baseline['bindings'][i] for i in (0, 1)})
                expected = baseline['expected'] if mode == 'common-grid' else p['expected']
                groups, pointers, metadata, arrays = span_groups(p['values'], bindings), {}, [], {}
                try:
                    for g in groups:
                        padding = 256 + g['start'] % 256
                        initial = np.full(padding + len(g['initial']) + 256, 211, dtype='u1')
                        initial[padding:padding + len(g['initial'])] = g['initial']
                        device = driver.upload(initial)
                        assert device.value % 256 == 0
                        g.update(device=device, initial_array=initial)
                        metadata.append({'indices': g['indices'], 'start': g['start'], 'end': g['end'],
                                         'padding': padding, 'device_base': device.value})
                        for i in g['indices']:
                            pointers[i] = device.value + padding + p['values'][i] - g['start']
                    view = bytearray(p['raw'][0])
                    for i in range(11):
                        struct.pack_into('<Q', view, i * 8, pointers[i])
                    raw = [bytes(view), *[pointers[i].to_bytes(8, 'little') for i in range(11, 16)]]
                    actual = [(ct.c_ubyte * len(value)).from_buffer_copy(value) for value in raw]
                    holders = (ct.c_void_p * 6)(*[ct.cast(ct.byref(v), ct.c_void_p) for v in actual])
                    for i, value in enumerate(raw):
                        arrays['actual-parameter-' + str(i)] = np.frombuffer(value, dtype='u1')
                    checks = {}
                    for backend in BACKENDS:
                        for g in groups:
                            initial = g['initial_array']
                            driver.check(driver.cu.cuMemcpyHtoD_v2(g['device'], ct.c_void_p(initial.ctypes.data), len(initial)))
                        if backend == 'original-runtime':
                            assert runtime.cudaLaunchKernel(functions[backend], Dim3(1, 1, 1), Dim3(128, 1, 1),
                                                            holders, 0, stream) == 0
                        else:
                            driver.check(driver.cu.cuLaunchKernel(functions[backend], 1, 1, 1, 128, 1, 1,
                                                                 0, stream, holders, None))
                        driver.check(driver.cu.cuStreamSynchronize(stream))
                        for index, g in enumerate(groups):
                            arrays[backend + '-group-' + str(index)] = driver.download(g['device'], g['initial_array'])
                        checks[backend] = {}
                        for i, wanted in expected.items():
                            value = driver.download(ct.c_uint64(pointers[i]), np.zeros(len(wanted), dtype='u1'))
                            arrays[backend + '-output-' + str(i)] = value
                            checks[backend][str(i)] = value.tobytes() == wanted
                    target = output / (label + '-' + mode + '.npz')
                    np.savez_compressed(target, **arrays)
                    rows.append({'label': label, 'mode': mode, 'groups': metadata, 'checks': checks,
                                 'output_sha256': hashlib.sha256(target.read_bytes()).hexdigest()})
                finally:
                    for g in groups:
                        if 'device' in g:
                            driver.check(driver.cu.cuMemFree_v2(g['device']))
        complete = True
    finally:
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
        (phase / 'replay-report.json').write_text(json.dumps({'rows': rows, 'complete': complete,
            'actual_calls': len(rows) * 3, 'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
    print('Replayed36 actual/common-grid SDK/PTX/candidate calls', flush=True)


def audit():
    phase, plan, packets, baseline = inputs()
    report = json.loads((phase / 'replay-report.json').read_text())
    assert report['complete'] and report['actual_calls'] == 36 and len(report['rows']) == 12
    counts, checks = Counter(), []
    for row in report['rows']:
        p = packets[row['label']]
        bindings = dict(p['bindings'])
        if row['mode'] == 'common-grid':
            bindings.update({i: baseline['bindings'][i] for i in (0, 1)})
        wanted = baseline['expected'] if row['mode'] == 'common-grid' else p['expected']
        path = phase / 'replay' / (row['label'] + '-' + row['mode'] + '.npz')
        assert hashlib.sha256(path.read_bytes()).hexdigest() == row['output_sha256']
        groups = span_groups(p['values'], bindings)
        with np.load(path, allow_pickle=False) as saved:
            raw = [saved['actual-parameter-' + str(i)].tobytes() for i in range(6)]
            assert len(raw[0]) == 120 and all(len(value) == 8 for value in raw[1:])
            assert raw[0][88:] == p['raw'][0][88:]
            pointers = list(struct.unpack_from('<11Q', raw[0])) + [int.from_bytes(v, 'little') for v in raw[1:]]
            for g, metadata in zip(groups, row['groups'], strict=True):
                assert {k: g[k] for k in ('start', 'end', 'indices')} == {k: metadata[k] for k in ('start', 'end', 'indices')}
                padding = 256 + g['start'] % 256
                assert metadata['padding'] == padding and metadata['device_base'] % 256 == 0
                initial = np.full(padding + len(g['initial']) + 256, 211, dtype='u1')
                initial[padding:padding + len(g['initial'])] = g['initial']
                mask = np.ones(len(initial), dtype=bool)
                for i in g['indices']:
                    offset = padding + p['values'][i] - g['start']
                    assert pointers[i] == metadata['device_base'] + offset
                    assert pointers[i] % 256 == p['values'][i] % 256
                    if i in wanted:
                        mask[offset:offset + len(wanted[i])] = False
                index = row['groups'].index(metadata)
                for backend in BACKENDS:
                    actual = saved[backend + '-group-' + str(index)]
                    assert actual.dtype == np.dtype('u1') and actual.shape == initial.shape
                    assert np.array_equal(actual[mask], initial[mask])
                    counts['full_after_bytes'] += len(actual)
                    counts['readonly_and_guard_bytes'] += int(mask.sum())
                    for i in g['indices']:
                        if i in wanted:
                            offset = padding + p['values'][i] - g['start']
                            output_bytes = saved[backend + '-output-' + str(i)].tobytes()
                            assert output_bytes == actual[offset:offset + len(wanted[i])].tobytes()
            for backend in BACKENDS:
                for i, expected in wanted.items():
                    value = saved[backend + '-output-' + str(i)].tobytes()
                    same = value == expected
                    assert row['checks'][backend][str(i)] == same
                    checks.append({'label': row['label'], 'mode': row['mode'], 'backend': backend, 'output': i, 'strict': same})
                    counts['complete_output_arrays'] += 1
                    counts['complete_output_words'] += len(value) // 4
            counts['actual_ABI_bytes'] += sum(map(len, raw)) * 3
            counts['relocated_pointer_fields'] += 16 * 3
    assert counts['complete_output_arrays'] == 180
    grid_differences = {label: [i for i in (0, 1) if p['bindings'][i] != baseline['bindings'][i]]
                        for label, p in packets.items()}
    result = {'counts': dict(counts), 'checks': checks, 'strict_passed': sum(r['strict'] for r in checks),
              'grid_head_or_next_difference_from_original0': grid_differences,
              'other_fourteen_logical_input_buffers_equal': True,
              'common_grid_is_diagnostic_control_only': True, 'old_two_strict_buffer_failures_reclassified': False,
              'production_changed': False, 'whole_solver_complete': False}
    output = phase / 'independent-cpu-audit.json'
    assert not output.exists()
    output.write_text(json.dumps(result, indent=2) + '\n')
    print('Complete outputs strict', result['strict_passed'], '/180', json.dumps(dict(counts)), flush=True)


if __name__ == '__main__':
    (audit if '--audit' in sys.argv else replay)()
