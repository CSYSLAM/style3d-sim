"""Tie actual scale arithmetic and GPU certificates to captured inputs;check whether its first differences reach self Hessians."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
FLOW = BASE.parent / 'continuation-20261101-7ca67172-driven-self-flow'
OUTPUT = BASE / 'independent-cpu.json'
assert not OUTPUT.exists()
hashes, rows = {}, []


def read(path):
    data = path.read_bytes()
    hashes[str(path.resolve())] = hashlib.sha256(data).hexdigest()
    return data


status = json.loads(read(BASE / 'replays/status.json'))
assert status['complete'] and all(row['actual_exit'] == 0 for row in status['completed'])
cert_path = BASE / 'surface-scale-scalar-certificates/independent-cpu-audit.json'
cert = json.loads(read(cert_path))
assert cert['isolated_gate_satisfied'] and cert['metrics']['actual_GPU_calls'] == 155
assert cert['metrics']['covered_origin_scalars'] == 768
for name, expected in cert['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
for worker in range(4):
    capture, replay = BASE / 'packets' / str(worker), BASE / 'replays' / str(worker)
    report = json.loads(read(replay / 'report.json'))
    operands = json.loads(read(replay / 'atomic-operands.json'))
    mapping = json.loads(read(capture / 'rename-only-map.json'))
    for name, origin in mapping.items():
        assert read(capture / name) == read(Path(origin['source']))
    assert report['contacts'] == 66 and report['output_scalars'] == 48
    assert report['all_isolated_contact_outputs_equal']
    assert operands['original']['thread_operands'] == operands['source']['thread_operands']
    assert report['actual_atomic_operands'] == 354
    read(replay / 'outputs.npz')
    with np.load(replay / 'outputs.npz', allow_pickle=False) as arrays:
        all_expected = []
        for operations in operands['original']['thread_operands']:
            assert len({target for target, _ in operations}) == len(operations)
            expected = np.zeros(48, dtype='<f4')
            for target, word in operations:
                expected[target] = np.float32(expected[target] + np.asarray(word, dtype='<u4').view('<f4')[()])
            all_expected.append(expected)
        expected = np.asarray(all_expected)
        assert expected.shape == (66, 48)
        for backend in ('original-runtime', 'original-ptx', 'source-ptx'):
            assert arrays[backend + '-isolated'].tobytes() == expected.tobytes()
        assert arrays['before'].tobytes() == read(
            capture / 'dump_35add_surface_contact_stiffness_scale_pre_arg1.bin')
        assert arrays['captured_after'].tobytes() == read(
            capture / 'dump_35add_surface_contact_stiffness_scale_post_arg1.bin')
    rows.append({'worker': worker, 'all_three_isolated_outputs_equal_actual_operands': True,
                 'contacts': 66, 'actual_operand_words_per_backend': 354,
                 'aggregate_matches_capture': report['aggregate_matches_captured']})
cross = []
for first in (0, 2):
    captures = [BASE / 'packets' / str(worker) for worker in (first, first + 1)]
    fields = json.loads(read(captures[0] / 'fields.json'))
    assert fields == json.loads(read(captures[1] / 'fields.json'))
    for field, (_, size) in fields.items():
        offset = int(field)
        suffix = '_offset' + field if offset else ''
        name = 'dump_30evaluate_surface_contact_force_pre_arg0' + suffix + '.bin'
        data = [read(folder / name) for folder in captures]
        assert all(len(value) == size for value in data)
        if offset in (16, 24, 32, 40, 48, 56):
            stride = 4 if offset == 32 else 12
            data = [value[:66 * stride] for value in data]
        assert data[0] == data[1], (first, field)
    before = [read(folder / 'dump_35add_surface_contact_stiffness_scale_pre_arg1.bin') for folder in captures]
    assert before[0] == before[1]
    after = [np.frombuffer(read(folder / 'dump_35add_surface_contact_stiffness_scale_post_arg1.bin'), dtype='<f4')
             for folder in captures]
    different = np.flatnonzero(after[0].view('<u4') != after[1].view('<u4')).tolist()
    directories = [FLOW / 'linear-captures-v2' / str(worker) for worker in (first, first + 1)]
    layout = json.loads(read(directories[0] / 'layout.json'))
    assert set(different) <= set(layout['proxy_indices'])
    for directory in directories:
        vertices = np.frombuffer(read(directory / 'dump_22accumulate_vertex_face_call000_pre_arg1.bin'), dtype='<i4')
        assert vertices.tolist() == list(range(8))
    hessians = []
    for kernel, argument in (('22accumulate_vertex_face', 12), ('20accumulate_edge_edge', 10),
                             ('20accumulate_edge_face', 11)):
        data = [read(directory / f'dump_{kernel}_call000_post_arg{argument}.bin') for directory in directories]
        assert data[0] == data[1]
        hessians.append(kernel)
    cross.append({'case': 'SO3' if first == 0 else 'SIX_SPRINGS',
                  'all_meaningful_view_inputs_and_initial_scale_equal': True,
                  'different_scale_indices': different, 'all_changed_scale_indices_are_affine_proxies': True,
                  'first_self_vertex_ids': list(range(8)), 'first_three_self_Hessians_equal': hessians,
                  'scale_difference_is_not_a_proven_cause_of_later_trajectory_error': True})
read(Path(__file__))
OUTPUT.write_text(json.dumps({'packets': rows, 'cross_backend_first_packets': cross,
    'isolated_three_backend_calls': 792, 'equal_actual_operand_words_per_backend': 1416,
    'GPU_scalar_certificates': 155, 'covered_captured_and_aggregate_origin_scalars': 768,
    'GPU_used_for_this_audit': False, 'actual_global_atomic_order_inferred': False,
    'fixed_failures_reclassified': False, 'candidate_promoted': False, 'whole_solver_complete': False,
    'input_sha256': hashes}, indent=2) + '\n')
print('CPU:792 isolated calls/1416 operands/155 GPU certificates checked;first self Hessians remain identical', flush=True)
