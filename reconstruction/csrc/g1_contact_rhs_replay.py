"""Replay both G1 contact output branches using authentic before bytes and complete output evidence."""
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
from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
from .host_particles_ab import native_source
from .library_entries import entries
from .pcg_alias_replay import span_groups
from .pcg_same_buffer_probe import Dim3
from .surface_atomic_operands import instrument


LANES, TRACE_RECORDS = 1024, 256


def instrument256(module, symbol):
    changed, sites = instrument(module, symbol)
    anchor = 'mul.wide.u32 %audit_lane_offset, %audit_lane, 2048;'
    assert changed.count(anchor) == sites
    changed = changed.replace(anchor, 'mul.wide.u32 %audit_lane_offset, %audit_lane, 4096;')
    assert not re.search(r'\b(?:red|atom)\.global\.add\.f32\b', changed) is None
    return changed, sites


def kernel_texts(build, name):
    original = next(path for path in (ROOT / 'build/reconstruction-ptx' / REFERENCE_SHA[:16]).glob('*.ptx')
                    if name in entries(path.read_text()))
    header = (ROOT / 'build/reconstruction-csrc/host-particles/source_ptx_bundle.h').read_text()
    modules = re.findall(r'\{"([^"]+)", R"([^\s(]+)\((.*?)\)\2"\}', header, re.S)
    return {'original': original.read_text(), 'source': modules[build['kernels'][name]['module']][2]}, original


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
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    runtime_launch = runtime.cudaLaunchKernel
    runtime_launch.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    runtime_launch.restype = ct.c_int
    core = native_source()
    assert hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest() == build['extension_sha256']
    source = core._KernelDriver()
    functions, probes, files, static_sites = {}, {}, {}, {}
    for key in ('force', 'matrix'):
        name = plan['kernels'][key]
        texts, original = kernel_texts(build, name)
        files[str(original)] = hashlib.sha256(original.read_bytes()).hexdigest()
        functions[key] = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                          'original-ptx': driver.function(texts['original'], name),
                          'source-ptx': ct.c_void_p(source.function(name))}
        probes[key], static_sites[key] = {}, {}
        for side, text in texts.items():
            changed, sites = instrument256(text, name)
            (output / (key + '-' + side + '-instrumented.ptx')).write_text(changed)
            static_sites[key][side] = sites
            probes[key][side] = driver.function(changed, name)
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows = []
    try:
        for side in ('original', 'source'):
            folder = capture / side
            layout = json.loads((folder / 'snapshot-layout.json').read_text())
            for stage in layout['stages']:
                key, node, outputs = stage['key'], stage['node'], stage['outputs']
                name = node['name']
                assert name == plan['kernels'][key] and node['geometry'] == [4, 1, 1, 256, 1, 1, 0]
                paths = sorted((folder / (key + '-packets')).glob('frame-*.npz'))
                assert len(paths) == 60
                for frame, path in enumerate(paths):
                    assert build_file.read_bytes() == build_bytes
                    files[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
                    with np.load(path) as packet:
                        raw = [packet['parameter-' + str(i)].tobytes() for i in range(len(node['parameter_hex']))]
                        assert [value.hex() for value in raw] == node['parameter_hex']
                        assert [len(value) for value in raw] == build['kernels'][name]['parameters']
                        values = [int.from_bytes(value, 'little') for value in raw]
                        bindings = {int(i): packet['before-arg-' + str(i)].tobytes() for i in stage['sizes']}
                        expected = {i: packet['after-arg-' + str(i)].tobytes() for i in outputs}
                        count = int.from_bytes(bindings[0], 'little', signed=True)
                        active = min(max(count, 0), values[1])
                        assert values[1] == 1000 and set(outputs) == ({32, 33} if key == 'force' else {33, 34})
                        assert key != 'matrix' or values[29] == values[30] == 0
                        for a in outputs:
                            assert len(expected[a]) == len(bindings[a])
                            for b in bindings:
                                if b not in outputs:
                                    assert min(values[a] + len(bindings[a]), values[b] + len(bindings[b])) <= max(
                                        values[a], values[b]), 'Output overlaps a read-only input'
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
                            for i in group['indices']:
                                offset = padding + values[i] - group['start']
                                pointers[i] = device.value + offset
                                assert pointers[i] % 256 == values[i] % 256
                                if i in outputs:
                                    mask[offset:offset + len(bindings[i])] = False
                            group['unwritten'] = mask
                            spans.append({'indices': group['indices'], 'bytes': len(group['initial']),
                                          'original_start_mod256': padding,
                                          'offsets': {str(i): values[i] - group['start'] for i in group['indices']}})
                        parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
                            pointers[i].to_bytes(8, 'little') if i in pointers else value) for i, value in enumerate(raw)]
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
                                code = runtime_launch(function, Dim3(4, 1, 1), Dim3(256, 1, 1), holders, 0, stream)
                                assert code == 0, code
                            else:
                                driver.check(driver.cu.cuLaunchKernel(function, 4, 1, 1, 256, 1, 1,
                                                                     0, stream, holders, None))
                            driver.check(driver.cu.cuStreamSynchronize(stream))
                            output_checks = {}
                            for i, expected_bytes in expected.items():
                                value = driver.download(ct.c_uint64(pointers[i]), np.zeros(len(expected_bytes), dtype='u1'))
                                arrays[tag + '-output-' + str(i)] = value
                                output_checks[str(i)] = value.tobytes() == expected_bytes
                            untouched = True
                            for i, group in enumerate(groups):
                                after = driver.download(group['device'], group['upload'])
                                arrays[tag + '-group-' + str(i)] = after
                                mask = group['unwritten']
                                untouched &= bool(np.all(after[mask] == group['upload'][mask]))
                            checks.append({'backend': tag, 'captured_output_equal': output_checks,
                                           'all_outputs_equal': all(output_checks.values()),
                                           'unwritten_bytes_unchanged': untouched})

                        order = list(functions[key])
                        rotation = len(rows) % 3
                        for backend in order[rotation:] + order[:rotation]:
                            run(backend, functions[key][backend], is_runtime=backend == 'original-runtime')
                        trace_zero = np.zeros((LANES, TRACE_RECORDS, 16), dtype='u1')
                        count_zero = np.zeros(LANES, dtype='u4')
                        trace, counts = driver.upload(trace_zero), driver.upload(count_zero)
                        operands, sequences, total_atoms = {}, {}, {}
                        for backend in ('original', 'source'):
                            for pointer, value in ((trace, trace_zero), (counts, count_zero)):
                                driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(value.ctypes.data), value.nbytes))
                            run(backend + '-probe', probes[key][backend], (trace, counts))
                            actual_counts = driver.download(counts, count_zero)
                            data = driver.download(trace, trace_zero)
                            assert actual_counts.max() <= (64 if key == 'force' else 144)
                            assert not actual_counts[active:].any()
                            valid = np.concatenate([data[lane, :size] for lane, size in enumerate(actual_counts)])
                            arrays[backend + '-counts'], arrays[backend + '-records'] = actual_counts, valid
                            offset, lanes, thread_sequences = 0, [], []
                            for size in actual_counts:
                                by_target, sequence = defaultdict(list), []
                                for record in valid[offset:offset + size]:
                                    address = int.from_bytes(record[:8].tobytes(), 'little')
                                    targets = [(i, (address - pointers[i]) // 4) for i in outputs
                                               if pointers[i] <= address < pointers[i] + len(expected[i])]
                                    assert targets and all((address - pointers[i]) % 4 == 0 for i, _ in targets)
                                    target = min(targets)
                                    value = int.from_bytes(record[8:12].tobytes(), 'little')
                                    by_target[target].append(value)
                                    sequence.append((target, value))
                                lanes.append(dict(by_target))
                                thread_sequences.append(sequence)
                                offset += int(size)
                            assert offset == len(valid)
                            operands[backend], sequences[backend], total_atoms[backend] = lanes, thread_sequences, offset
                        differences = [lane for lane, (a, b) in enumerate(zip(operands['original'], operands['source']))
                                       if a != b]
                        sequence_differences = [lane for lane, (a, b) in enumerate(zip(sequences['original'],
                                                                                     sequences['source'])) if a != b]
                        filename = key + '-' + side + '-frame-' + str(frame).zfill(2) + '.npz'
                        np.savez_compressed(output / filename, **arrays)
                        rows.append({'stage': key, 'side': side, 'frame': frame, 'spans': spans, 'checks': checks,
                                     'reported_contact_count': count, 'active_contacts': active,
                                     'actual_output_replay_addresses': {str(i): pointers[i] for i in outputs},
                                     'all_per_thread_per_target_operand_sequences_equal': not differences,
                                     'all_complete_thread_sequences_equal': not sequence_differences,
                                     'operand_differing_lanes': differences,
                                     'complete_sequence_differing_lanes': sequence_differences,
                                     'atomic_operands': total_atoms,
                                     'capture_effective_scalars': {str(i): int(np.count_nonzero(
                                         np.frombuffer(expected[i], dtype='<u4') != np.frombuffer(bindings[i], dtype='<u4')))
                                         for i in outputs}})
                        driver.free()
                    if frame % 10 == 0:
                        print(key, side, 'replayed complete two-output packet', frame, flush=True)
        report = {'packets': rows, 'input_sha256': files, 'packet_count': len(rows), 'static_atomic_sites': static_sites,
                  'source_sha256': build['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
                  'all_per_thread_per_target_operand_sequences_equal': all(
                      row['all_per_thread_per_target_operand_sequences_equal'] for row in rows),
                  'all_complete_thread_sequences_equal': all(row['all_complete_thread_sequences_equal'] for row in rows),
                  'all_unwritten_bytes_unchanged': all(check['unwritten_bytes_unchanged']
                                                      for row in rows for check in row['checks']),
                  'full_unwritten_after_buffers_saved': True, 'actual_pre_call_accumulator_captured': True,
                  'production_changed': False, 'frozen_failure_reclassified': False, 'whole_solver_complete': False,
                  'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        assert len(rows) == 240 and report['all_unwritten_bytes_unchanged']
        print('All240 two-output packets saved; operand/strict differences remain explicit in report.', flush=True)
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    main()
