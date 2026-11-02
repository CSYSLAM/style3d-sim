"""Independently connect every captured first-NL direction and six ordered extra writers to matrix.arg5."""
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from schema import KEYS, SO3, CONTACT, SOFT, DRIVE, LIMIT, ROLL, DIRECTION, MATRIX, integer

PHASE = BASE / 'capture/full-input-replays'
OUTPUT = BASE / 'capture/context-independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((PHASE / 'plan.json').read_text())
hashes = dict(plan['input_sha256'])
stages = [defaultdict(dict), defaultdict(dict)]
for packet in plan['packets']:
    stage = packet['stage']
    stages[packet['worker']][stage['kind']][stage['CG_iteration']] = (stage, packet['input'])
archives = {}
links, rows = [], []


def get(worker, key, iteration, phase, label):
    stage, path = stages[worker][key][iteration]
    if path not in archives:
        archives[path] = np.load(path, allow_pickle=False)
    return archives[path][stage['key'] + '/' + phase + '/' + label]


def address(worker, key, iteration, label):
    stage = stages[worker][key][iteration][0]
    binding = next(b for b in stage['bindings'] if b['label'] == label)
    return binding['address']


def link(worker, iteration, left, right, label):
    a, af = left
    b, bf = right
    x = get(worker, a, iteration, 'after', af)
    y = get(worker, b, iteration, 'before', bf)
    same_address = address(worker, a, iteration, af) == address(worker, b, iteration, bf)
    equal = x.tobytes() == y.tobytes()
    links.append({'worker': worker, 'iteration': iteration, 'label': label, 'producer': [a, af],
                  'consumer': [b, bf], 'same_address': same_address, 'observed_bytes_equal': equal})
    assert equal and same_address, links[-1]


changed, active_counts = Counter(), defaultdict(set)
directions = {SO3: 0, CONTACT: 29, SOFT: 24, DRIVE: 1, LIMIT: 7, ROLL: 1, MATRIX: 4}
products = [(SO3, 'arg-5'), (CONTACT, 'arg-30'), (SOFT, 'arg-25'), (DRIVE, 'arg-18'),
            (LIMIT, 'arg-8'), (ROLL, 'arg-2'), (MATRIX, 'arg-5')]
try:
    for worker in (0, 1):
        assert all(len(stages[worker][key]) == 50 for key in KEYS)
        for iteration in range(50):
            owned = [stages[worker][key][iteration][0]['node']['owned_launch'] for key in KEYS]
            assert owned == list(range(25 + 10 * iteration, 33 + 10 * iteration)), owned
            assert not get(worker, SO3, iteration, 'before', 'arg-5').any()
            for key, field in directions.items():
                link(worker, iteration, (DIRECTION, 'arg-6'), (key, 'arg-' + str(field)), 'actual direction')
            for left, right in zip(products, products[1:]):
                link(worker, iteration, left, right, 'ordered extra product accumulation')
            for key, label in products[:-1]:
                before = get(worker, key, iteration, 'before', label)
                after = get(worker, key, iteration, 'after', label)
                changed[key] += before.tobytes() != after.tobytes()
                if key in (CONTACT, SOFT):
                    count = get(worker, key, iteration, 'before', 'arg-0').view('<i4')
                    assert count.shape == (1,)
                    active_counts[key].add(int(count[0]))
                elif key == ROLL:
                    count = get(worker, key, iteration, 'before', 'view-0-0').view('<i4')
                    active_counts[key].add(int(count[0]))
            row = {'iteration': iteration}
            for key, label in products[:-1] + [(DIRECTION, 'arg-6'), (MATRIX, 'arg-6')]:
                a, b = [get(w, key, iteration, 'after', label).view('<f4') for w in (0, 1)]
                assert np.isfinite(a).all() and np.isfinite(b).all()
                row[key] = {'max_abs': float(np.max(np.abs(a.astype('f8') - b.astype('f8')))),
                            'different_words': int(np.count_nonzero(a.view('<u4') != b.view('<u4')))}
            if worker == 0:
                rows.append(row)
finally:
    for archive in archives.values():
        archive.close()
assert len(links) == 1300
for path in (Path(__file__), PHASE / 'plan.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
result = {'observed_links': links, 'all1300_observed_links_have_same_address_and_bytes': True,
          'all100_initial_extra_buffers_zero': True, 'changed_packets_by_operator': dict(changed),
          'actual_contact_counts_by_operator': {key: sorted(value) for key, value in active_counts.items()},
          'cross_backend_growth': rows, 'input_sha256': hashes, 'GPU_used_for_this_audit': False,
          'same_input_kernel_formula_equivalence_claimed_by_this_context_audit': False,
          'full_trajectory_failure_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('CPU1300 actual address/value links equal across50 extra chains;100 actual initial buffers zero')
print('Actual active contact counts:', result['actual_contact_counts_by_operator'])
print('Changed complete extra-product packets:', result['changed_packets_by_operator'])
