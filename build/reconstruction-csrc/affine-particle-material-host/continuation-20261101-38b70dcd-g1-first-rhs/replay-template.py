"""Replay real G1 checkpoint substeps on SDK/PTX/source and independently audit full buffers and actual ABI."""
import argparse
from collections import Counter
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from .demo_source_ab import ROOT
from .pcg_alias_replay import span_groups


BACKENDS = ('original-runtime', 'original-ptx', 'source-ptx')


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def inputs(phase):
    plan = json.loads((phase / 'plan.json').read_text())
    for name, expected in plan['input_sha256'].items():
        assert sha(Path(name)) == expected, name
    status = json.loads((phase / 'run.status.json').read_text())
    assert status['complete'] and status['running'] is None
    assert [row['label'] for row in status['completed']] == [row['label'] for row in plan['runs']]
    return plan


def packets(phase, plan):
    for run in plan['runs']:
        folder = phase / run['label'] / 'trace'
        layout = json.loads((folder / 'snapshot-layout.json').read_text())
        assert len(layout['stages']) == 3
        for stage in layout['stages']:
            path = folder / (stage['key'] + '-packets/frame-00.npz')
            with np.load(path, allow_pickle=False) as packet:
                node = stage['node']
                raw = [packet['parameter-' + str(i)].tobytes() for i in range(len(node['parameter_hex']))]
                assert [value.hex() for value in raw] == node['parameter_hex']
                values = [int.from_bytes(value, 'little') for value in raw]
                bindings = {int(i): packet['before-arg-' + str(i)].tobytes() for i in stage['sizes']}
                expected = {i: packet['after-arg-' + str(i)].tobytes() for i in stage['outputs']}
            yield run['label'], stage, path, raw, values, bindings, expected


def replay(phase):
    from reconstruction import kernel_ab as k
    from .g1_contact_rhs_replay import kernel_texts
    from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
    from .host_particles_ab import native_source
    from .pcg_same_buffer_probe import Dim3

    plan = inputs(phase)
    output = phase / 'replay'
    output.mkdir(exist_ok=False)
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    frozen_build = build_path.read_bytes()
    build = json.loads(frozen_build)
    driver = k.Driver()
    assert sha(REFERENCE) == REFERENCE_SHA
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    launch_runtime = runtime.cudaLaunchKernel
    launch_runtime.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    launch_runtime.restype = ct.c_int
    source_module = native_source()
    assert sha(Path(source_module.__file__)) == build['extension_sha256']
    source = source_module._KernelDriver()
    functions = {}
    for kind, name in plan['kernels'].items():
        texts, _ = kernel_texts(build, name)
        functions[kind] = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                           'original-ptx': driver.function(texts['original'], name),
                           'source-ptx': ct.c_void_p(source.function(name))}
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows, complete = [], False
    try:
        for label, stage, path, raw, values, bindings, expected in packets(phase, plan):
            assert build_path.read_bytes() == frozen_build
            groups = span_groups(values, bindings)
            pointers, metadata, arrays = {}, [], {}
            try:
                for index, group in enumerate(groups):
                    padding, size = 256 + group['start'] % 256, len(group['initial'])
                    initial = np.full(padding + size + 256, 211, dtype='u1')
                    initial[padding:padding + size] = group['initial']
                    device = driver.upload(initial)
                    assert device.value % 256 == 0
                    group.update(device=device, upload=initial, padding=padding)
                    mask = np.ones(len(initial), dtype=bool)
                    for i in group['indices']:
                        offset = padding + values[i] - group['start']
                        pointers[i] = device.value + offset
                        assert pointers[i] % 256 == values[i] % 256
                        if i in expected:
                            mask[offset:offset + len(bindings[i])] = False
                    group['unwritten'] = mask
                    metadata.append({'indices': group['indices'], 'start': group['start'], 'end': group['end'],
                                     'padding': padding, 'device_base': device.value})
                parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
                    pointers[i].to_bytes(8, 'little') if i in pointers else value) for i, value in enumerate(raw)]
                for i, value in enumerate(parameters):
                    arrays['actual-parameter-' + str(i)] = np.frombuffer(bytes(value), dtype='u1').copy()
                holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(value), ct.c_void_p)
                                                         for value in parameters])
                checks = []
                rotation = len(rows) % 3
                for backend in BACKENDS[rotation:] + BACKENDS[:rotation]:
                    for group in groups:
                        value = group['upload']
                        driver.check(driver.cu.cuMemcpyHtoD_v2(group['device'],
                                     ct.c_void_p(value.ctypes.data), value.nbytes))
                    function = functions[stage['kernel_key']][backend]
                    if backend == 'original-runtime':
                        assert launch_runtime(function, Dim3(1, 1, 1), Dim3(256, 1, 1), holders, 0, stream) == 0
                    else:
                        driver.check(driver.cu.cuLaunchKernel(function, 1, 1, 1, 256, 1, 1, 0, stream, holders, None))
                    driver.check(driver.cu.cuStreamSynchronize(stream))
                    for index, group in enumerate(groups):
                        after = driver.download(group['device'], group['upload'])
                        arrays[backend + '-group-' + str(index)] = after
                        assert np.array_equal(after[group['unwritten']], group['upload'][group['unwritten']])
                    equal = {}
                    for i, wanted in expected.items():
                        actual = driver.download(ct.c_uint64(pointers[i]), np.zeros(len(wanted), dtype='u1'))
                        arrays[backend + '-output-' + str(i)] = actual
                        equal[str(i)] = actual.tobytes() == wanted
                    checks.append({'backend': backend, 'captured_output_equal': equal,
                                   'unwritten_bytes_unchanged': True})
                target = output / (label + '-' + stage['key'] + '.npz')
                np.savez_compressed(target, **arrays)
                rows.append({'label': label, 'stage': stage['key'], 'kernel_key': stage['kernel_key'],
                             'capture_sha256': sha(path), 'output_sha256': sha(target),
                             'groups': metadata, 'checks': checks})
                if len(rows) % 3 == 0:
                    print('Replayed', label, 'all3 real first-force calls', flush=True)
            finally:
                for group in groups:
                    if 'device' in group:
                        driver.check(driver.cu.cuMemFree_v2(group['device']))
        assert len(rows) == 6
        complete = True
    finally:
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
        (phase / 'replay-report.json').write_text(json.dumps({
            'rows': rows, 'complete': complete, 'actual_calls': 3 * len(rows),
            'runner_sha256': sha(Path(__file__)), 'strict_failures_retained': True,
            'production_changed': False, 'old_C8_reclassified': False, 'whole_solver_complete': False,
        }, indent=2) + '\n')


def audit(phase):
    plan = inputs(phase)
    report = json.loads((phase / 'replay-report.json').read_text())
    assert report['complete'] and report['actual_calls'] == 18
    assert report['runner_sha256'] == sha(Path(__file__))
    output = phase / 'replay-independent-cpu-audit.json'
    assert not output.exists()
    counts, strict, totals = Counter(), Counter(), Counter()
    hashes = {}
    for source, row in zip(packets(phase, plan), report['rows'], strict=True):
        label, stage, path, raw, values, bindings, expected = source
        assert (row['label'], row['stage'], row['kernel_key']) == (label, stage['key'], stage['kernel_key'])
        assert sha(path) == row['capture_sha256']
        target = phase / 'replay' / (label + '-' + stage['key'] + '.npz')
        assert sha(target) == row['output_sha256']
        hashes[str(path)], hashes[str(target)] = sha(path), sha(target)
        groups = span_groups(values, bindings)
        assert len(groups) == len(row['groups'])
        with np.load(target, allow_pickle=False) as packet:
            actual = {i: packet['actual-parameter-' + str(i)].tobytes() for i in range(len(raw))}
            expected_fields = set()
            for index, (group, saved) in enumerate(zip(groups, row['groups'], strict=True)):
                assert {k: group[k] for k in ('indices', 'start', 'end')} == {
                    k: saved[k] for k in ('indices', 'start', 'end')}
                padding = 256 + group['start'] % 256
                assert saved['padding'] == padding and saved['device_base'] % 256 == 0
                initial = np.full(padding + len(group['initial']) + 256, 211, dtype='u1')
                initial[padding:padding + len(group['initial'])] = group['initial']
                mask = np.ones(len(initial), dtype=bool)
                for i in group['indices']:
                    offset = padding + values[i] - group['start']
                    pointer = int.from_bytes(actual[i], 'little')
                    assert len(actual[i]) == 8 and pointer == saved['device_base'] + offset
                    assert pointer % 256 == values[i] % 256
                    expected_fields.add(i)
                    if i in expected:
                        mask[offset:offset + len(expected[i])] = False
                for backend in BACKENDS:
                    after = packet[backend + '-group-' + str(index)]
                    assert after.dtype == np.dtype('u1') and after.shape == initial.shape
                    assert np.array_equal(after[mask], initial[mask])
                    counts['full_after_bytes'] += after.nbytes
                    counts['unwritten_input_and_guard_bytes'] += int(mask.sum())
                    for i in group['indices']:
                        if i in expected:
                            offset = padding + values[i] - group['start']
                            actual_output = packet[backend + '-output-' + str(i)]
                            assert actual_output.tobytes() == after[offset:offset + len(expected[i])].tobytes()
            assert expected_fields == set(bindings)
            for i, value in enumerate(raw):
                assert len(actual[i]) == len(value)
                if i not in bindings:
                    assert actual[i] == value
                    counts['scalar_bytes'] += len(value) * 3
                else:
                    counts['pointer_fields'] += 3
                counts['actual_ABI_bytes'] += len(actual[i]) * 3
            checks = {check['backend']: check for check in row['checks']}
            assert set(checks) == set(BACKENDS)
            for backend in BACKENDS:
                for i, wanted in expected.items():
                    value = packet[backend + '-output-' + str(i)].tobytes()
                    same = value == wanted
                    assert checks[backend]['captured_output_equal'][str(i)] == same
                    key = stage['kernel_key'] + ':' + backend + ':' + str(i)
                    strict[key] += same
                    totals[key] += 1
                    counts['complete_output_arrays'] += 1
                    counts['complete_output_words'] += len(wanted) // 4
        counts['packets'] += 1
        counts['actual_calls'] += 3
    assert counts['packets'] == 6 and counts['complete_output_arrays'] == 30
    result = {'counts': dict(counts), 'strict': dict(strict), 'total': dict(totals), 'input_sha256': hashes,
              'runner_sha256': sha(Path(__file__)), 'strict_failures_retained': True,
              'production_changed': False, 'old_C8_reclassified': False, 'whole_solver_complete': False}
    output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({'counts': dict(counts), 'strict': dict(strict), 'total': dict(totals)}, indent=2))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    parser.add_argument('--audit', action='store_true')
    args = parser.parse_args()
    (audit if args.audit else replay)(args.phase.resolve())


if __name__ == '__main__':
    main()
