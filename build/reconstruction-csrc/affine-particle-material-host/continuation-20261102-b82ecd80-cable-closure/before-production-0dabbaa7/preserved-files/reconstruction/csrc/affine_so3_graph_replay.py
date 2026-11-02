"""Replay authentic PD-contact SO3 snapshots against SDK runtime, original PTX, and source PTX."""
import argparse
import ctypes as ct
import hashlib
import importlib.util
import json
from pathlib import Path

import numpy as np

from .demo_source_ab import ROOT


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify(hashes):
    for name, expected in hashes.items():
        assert sha(Path(name)) == expected, name


def prepare(phase):
    from .g1_contact_rhs_replay import kernel_texts
    from .library_entries import entries
    from .ptx_store_origins_param import store_origins

    capture = phase / 'so3-captures'
    terminal = json.loads((capture / 'status.json').read_text())
    assert terminal['complete'] and len(terminal['completed']) == 4
    hashes = dict(json.loads((capture / 'plan.json').read_text())['input_sha256'])
    candidate = phase.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts/candidate-guard-only/build.json'
    build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
    metadata = json.loads(candidate.read_text())
    image = Path(metadata['image'])
    assert sha(image) == metadata['image_sha256'] == '4f638b4b9141e6ad6e2aabfb6533f8ed23bdfedbf7c1508063ea96bdb7e09326'
    hashes.update({str(p): sha(p) for p in (candidate, image, Path(__file__), capture / 'status.json')})
    packets, kernels = [], {}
    proof = {}
    for worker in range(4):
        provenance = json.loads((capture / str(worker) / 'provenance.json').read_text())
        assert provenance['complete'] and provenance['frames_read'] == [30, 30]
        assert provenance['original_SDK_mapped'] == (worker == 0)
        for graph in range(2):
            folder = capture / str(worker) / ('so3-graph-' + str(graph))
            layout_path = folder / 'snapshot-layout.json'
            layout = json.loads(layout_path.read_text())
            hashes[str(layout_path)] = sha(layout_path)
            assert layout['total_snapshot_bytes'] == 3648 and layout['graph_nodes_added'] == 24
            for stage in layout['stages']:
                node, key = stage['node'], stage['key']
                name = node['name']
                assert node['parameter_widths'] == build['kernels'][name]['parameters']
                kernels[key] = name
                if name not in proof:
                    texts, original = kernel_texts(build, name)
                    hashes[str(original)] = sha(original)
                    proof[name] = {}
                    for backend, text in texts.items():
                        entry = entries(text)[name]
                        writes = store_origins(entry, [(i, 0) for i in range(4)])
                        assert set(map(tuple, writes['potential_written_pointer_fields'])) == {(2, 0), (3, 0)}
                        assert writes['parameter_count'] == len(node['parameter_hex'])
                        proof[name][backend] = writes
                paths = sorted((folder / 'packets').glob(key + '-frame-*.npz'))
                assert len(paths) == 30
                for frame, path in zip(range(graph, 60, 2), paths):
                    assert path.name == f'{key}-frame-{frame:02d}.npz'
                    with np.load(path, allow_pickle=False) as packet:
                        expected = {'parameter-' + str(i) for i in range(len(node['parameter_hex']))}
                        expected |= {'before-arg-' + str(i) for i in range(4)} | {'after-arg-2', 'after-arg-3'}
                        assert set(packet.files) == expected
                        assert all(packet['parameter-' + str(i)].tobytes().hex() == value
                                   for i, value in enumerate(node['parameter_hex']))
                        for i in range(4):
                            assert len(packet['before-arg-' + str(i)]) == stage['sizes'][str(i)]
                        for i in (2, 3):
                            assert len(packet['after-arg-' + str(i)]) == stage['sizes'][str(i)]
                        ids = packet['before-arg-1'].view('<i4').reshape(-1, 4)
                        assert ids.shape == (3, 4) and ids.min() >= 0 and ids.max() < 36
                        if stage['advance'] == 0:
                            assert packet['before-arg-3'].tobytes() == packet['after-arg-3'].tobytes()
                    hashes[str(path)] = sha(path)
                    packets.append({'worker': worker, 'graph': graph, 'stage': key, 'frame': frame,
                                    'path': str(path), 'node': node, 'sizes': stage['sizes']})
    assert len(packets) == 960 and len(set(kernels.values())) == 2
    verify(hashes)
    plan = {'input_sha256': hashes, 'candidate_image': str(image), 'candidate_image_sha256': sha(image),
            'packets': packets, 'kernels': kernels, 'expected_calls': 5760,
            'backends': ['original-runtime', 'original-ptx', 'source-ptx'], 'trials': 2,
            'real_before_bytes_including_private_history': True, 'original_capture_can_be_perturbed': True,
            'frozen_failure_replaced': False, 'production_changed': False, 'whole_solver_complete': False}
    output = phase / 'so3-replays'
    output.mkdir(exist_ok=False)
    (output / 'CPU-preflight.json').write_text(json.dumps(proof, indent=2) + '\n')
    (output / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
    print('Prepared960 real SO3 packets, two trials per backend;5760 actual calls planned', flush=True)


def execute(phase):
    from reconstruction import kernel_ab as k
    from .g1_contact_rhs_replay import kernel_texts
    from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
    from .pcg_same_buffer_probe import Dim3

    output = phase / 'so3-replays'
    plan = json.loads((output / 'plan.json').read_text())
    verify(plan['input_sha256'])
    assert sha(REFERENCE) == REFERENCE_SHA
    (output / 'packets').mkdir(exist_ok=False)
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build_bytes = build_path.read_bytes()
    build = json.loads(build_bytes)
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    runtime_launch = runtime.cudaLaunchKernel
    runtime_launch.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    runtime_launch.restype = ct.c_int
    image = Path(plan['candidate_image'])
    assert sha(image) == plan['candidate_image_sha256']
    spec = importlib.util.spec_from_file_location('_source_solver', image)
    core = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(core)
    assert core.source_only and not core.solver_api_ready
    source = core._KernelDriver()
    functions = {}
    for name in set(plan['kernels'].values()):
        texts, _ = kernel_texts(build, name)
        functions[name] = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                           'original-ptx': driver.function(texts['original'], name),
                           'source-ptx': ct.c_void_p(source.function(name))}
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows, error = [], None
    try:
        for number, packet_plan in enumerate(plan['packets']):
            assert build_path.read_bytes() == build_bytes
            path, node = Path(packet_plan['path']), packet_plan['node']
            with np.load(path, allow_pickle=False) as packet:
                raw = [packet['parameter-' + str(i)].tobytes() for i in range(len(node['parameter_hex']))]
                values = [int.from_bytes(v, 'little') for v in raw]
                bindings = {i: packet['before-arg-' + str(i)].copy() for i in range(4)}
                expected = {i: packet['after-arg-' + str(i)].tobytes() for i in (2, 3)}
            for a in bindings:
                for b in bindings:
                    if a < b:
                        assert min(values[a] + len(bindings[a]), values[b] + len(bindings[b])) <= max(values[a], values[b])
            pointers, buffers, initial, masks, padding = {}, {}, {}, {}, {}
            for i, value in bindings.items():
                # Keep original pointer alignment while guarding both ends of every complete captured span.
                prefix = 256 + values[i] % 256
                allocation = np.full(prefix + len(value) + 256, 211, dtype='u1')
                allocation[prefix:prefix + len(value)] = value
                device = driver.upload(allocation)
                assert device.value % 256 == 0
                pointers[i], buffers[i], initial[i], padding[i] = device.value + prefix, device, allocation, prefix
                mask = np.ones(len(allocation), dtype=bool)
                if i in expected:
                    mask[prefix:prefix + len(value)] = False
                masks[i] = mask
                assert pointers[i] % 256 == values[i] % 256
            parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
                pointers[i].to_bytes(8, 'little') if i in pointers else value) for i, value in enumerate(raw)]
            holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(v), ct.c_void_p) for v in parameters])
            arrays = {'actual-parameter-' + str(i): np.frombuffer(bytes(v), dtype='u1')
                      for i, v in enumerate(parameters)}
            checks = []
            for trial in range(plan['trials']):
                order = plan['backends']
                rotation = (number + trial) % len(order)
                for backend in order[rotation:] + order[:rotation]:
                    for i, value in initial.items():
                        driver.check(driver.cu.cuMemcpyHtoD_v2(buffers[i], ct.c_void_p(value.ctypes.data), value.nbytes))
                    function = functions[node['name']][backend]
                    gx, gy, gz, bx, by, bz, shared = node['geometry']
                    if backend == 'original-runtime':
                        code = runtime_launch(function, Dim3(gx, gy, gz), Dim3(bx, by, bz), holders, shared, stream)
                        assert code == 0, code
                    else:
                        driver.check(driver.cu.cuLaunchKernel(function, gx, gy, gz, bx, by, bz,
                                                             shared, stream, holders, None))
                    driver.check(driver.cu.cuStreamSynchronize(stream))
                    tag = backend + '-trial-' + str(trial)
                    equal, untouched = {}, True
                    for i, before in initial.items():
                        after = driver.download(buffers[i], np.empty_like(before))
                        arrays[tag + '-buffer-' + str(i)] = after.copy()
                        untouched &= after[masks[i]].tobytes() == before[masks[i]].tobytes()
                        if i in expected:
                            actual = after[padding[i]:padding[i] + len(bindings[i])].copy()
                            arrays[tag + '-output-' + str(i)] = actual
                            equal[str(i)] = actual.tobytes() == expected[i]
                    checks.append({'backend': backend, 'trial': trial, 'captured_output_equal': equal,
                                   'all_outputs_equal': all(equal.values()), 'unwritten_and_guards_equal': untouched})
            name = f'w{packet_plan["worker"]}-g{packet_plan["graph"]}-{packet_plan["stage"]}-f{packet_plan["frame"]:02d}.npz'
            np.savez_compressed(output / 'packets' / name, **arrays)
            rows.append({k: v for k, v in packet_plan.items() if k not in ('node', 'sizes')})
            rows[-1].update(checks=checks, replay_packet=name,
                            allocated_device_bases={str(i): d.value for i, d in buffers.items()},
                            replay_pointers=pointers, padding=padding)
            driver.free()
            assert all(check['unwritten_and_guards_equal'] for check in checks), 'Read-only input or guard changed'
            if number % 60 == 0:
                print('SO3 real packet', number + 1, '/', len(plan['packets']), flush=True)
        verify(plan['input_sha256'])
    except BaseException as problem:
        error = f'{type(problem).__name__}: {problem}'
        raise
    finally:
        report = {'packets': rows, 'error': error, 'complete': len(rows) == 960 and error is None,
                  'all_complete_outputs_equal': all(c['all_outputs_equal'] for r in rows for c in r['checks']),
                  'all_unwritten_and_guards_equal': all(c['unwritten_and_guards_equal'] for r in rows for c in r['checks']),
                  'actual_calls': sum(len(row['checks']) for row in rows), 'whole_solver_complete': False}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
    assert report['complete'] and report['actual_calls'] == 5760
    assert report['all_complete_outputs_equal'] and report['all_unwritten_and_guards_equal']
    print('SO3:960 packets/5760 SDK+PTX+source calls; every complete output strict', flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--prepare', action='store_true')
    mode.add_argument('--execute', action='store_true')
    args = parser.parse_args()
    if args.prepare:
        prepare(args.phase.resolve())
    else:
        execute(args.phase.resolve())


if __name__ == '__main__':
    main()
