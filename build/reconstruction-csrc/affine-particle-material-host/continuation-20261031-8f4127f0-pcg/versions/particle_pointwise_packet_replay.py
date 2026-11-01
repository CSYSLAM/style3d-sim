"""Replay fixed failing particle inputs with actual captured scalars, preserving pointer aliases."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k
from .audit_cudahook import schemas
from .host_api_probe import load_reference, REFERENCE, REFERENCE_SHA
from .host_particles_ab import native_source
from .library_entries import entries
from .particle_packet_capture import TOKENS
from .pcg_same_buffer_probe import Dim3


def native_directory(root, side):
    path = root / side / 'native'
    return path / 'actual' if (path / 'actual').exists() else path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--complete', type=Path, required=True)
    parser.add_argument('--frozen', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--trials', type=int, default=8)
    args = parser.parse_args()
    assert args.trials > 0
    args.output.mkdir(parents=True, exist_ok=False)
    build = json.loads((args.complete / 'solver-build.json').read_text())
    (args.output / 'build.json').write_text(json.dumps(build, indent=2) + '\n')
    schema, inputs, rows = schemas()[0], {}, []

    def read(path):
        data = path.read_bytes()
        inputs[str(path.resolve())] = hashlib.sha256(data).hexdigest()
        return data

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
    original, functions = {}, {}
    for path in Path('build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx'):
        text = path.read_text()
        for name in entries(text):
            if any(token in name for token in TOKENS):
                original[name] = text
                inputs[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    backends = ('original-runtime', 'original-ptx', 'source-ptx')
    try:
        for side in ('legacy', 'source'):
            old, full = native_directory(args.frozen, side), native_directory(args.complete, side)
            old_runtime = json.loads(read(args.frozen / side / 'diagnostic-runtime.json'))
            assert old_runtime['image_sha256'] == (REFERENCE_SHA if side == 'legacy' else build['extension_sha256'])
            metadata = [p for p in sorted(old.glob('*.json')) if any(token + '.' in p.name for token in TOKENS)]
            assert len(metadata) == 9
            start = sorted(full.glob('*.15initialize_stepE.json'))[0]
            static_prefix = start.name[:-4]
            static_mass = read(full / (static_prefix + 'before.mass.bin'))
            static_flags = read(full / (static_prefix + 'before.flags.bin'))
            for meta_path in metadata:
                meta = json.loads(read(meta_path))
                prefix, name = meta_path.name[:-4], meta['name']
                complete_meta = json.loads(read(full / meta_path.name))
                assert all(meta[key] == complete_meta[key] for key in ('name', 'grid', 'block'))
                widths = build['kernels'][name]['parameters']
                raw = [read(full / (prefix + f'before.param_{i}.bin')) for i in range(len(widths))]
                assert list(map(len, raw)) == widths
                value = lambda index: int.from_bytes(raw[index], 'little')
                bindings, outputs, unread = {}, {}, []

                def bind(index, label, dynamic=False):
                    path = (old if dynamic else full) / (prefix + 'before.' + label + '.bin')
                    if value(index):
                        bindings[index] = read(path)
                    else:
                        assert not path.exists(), path

                if TOKENS[0] in name:
                    n, local = value(23), value(24)
                    assert n == local == 257
                    for index, label in ((1, 'gravity'), (3, 'world'), (6, 'host_diagonal'), (17, 'mass'),
                                         (18, 'flags'), (19, 'particle_kind')):
                        bind(index, label)
                    for index, label in ((4, 'v'), (5, 'x')):
                        bind(index, label, True)
                    for slot in range(5):
                        bind(7 + slot * 2, 'diagonal_template' + str(slot))
                    assert bindings[17] == static_mass == read(old / (prefix + 'before.mass.bin'))
                    assert bindings[18] == static_flags == read(old / (prefix + 'before.flags.bin'))
                    assert bindings[6] == read(old / (prefix + 'before.host_diagonal.bin'))
                    outputs = {5: 'x', 20: 'previous', 21: 'target', 22: 'diagonal'}
                elif TOKENS[1] in name:
                    n, local = value(10), value(11)
                    assert n == local == 257 and value(6) == 0
                    for index, label in ((1, 'x'), (2, 'target'), (7, 'external')):
                        bind(index, label, True)
                    bind(3, 'mass')
                    bind(8, 'flags')
                    assert bindings[3] == static_mass and bindings[8] == static_flags
                    # The recorded maximum is zero: both actual PTX entries bypass ELL pointee reads.
                    for index in (4, 5):
                        if value(index):
                            bindings[index] = bytes(local * 4 if index == 4 else 8)
                            unread.append(index)
                    outputs = {9: 'rhs'}
                else:
                    assert TOKENS[2] in name
                    n, local = value(4), value(5)
                    assert n == local == 257
                    bind(0, 'blocks', True)
                    bind(1, 'mass')
                    bind(2, 'flags')
                    assert bindings[1] == static_mass and bindings[2] == static_flags
                    outputs = {3: 'inverse'}
                expected = {index: read(old / (prefix + 'after.' + label + '.bin')) for index, label in outputs.items()}
                groups = {}
                for index, kind in enumerate(schema[name]):
                    if kind != 'pointer' or not value(index):
                        continue
                    assert index in bindings or index in outputs, (name, index)
                    size = max(len(bindings.get(index, b'')), len(expected.get(index, b'')))
                    group = groups.setdefault(value(index), {'size': 0, 'inputs': []})
                    group['size'] = max(group['size'], size)
                    if index in bindings:
                        group['inputs'].append(bindings[index])
                for address, group in groups.items():
                    initial = bytearray([0xa5] * group['size'])
                    for data in group['inputs']:
                        for other in group['inputs']:
                            assert data[:min(len(data), len(other))] == other[:min(len(data), len(other))]
                        initial[:len(data)] = data
                    group['initial'] = np.frombuffer(bytes(initial), dtype='u1')
                    group['pointer'] = driver.upload(group['initial'])
                parameters = [ct.c_void_p(groups[value(i)]['pointer'].value) if kind == 'pointer' and value(i)
                              else ct.create_string_buffer(raw[i], len(raw[i])) for i, kind in enumerate(schema[name])]
                holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(p), ct.c_void_p) for p in parameters])
                if name not in functions:
                    functions[name] = {
                        'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                        'original-ptx': driver.function(original[name], name),
                        'source-ptx': ct.c_void_p(source.function(name)),
                    }
                checks = []
                for trial in range(args.trials):
                    for backend in backends[trial % 3:] + backends[:trial % 3]:
                        for group in groups.values():
                            array = group['initial']
                            driver.check(driver.cu.cuMemcpyHtoD_v2(group['pointer'], ct.c_void_p(array.ctypes.data), array.nbytes))
                        function = functions[name][backend]
                        if backend == 'original-runtime':
                            status = launch_runtime(function, Dim3(meta['grid'], 1, 1), Dim3(meta['block'], 1, 1),
                                                    holders, 0, stream)
                            assert status == 0, status
                        else:
                            driver.check(driver.cu.cuLaunchKernel(function, meta['grid'], 1, 1, meta['block'], 1, 1,
                                                                 0, stream, holders, None))
                        driver.check(driver.cu.cuStreamSynchronize(stream))
                        same = {}
                        for index, data in expected.items():
                            actual = driver.download(groups[value(index)]['pointer'], np.zeros(len(data), dtype='u1'))
                            same[outputs[index]] = actual.tobytes() == data
                            if not same[outputs[index]]:
                                (args.output / f'{side}-{prefix}{backend}-{trial}-{outputs[index]}.bin').write_bytes(actual)
                        checks.append({'backend': backend, 'trial': trial, 'outputs_equal': same})
                rows.append({'capture': side, 'packet': meta_path.name, 'checks': checks,
                             'unread_ELL_arguments_with_recorded_maximum_zero': unread,
                             'pointer_aliases_preserved': True,
                             'passed': all(all(r['outputs_equal'].values()) for r in checks)})
                print(side, meta_path.name, 'passed', rows[-1]['passed'], flush=True)
                driver.free()
        report = {'source_sha256': build['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
                  'packets': rows, 'all_pointwise_equal': all(row['passed'] for row in rows),
                  'captured_scalars_used_verbatim': True, 'frozen_dynamic_inputs_used': True,
                  'static_inputs_completed_from_same_model_capture': True, 'trials_per_backend': args.trials,
                  'diagnostic_intentionally_maps_original': True, 'fixed_source_replaced': False,
                  'whole_solver_complete': False, 'input_sha256': inputs,
                  'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        return int(not report['all_pointwise_equal'])
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    raise SystemExit(main())
