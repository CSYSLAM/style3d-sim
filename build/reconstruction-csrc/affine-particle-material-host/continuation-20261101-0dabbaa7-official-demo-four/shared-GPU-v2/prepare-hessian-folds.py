"""Explain differing first membrane-Hessian words using identical real operands and captured nonzero initial values."""
from collections import defaultdict
import hashlib
import itertools
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'particles-full-inputs'
OUTPUT = PHASE / 'hessian-folds'
OUTPUT.mkdir(exist_ok=False)
plan = json.loads((PHASE / 'full-input-replays/plan.json').read_text())
trace_path = PHASE / 'atomic-operands/report.json'
trace = json.loads(trace_path.read_text())['rows'][2]
assert trace['kind'] == 'add_cloth_membrane_gauss_newton_hessian' and trace['per_thread_sequences_equal']
left, right = plan['packets'][2], plan['packets'][11]
assert left['stage']['kind'] == right['stage']['kind'] == trace['kind']
groups = defaultdict(list)
for lane, rows in enumerate(trace['thread_operands']['original']):
    for ordinal, (label, index, word) in enumerate(rows):
        groups[label, index].append((lane, ordinal, word))
arrays, requests, counts = {}, [], {}
tiny = np.finfo('f4').tiny


def ftz(value):
    return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value


with np.load(left['input'], allow_pickle=False) as a, np.load(right['input'], allow_pickle=False) as b:
    for binding in left['stage']['bindings']:
        key = left['stage']['key'] + '/before/' + binding['label']
        assert a[key].tobytes() == b[key].tobytes(), key
    for label in left['stage']['outputs']:
        key = left['stage']['key'] + '/'
        before = a[key + 'before/' + label].view('<u4')
        originals, sources = a[key + 'after/' + label].view('<u4'), b[key + 'after/' + label].view('<u4')
        different = np.flatnonzero(originals != sources)
        counts[label] = len(different)
        for target_index in different:
            operands = groups[label, int(target_index)]
            assert operands and len({lane for lane, _, _ in operands}) == len(operands)
            values = np.asarray([row[2] for row in operands], dtype='<u4').view('<f4')
            initial = before[target_index].view('<f4')
            wanted = {'original': int(originals[target_index]), 'source': int(sources[target_index])}
            found = {}
            for trial, order in enumerate(itertools.permutations(range(len(values)))):
                history, total = [], initial
                for index in order:
                    history.append(total)
                    total = ftz(np.float32(ftz(total) + ftz(values[index])))
                for side, target in wanted.items():
                    if int(total.view('<u4')) == target and side not in found:
                        found[side] = (np.asarray(order, dtype='<u4'), np.asarray(history, dtype='<f4'))
                if len(found) == 2:
                    break
            assert len(found) == 2, (label, int(target_index), wanted, values.view('<u4').tolist())
            for side, (order, history) in found.items():
                number = len(requests)
                arrays[f'{number}/values'] = values.copy()
                arrays[f'{number}/order'] = order
                arrays[f'{number}/expected-history'] = history
                requests.append({'number': number, 'captured_side': side, 'output_label': label,
                                 'global_word_index': int(target_index), 'initial_bits': int(before[target_index]),
                                 'target_bits': wanted[side], 'recorded_operands': operands, 'search_trials': trial + 1,
                                 'actual_production_order_inferred': False})
assert counts == {'arg-5': 164, 'arg-7': 2} and len(requests) == 332
path = OUTPUT / 'inputs.npz'
np.savez_compressed(path, **arrays)
paths = [Path(__file__), trace_path, PHASE / 'atomic-operands/independent-cpu.json',
         PHASE / 'full-input-replays/plan.json', Path(left['input']), Path(right['input']), path]
result = {'requests': requests, 'differing_words': sum(counts.values()), 'different_by_output': counts,
          'all_actual_before_inputs_equal': True, 'planned_GPU_calls': len(requests), 'input_sha256':
          {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths},
          'GPU_certificate_claimed': False, 'whole_trajectory_accepted': False}
(OUTPUT / 'plan.json').write_text(json.dumps(result, indent=2) + '\n')
print('Prepared166 complete Hessian differences;332 GPU scalar folds;captured nonzero initial values preserved')
