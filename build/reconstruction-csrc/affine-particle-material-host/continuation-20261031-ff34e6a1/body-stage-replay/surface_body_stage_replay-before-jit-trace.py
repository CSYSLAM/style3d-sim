"""Replay complete captured body stages on the same buffers with actual SDK, original PTX and source PTX."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re

import numpy as np

from reconstruction import kernel_ab as k
from .audit_cudahook import schemas
from .demo_source_ab import ROOT
from .host_api_probe import load_reference, REFERENCE, REFERENCE_SHA
from .host_particles_ab import native_source
from .library_entries import entries
from .pcg_same_buffer_probe import Dim3


OUTPUTS = {'32build_affine_body_preconditioner': (17, 18),
           '32apply_affine_body_preconditioner': (4,),
           '53multiply_affine_body_so3_augmented_lagrangian_tangent': (5,)}


def nodes(folder):
    probe = json.loads((folder / 'probe.json').read_text())
    selection = probe['selection']
    lines = (folder / 'launches.txt').read_text().splitlines()
    counts = {token: 0 for token in OUTPUTS}
    result = []
    for line in lines[selection['first_log_line']:selection['last_log_line_exclusive']]:
        parts = line.split()
        assert parts[-2].startswith('symbol:') and parts[-1].startswith('launch:')
        name = parts[-2].removeprefix('symbol:')
        matching = [token for token in OUTPUTS if token in name]
        if not matching:
            continue
        assert len(matching) == 1
        token = matching[0]
        index = counts[token]
        counts[token] += 1
        assert index < 15
        result.append({'token': token, 'ordinal': index, 'name': name, 'arguments': parts[5:-2],
                       'geometry': list(map(int, parts[-1].removeprefix('launch:').split(',')))[:7]})
    assert sorted(counts.values()) == [3, 15, 15], counts
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--original', type=Path, required=True)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--trials', type=int, default=8)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    layout = schemas()[0]
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    runtime.cudaLaunchKernel.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    runtime.cudaLaunchKernel.restype = ct.c_int
    source_image = native_source()
    source = source_image._KernelDriver()
    captures = {'original': args.original, 'source': args.source}
    packets = {tag: nodes(folder) for tag, folder in captures.items()}
    names = {node['name'] for group in packets.values() for node in group}
    functions, hashes = {}, {}
    for path in (ROOT / 'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx'):
        text = path.read_text()
        for name in names.intersection(entries(text)):
            functions[name] = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                               'original-ptx': driver.function(text, name),
                               'source-ptx': ct.c_void_p(source.function(name))}
            hashes[str(path.relative_to(ROOT))] = hashlib.sha256(path.read_bytes()).hexdigest()
    assert names == set(functions)
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    checks, arrays = [], {}
    try:
        for tag, group in packets.items():
            folder = captures[tag]
            for node in group:
                token, ordinal, name = node['token'], node['ordinal'], node['name']
                prefix = f'dump_{token}_call{ordinal:03d}'
                parameters, buffers, pointers, expected = [], {}, {}, {}
                for index, (kind, value) in enumerate(zip(layout[name], node['arguments'])):
                    if kind == 'pointer':
                        old_address = int(value.removeprefix('u:'), 16)
                        if not old_address:
                            assert not (folder / f'{prefix}_pre_arg{index}.bin').exists()
                            parameters.append(k.null())
                            continue
                        path = folder / f'{prefix}_pre_arg{index}.bin'
                        data = path.read_bytes()
                        hashes[str(path)] = hashlib.sha256(data).hexdigest()
                        array = np.frombuffer(data, dtype='u1').copy()
                        # Preserve pointer aliasing as well as input bytes when multiple arguments share storage.
                        if old_address in pointers:
                            pointer, previous = pointers[old_address]
                            assert previous.tobytes() == data
                        else:
                            pointer = driver.upload(array)
                            pointers[old_address] = pointer, array
                        parameters.append(pointer)
                        buffers[index] = pointer, array
                        if index in OUTPUTS[token]:
                            expected[index] = (folder / f'{prefix}_post_arg{index}.bin').read_bytes()
                    elif kind == 'C':
                        words = re.findall(r'(\d+):([0-9a-f]+)\(', value)
                        assert [int(offset) for offset, _ in words] == list(range(0, 160, 8))
                        payload = b''.join(int(bits, 16).to_bytes(8, 'little') for _, bits in words)
                        parameters.append(ct.create_string_buffer(payload, len(payload)))
                    elif kind == 'f':
                        parameters.append(ct.c_float(float(value.removeprefix('f:'))))
                    elif kind == 'u':
                        parameters.append(k.u64(int(value.removeprefix('u:'), 16)))
                    else:
                        raise ValueError((name, index, kind))
                assert len(parameters) == len(layout[name])
                if token == '32build_affine_body_preconditioner':
                    # Empty adjacency makes CableView's historical pointers unreachable; preserve its raw scalar payload.
                    assert buffers[12][1].view('u8').tolist() == [0, 0]
                    assert parameters[7].value == 3 and parameters[8].value == 36
                    assert parameters[19].value == 3 and parameters[20].value == 1 and parameters[21].value == 12
                if token == '53multiply_affine_body_so3_augmented_lagrangian_tangent':
                    assert parameters[6].value == 3 and parameters[7].value == 1 and parameters[8].value == 12
                holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(p), ct.c_void_p) for p in parameters])
                backends = tuple(functions[name])
                reference_outputs = None
                for trial in range(args.trials):
                    order = backends[trial % 3:] + backends[:trial % 3]
                    for backend in order:
                        for pointer, initial in pointers.values():
                            driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(initial.ctypes.data), initial.nbytes))
                        function = functions[name][backend]
                        gx, gy, gz, bx, by, bz, shared = node['geometry']
                        if backend == 'original-runtime':
                            code = runtime.cudaLaunchKernel(function, Dim3(gx, gy, gz), Dim3(bx, by, bz),
                                                            holders, shared, stream)
                            assert code == 0, code
                        else:
                            driver.check(driver.cu.cuLaunchKernel(function, gx, gy, gz, bx, by, bz, shared,
                                                                 stream, holders, None))
                        driver.check(driver.cu.cuStreamSynchronize(stream))
                        outputs = {i: driver.download(*buffers[i]) for i in OUTPUTS[token]}
                        if reference_outputs is None:
                            assert backend == 'original-runtime'
                            reference_outputs = outputs
                        same = {str(i): value.tobytes() == reference_outputs[i].tobytes() for i, value in outputs.items()}
                        captured = {str(i): value.tobytes() == expected[i] for i, value in outputs.items()}
                        key = f'{tag}-{token}-{ordinal:02d}-{backend}-{trial:02d}'
                        arrays.update({f'{key}-arg{i}': value for i, value in outputs.items()})
                        checks.append({'capture': tag, 'token': token, 'ordinal': ordinal, 'trial': trial,
                                       'backend': backend, 'equal_actual_runtime_replay': same,
                                       'equal_captured_output': captured})
                driver.free()
        report = {'reference_sha256': REFERENCE_SHA,
                  'source_sha256': hashlib.sha256(Path(source_image.__file__).read_bytes()).hexdigest(),
                  'packets_per_capture': len(next(iter(packets.values()))), 'trials_per_backend': args.trials,
                  'all_outputs_equal': all(all(row['equal_actual_runtime_replay'].values()) for row in checks),
                  'checks': checks, 'input_sha256': hashes, 'same_buffers_for_all_backends': True,
                  'backend_order_rotated': True, 'diagnostic_intentionally_maps_original': True,
                  'frozen_candidate_replaced': False, 'whole_solver_complete': False,
                  'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        np.savez_compressed(args.output / 'outputs.npz', **arrays)
        print('body stage packets', 2 * report['packets_per_capture'], 'checks', len(checks),
              'all outputs equal', report['all_outputs_equal'], flush=True)
        return int(not report['all_outputs_equal'])
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    raise SystemExit(main())
