"""Find F32 atomic folds for every differing real replay word while preserving each thread's target-local sequence."""
from collections import defaultdict
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'capture'
OUTPUT = PHASE / 'scalar-folds'
OUTPUT.mkdir(exist_ok=False)
plan = json.loads((PHASE / 'full-input-replays/plan.json').read_text())
report = json.loads((PHASE / 'full-input-replays/report.json').read_text())
trace = json.loads((PHASE / 'atomic-operands/report.json').read_text())
arrays, requests, word_rows, hashes = {}, [], [], {}
tiny = np.finfo('f4').tiny


def ftz(value):
    return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value


for traced in trace['rows']:
    packet_index = traced['packet_index']
    packet, row = plan['packets'][packet_index], report['packets'][packet_index]
    assert traced['per_thread_sequences_equal']
    groups = defaultdict(list)
    for lane, operations in enumerate(traced['thread_operands']['original']):
        for ordinal, (label, index, value) in enumerate(operations):
            groups[label, index].append((lane, ordinal, value))
    stage = packet['stage']
    with np.load(packet['input'], allow_pickle=False) as inputs, np.load(row['output'], allow_pickle=False) as raw:
        for label in stage['outputs']:
            key = stage['key'] + '/'
            before = inputs[key + 'before/' + label].view('<u4')
            targets = {'captured': inputs[key + 'after/' + label].view('<u4')}
            targets.update({side: raw[side + '-output-' + label].view('<u4') for side in plan['backends']})
            different = np.any(np.asarray(list(targets.values())) != targets['captured'], axis=0)
            for index in np.flatnonzero(different):
                operands = groups[label, int(index)]
                values = np.asarray([record[2] for record in operands], dtype='<u4').view('<f4')
                lanes = sorted({record[0] for record in operands})
                chains = [[i for i, record in enumerate(operands) if record[0] == lane] for lane in lanes]
                wanted = {int(value[index]) for value in targets.values()}
                found, seen = {}, set()

                def search(cursors, total, order, history):
                    state = (cursors, int(total.view('<u4')))
                    if state in seen:
                        return
                    seen.add(state)
                    if len(order) == len(values):
                        if state[1] in wanted:
                            found.setdefault(state[1], (order, history))
                        return
                    for lane, chain in enumerate(chains):
                        if cursors[lane] == len(chain):
                            continue
                        position = chain[cursors[lane]]
                        next_cursors = list(cursors)
                        next_cursors[lane] += 1
                        result = ftz(np.float32(ftz(total) + ftz(values[position])))
                        search(tuple(next_cursors), result, order + [position], history + [total])
                        if wanted <= found.keys():
                            return

                trials = 0
                method = 'constrained exhaustive search'
                if len(values) <= 8:
                    search((0,) * len(chains), before[index].view('<f4'), [], [])
                else:
                    assert len(values) == 68 and all(len(chain) == 1 for chain in chains)
                    method = 'seeded actual-operand permutations'
                    seed = hashlib.sha256(f'{packet_index}/{label}/{int(index)}/{sorted(wanted)}'.encode()).hexdigest()
                    rng = np.random.default_rng(int(seed[:16], 16))
                    for trials in range(1, 10001):
                        order = np.arange(len(values)) if trials == 1 else rng.permutation(len(values))
                        total, history = before[index].view('<f4'), []
                        for position in order:
                            history.append(total)
                            total = ftz(np.float32(ftz(total) + ftz(values[position])))
                        bits = int(total.view('<u4'))
                        if bits in wanted:
                            found.setdefault(bits, (order.tolist(), history))
                        if wanted <= found.keys():
                            break

                assert wanted <= found.keys(), (packet_index, label, int(index), wanted - found.keys())
                word_rows.append({'packet_index': packet_index, 'output_label': label, 'word_index': int(index),
                                  'actual_target_bits': sorted(wanted), 'visited_search_states': len(seen),
                                  'search_method': method, 'permutation_trials': trials})
                for target, (order, history) in sorted(found.items()):
                    number = len(requests)
                    arrays[f'{number}/values'] = values.copy()
                    arrays[f'{number}/order'] = np.asarray(order, dtype='<u4')
                    arrays[f'{number}/expected-history'] = np.asarray(history, dtype='<f4')
                    requests.append({'number': number, 'packet_index': packet_index, 'output_label': label,
                                     'global_word_index': int(index), 'initial_bits': int(before[index]),
                                     'target_bits': target, 'recorded_operands': operands,
                                     'within_thread_target_order_preserved': True})
                hashes[str(Path(row['output']).resolve())] = hashlib.sha256(Path(row['output']).read_bytes()).hexdigest()
                hashes[str(Path(packet['input']).resolve())] = hashlib.sha256(Path(packet['input']).read_bytes()).hexdigest()
path = OUTPUT / 'inputs.npz'
np.savez_compressed(path, **arrays)
for path in (Path(__file__), path, PHASE / 'full-input-replays/plan.json', PHASE / 'full-input-replays/report.json',
             PHASE / 'atomic-operands/report.json', PHASE / 'atomic-operands/independent-cpu.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
result = {'requests': requests, 'differing_words': len(word_rows), 'words': word_rows, 'input_sha256': hashes,
          'planned_GPU_calls': len(requests), 'GPU_certificate_claimed': False,
          'production_global_order_inferred': False, 'whole_trajectory_accepted': False}
(OUTPUT / 'plan.json').write_text(json.dumps(result, indent=2) + '\n')
print('Prepared all', len(word_rows), 'differing contact/PCG replay words;', len(requests), 'real GPU targets planned')
