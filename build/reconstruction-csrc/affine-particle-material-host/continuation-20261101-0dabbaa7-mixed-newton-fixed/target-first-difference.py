"""Locate the first world85 payload difference and bind it to the saved actual GPU atomic-fold evidence."""
import hashlib
import itertools
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
pair = BASE / 'frozen-reproduced-mixed-pair'
folders = [pair / side / 'native' for side in ('legacy', 'source')]
vectors = {'x', 'v', 'q', 'rhs', 'r', 'p', 'z', 'ap', 'dx', 'target', 'previous', 'external'}
matrices = {'blocks', 'diagonal', 'inverse'}
groups = {'numerator', 'denominator', 'previous_numerator'}
inputs, examined, unmapped, first = {}, 0, [], None


def read(path):
    data = path.read_bytes()
    inputs[str(path)] = hashlib.sha256(data).hexdigest()
    return data


for metadata in sorted(folders[0].glob('*.json')):
    if metadata.name == 'deferred-receipt.json':
        continue
    prefix = metadata.name[:-4]
    differences = []
    for phase in ('before', 'after'):
        for path in sorted(folders[0].glob(prefix + phase + '.*.bin')):
            if '.param_' in path.name:
                continue
            left, right = read(path), read(folders[1] / path.name)
            examined += 1
            if left == right:
                continue
            label = path.name.removesuffix('.bin').rsplit('.', 1)[1]
            assert len(left) == len(right)
            if label in vectors | matrices and len(left) == 387 * (12 if label in vectors else 36):
                width = 12 if label in vectors else 36
                select = lambda data: np.frombuffer(data, dtype='u1').reshape(387, width)[255:258]
            elif label == 'entries' and len(left) == 2 * 387 * 40:
                select = lambda data: np.frombuffer(data, dtype='u1').reshape(2, 387, 40)[:, 255:258]
            elif label in groups and len(left) % 129 == 0:
                select = lambda data: np.frombuffer(data, dtype='u1').reshape(129, -1)[85]
            else:
                unmapped.append(path.name)
                continue
            if select(left).tobytes() != select(right).tobytes():
                differences.append({'phase': phase, 'label': label})
    if differences:
        first = {'packet': metadata.name, 'differences': differences}
        break
assert not unmapped and first is not None
assert first['packet'] == '000090.21evaluate_spring_forceE.json'
assert first['differences'] == [{'phase': 'after', 'label': 'rhs'}]
prefix = first['packet'][:-4]
for label in ('indices', 'stiffness', 'rest'):
    assert read(folders[0] / (prefix + 'before.' + label + '.bin')) == \
        read(folders[1] / (prefix + 'before.' + label + '.bin'))
with np.load(BASE / 'replays/legacy-NL2/contributions.npz') as old, \
        np.load(BASE / 'replays/source-NL2/contributions.npz') as new:
    operands = [data['90_diagonal'].reshape(129, 3, 2, 3)[85] for data in (old, new)]
    assert operands[0].tobytes() == operands[1].tobytes()
    before, after, folds = {}, {}, {}
    for side, data in (('legacy', old), ('source', new)):
        tag = '90_diagonal_' + side
        before[side] = data[tag + '_before'][255:258]
        after[side] = data[tag + '_after'][255:258]
        folds[side] = data[tag + '_hardware_folds'][:, 255:258]
        assert np.all((folds[side].view('u4') == after[side].view('u4')[None]).any(axis=0))
        for phase, values in (('before', before[side]), ('after', after[side])):
            raw = read(pair / side / 'native' / (prefix + phase + '.rhs.bin'))
            assert np.frombuffer(raw, dtype='<f4').reshape(387, 3)[255:258].tobytes() == values.tobytes()
    assert before['legacy'].tobytes() == before['source'].tobytes()
    assert folds['legacy'].tobytes() == folds['source'].tobytes()
    orders = list(itertools.permutations(range(3)))
    whole_target_orders = {side: [orders[i] for i in range(6) if folds[side][i].tobytes() == after[side].tobytes()]
                           for side in ('legacy', 'source')}
record = {'first_world85_difference': first, 'examined_semantic_buffers': examined,
          'earlier_differing_buffers_without_known_layout': unmapped,
          'world85_before_RHS_and_isolated_spring_operands_identical': True,
          'world85_six_actual_GPU_folds_identical': True, 'whole_target_matching_orders': whole_target_orders,
          'actual_global_atomic_order_inferred': False, 'input_sha256': inputs,
          'fixed_C10_reclassified': False, 'whole_solver_complete': False}
(BASE / 'target-first-difference.json').write_text(json.dumps(record, indent=2) + '\n')
print('First world85 difference:', first, 'legal GPU folds:', whole_target_orders)
