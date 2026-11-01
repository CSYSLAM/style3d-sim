"""Compare SO3 initialization on the unchanged public positions of the frozen G1 failure cohort."""
import argparse
from contextlib import ExitStack
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from .demo_source_ab import ROOT


HOST_SHA = '38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49'
CORE_SHA = '7eb6e847ad6f100b51f2bc89db0a88744f93878077c318c91288d2f595116b53'
FROZEN_SHA = '32b6e2a7337aaa80442fa3fd6232896410eb8163e875d35d845d4a8ae82d4e42'
SIZES = {0: 2112, 1: 704, 2: 1584, 3: 1584}
PADDING, GUARD = 256, 211


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify_inputs(plan):
    for name, expected in plan['input_sha256'].items():
        assert sha(Path(name)) == expected, name


def prepare(phase):
    from .g1_contact_rhs_replay import kernel_texts
    from .graph_definition_compare import linear_order
    from .library_entries import entries
    from .ptx_store_origins_param import store_origins

    assert not (phase / 'plan.json').exists()
    phase.mkdir(parents=True, exist_ok=True)
    base = ROOT / 'build/reconstruction-csrc/affine-particle-material-host'
    previous = base / 'continuation-20261101-38b70dcd-g1-drive-and-AL-state'
    fixed = base / 'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json'
    assert sha(fixed) == FROZEN_SHA
    cohort = json.loads(fixed.read_text())
    assert cohort['source_sha256'] == HOST_SHA and cohort['public_core_sha256'] == CORE_SHA
    assert not cohort['old_failure_replaced'] and not cohort['cohorts_resampled']
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build = json.loads(build_path.read_text())
    assert build['extension_sha256'] == HOST_SHA and build['source_only'] and build['kernel_count'] == 176
    names = [name for name in build['kernels'] if 'initialize_affine_body_so3_stateE' in name]
    assert len(names) == 1
    name = names[0]
    assert build['kernels'][name]['parameters'] == [8] * 7
    initializer_nodes, graph_paths = {}, []
    for side in ('original', 'source'):
        graph_path = previous / side / 'definition-before/graph.json'
        graph_paths.append(graph_path)
        nodes = linear_order(json.loads(graph_path.read_text()))[0]
        calls = [(rank, node) for rank, node in enumerate(nodes) if node.get('name') == name]
        assert [rank for rank, _ in calls] == [20, 2930, 5840, 8750, 11660, 14570]
        for _, node in calls:
            assert node['parameter_widths'] == [8] * 7 and node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
            assert [int.from_bytes(bytes.fromhex(value), 'little') for value in node['parameter_hex'][4:]] == [44, 44, 176]
            assert node['parameter_hex'][1] == nodes[15149]['parameter_hex'][1]
        initializer_nodes[side] = [{'rank': rank, 'node': node} for rank, node in calls]
    mapping = previous / 'original/so3_true-packets/frame-00.npz'
    closed = json.loads((previous / 'closed-packets.json').read_text())
    assert sha(mapping) == closed['input_sha256'][str(mapping)]
    with np.load(mapping, allow_pickle=False) as packet:
        ids = packet['before-arg-1'].view('<i4')
        assert ids.shape == (176,) and sorted(ids.tolist()) == list(range(176))
    labels = list(cohort['input_npz_paths'])
    assert labels == ['original' + str(i) for i in range(8)] + ['source' + str(i) for i in range(3)]
    for label, path in cohort['input_npz_paths'].items():
        assert sha(Path(path)) == cohort['input_npz_sha256'][label]
        with np.load(path, allow_pickle=False) as packet:
            assert packet['particle_q'].shape == (60, 176, 3) and packet['particle_q'].dtype == np.dtype('<f4')
            assert np.isfinite(packet['particle_q']).all()
    texts, original = kernel_texts(build, name)
    proofs = {}
    for side, text in texts.items():
        entry = entries(text)[name]
        proof = store_origins(entry, [(i, 0) for i in range(4)])
        assert proof['parameter_count'] == 7
        assert set(map(tuple, proof['potential_written_pointer_fields'])) == {(2, 0), (3, 0)}
        (phase / (side + '-entry.ptx')).write_text(entry)
        proofs[side] = proof
    priority = [('source1', 30), ('source1', 31)]
    cases = priority + [(label, frame) for label in labels for frame in range(60) if (label, frame) not in priority]
    assert len(cases) == len(set(cases)) == 660
    hashes = dict(json.loads((previous / 'plan.json').read_text())['input_sha256'])
    paths = [Path(__file__), phase / 'independent-cpu-audit.py', fixed, mapping, build_path, original, *graph_paths]
    paths.extend(Path(path) for path in cohort['input_npz_paths'].values())
    for path in paths:
        hashes[str(path)] = sha(path)
    plan = {
        'previous_goal_turn': 'progress: published68297454 and verified251248 files with zero failures',
        'kernel': name, 'input_sha256': hashes, 'input_npz_paths': cohort['input_npz_paths'],
        'mapping_packet': str(mapping), 'cases': cases, 'canary_bytes': [127, 165],
        'payload_sizes': SIZES, 'padding': PADDING, 'guard_byte': GUARD,
        'geometry': [1, 1, 1, 256, 1, 1, 0], 'parameters': [8] * 7,
        'backends': ['original-runtime', 'original-ptx', 'source-ptx'], 'expected_calls': 3960,
        'frozen_public_positions_are_shared_inputs': True, 'old_internal_state_reconstructed': False,
        'controlled_output_canaries_not_original_before_values': True,
        'old_C8_reclassified': False, 'production_changed': False, 'whole_solver_complete': False,
    }
    verify_inputs(plan)
    (phase / 'CPU-preflight.json').write_text(json.dumps({'proofs': proofs, 'actual_G1_initializer_nodes': initializer_nodes,
                                                        'GPU_context_created': False, 'whole_solver_complete': False},
                                                       indent=2) + '\n')
    (phase / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
    print('Frozen660 public-position inputs;3960 SDK/PTX/source calls with two output canaries', flush=True)


def execute(phase):
    from reconstruction import kernel_ab as k
    from .g1_contact_rhs_replay import kernel_texts
    from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
    from .host_particles_ab import native_source
    from .pcg_same_buffer_probe import Dim3

    assert not (phase / 'report.json').exists() and not (phase / 'packets').exists()
    (phase / 'packets').mkdir()
    plan = json.loads((phase / 'plan.json').read_text())
    verify_inputs(plan)
    assert sha(REFERENCE) == REFERENCE_SHA
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build_bytes = build_path.read_bytes()
    build = json.loads(build_bytes)
    name = plan['kernel']
    texts, _ = kernel_texts(build, name)
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    launch_runtime = runtime.cudaLaunchKernel
    launch_runtime.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    launch_runtime.restype = ct.c_int
    source_module = native_source()
    assert sha(Path(source_module.__file__)) == HOST_SHA
    source = source_module._KernelDriver()
    functions = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                 'original-ptx': driver.function(texts['original'], name),
                 'source-ptx': ct.c_void_p(source.function(name))}
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    buffers = {i: driver.upload(np.zeros(size + 2 * PADDING, dtype='u1')) for i, size in SIZES.items()}
    pointers = {i: pointer.value + PADDING for i, pointer in buffers.items()}
    assert all(pointer.value % 256 == 0 for pointer in buffers.values())
    rows, error = [], None
    try:
        with ExitStack() as stack:
            frozen = {label: stack.enter_context(np.load(path, allow_pickle=False))
                      for label, path in plan['input_npz_paths'].items()}
            mapping = stack.enter_context(np.load(plan['mapping_packet'], allow_pickle=False))['before-arg-1'].tobytes()
            for number, (label, frame) in enumerate(plan['cases']):
                assert build_path.read_bytes() == build_bytes
                positions = np.ascontiguousarray(frozen[label]['particle_q'][frame]).tobytes()
                assert len(positions) == SIZES[0] and len(mapping) == SIZES[1]
                arrays, checks = {}, []
                for canary_index, canary in enumerate(plan['canary_bytes']):
                    payloads = {0: positions, 1: mapping, 2: bytes([canary]) * 1584, 3: bytes([canary]) * 1584}
                    initial = {}
                    for i, size in SIZES.items():
                        value = np.full(size + 2 * PADDING, GUARD, dtype='u1')
                        value[PADDING:PADDING + size] = np.frombuffer(payloads[i], dtype='u1')
                        initial[i] = value
                    order = list(functions)
                    rotation = number % 3
                    for backend in order[rotation:] + order[:rotation]:
                        tag = backend + '-canary' + str(canary_index)
                        for i, value in initial.items():
                            driver.check(driver.cu.cuMemcpyHtoD_v2(buffers[i], ct.c_void_p(value.ctypes.data), value.nbytes))
                        parameters = [*(ct.c_uint64(pointers[i]) for i in range(4)),
                                      ct.c_uint64(44), ct.c_uint64(44), ct.c_uint64(176)]
                        for i, value in enumerate(parameters):
                            arrays[tag + '-parameter-' + str(i)] = np.frombuffer(bytes(value), dtype='u1').copy()
                        holders = (ct.c_void_p * 7)(*[ct.cast(ct.byref(value), ct.c_void_p) for value in parameters])
                        if backend == 'original-runtime':
                            assert launch_runtime(functions[backend], Dim3(1, 1, 1), Dim3(256, 1, 1),
                                                  holders, 0, stream) == 0
                        else:
                            driver.check(driver.cu.cuLaunchKernel(functions[backend], 1, 1, 1, 256, 1, 1,
                                                                 0, stream, holders, None))
                        driver.check(driver.cu.cuStreamSynchronize(stream))
                        untouched = True
                        for i, value in initial.items():
                            after = driver.download(buffers[i], np.empty_like(value))
                            arrays[tag + '-buffer-' + str(i)] = after.copy()
                            mask = np.ones(len(value), dtype=bool)
                            if i in (2, 3):
                                mask[PADDING:PADDING + SIZES[i]] = False
                                arrays[tag + '-output-' + str(i)] = after[PADDING:PADDING + SIZES[i]].copy()
                            untouched &= bool(np.array_equal(after[mask], value[mask]))
                        checks.append({'tag': tag, 'unwritten_equal': untouched})
                for check in checks:
                    tag = check['tag']
                    check['outputs_equal_to_primary_SDK'] = {
                        str(i): arrays[tag + '-output-' + str(i)].tobytes() ==
                                arrays['original-runtime-canary0-output-' + str(i)].tobytes() for i in (2, 3)}
                path = phase / 'packets' / f'{label}-frame-{frame:02d}.npz'
                np.savez_compressed(path, **arrays)
                rows.append({'label': label, 'frame': frame, 'checks': checks,
                             'position_bytes_sha256': hashlib.sha256(positions).hexdigest(),
                             'allocated_device_bases': {str(i): value.value for i, value in buffers.items()},
                             'actual_parameter_addresses': {str(i): value for i, value in pointers.items()}})
                assert all(check['unwritten_equal'] for check in checks), 'A read-only input or guard changed'
                if number < 2 or number % 60 == 0:
                    print('Frozen SO3 initialization', number + 1, '/', len(plan['cases']), label, frame, flush=True)
        verify_inputs(plan)
    except BaseException as problem:
        error = f'{type(problem).__name__}: {problem}'
        raise
    finally:
        report = {'packets': rows, 'error': error, 'complete': len(rows) == 660 and error is None,
                  'all_complete_outputs_equal': all(all(check['outputs_equal_to_primary_SDK'].values())
                                                    for row in rows for check in row['checks']),
                  'all_unwritten_equal': all(check['unwritten_equal'] for row in rows for check in row['checks']),
                  'actual_calls': sum(len(row['checks']) for row in rows),
                  'runner_sha256': sha(Path(__file__)), 'production_changed': False, 'whole_solver_complete': False}
        (phase / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
    assert report['complete'] and report['actual_calls'] == 3960
    assert report['all_complete_outputs_equal'] and report['all_unwritten_equal']
    print('All3960 SO3 initialization calls passed strict output and full input/guard checks', flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--prepare', action='store_true')
    mode.add_argument('--execute', action='store_true')
    args = parser.parse_args()
    phase = args.phase.resolve()
    if args.prepare:
        prepare(phase)
    else:
        execute(phase)


if __name__ == '__main__':
    main()
