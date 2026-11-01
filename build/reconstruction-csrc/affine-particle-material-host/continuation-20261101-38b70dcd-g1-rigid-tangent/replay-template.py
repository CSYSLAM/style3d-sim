"""Replay authentic G1 rigid-tangent packets on SDK/PTX/source and record real per-thread atomic operands."""
import argparse
from collections import defaultdict
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re

import numpy as np

from reconstruction import kernel_ab as k
from .demo_source_ab import ROOT
from .g1_rigid_tangent_capture import TOKEN
from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
from .host_particles_ab import native_source
from .library_entries import entries
from .pcg_alias_replay import span_groups
from .pcg_same_buffer_probe import Dim3
from .surface_atomic_operands import instrument


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    capture, output = args.capture.resolve(strict=True), args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    assert json.loads((capture / 'status.json').read_text())['complete']
    plan = json.loads((capture / 'plan.json').read_text())
    for path, digest in plan['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest, path
    build_file = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build_bytes = build_file.read_bytes()
    build = json.loads(build_bytes)
    name = plan['kernel']
    assert TOKEN in name
    original_path = next(path for path in (ROOT / 'build/reconstruction-ptx' / REFERENCE_SHA[:16]).glob('*.ptx')
                         if name in entries(path.read_text()))
    header = (build_file.parent / 'source_ptx_bundle.h').read_text()
    modules = re.findall(r'\{"([^"]+)", R"([^\s(]+)\((.*?)\)\2"\}', header, re.S)
    texts = {'original': original_path.read_text(), 'source': modules[build['kernels'][name]['module']][2]}
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    runtime_launch = runtime.cudaLaunchKernel
    runtime_launch.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    runtime_launch.restype = ct.c_int
    core = native_source()
    assert hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest() == build['extension_sha256']
    source = core._KernelDriver()
    functions = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                 'original-ptx': driver.function(texts['original'], name),
                 'source-ptx': ct.c_void_p(source.function(name))}
    probes = {}
    for side, text in texts.items():
        changed, sites = instrument(text, name)
        assert sites == 75
        (output / (side + '-instrumented.ptx')).write_text(changed)
        probes[side] = driver.function(changed, name)
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows, files = [], {str(original_path): hashlib.sha256(original_path.read_bytes()).hexdigest()}
    try:
        for side in ('original', 'source'):
            folder = capture / side
            layout = json.loads((folder / 'snapshot-layout.json').read_text())
            node = layout['node']
            assert node['name'] == name and node['geometry'] == [4, 1, 1, 256, 1, 1, 0]
            paths = sorted((folder / 'packets').glob('frame-*.npz'))
            assert len(paths) == 60
            for frame, path in enumerate(paths):
                assert build_file.read_bytes() == build_bytes
                files[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
                with np.load(path) as packet:
                    raw = [packet['parameter-' + str(index)].tobytes() for index in range(35)]
                    assert [value.hex() for value in raw] == node['parameter_hex']
                    assert [len(value) for value in raw] == build['kernels'][name]['parameters']
                    values = [int.from_bytes(value, 'little') for value in raw]
                    bindings = {int(index): packet['before-arg-' + str(index)].tobytes() for index in layout['sizes']}
                    expected = packet['after-arg-30'].tobytes()
                    contact_count = int.from_bytes(bindings[0], 'little', signed=True)
                    active = min(max(contact_count, 0), values[1])
                    assert values[1] == 1000 and values[33] == values[34] == 0
                    for index, data in bindings.items():
                        if index != 30:
                            assert min(values[30] + len(expected), values[index] + len(data)) <= max(
                                values[30], values[index]), 'Output aliases a read input'
                    groups = span_groups(values, bindings)
                    pointers, spans = {}, []
                    for group in groups:
                        padding = group['start'] % 256
                        initial = np.zeros(padding + len(group['initial']), dtype='u1')
                        initial[padding:] = group['initial']
                        device = driver.upload(initial)
                        assert device.value % 256 == 0
                        group.update(device=device, upload=initial, padding=padding)
                        mask = np.ones(len(initial), dtype=bool)
                        for index in group['indices']:
                            offset = padding + values[index] - group['start']
                            pointers[index] = device.value + offset
                            assert pointers[index] % 256 == values[index] % 256
                            if index == 30:
                                mask[offset:offset + len(bindings[index])] = False
                        group['unwritten'] = mask
                        spans.append({'indices': group['indices'], 'bytes': len(group['initial']),
                                      'original_start_mod256': padding,
                                      'offsets': {str(index): values[index] - group['start'] for index in group['indices']}})
                    parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
                        pointers[index].to_bytes(8, 'little') if index in pointers else value)
                        for index, value in enumerate(raw)]
                    arrays, checks = {}, []

                    def run(tag, function, extra=(), is_runtime=False):
                        for group in groups:
                            value = group['upload']
                            driver.check(driver.cu.cuMemcpyHtoD_v2(group['device'],
                                         ct.c_void_p(value.ctypes.data), value.nbytes))
                        arguments = [*parameters, *extra]
                        holders = (ct.c_void_p * len(arguments))(*[ct.cast(ct.byref(value), ct.c_void_p)
                                                                   for value in arguments])
                        if is_runtime:
                            assert runtime_launch(function, Dim3(4, 1, 1), Dim3(256, 1, 1), holders, 0, stream) == 0
                        else:
                            driver.check(driver.cu.cuLaunchKernel(function, 4, 1, 1, 256, 1, 1, 0, stream, holders, None))
                        driver.check(driver.cu.cuStreamSynchronize(stream))
                        result = driver.download(ct.c_uint64(pointers[30]), np.zeros(len(expected), dtype='u1'))
                        arrays[tag + '-output'] = result
                        untouched = True
                        for index, group in enumerate(groups):
                            after = driver.download(group['device'], group['upload'])
                            arrays[tag + '-group-' + str(index)] = after
                            mask = group['unwritten']
                            untouched &= bool(np.all(after[mask] == group['upload'][mask]))
                        checks.append({'backend': tag, 'captured_output_equal': result.tobytes() == expected,
                                       'unwritten_bytes_unchanged': untouched,
                                       'output_sha256': hashlib.sha256(result.tobytes()).hexdigest()})

                    order = list(functions)
                    rotation = len(rows) % 3
                    for backend in order[rotation:] + order[:rotation]:
                        run(backend, functions[backend], is_runtime=backend == 'original-runtime')
                    trace_zero, count_zero = np.zeros((1024, 128, 16), dtype='u1'), np.zeros(1024, dtype='u4')
                    trace, counts = driver.upload(trace_zero), driver.upload(count_zero)
                    operands = {}
                    for backend in ('original', 'source'):
                        for pointer, value in ((trace, trace_zero), (counts, count_zero)):
                            driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(value.ctypes.data), value.nbytes))
                        run(backend + '-probe', probes[backend], (trace, counts))
                        actual_counts = driver.download(counts, count_zero)
                        data = driver.download(trace, trace_zero)
                        assert actual_counts.max() <= 128 and not actual_counts[active:].any()
                        valid = np.concatenate([data[lane, :size] for lane, size in enumerate(actual_counts)])
                        arrays[backend + '-counts'], arrays[backend + '-records'] = actual_counts, valid
                        offset, lanes = 0, []
                        for lane, size in enumerate(actual_counts):
                            by_target = defaultdict(list)
                            for record in valid[offset:offset + size]:
                                address = int.from_bytes(record[:8].tobytes(), 'little')
                                assert pointers[30] <= address < pointers[30] + len(expected)
                                assert (address - pointers[30]) % 4 == 0
                                target = (address - pointers[30]) // 4
                                by_target[target].append(int.from_bytes(record[8:12].tobytes(), 'little'))
                            lanes.append(dict(by_target))
                            offset += int(size)
                        assert offset == len(valid)
                        operands[backend] = lanes
                    differences = [{'lane': lane, 'original': left, 'source': right}
                                   for lane, (left, right) in enumerate(zip(operands['original'], operands['source']))
                                   if left != right]
                    np.savez_compressed(output / (side + '-frame-' + str(frame).zfill(2) + '.npz'), **arrays)
                    rows.append({'side': side, 'frame': frame, 'spans': spans, 'checks': checks,
                                 'reported_contact_count': contact_count, 'active_contacts': active,
                                 'actual_output_replay_address': pointers[30],
                                 'all_per_thread_per_target_operand_sequences_equal': not differences,
                                 'operand_difference_examples': differences[:16],
                                 'atomic_operands': sum(map(lambda row: sum(map(len, row.values())), operands['original'])),
                                 'capture_effective_scalars': int(np.count_nonzero(
                                     np.frombuffer(expected, dtype='<u4') != np.frombuffer(bindings[30], dtype='<u4')))})
                    driver.free()
                    if frame % 10 == 0:
                        print(side, 'replayed and recorded rigid tangent frame', frame, flush=True)
        report = {'packets': rows, 'input_sha256': files, 'packet_count': len(rows),
                  'source_sha256': build['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
                  'all_per_thread_per_target_operand_sequences_equal': all(
                      row['all_per_thread_per_target_operand_sequences_equal'] for row in rows),
                  'all_unwritten_bytes_unchanged': all(check['unwritten_bytes_unchanged']
                                                      for row in rows for check in row['checks']),
                  'full_unwritten_after_buffers_saved': True, 'actual_pre_call_accumulator_captured': True,
                  'production_changed': False, 'frozen_failure_reclassified': False, 'whole_solver_complete': False,
                  'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        assert report['packet_count'] == 120
        assert report['all_per_thread_per_target_operand_sequences_equal'] and report['all_unwritten_bytes_unchanged']
        print('Rigid tangent real per-thread/target operands equal for all120 packets', flush=True)
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    main()
