"""Audit complete observed five-NL RHS/preconditioner/state connections without skipping intervening CG stages."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from schema import RHS, FORCE, ROLL_FORCE, SOFT, BODY, JOINT, LOAD, LIMIT, SO3, BLOCK, CONTACT
from schema import SO3_PRE, DRIVE_PRE, ROLL_PRE, I, PRE, U, APPLY, SO3_STATE, JOINT_STATE, VELOCITY, ANGLE

PHASE = BASE / 'capture/full-input-replays'
OUTPUT = BASE / 'capture/context-independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((PHASE / 'plan.json').read_text())
hashes = dict(plan['input_sha256'])
stages, archives, links, growth = {}, {}, [], []
for packet in plan['packets']:
    stage = packet['stage']
    key, nl = stage['kind'], stage['NL_iteration']
    labels = {b['label'] for b in stage['bindings']}
    role = ('force' if 'arg-36' in labels else 'matrix') if key == SOFT else ''
    if key == LIMIT:
        role = 'force' if 'arg-8' in labels else 'matrix'
    index = packet['worker'], key, nl, role
    assert index not in stages
    stages[index] = stage, packet['input']


def get(worker, key, nl, phase, field, role=''):
    stage, path = stages[worker, key, nl, role]
    if path not in archives:
        archives[path] = np.load(path, allow_pickle=False)
    label = 'arg-' + str(field)
    binding = next(b for b in stage['bindings'] if b['label'] == label)
    return archives[path][stage['key'] + '/' + phase + '/' + label], binding['address']


def link(worker, nl, left, right, label, right_nl=None, require_same_address=True):
    a, af, arole = left
    b, bf, brole = right
    rn = nl if right_nl is None else right_nl
    x, xa = get(worker, a, nl, 'after', af, arole)
    y, ya = get(worker, b, rn, 'before', bf, brole)
    row = {'worker': worker, 'producer_NL': nl, 'consumer_NL': rn, 'producer': list(left), 'consumer': list(right),
           'label': label, 'observed_bytes_equal': x.tobytes() == y.tobytes(), 'same_address': xa == ya,
           'same_address_required': require_same_address}
    links.append(row)
    assert row['observed_bytes_equal'] and (row['same_address'] or not require_same_address), row


rhs_chain = [(RHS, 9, ''), (FORCE, 32, ''), (ROLL_FORCE, 1, ''), (SOFT, 36, 'force'), (BODY, 12, ''),
             (JOINT, 10, ''), (LOAD, 26, ''), (LIMIT, 8, 'force'), (SO3, 6, '')]
pre_chain = [(CONTACT, 34, ''), (SOFT, 41, 'matrix'), (SO3_PRE, 4, ''), (DRIVE_PRE, 17, ''),
             (LIMIT, 9, 'matrix'), (ROLL_PRE, 1, ''), (I, 0, '')]
public_links = []
try:
    for worker in (0, 1):
        for nl in range(5):
            for a, b in zip(rhs_chain, rhs_chain[1:]):
                link(worker, nl, a, b, 'all RHS accumulators in order')
            link(worker, nl, (SO3, 6, ''), (PRE, 1, ''), 'complete RHS copied to initial residual',
                 require_same_address=False)
            link(worker, nl, (FORCE, 33, ''), (SOFT, 37, 'force'), 'contact scalar to soft contact')
            link(worker, nl, (SOFT, 37, 'force'), (BLOCK, 0, ''), 'complete scalar diagonal to blocks')
            link(worker, nl, (BLOCK, 1, ''), (CONTACT, 33, ''), 'initial system blocks')
            link(worker, nl, (BLOCK, 1, ''), (CONTACT, 34, ''), 'system blocks copied to preconditioner',
                 require_same_address=False)
            link(worker, nl, (CONTACT, 33, ''), (SOFT, 40, 'matrix'), 'system contact block accumulation')
            for a, b in zip(pre_chain, pre_chain[1:]):
                link(worker, nl, a, b, 'all preconditioner accumulators in order')
            link(worker, nl, (I, 3, ''), (PRE, 0, ''), 'inverse to first preconditioner')
            link(worker, nl, (U, 6, ''), (APPLY, 2, ''), 'last update to nonlinear apply')
            assert not get(worker, APPLY, nl, 'after', 2)[0].any()
            link(worker, nl, (APPLY, 1, ''), (SO3_STATE, 0, ''), 'applied position to SO3 state')
            if nl < 4:
                link(worker, nl, (APPLY, 1, ''), (JOINT_STATE, 0, ''), 'applied position to joint AL state')
                link(worker, nl, (APPLY, 1, ''), (RHS, 1, ''), 'new position copied into next RHS', nl + 1, False)
                link(worker, nl, (SO3_STATE, 2, ''), (SO3, 3, ''), 'rotation recurrence', nl + 1)
                link(worker, nl, (SO3_STATE, 3, ''), (SO3, 4, ''), 'SO3 multiplier recurrence', nl + 1)
                link(worker, nl, (SO3_STATE, 2, ''), (SO3_PRE, 2, ''), 'rotation to next preconditioner', nl + 1)
                link(worker, nl, (JOINT_STATE, 7, ''), (JOINT, 8, ''), 'joint multiplier recurrence', nl + 1)
                link(worker, nl, (LOAD, 3, ''), (LOAD, 3, ''), 'persistent angle recurrence', nl + 1)
                link(worker, nl, (LOAD, 4, ''), (LOAD, 4, ''), 'persistent initialized recurrence', nl + 1)
        link(worker, 4, (APPLY, 1, ''), (VELOCITY, 2, ''), 'final position to velocity')
        link(worker, 4, (APPLY, 1, ''), (ANGLE, 0, ''), 'final position to drive angle')
        backend = 'original' if worker == 0 else 'source'
        path = BASE / 'capture' / backend / 'raw.npz'
        with np.load(path, allow_pickle=False) as saved:
            for key, field, label in [(APPLY, 1, 'output_particle_q'), (VELOCITY, 3, 'output_particle_qd')]:
                actual = get(worker, key, 4, 'after', field)[0]
                assert actual.tobytes() == saved[label].tobytes()
                public_links.append({'worker': worker, 'native_stage': key, 'public_field': label, 'bytes_equal': True})
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    for nl in range(5):
        row = {'NL_iteration': nl}
        for key, field, role, label in [(RHS, 9, '', 'inertial_RHS'), (SO3, 6, '', 'assembled_RHS'),
                                        (I, 0, '', 'assembled_preconditioner'), (PRE, 6, '', 'first_numerator'),
                                        (U, 6, '', 'last_CG_delta'), (APPLY, 1, '', 'applied_position'),
                                        (SO3_STATE, 2, '', 'updated_rotation')]:
            phase = 'before' if key == I else 'after'
            a, b = [get(worker, key, nl, phase, field, role)[0].view('<f4') for worker in (0, 1)]
            assert np.isfinite(a).all() and np.isfinite(b).all()
            row[label] = {'max_abs': float(np.max(np.abs(a.astype('f8') - b.astype('f8')))),
                          'different_words': int(np.count_nonzero(a.view('<u4') != b.view('<u4')))}
        growth.append(row)
finally:
    for archive in archives.values():
        archive.close()
for path in (Path(__file__), PHASE / 'plan.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
result = {'observed_links': links, 'all_observed_value_links_equal': True, 'public_particle_outputs': public_links,
          'observed_link_count': len(links), 'link_counts_by_label': dict(Counter(row['label'] for row in links)),
          'NL_growth': growth, 'input_sha256': hashes, 'GPU_used_for_this_audit': False,
          'intervening49_CG_iterations_proved_by_this_audit': False, 'global_joint_atomic_order_inferred': False,
          'full_trajectory_failure_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('CPU five-NL actual RHS/preconditioner/state links:', len(links), 'equal;4 public particle fields equal')
