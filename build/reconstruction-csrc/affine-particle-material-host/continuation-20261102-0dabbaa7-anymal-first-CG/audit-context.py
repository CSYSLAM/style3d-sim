"""Independently inspect captured producer/consumer values and first-CG cross-backend differences without using a solver."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare, parameter_types, schemas

PHASE = BASE / 'capture'
OUTPUT = PHASE / 'context-independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((PHASE / 'full-input-replays/plan.json').read_text())
status = json.loads((PHASE / 'status.json').read_text())
assert status['complete'] and all(row['actual_exit'] == 0 for row in status['completed'])
metadata = compare(PHASE / 'original/launches.txt', PHASE / 'source/launches.txt', schemas()[0])
assert metadata['equal'] and metadata['left_launches'] == metadata['right_launches'] == 2608
hashes = dict(plan['input_sha256'])
by_worker = [{packet['stage']['kind']: packet for packet in plan['packets'] if packet['worker'] == worker}
             for worker in (0, 1)]
arrays = []
for worker in (0, 1):
    path = PHASE / 'full-input-replays' / f'worker-{worker}.npz'
    with np.load(path, allow_pickle=False) as raw:
        arrays.append({key: raw[key].copy() for key in raw.files})
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()


def get(worker, kind, phase, field):
    packet = by_worker[worker][kind]
    return arrays[worker][packet['stage']['key'] + '/' + phase + '/arg-' + str(field)]


def pointer(worker, kind, field):
    node = by_worker[worker][kind]['stage']['node']
    return int.from_bytes(bytes.fromhex(node['parameter_hex'][field]), 'little')


F, T = '22evaluate_contact_force', '24evaluate_contact_tangent'
I, P, D = '27invert_block_preconditioner', '23precondition_and_reduce', '19update_cg_direction'
M, U, A = '26multiply_matrix_and_reduce', '28update_solution_and_residual', '20apply_nonlinear_step'
links = [(F, 32, P, 1), (T, 34, I, 0), (I, 3, P, 0), (P, 2, D, 1), (P, 6, D, 4),
         (D, 6, M, 4), (P, 6, U, 2), (M, 6, U, 5), (M, 9, U, 3)]
edges = []
for worker in (0, 1):
    for producer, output, consumer, argument in links:
        left, right = get(worker, producer, 'after', output), get(worker, consumer, 'before', argument)
        edges.append({'worker': worker, 'producer': producer, 'output': output,
                      'consumer': consumer, 'argument': argument,
                      'observed_same_address': pointer(worker, producer, output) == pointer(worker, consumer, argument),
                      'observed_values_bitwise_equal': left.tobytes() == right.tobytes()})
    assert pointer(worker, I, 0) == pointer(worker, I, 3)
    for phase in ('before', 'after'):
        assert get(worker, I, phase, 0).tobytes() == get(worker, I, phase, 3).tobytes()
    for kind, field in ((P, 6), (M, 9)):
        assert get(worker, kind, 'before', field).shape == (32,)
        assert not get(worker, kind, 'before', field).any()
comparisons = []
for kind, packet in by_worker[0].items():
    fields = []
    types = parameter_types(packet['stage']['node']['name'])
    for binding in packet['stage']['bindings']:
        field = binding['argument']
        for phase in ('before', 'after'):
            left, right = get(0, kind, phase, field), get(1, kind, phase, field)
            assert left.dtype == right.dtype == np.dtype('u1') and left.shape == right.shape
            row = {'argument': field, 'phase': phase, 'different_bytes': int(np.count_nonzero(left != right))}
            if 'float' in types[field]:
                a, b = left.view('<f4'), right.view('<f4')
                assert np.isfinite(a).all() and np.isfinite(b).all()
                row['max_abs'] = float(np.abs(a.astype('f8') - b.astype('f8')).max())
            fields.append(row)
    comparisons.append({'kernel': kind, 'fields': fields})
apply = []
for worker in (0, 1):
    first = get(worker, U, 'after', 6)
    last = get(worker, A, 'before', 2)
    apply.append({'worker': worker, 'same_delta_address': pointer(worker, U, 6) == pointer(worker, A, 2),
                  'first_update_and_first_apply_delta_equal': first.tobytes() == last.tobytes(),
                  'CG_iterations_between_first_update_and_apply': 49, 'direct_value_link_claimed': False})
for path in (Path(__file__), PHASE / 'status.json', PHASE / 'original/launches.txt', PHASE / 'source/launches.txt'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
result = {'metadata': metadata, 'observed_edges': edges, 'cross_backend_buffers': comparisons,
          'inverse_aliases_verified': 2, 'world_scalar_count': 8, 'first_apply_scope': apply,
          'input_sha256': hashes, 'GPU_used': False, 'unobserved_memcpy_operations_claimed': False,
          'whole50_CG_propagation_proved': False, 'old_failures_reclassified': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('CPU verified16 complete packets and18 observed producer/consumer comparisons;first apply scope explicit')
print('Equal value edges', sum(edge['observed_values_bitwise_equal'] for edge in edges), '/', len(edges))
