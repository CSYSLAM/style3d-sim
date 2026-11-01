"""Replay real post-frame G1 matrix inputs on the fixed SDK runtime, its PTX and independent source PTX."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k
from .demo_source_ab import ROOT
from .g1_last_matrix_capture import TOKEN
from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
from .host_particles_ab import native_source
from .library_entries import entries
from .pcg_alias_replay import span_groups
from .pcg_same_buffer_probe import Dim3


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    capture, output = args.capture.resolve(strict=True), args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    assert json.loads((capture / 'status.json').read_text())['complete']
    plan = json.loads((capture / 'plan.json').read_text())
    build_file = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build_bytes = build_file.read_bytes()
    build = json.loads(build_bytes)
    for name, digest in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    launch = runtime.cudaLaunchKernel
    launch.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    launch.restype = ct.c_int
    source_core = native_source()
    assert hashlib.sha256(Path(source_core.__file__).read_bytes()).hexdigest() == build['extension_sha256']
    source = source_core._KernelDriver()
    original = {}
    files = {}
    for path in (ROOT / 'build/reconstruction-ptx' / REFERENCE_SHA[:16]).glob('*.ptx'):
        text = path.read_text()
        for name in entries(text):
            if TOKEN in name:
                assert name not in original
                original[name] = text
                files[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    assert len(original) == 1
    name = next(iter(original))
    functions = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                 'original-ptx': driver.function(original[name], name),
                 'source-ptx': ct.c_void_p(source.function(name))}
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows = []
    try:
        for side in ('original', 'source'):
            folder = capture / side
            provenance = json.loads((folder / 'provenance.json').read_text())
            assert provenance['complete'] and provenance['frames_read'] == 60
            layout = json.loads((folder / 'readback-layout.json').read_text())
            node = layout['matrix']
            assert node['name'] == name and layout['post_frame_inputs_and_outputs_not_overwritten_by_tail']
            paths = sorted((folder / 'packets').glob('frame-*.npz'))
            assert len(paths) == 60
            for ordinal, path in enumerate(paths):
                assert build_file.read_bytes() == build_bytes
                files[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
                with np.load(path) as packet:
                    raw = [packet['parameter-' + str(index)].tobytes()
                           for index in range(len(node['parameter_widths']))]
                    assert [len(value) for value in raw] == build['kernels'][name]['parameters']
                    assert [value.hex() for value in raw] == node['parameter_hex']
                    values = [int.from_bytes(value, 'little') for value in raw]
                    n, maximum, local = values[10], values[2], values[11]
                    assert n == local == values[8] == 176 and not values[7] and maximum > 0
                    bindings = {int(index): packet['post-frame-arg-' + str(index)].tobytes()
                                for index in layout['sizes']}
                    expected = {index: bindings[index] for index in (6, 9)}
                    # Output pre-call bytes were not observed. Both test seeds are explicit controlled inputs.
                    bindings[6] = bytes([127]) * len(bindings[6])
                    bindings[9] = bytes(len(bindings[9]))
                    groups = span_groups(values, bindings)
                    pointers, span_report = {}, []
                    for group in groups:
                        padding = group['start'] % 256
                        initial = np.zeros(padding + len(group['initial']), dtype='u1')
                        initial[padding:] = group['initial']
                        pointer = driver.upload(initial)
                        assert pointer.value % 256 == 0
                        group.update(device=pointer, upload=initial, padding=padding)
                        unchanged = np.ones(len(initial), dtype=bool)
                        for index in group['indices']:
                            offset = padding + values[index] - group['start']
                            pointers[index] = pointer.value + offset
                            assert pointers[index] % 256 == values[index] % 256
                            if index in expected:
                                unchanged[offset:offset + len(bindings[index])] = False
                        group['unchanged'] = unchanged
                        span_report.append({'indices': group['indices'], 'bytes': len(group['initial']),
                                            'original_start_mod256': padding,
                                            'offsets': {str(i): values[i] - group['start'] for i in group['indices']}})
                    parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
                        pointers[index].to_bytes(8, 'little') if index in pointers else value)
                        for index, value in enumerate(raw)]
                    holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(value), ct.c_void_p)
                                                               for value in parameters])
                    grid, block, shared = node['geometry'][:3], node['geometry'][3:6], node['geometry'][6]
                    checks, arrays = [], {}
                    backends = list(functions)
                    rotation = len(rows) % len(backends)
                    backends = backends[rotation:] + backends[:rotation]
                    for seed in plan['controlled_Ap_initial_bytes']:
                        for backend in backends:
                            for group in groups:
                                initial = group['upload'].copy()
                                for index in group['indices']:
                                    if index in expected:
                                        offset = group['padding'] + values[index] - group['start']
                                        initial[offset:offset + len(bindings[index])] = seed if index == 6 else 0
                                driver.check(driver.cu.cuMemcpyHtoD_v2(group['device'],
                                             ct.c_void_p(initial.ctypes.data), initial.nbytes))
                            function = functions[backend]
                            if backend == 'original-runtime':
                                assert launch(function, Dim3(*grid), Dim3(*block), holders, shared, stream) == 0
                            else:
                                driver.check(driver.cu.cuLaunchKernel(function, *grid, *block, shared, stream, holders, None))
                            driver.check(driver.cu.cuStreamSynchronize(stream))
                            actual = {index: driver.download(ct.c_uint64(pointers[index]),
                                      np.frombuffer(bindings[index], dtype='u1')) for index in expected}
                            untouched = True
                            for group in groups:
                                value = driver.download(group['device'], group['upload'])
                                mask = group['unchanged']
                                untouched &= bool(np.all(value[mask] == group['upload'][mask]))
                            tag = backend + '-seed-' + str(seed)
                            arrays[tag + '-ap'], arrays[tag + '-denominator'] = actual[6], actual[9]
                            checks.append({'backend': backend, 'controlled_Ap_seed_byte': seed,
                                           'pointwise_equal': actual[6].tobytes() == expected[6],
                                           'pointwise_sha256': hashlib.sha256(actual[6].tobytes()).hexdigest(),
                                           'captured_aggregate_equal': actual[9].tobytes() == expected[9],
                                           'aggregate_bits': actual[9].view('<u4').tolist(),
                                           'unwritten_bytes_unchanged': untouched})
                    np.savez_compressed(output / (side + '-' + path.name), **arrays)
                    rows.append({'side': side, 'frame': ordinal, 'spans': span_report, 'checks': checks,
                                 'captured_aggregate_bits': np.frombuffer(expected[9], dtype='<u4').tolist()})
                    driver.free()
                    if ordinal % 10 == 0:
                        print(side, 'replayed final matrix frame', ordinal, flush=True)
        report = {'source_sha256': build['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
                  'packets': rows, 'input_sha256': files, 'overlaps_and_mod256_alignment_preserved': True,
                  'pointwise_checks': sum(len(row['checks']) for row in rows),
                  'all_pointwise_equal': all(check['pointwise_equal'] for row in rows for check in row['checks']),
                  'all_unwritten_bytes_unchanged': all(check['unwritten_bytes_unchanged']
                                                      for row in rows for check in row['checks']),
                  'actual_pre_call_output_bytes_captured': False, 'denominator_seed_is_controlled_zero': True,
                  'aggregate_match_is_observation_not_full_atomic_certificate': True,
                  'diagnostic_intentionally_maps_original': True, 'production_changed': False,
                  'frozen_source_failure_reclassified': False, 'whole_solver_complete': False,
                  'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        assert report['pointwise_checks'] == plan['expected_replay_pointwise_checks']
        assert report['all_pointwise_equal'] and report['all_unwritten_bytes_unchanged']
        print('Final-matrix pointwise replay checks:', report['pointwise_checks'], 'all strict', flush=True)
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    main()
