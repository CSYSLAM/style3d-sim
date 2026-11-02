"""Find exact F32 folds for every differing captured first-stretch scalar using the recorded real atomic operands."""
from collections import defaultdict
import hashlib
import itertools
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'particles-full-inputs'
OUTPUT = PHASE / 'stretch-folds'
OUTPUT.mkdir(exist_ok=False)
plan = json.loads((PHASE / 'full-input-replays/plan.json').read_text())
trace_path = PHASE / 'atomic-operands/report.json'
trace = json.loads(trace_path.read_text())['rows'][0]
assert trace['kind'] == '22evaluate_stretch_force' and trace['per_thread_sequences_equal']
left, right = plan['packets'][0], plan['packets'][9]
assert left['stage']['kind'] == right['stage']['kind'] == trace['kind']
with np.load(left['input'], allow_pickle=False) as a, np.load(right['input'], allow_pickle=False) as b:
    for binding in left['stage']['bindings']:
        label = binding['label']
        assert a[left['stage']['key'] + '/before/' + label].tobytes() == b[right['stage']['key'] + '/before/' + label].tobytes()
    before = a[left['stage']['key'] + '/before/arg-5'].copy().view('<u4')
    originals = a[left['stage']['key'] + '/after/arg-5'].copy().view('<u4')
    sources = b[right['stage']['key'] + '/after/arg-5'].copy().view('<u4')
different = np.flatnonzero(originals != sources)
assert len(different) == 215 and not before[different].any()
groups = defaultdict(list)
for lane, rows in enumerate(trace['thread_operands']['original']):
    for ordinal, (label, index, word) in enumerate(rows):
        assert label == 'arg-5'
        groups[index].append((lane, ordinal, word))
arrays, requests = {}, []
tiny = np.finfo('f4').tiny


def ftz(value):
    return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value


for target_index in different:
    operands = groups[int(target_index)]
    assert len({lane for lane, _, _ in operands}) == len(operands)
    values = np.asarray([row[2] for row in operands], dtype='<u4').view('<f4')
    wanted = {'original': int(originals[target_index]), 'source': int(sources[target_index])}
    found = {}
    for trial, order in enumerate(itertools.permutations(range(len(values)))):
        history, total = [], np.float32(0)
        for index in order:
            history.append(total)
            total = ftz(np.float32(total + ftz(values[index])))
        bits = int(total.view('<u4'))
        for side, target in wanted.items():
            if bits == target and side not in found:
                found[side] = (np.asarray(order, dtype='<u4'), np.asarray(history, dtype='<f4'))
        if len(found) == 2:
            break
    assert len(found) == 2, (int(target_index), wanted, values.view('<u4').tolist())
    for side, (order, history) in found.items():
        number = len(requests)
        arrays[str(number) + '/values'] = values.copy()
        arrays[str(number) + '/order'] = order
        arrays[str(number) + '/expected-history'] = history
        requests.append({'number': number, 'captured_side': side, 'global_word_index': int(target_index),
                         'initial_bits': int(before[target_index]), 'target_bits': wanted[side],
                         'recorded_operands': operands, 'search_trials': trial + 1,
                         'actual_production_order_inferred': False})
path = OUTPUT / 'inputs.npz'
np.savez_compressed(path, **arrays)
paths = [Path(__file__), trace_path, PHASE / 'atomic-operands/independent-cpu.json',
         PHASE / 'full-input-replays/plan.json', Path(left['input']), Path(right['input']), path]
result = {'requests': requests, 'differing_words': len(different), 'all_actual_before_inputs_equal': True,
          'planned_GPU_calls': len(requests), 'input_sha256':
          {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths},
          'GPU_certificate_claimed': False, 'whole_trajectory_accepted': False}
(OUTPUT / 'plan.json').write_text(json.dumps(result, indent=2) + '\n')
print('Prepared exact F32 folds:', len(different), 'differing captured words;', len(requests), 'GPU calls planned')
