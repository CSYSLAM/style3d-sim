"""Audit all50 observed CG core recurrences and the real last-update/first-apply link without loading a solver."""
from collections import defaultdict
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'full50'
OUTPUT = PHASE / 'context-independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((PHASE / 'full-input-replays/plan.json').read_text())
hashes = dict(plan['input_sha256'])
P, D, M = '23precondition_and_reduce', '19update_cg_direction', '26multiply_matrix_and_reduce'
U = '28update_solution_and_residual'
I, A = '27invert_block_preconditioner', '20apply_nonlinear_step'
F = '51evaluate_affine_body_so3_augmented_lagrangian_force'
stages = [defaultdict(dict), defaultdict(dict)]
for packet in plan['packets']:
    stage = packet['stage']
    stages[packet['worker']][stage['kind']][stage['call_ordinal']] = stage
links, growth = [], []
archives = [np.load(PHASE / 'full-input-replays' / f'worker-{i}.npz', allow_pickle=False) for i in (0, 1)]


def get(worker, kind, call, phase, field):
    stage = stages[worker][kind][call]
    return archives[worker][stage['key'] + '/' + phase + '/arg-' + str(field)]


def address(worker, kind, call, field):
    node = stages[worker][kind][call]['node']
    return int.from_bytes(bytes.fromhex(node['parameter_hex'][field]), 'little')


def link(worker, left, right, label):
    a, af, acall = left
    b, bf, bcall = right
    x, y = get(worker, a, acall, 'after', af), get(worker, b, bcall, 'before', bf)
    equal = x.tobytes() == y.tobytes()
    same_address = address(worker, a, acall, af) == address(worker, b, bcall, bf)
    links.append({'worker': worker, 'label': label, 'producer': [a, acall, af], 'consumer': [b, bcall, bf],
                  'observed_bytes_equal': equal, 'same_address': same_address})
    assert equal, links[-1]


try:
    for worker in (0, 1):
        assert all(len(stages[worker][kind]) == 50 for kind in (P, D, M, U))
        assert all(len(stages[worker][kind]) == 5 for kind in (I, A, F))
        assert not get(worker, U, 0, 'before', 6).any()
        link(worker, (F, 6, 0), (P, 1, 0), 'last RHS writer to initial residual')
        for k in range(50):
            order = [stages[worker][kind][k]['node']['owned_launch'] for kind in (P, D, M, U)]
            assert order == sorted(order) and order[-1] < stages[worker][A][0]['node']['owned_launch']
            assert not get(worker, P, k, 'before', 6).any()
            assert not get(worker, M, k, 'before', 9).any()
            link(worker, (I, 3, 0), (P, 0, k), 'fixed inverse to preconditioner')
            link(worker, (P, 2, k), (D, 1, k), 'z to direction')
            link(worker, (P, 6, k), (D, 4, k), 'numerator to direction')
            link(worker, (D, 6, k), (M, 4, k), 'direction to matrix')
            link(worker, (P, 6, k), (U, 2, k), 'numerator to update')
            link(worker, (M, 6, k), (U, 5, k), 'product to update')
            link(worker, (M, 9, k), (U, 3, k), 'denominator to update')
            if k < 49:
                link(worker, (U, 7, k), (P, 1, k + 1), 'residual recurrence')
                link(worker, (U, 6, k), (U, 6, k + 1), 'solution recurrence')
                link(worker, (D, 6, k), (D, 6, k + 1), 'direction recurrence')
                link(worker, (P, 6, k), (D, 5, k + 1), 'previous numerator recurrence')
        link(worker, (U, 6, 49), (A, 2, 0), 'last update to first nonlinear apply')
    for k in range(50):
        row = {'iteration': k}
        for kind, field, label in [(P, 1, 'residual_before'), (P, 6, 'numerator_after'),
                                   (D, 6, 'direction_after'), (M, 5, 'extra_before'),
                                   (M, 6, 'product_after'), (M, 9, 'denominator_after'),
                                   (U, 6, 'solution_after'), (U, 7, 'residual_after')]:
            phase = 'before' if label.endswith('_before') else 'after'
            a, b = [get(worker, kind, k, phase, field).view('<f4') for worker in (0, 1)]
            assert np.isfinite(a).all() and np.isfinite(b).all()
            row[label] = {'max_abs': float(np.max(np.abs(a.astype('f8') - b.astype('f8')))),
                          'different_words': int(np.count_nonzero(a.view('<u4') != b.view('<u4')))}
        growth.append(row)
finally:
    for archive in archives:
        archive.close()
assert len(links) == 1096
for path in (Path(__file__), PHASE / 'full-input-replays/plan.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
result = {'observed_value_links': links, 'all1096_links_equal': True, 'core50_growth': growth,
          'initial_solution_zero': True, 'all_world_scalar_initial_slices_zero': True,
          'all_intermediate_extra_operator_producers_verified': False, 'full_solver_causality_claimed': False,
          'GPU_used': False, 'input_sha256': hashes, 'old_frozen_failures_reclassified': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('CPU verified1096 real value links across50 CG iterations;last update to first apply connected')
