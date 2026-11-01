"""Check both real input sides of the first CG update after each certified denominator difference."""
import argparse
import ctypes as ct
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def prepare():
    first = json.loads((BASE / 'first-CG-replay/plan.json').read_text())
    hashes = dict(first['input_sha256'])
    hashes[str(Path(__file__))] = sha(Path(__file__))
    output = BASE / 'first-update'
    output.mkdir(exist_ok=False)
    cases, differences = [], []
    for original in first['cases']:
        worker, frame = original['source_worker'], original['frame']
        payloads = {}
        for side, w in (('SDK', 0), ('source', worker)):
            folder = BASE / f'rhs-captures-v2/{w}/rhs-graph-{frame % 2}'
            stages = json.loads((folder / 'snapshot-layout.json').read_text())['stages']
            stage = next(s for s in stages if s['rank'] == original['actual_stages'][0]['rank'] + 1)
            assert stage['kind'] == 'CG-solution'
            path = folder / f'frames/frame-{frame:02d}.npz'
            with np.load(path, allow_pickle=False) as data:
                arrays = {'before-' + b['label']: data[stage['key'] + '/before/' + b['label']].copy()
                          for b in stage['bindings']}
                arrays.update({'after-' + label: data[stage['key'] + '/after/' + label].copy() for label in stage['outputs']})
            payloads[side] = arrays
            target = output / f'w{worker}-{side}-input.npz'
            np.savez_compressed(target, **arrays)
            hashes[str(target)] = sha(target)
            cases.append({'source_worker': worker, 'side': side, 'frame': frame, 'stage': stage, 'input': str(target)})
        labels = [k for k in payloads['SDK'] if k.startswith('before-')]
        changed = [k for k in labels if payloads['SDK'][k].tobytes() != payloads['source'][k].tobytes()]
        assert changed == ['before-arg-3']
        counts = {label: int(np.count_nonzero(payloads['SDK']['after-' + label].view('<u4') !=
                                             payloads['source']['after-' + label].view('<u4'))) for label in ('arg-6', 'arg-7')}
        differences.append({'source_worker': worker, 'frame': frame, 'only_before_difference': 'denominator',
                            'captured_after_differing_words': counts})
    record = {'cases': cases, 'differences': differences, 'input_sha256': hashes,
              'candidate_image': first['candidate_image'], 'candidate_sha256': first['candidate_sha256'],
              'expected_calls': 36, 'old_fixed_failure_reclassified': False, 'whole_solver_complete': False}
    (output / 'plan.json').write_text(json.dumps(record, indent=2) + '\n')
    print('Prepared6 authentic CG-update input packets;only denominator differs in each pair')


def execute():
    from reconstruction import kernel_ab as k
    from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
    from reconstruction.csrc.host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
    from reconstruction.csrc.pcg_alias_replay import span_groups
    from reconstruction.csrc.pcg_same_buffer_probe import Dim3

    output = BASE / 'first-update'
    plan = json.loads((output / 'plan.json').read_text())
    for path, expected in plan['input_sha256'].items():
        assert sha(Path(path)) == expected, path
    assert sha(REFERENCE) == REFERENCE_SHA
    build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    runtime_launch = runtime.cudaLaunchKernel
    runtime_launch.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    runtime_launch.restype = ct.c_int
    spec = importlib.util.spec_from_file_location('_source_solver', plan['candidate_image'])
    source_module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(source_module)
    assert sha(Path(source_module.__file__)) == plan['candidate_sha256']
    source = source_module._KernelDriver()
    name = plan['cases'][0]['stage']['node']['name']
    texts, _ = kernel_texts(build, name)
    functions = {'SDK-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                 'original-ptx': driver.function(texts['original'], name),
                 'source-ptx': ct.c_void_p(source.function(name))}
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows, calls, error = [], 0, None
    try:
        for case in plan['cases']:
            node = case['stage']['node']
            assert node['name'] == name and node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
            raw = [bytes.fromhex(v) for v in node['parameter_hex']]
            values = [int.from_bytes(v, 'little') for v in raw]
            assert values[0] == 0 and values[1] == 12 and values[8] == 36
            with np.load(case['input'], allow_pickle=False) as packet:
                bindings = {i: packet['before-arg-' + str(i)].tobytes() for i in range(2, 8)}
                expected = {i: packet['after-arg-' + str(i)].tobytes() for i in (6, 7)}
            groups = span_groups(values, bindings)
            pointers, initial, devices, masks, metadata = {}, [], [], [], []
            for group in groups:
                prefix = 256 + group['start'] % 256
                data = np.full(prefix + len(group['initial']) + 256, 211, dtype='u1')
                data[prefix:prefix + len(group['initial'])] = group['initial']
                device = driver.upload(data)
                assert device.value % 256 == 0
                mask = np.ones(len(data), dtype=bool)
                for i in group['indices']:
                    offset = prefix + values[i] - group['start']
                    pointers[i] = device.value + offset
                    assert pointers[i] % 256 == values[i] % 256
                    if i in expected:
                        mask[offset:offset + len(bindings[i])] = False
                initial.append(data)
                devices.append(device)
                masks.append(mask)
                metadata.append({'start': group['start'], 'bytes': len(group['initial']), 'indices': group['indices'],
                                 'prefix': prefix, 'device_base': device.value})
            parameters = [(ct.c_ubyte * len(v)).from_buffer_copy(pointers[i].to_bytes(8, 'little') if i in pointers else v)
                          for i, v in enumerate(raw)]
            holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(v), ct.c_void_p) for v in parameters])
            arrays = {'actual-parameter-' + str(i): np.frombuffer(bytes(v), dtype='u1').copy()
                      for i, v in enumerate(parameters)}
            checks = []
            for trial in range(2):
                order = list(functions)
                order = order[trial:] + order[:trial]
                for backend in order:
                    tag = backend + '-trial-' + str(trial)
                    for device, data in zip(devices, initial):
                        driver.check(driver.cu.cuMemcpyHtoD_v2(device, ct.c_void_p(data.ctypes.data), data.nbytes))
                    if backend == 'SDK-runtime':
                        assert runtime_launch(functions[backend], Dim3(1, 1, 1), Dim3(256, 1, 1), holders, 0, stream) == 0
                    else:
                        driver.check(driver.cu.cuLaunchKernel(functions[backend], 1, 1, 1, 256, 1, 1,
                                                             0, stream, holders, None))
                    driver.check(driver.cu.cuStreamSynchronize(stream))
                    calls += 1
                    for index, (device, before, mask) in enumerate(zip(devices, initial, masks)):
                        after = driver.download(device, np.empty_like(before))
                        arrays[tag + '-group-' + str(index)] = after.copy()
                        assert after[mask].tobytes() == before[mask].tobytes()
                    for i, value in expected.items():
                        actual = driver.download(ct.c_uint64(pointers[i]), np.zeros(len(value), dtype='u1'))
                        arrays[tag + '-output-' + str(i)] = actual.copy()
                        assert actual.tobytes() == value
                    checks.append({'tag': tag, 'both_complete_outputs_strict': True, 'unwritten_and_guards_equal': True})
            target = output / f'w{case["source_worker"]}-{case["side"]}-outputs.npz'
            np.savez_compressed(target, **arrays)
            rows.append({'source_worker': case['source_worker'], 'side': case['side'], 'checks': checks,
                         'groups': metadata, 'pointers': pointers, 'output': str(target), 'sha256': sha(target)})
            driver.free()
        for path, expected in plan['input_sha256'].items():
            assert sha(Path(path)) == expected, path
    except BaseException as problem:
        error = f'{type(problem).__name__}: {problem}'
        raise
    finally:
        result = {'cases': rows, 'actual_calls': calls, 'error': error, 'complete': len(rows) == 6 and error is None,
                  'production_changed': False, 'old_fixed_failure_reclassified': False, 'whole_solver_complete': False}
        (output / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
    assert result['complete'] and calls == 36
    print('All36 actual SDK/PTX/source updates reproduce both full captured vectors for their own authentic inputs')


def audit():
    output = BASE / 'first-update'
    plan, report = (json.loads((output / name).read_text()) for name in ('plan.json', 'report.json'))
    assert report['complete'] and report['actual_calls'] == 36
    words, ABI, protected = 0, 0, 0
    hashes = dict(plan['input_sha256'])
    for case, row in zip(plan['cases'], report['cases']):
        path = Path(row['output'])
        hashes[str(path)] = sha(path)
        assert hashes[str(path)] == row['sha256']
        with np.load(case['input']) as packet, np.load(path) as data:
            for i, raw in enumerate(case['stage']['node']['parameter_hex']):
                expected = bytes.fromhex(raw)
                if str(i) in row['pointers']:
                    expected = row['pointers'][str(i)].to_bytes(8, 'little')
                assert data['actual-parameter-' + str(i)].tobytes() == expected
                ABI += 1
            for check in row['checks']:
                tag = check['tag']
                for i in (6, 7):
                    assert data[tag + '-output-' + str(i)].tobytes() == packet['after-arg-' + str(i)].tobytes()
                    words += len(packet['after-arg-' + str(i)]) // 4
                for index, group in enumerate(row['groups']):
                    before = np.full(group['prefix'] + group['bytes'] + 256, 211, dtype='u1')
                    mask, seen = np.ones(len(before), dtype=bool), np.zeros(group['bytes'], dtype=bool)
                    for i in group['indices']:
                        value = packet['before-arg-' + str(i)]
                        offset = int.from_bytes(bytes.fromhex(case['stage']['node']['parameter_hex'][i]), 'little')
                        offset -= group['start']
                        region = before[group['prefix'] + offset:group['prefix'] + offset + len(value)]
                        assert region.shape == value.shape
                        if seen[offset:offset + len(value)].any():
                            selected = seen[offset:offset + len(value)]
                            assert region[selected].tobytes() == value[selected].tobytes()
                        region[:] = value
                        seen[offset:offset + len(value)] = True
                        if i in (6, 7):
                            mask[group['prefix'] + offset:group['prefix'] + offset + len(value)] = False
                    assert seen.all()
                    after = data[tag + '-group-' + str(index)]
                    assert after[mask].tobytes() == before[mask].tobytes()
                    for i in (6, 7):
                        if i in group['indices']:
                            offset = row['pointers'][str(i)] - group['device_base']
                            assert after[offset:offset + 432].tobytes() == packet['after-arg-' + str(i)].tobytes()
                    protected += int(mask.sum())
    assert words == 7776 and ABI == 54
    for path, expected in hashes.items():
        assert sha(Path(path)) == expected, path
    record = {'actual_calls_checked': 36, 'complete_output_words_checked': words, 'ABI_parameters_checked': ABI,
              'protected_bytes_checked': protected, 'input_sha256': hashes, 'GPU_used': False,
              'only_denominator_differs_in_each_input_pair': True, 'whole_solver_complete': False}
    (BASE / 'first-update-independent-cpu-audit.json').write_text(json.dumps(record, indent=2) + '\n')
    print('Independent CPU:36 calls,7776 full vector words,54 ABI parameters and all guards checked')


parser = argparse.ArgumentParser(description=__doc__)
mode = parser.add_mutually_exclusive_group(required=True)
mode.add_argument('--prepare', action='store_true')
mode.add_argument('--execute', action='store_true')
mode.add_argument('--audit', action='store_true')
args = parser.parse_args()
if args.prepare:
    prepare()
elif args.execute:
    execute()
else:
    audit()
