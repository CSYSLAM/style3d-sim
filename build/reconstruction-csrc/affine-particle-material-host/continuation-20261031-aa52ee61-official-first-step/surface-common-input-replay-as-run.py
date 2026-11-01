"""Replay actual surface contacts on identical buffers, isolating every contact before testing aggregate atomics."""
import argparse
import ctypes as ct
import hashlib
import itertools
import json
from pathlib import Path
import re
import struct

import numpy as np

from reconstruction import kernel_ab as k
from .demo_source_ab import ROOT
from .host_api_probe import load_reference, REFERENCE, REFERENCE_SHA
from .host_particles_ab import native_source
from .library_entries import entries
from .pcg_same_buffer_probe import Dim3


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--operation', choices=('force', 'stiffness', 'preconditioner', 'tangent'), default='force')
    parser.add_argument('--source-ptx', type=Path, help='Diagnostic layout experiment; never a delivered solver image')
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    fields = {int(key): value for key, value in json.loads((args.capture / 'fields.json').read_text()).items()}
    operation, width, argument = {
        'force': ('30evaluate_surface_contact_force', 3, 1),
        'stiffness': ('35add_surface_contact_stiffness_scale', 1, 1),
        'preconditioner': ('34add_surface_contact_preconditioner', 9, 1),
        'tangent': ('32multiply_surface_contact_tangent', 3, 2),
    }[args.operation]
    line = next(row for row in (args.capture / 'launches.txt').read_text().splitlines() if operation + ' ' in row)
    name = line.split(' symbol:', 1)[1].split()[0]
    words = {int(off): int(value, 16) for off, value in
             re.findall(r'(\d+):([0-9a-f]+)\([^)]*\)', line.split()[5])}
    original_view = b''.join(struct.pack('<Q', words[offset]) for offset in range(0, 296, 8))
    total = words[120]
    grid = int(re.search(r'grid=(\d+)', line)[1])
    assert int(re.search(r'block=(\d+)', line)[1]) == 256
    payloads = {}
    for offset, (_, size) in fields.items():
        filename = f'dump_30evaluate_surface_contact_force_pre_arg0{f"_offset{offset}" if offset else ""}.bin'
        payloads[offset] = (args.capture / filename).read_bytes()
        assert len(payloads[offset]) == size
    count = struct.unpack('<i', payloads[0])[0]
    assert 0 < count <= grid * 256 <= 8192
    if words[64]:
        assert len(payloads[64]) == words[72] * 4, 'Capture the actual particle-only shape mask'
    else:
        assert words[72] == 0 and 64 not in payloads
    before = np.fromfile(args.capture / f'dump_{operation}_pre_arg{argument}.bin', dtype='f4')
    expected = np.fromfile(args.capture / f'dump_{operation}_post_arg{argument}.bin', dtype='f4')
    assert before.size == expected.size == total * width
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    launch_runtime = runtime.cudaLaunchKernel
    launch_runtime.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    launch_runtime.restype = ct.c_int
    source_image = native_source()
    source = source_image._KernelDriver()
    original_ptx = next(p for p in (ROOT / 'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')
                        if name in entries(p.read_text()))
    functions = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                 'original-ptx': driver.function(original_ptx.read_text(), name),
                 'source-ptx': driver.function(args.source_ptx.read_text(), name) if args.source_ptx else
                               ct.c_void_p(source.function(name))}
    pointers = {off: driver.upload(np.frombuffer(data, dtype='u1')) for off, data in payloads.items()}
    output = driver.upload(np.zeros(total * width, dtype='f4'))
    direction = driver.upload(np.fromfile(args.capture / f'dump_{operation}_pre_arg1.bin', dtype='f4')) \
        if args.operation == 'tangent' else None
    view = bytearray(original_view)
    for offset, pointer in pointers.items():
        struct.pack_into('<Q', view, offset, pointer.value)
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    isolated, full, checks = {}, {}, []

    def write(pointer, data):
        driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_char_p(data), len(data)))

    def run(backend, image, initial):
        write(output, initial.tobytes())
        packed = ct.create_string_buffer(bytes(image))
        arguments = [direction, output] if direction is not None else [output]
        holders = (ct.c_void_p * (1 + len(arguments)))(ct.cast(packed, ct.c_void_p),
            *[ct.cast(ct.byref(v), ct.c_void_p) for v in arguments])
        if backend == 'original-runtime':
            status = launch_runtime(functions[backend], Dim3(grid, 1, 1), Dim3(256, 1, 1), holders, 0, stream)
            assert not status, status
        else:
            driver.check(driver.cu.cuLaunchKernel(functions[backend], grid, 1, 1, 256, 1, 1, 0, stream, holders, None))
        driver.check(driver.cu.cuStreamSynchronize(stream))
        return driver.download(output, initial)

    try:
        write(pointers[0], struct.pack('<i', 1))
        zero = np.zeros_like(before)
        for backend in functions:
            values = []
            for contact in range(count):
                one = bytearray(view)
                struct.pack_into('<Q', one, 8, 1)
                for offset, stride in ((16, 12), (24, 12), (32, 4), (40, 12), (48, 12), (56, 12)):
                    struct.pack_into('<Q', one, offset, pointers[offset].value + contact * stride)
                values.append(run(backend, one, zero))
            isolated[backend] = np.asarray(values)
        actual = isolated['original-runtime']
        for backend, values in isolated.items():
            checks.append({'backend': backend, 'isolated_contact_outputs_equal': values.tobytes() == actual.tobytes()})
        write(pointers[0], struct.pack('<i', count))
        for backend in functions:
            full[backend] = run(backend, view, before)
        np.savez_compressed(args.output / 'outputs.npz', before=before, captured_after=expected,
                            **{key + '-isolated': value for key, value in isolated.items()},
                            **{key + '-aggregate': value for key, value in full.items()})
        from .surface_atomic_operands import capture as capture_operands
        bundle = (ROOT / 'build/reconstruction-csrc/host-particles/source_ptx_bundle.h').read_text()
        modules = re.findall(r'\{("[^"\n]+"), R"(\w+)\((.*?)\)\2"\}', bundle, re.S)
        source_module = args.source_ptx.read_text() if args.source_ptx else \
            next(text for _, _, text in modules if name in entries(text))
        operand_captures, operand_outputs = {}, {}
        for backend, module in [('original', original_ptx.read_text()), ('source', source_module)]:
            operand_captures[backend], operand_outputs[backend] = capture_operands(
                driver, module, name, view, output, before, stream, count=count, direction=direction, grid=grid)
        same_operands = operand_captures['original']['thread_operands'] == operand_captures['source']['thread_operands']
        (args.output / 'atomic-operands.json').write_text(json.dumps(operand_captures, indent=2) + '\n')
        # Use each actual scalar atomic operand, never a rounded sum of a contact's normal and friction writes.
        destinations = [[] for _ in before]
        for lane in operand_captures['original']['thread_operands']:
            for index, bits in lane:
                destinations[index].append(np.asarray(bits, dtype='u4').view('f4')[()])
        rng = np.random.default_rng(17031)
        targets = {'captured': expected, **full, **{key + '-probe': value for key, value in operand_outputs.items()}}
        witnesses = {key: [] for key in targets}
        for index, terms in enumerate(destinations):
            values = np.asarray(terms, dtype='f4')
            n = len(values)
            if n <= 6:
                orders = np.asarray(list(itertools.permutations(range(n))), dtype='i4').reshape(-1, n) \
                    if n else np.zeros((1, 0), dtype='i4')
            else:
                orders = np.asarray([np.arange(n), np.arange(n)[::-1], *[rng.permutation(n) for _ in range(4096)]])
            initial = np.full((len(orders), 1), before[index], dtype='f4')
            sums = np.add.accumulate(np.concatenate((initial, values[orders]), axis=1), axis=1, dtype='f4')[:, -1]
            for key, vector in targets.items():
                target = vector[index]
                matched = np.flatnonzero(sums.view('u4') == target.view('u4'))
                row = {'scalar': index, 'target_bits': int(target.view('u4')), 'operand_count': n,
                       'exact_float32_witness': bool(len(matched))}
                if len(matched):
                    order = orders[matched[0]]
                    value = before[index]
                    for j in order:
                        value = np.float32(value + values[j])
                    assert value.view('u4') == target.view('u4')
                    row['order'] = order.tolist()
                witnesses[key].append(row)
        report = {
            'reference_sha256': REFERENCE_SHA,
            'source_sha256': hashlib.sha256(Path(source_image.__file__).read_bytes()).hexdigest(),
            'contacts': count, 'output_scalars': len(before), 'same_buffers_for_all_backends': True,
            'grid': grid, 'block': 256,
            'operation': args.operation,
            'experimental_source_ptx': str(args.source_ptx) if args.source_ptx else None,
            'experimental_ptx_sha256': hashlib.sha256(args.source_ptx.read_bytes()).hexdigest()
                if args.source_ptx else None,
            'isolated_contact_comparisons': checks,
            'all_isolated_contact_outputs_equal': all(row['isolated_contact_outputs_equal'] for row in checks),
            'aggregate_matches_captured': {key: value.tobytes() == expected.tobytes() for key, value in full.items()},
            'all_per_contact_atomic_operand_sequences_identical': same_operands,
            'actual_atomic_operands': sum(map(len, operand_captures['original']['thread_operands'])),
            'scalar_exact_atomic_sum_witnesses': {key: sum(row['exact_float32_witness'] for row in values)
                                                 for key, values in witnesses.items()},
            'witnesses': witnesses, 'production_atomic_order_inferred': False,
            'fixed_candidate_replaced': False, 'whole_solver_accepted': False,
            'input_sha256': {str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest() for p in
                             [Path(__file__), original_ptx, *args.capture.glob('dump_*_pre_*.bin')]},
        }
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        print(json.dumps({key: value for key, value in report.items() if key not in ('input_sha256', 'witnesses')}),
              flush=True)
        assert report['all_isolated_contact_outputs_equal']
        assert same_operands
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    main()
