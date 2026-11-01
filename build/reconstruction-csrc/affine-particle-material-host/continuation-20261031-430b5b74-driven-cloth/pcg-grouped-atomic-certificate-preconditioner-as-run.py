"""Certify grouped PCG sums from actual original/source lane operands and real GPU atomics."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re

import numpy as np

from reconstruction import kernel_ab as k
from .demo_source_ab import ROOT
from .host_particles_ab import native_source
from .library_entries import entries
from .particle_reduction_certificates import SERIAL_PTX
from .surface_atomic_operands import instrument


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--launch', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    inputs, payloads, targets = {}, {}, {}
    prefix = args.launch.removesuffix('.json') + '.'

    def read(path):
        data = path.read_bytes()
        inputs[str(path.resolve())] = hashlib.sha256(data).hexdigest()
        return data

    for side in ('original', 'source'):
        folder = args.capture / side / 'native'
        metadata = json.loads(read(folder / (prefix + 'json')))
        assert '23precondition_and_reduceIN3glm' in metadata['name']
        payload = {label: read(folder / (prefix + label + '.bin')) for label in (
            'before.r', 'before.precomputed', 'before.per_group', 'before.numerator', 'after.z')}
        assert payload['before.precomputed'] in (b'\0', b'\1')
        precomputed = payload['before.precomputed'] == b'\1'
        input_label = 'before.z' if precomputed else 'before.inverse'
        payload[input_label] = read(folder / (prefix + input_label + '.bin'))
        assert not (folder / (prefix + 'before.world.bin')).exists()
        if precomputed:
            assert payload['before.z'] == payload['after.z']
        targets[side] = read(folder / (prefix + 'after.numerator.bin'))
        payloads[side] = metadata, payload
    assert payloads['original'] == payloads['source'], 'The first-divergence inputs are not identical'
    metadata, payload = payloads['original']
    name = metadata['name']
    precomputed = payload['before.precomputed'] == b'\1'
    n = len(payload['after.z']) // 12
    groups = len(targets['original']) // 4
    per_group = int.from_bytes(payload['before.per_group'], 'little')
    assert n > 0 and n == groups * per_group and len(payload['before.numerator']) == groups * 4
    assert not any(payload['before.numerator'])
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build = json.loads(read(build_path))
    header = read(build_path.parent / 'source_ptx_bundle.h').decode()
    parts = re.findall(r'\{("[^"\n]+"), R"(\w+)\((.*?)\)\2"\},', header, re.S)
    assert len(parts) == 28
    source_ptx = parts[build['kernels'][name]['module']][2]
    original_path = next(p for p in (ROOT / 'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')
                         if name in entries(p.read_text()))
    modules = {'original': read(original_path).decode(), 'source': source_ptx}
    driver = k.Driver()
    core = native_source()
    assert hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest() == build['extension_sha256']
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    arrays, certificates = {}, []

    def launch(function, parameters, grid=1, block=1):
        raw = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(v), ct.c_void_p) for v in parameters])
        driver.check(driver.cu.cuLaunchKernel(function, grid, 1, 1, block, 1, 1, 0, stream, raw, None))
        driver.check(driver.cu.cuStreamSynchronize(stream))

    def reset(pointer, array):
        driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(array.ctypes.data), array.nbytes))

    try:
        lanes = metadata['grid'] * metadata['block']
        trace_zero, count_zero = np.zeros((lanes, 128, 16), dtype='u1'), np.zeros(lanes, dtype='u4')
        trace, counts = driver.upload(trace_zero), driver.upload(count_zero)
        z_initial = (np.frombuffer(payload['before.z'], dtype='u1').copy() if precomputed else
                     np.zeros(n * 12, dtype='u1'))
        z = driver.upload(z_initial)
        r = driver.upload(np.frombuffer(payload['before.r'], dtype='u1'))
        inverse_initial = (np.zeros((n, 9), dtype='f4') if precomputed else
                           np.frombuffer(payload['before.inverse'], dtype='f4').reshape(n, 9))
        inverse = driver.upload(inverse_initial)
        initial = np.zeros(groups, dtype='f4')
        counter = driver.upload(initial)
        parameters = [inverse, r, z, ct.c_bool(precomputed), ct.c_void_p(), ct.c_uint(per_group), counter, k.u64(n)]
        operands = []
        for side, module in modules.items():
            changed, sites = instrument(module, name)
            assert sites == 1
            (args.output / (side + '-instrumented.ptx')).write_text(changed)
            function = driver.function(changed, name)
            for pointer, array in ((trace, trace_zero), (counts, count_zero), (counter, initial), (z, z_initial)):
                reset(pointer, array)
            launch(function, [*parameters, trace, counts], metadata['grid'], metadata['block'])
            sizes = driver.download(counts, count_zero)
            records = driver.download(trace, trace_zero)[:n, 0].copy()
            addresses = records[:, :8].copy().view('u8').reshape(-1)
            values = records[:, 8:12].copy().view('f4').reshape(-1)
            expected_addresses = counter.value + (np.arange(n, dtype='u8') // per_group) * 4
            assert np.all(sizes[:n] == 1) and not sizes[n:].any()
            assert np.array_equal(addresses, expected_addresses) and np.isfinite(values).all()
            assert driver.download(z, z_initial).tobytes() == payload['after.z']
            arrays[side + '-lane-operands'] = values.copy()
            operands.append(values)
        assert operands[0].tobytes() == operands[1].tobytes()
        (args.output / 'serial-atomic.ptx').write_text(SERIAL_PTX)
        serial = driver.function(SERIAL_PTX, 'audit_serial_atomic')
        tiny = np.finfo('f4').tiny

        def ftz(value):
            return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value

        for side, target in targets.items():
            target_words = np.frombuffer(target, dtype='u4')
            for group, word in enumerate(target_words):
                values = operands[0][group * per_group:(group + 1) * per_group].copy()
                normalized = np.asarray([ftz(value) for value in values], dtype='f4')
                seed = hashlib.sha256(f'{side}/{group}/{int(word)}'.encode()).hexdigest()[:16]
                rng = np.random.default_rng(int(seed, 16))
                row = {'target_side': side, 'group': group, 'target_bits': int(word), 'passed': False,
                       'negative_operands': int(np.count_nonzero(values < 0)),
                       'subnormal_operands': int(np.count_nonzero((abs(values) > 0) & (abs(values) < tiny)))}
                certificates.append(row)
                order, history = None, None
                for trial in range(10000):
                    proposed = np.arange(per_group) if trial == 0 else rng.permutation(per_group)
                    before, total = [], np.float32(0)
                    for lane in proposed:
                        before.append(total)
                        total = ftz(np.float32(total + normalized[lane]))
                    if int(total.view('u4')) == int(word):
                        order, history = proposed.astype('u4'), np.asarray(before, dtype='f4')
                        break
                row['search_trials'] = trial + 1
                if order is None:
                    continue
                output_zero, history_zero = np.zeros(1, dtype='f4'), np.zeros(per_group, dtype='f4')
                pointers = [driver.upload(array) for array in (values, order, output_zero, history_zero)]
                launch(serial, [*pointers, ct.c_uint(per_group)])
                actual = driver.download(pointers[2], output_zero)
                actual_history = driver.download(pointers[3], history_zero)
                assert int(actual.view('u4')[0]) == int(word) and actual_history.tobytes() == history.tobytes()
                tag = f'{side}-group{group}'
                arrays[tag + '-order'], arrays[tag + '-hardware-history'] = order, actual_history
                row.update(passed=True, actual_production_order_inferred=False, hardware_atomic_order_verified=True)
        report = {'source_sha256': build['extension_sha256'], 'kernel': name, 'particles': n, 'groups': groups,
                  'per_group': per_group, 'precomputed': precomputed,
                  'real_lane_operands_equal': True, 'certificates': certificates,
                  'all_passed': all(row['passed'] for row in certificates), 'input_sha256': inputs,
                  'frozen_candidate_replaced': False, 'cohort_expanded': False, 'whole_solver_complete': False,
                  'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        np.savez_compressed(args.output / 'certificates.npz', **arrays)
        print('group certificates', len(certificates), 'passed', report['all_passed'], flush=True)
        return int(not report['all_passed'])
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    raise SystemExit(main())
