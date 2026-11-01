"""Record literal atomic operands at the reproduced first joint AL difference, retaining full buffers and actual ABI."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k
from .demo_source_ab import ROOT
from .g1_contact_rhs_replay import kernel_texts
from .pcg_alias_replay import span_groups
from .ptx_atomic_literal_probe import instrument


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    args = parser.parse_args()
    phase = args.phase.resolve()
    plan = json.loads((phase / 'plan.json').read_text())
    for name, expected in plan['input_sha256'].items():
        assert sha(Path(name)) == expected, name
    output = phase / 'replay'
    output.mkdir(exist_ok=False)
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    frozen_build = build_path.read_bytes()
    build = json.loads(frozen_build)
    name = plan['kernels']['joint']
    texts, _ = kernel_texts(build, name)
    driver = k.Driver()
    functions, sites = {}, {}
    for side, text in texts.items():
        changed, sites[side] = instrument(text, name)
        (output / (side + '-instrumented.ptx')).write_text(changed)
        functions[side] = driver.function(changed, name)
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows, complete = [], False
    try:
        for side in ('original', 'source'):
            assert build_path.read_bytes() == frozen_build
            stage = json.loads((phase / side / 'snapshot-layout.json').read_text())['stages'][0]
            with np.load(phase / side / 'joint-packets/frame-00.npz', allow_pickle=False) as saved:
                raw = [saved['parameter-' + str(i)].tobytes() for i in range(15)]
                values = [int.from_bytes(value, 'little') for value in raw]
                bindings = {int(i): saved['before-arg-' + str(i)].tobytes() for i in stage['sizes']}
                expected = saved['after-arg-10'].tobytes()
            assert values[11:] == [86, 86, 86, 176] and not np.frombuffer(bindings[8], dtype='<f4').any()
            groups, pointers, metadata, arrays = span_groups(values, bindings), {}, [], {}
            for number, group in enumerate(groups):
                padding = 256 + group['start'] % 256
                initial = np.full(padding + len(group['initial']) + 256, 211, dtype='u1')
                initial[padding:padding + len(group['initial'])] = group['initial']
                device = driver.upload(initial)
                assert device.value % 256 == 0
                mask = np.ones(len(initial), dtype=bool)
                for i in group['indices']:
                    offset = padding + values[i] - group['start']
                    pointers[i] = device.value + offset
                    if i == 10:
                        mask[offset:offset + len(expected)] = False
                group.update(device=device, upload=initial, padding=padding, unwritten=mask)
                metadata.append({'indices': group['indices'], 'start': group['start'], 'end': group['end'],
                                 'padding': padding, 'device_base': device.value})
                arrays['initial-group-' + str(number)] = initial
            parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
                pointers[i].to_bytes(8, 'little') if i in pointers else value) for i, value in enumerate(raw)]
            trace_zero, count_zero = np.zeros((256, 128, 16), dtype='u1'), np.zeros(256, dtype='<u4')
            trace, counts = driver.upload(trace_zero), driver.upload(count_zero)
            for backend in ('original', 'source'):
                for group in groups:
                    value = group['upload']
                    driver.check(driver.cu.cuMemcpyHtoD_v2(group['device'], ct.c_void_p(value.ctypes.data), value.nbytes))
                for pointer, value in ((trace, trace_zero), (counts, count_zero)):
                    driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(value.ctypes.data), value.nbytes))
                arguments = [*parameters, trace, counts]
                for i, value in enumerate(arguments):
                    arrays[backend + '-actual-parameter-' + str(i)] = np.frombuffer(bytes(value), dtype='u1').copy()
                holders = (ct.c_void_p * len(arguments))(*[ct.cast(ct.byref(v), ct.c_void_p) for v in arguments])
                driver.check(driver.cu.cuLaunchKernel(functions[backend], 1, 1, 1, 256, 1, 1, 0, stream, holders, None))
                driver.check(driver.cu.cuStreamSynchronize(stream))
                sizes = driver.download(counts, count_zero)
                full_trace = driver.download(trace, trace_zero)
                assert sizes.max() <= 128 and not sizes[86:].any()
                records = np.concatenate([full_trace[lane, :size] for lane, size in enumerate(sizes)])
                arrays[backend + '-counts'], arrays[backend + '-records'] = sizes, records
                actual = driver.download(ct.c_uint64(pointers[10]), np.zeros(2112, dtype='u1'))
                arrays[backend + '-probe-output-10'] = actual
                for number, group in enumerate(groups):
                    after = driver.download(group['device'], group['upload'])
                    assert np.array_equal(after[group['unwritten']], group['upload'][group['unwritten']])
                    arrays[backend + '-group-' + str(number)] = after
            assert arrays['original-counts'].tobytes() == arrays['source-counts'].tobytes()
            assert arrays['original-records'][:, :12].tobytes() == arrays['source-records'][:, :12].tobytes()
            path = output / ('joint-' + side + '-frame-00.npz')
            np.savez_compressed(path, **arrays)
            rows.append({'stage': 'joint', 'side': side, 'frame': 0, 'groups': metadata,
                         'actual_output_replay_addresses': {'10': pointers[10]},
                         'actual_binding_replay_addresses': {str(i): p for i, p in pointers.items()},
                         'extra_parameter_addresses': [trace.value, counts.value],
                         'actual_operands': int(arrays['original-counts'].sum()),
                         'strict_probe_outputs_vs_capture': {
                             backend: arrays[backend + '-probe-output-10'].tobytes() == expected
                             for backend in ('original', 'source')},
                         'saved_sha256': sha(path)})
            driver.free()
            print(side, 'actual per-thread atomics', rows[-1]['actual_operands'], 'operand sequences equal', flush=True)
        complete = True
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
        (output / 'report.json').write_text(json.dumps({
            'packets': rows, 'complete': complete, 'all_per_thread_per_target_operand_sequences_equal': complete,
            'all_unwritten_bytes_unchanged': complete, 'static_atomic_sites': sites, 'actual_probe_calls': len(rows) * 2,
            'runner_sha256': sha(Path(__file__)), 'strict_failures_retained': True,
            'production_changed': False, 'frozen_failure_reclassified': False, 'whole_solver_complete': False,
        }, indent=2) + '\n')


if __name__ == '__main__':
    main()
