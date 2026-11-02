"""Audit all observed initialization, five-NL assembly,250-CG and public-output links in one real capture."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from schema import rhs as verified, extra, STEP, REFRESH, DIAGONALS, SO3_INIT, JOINT_INIT, COMBINE, BLOCK_INIT
from collections import defaultdict
from functools import lru_cache
RHS = verified.RHS
FORCE = verified.FORCE
ROLL_FORCE = verified.ROLL_FORCE
SOFT = verified.SOFT
BODY = verified.BODY
JOINT = verified.JOINT
LOAD = verified.LOAD
LIMIT = verified.LIMIT
SO3 = verified.SO3
BLOCK = verified.BLOCK
CONTACT = verified.CONTACT
SO3_PRE = verified.SO3_PRE
DRIVE_PRE = verified.DRIVE_PRE
ROLL_PRE = verified.ROLL_PRE
I = verified.I
PRE = verified.PRE
U = verified.U
APPLY = verified.APPLY
SO3_STATE = verified.SO3_STATE
JOINT_STATE = verified.JOINT_STATE
VELOCITY = verified.VELOCITY
ANGLE = verified.ANGLE

PHASE = BASE / 'capture/full-input-replays'
OUTPUT = BASE / 'capture/context-independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((PHASE / 'plan.json').read_text())
hashes = dict(plan['input_sha256'])
stages, archives, links, growth = defaultdict(list), {}, [], []
for packet in plan['packets']:
    stage = packet['stage']
    key, nl = stage['kind'], stage['NL_iteration']
    labels = {b['label'] for b in stage['bindings']}
    role = ('force' if 'arg-36' in labels else 'matrix') if key == SOFT else ''
    if key == LIMIT:
        role = 'tangent' if 'arg-7' in labels else ('force' if 'arg-8' in labels else 'matrix')
    if key == CONTACT and 'arg-30' in labels:
        role = 'tangent'
    index = packet['worker'], key, nl, role
    stages[index].append((stage, packet['input']))


@lru_cache(maxsize=128)
def get(worker, key, nl, phase, field, role='', cg=None):
    options = stages[worker, key, nl, role]
    if cg is None and key in (PRE, U):
        cg = 0 if key == PRE else 49
    if cg is not None:
        options = [(stage, path) for stage, path in options if stage['CG_iteration'] == cg]
    assert len(options) == 1, (worker, key, nl, role, cg, len(options))
    stage, path = options[0]
    if path not in archives:
        archives[path] = np.load(path, allow_pickle=False)
    label = 'arg-' + str(field)
    binding = next(b for b in stage['bindings'] if b['label'] == label)
    return archives[path][stage['key'] + '/' + phase + '/' + label], binding['address']


def link(worker, nl, left, right, label, right_nl=None, require_same_address=True, left_cg=None, right_cg=None):
    a, af, arole = left
    b, bf, brole = right
    rn = nl if right_nl is None else right_nl
    x, xa = get(worker, a, nl, 'after', af, arole, left_cg)
    y, ya = get(worker, b, rn, 'before', bf, brole, right_cg)
    row = {'worker': worker, 'producer_NL': nl, 'consumer_NL': rn, 'producer': list(left), 'consumer': list(right),
           'label': label, 'observed_bytes_equal': x.tobytes() == y.tobytes(), 'same_address': xa == ya,
           'same_address_required': require_same_address, 'producer_CG': left_cg, 'consumer_CG': right_cg}
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

    # All links below use this capture's own arrays; no prior first-NL histories are substituted.
    for worker in (0, 1):
        link(worker, -1, (REFRESH, 6, ''), (COMBINE, 7, ''), 'refreshed mass ELL to combination')
        link(worker, -1, (REFRESH, 7, ''), (COMBINE, 8, ''), 'refreshed body ELL to combination')
        link(worker, -1, (DIAGONALS, 3, ''), (STEP, 7, ''), 'refreshed scaled mass diagonal')
        link(worker, -1, (DIAGONALS, 4, ''), (STEP, 9, ''), 'refreshed mass diagonal')
        link(worker, -1, (COMBINE, 13, ''), (BLOCK_INIT, 0, ''), 'combined ELL to block template')
        link(worker, -1, (STEP, 5, ''), (SO3_INIT, 0, ''), 'predicted position to initial SO3')
        link(worker, -1, (STEP, 5, ''), (RHS, 1, ''), 'predicted position to first RHS', right_nl=0)
        link(worker, -1, (SO3_INIT, 2, ''), (SO3, 3, ''), 'initial rotation to first SO3 RHS', right_nl=0)
        link(worker, -1, (SO3_INIT, 3, ''), (SO3, 4, ''), 'initial multiplier to first SO3 RHS', right_nl=0)
        link(worker, -1, (JOINT_INIT, 0, ''), (JOINT, 8, ''), 'initial joint multiplier to first RHS', right_nl=0)
        assert not get(worker, SO3_INIT, -1, 'after', 3)[0].any()
        assert not get(worker, JOINT_INIT, -1, 'after', 0)[0].any()
        local_rows = get(worker, BLOCK_INIT, -1, 'before', 1)[0]
        for nl in range(5):
            link(worker, -1, (STEP, 21, ''), (RHS, 2, ''), 'fixed predicted target to each RHS', right_nl=nl)
            link(worker, -1, (STEP, 22, ''), (FORCE, 33, ''), 'restored base diagonal before forces', right_nl=nl)
            assert not get(worker, U, nl, 'before', 6, cg=0)[0].any()
            for cg in range(50):
                for a, af, b, bf, label in [
                    (I, 3, PRE, 0, 'fixed inverse throughout CG'),
                    (PRE, 2, extra.DIRECTION, 1, 'preconditioned residual to direction'),
                    (PRE, 6, extra.DIRECTION, 4, 'numerator to direction'),
                    (PRE, 6, U, 2, 'numerator to solution update'),
                    (extra.MATRIX, 6, U, 5, 'matrix product to residual update'),
                    (extra.MATRIX, 9, U, 3, 'denominator to solution update'),
                ]:
                    link(worker, nl, (a, af, ''), (b, bf, ''), label,
                         left_cg=None if a == I else cg, right_cg=cg)
                assert not get(worker, PRE, nl, 'before', 6, cg=cg)[0].any()
                assert not get(worker, extra.MATRIX, nl, 'before', 9, cg=cg)[0].any()
                directions = [(extra.SO3, 0, ''), (CONTACT, 29, 'tangent'), (extra.SOFT, 24, ''),
                              (extra.DRIVE, 1, ''), (LIMIT, 7, 'tangent'), (extra.ROLL, 1, ''), (extra.MATRIX, 4, '')]
                for target in directions:
                    link(worker, nl, (extra.DIRECTION, 6, ''), target, 'actual direction to every extra/matrix',
                         left_cg=cg, right_cg=cg)
                products = [(extra.SO3, 5, ''), (CONTACT, 30, 'tangent'), (extra.SOFT, 25, ''),
                            (extra.DRIVE, 18, ''), (LIMIT, 8, 'tangent'), (extra.ROLL, 2, ''), (extra.MATRIX, 5, '')]
                assert not get(worker, extra.SO3, nl, 'before', 5, cg=cg)[0].any()
                for a, b in zip(products, products[1:]):
                    link(worker, nl, a, b, 'complete ordered extra accumulation', left_cg=cg, right_cg=cg)
                link(worker, -1, (BLOCK_INIT, 4, ''), (extra.MATRIX, 1, ''), 'block template in actual CG matrix',
                     right_nl=nl, require_same_address=False, right_cg=cg)
                actual_rows = get(worker, extra.MATRIX, nl, 'before', 0, cg=cg)[0]
                assert np.tile(local_rows, 8).tobytes() == actual_rows.tobytes()
                if cg < 49:
                    for a, af, b, bf, label in [
                        (U, 7, PRE, 1, 'every residual recurrence'), (U, 6, U, 6, 'every delta recurrence'),
                        (extra.DIRECTION, 6, extra.DIRECTION, 6, 'every direction recurrence'),
                        (PRE, 6, extra.DIRECTION, 5, 'every previous-numerator recurrence'),
                    ]:
                        link(worker, nl, (a, af, ''), (b, bf, ''), label, left_cg=cg, right_cg=cg + 1)

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
          'all250_CG_iteration_observed_links_checked': True, 'global_joint_atomic_order_inferred': False,
          'full_trajectory_failure_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('CPU full native-step actual value links:', len(links), 'equal;4 public particle fields equal')
