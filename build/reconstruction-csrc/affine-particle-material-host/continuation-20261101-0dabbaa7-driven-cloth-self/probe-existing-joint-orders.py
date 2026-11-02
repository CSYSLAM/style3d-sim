"""Test whether existing scalar proposals admit one order respecting every original thread's full atomic sequence."""
import heapq
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
rows = []
for folder in sorted((BASE / 'first-surface-replays').glob('*/*')):
    if not (folder / 'report.json').exists():
        continue
    report = json.loads((folder / 'report.json').read_text())
    threads = json.loads((folder / 'atomic-operands.json').read_text())['original']['thread_operands']
    operations, per_target, per_thread = [], [[] for _ in range(144)], []
    for lane, values in enumerate(threads):
        chain = []
        for ordinal, (target, bits) in enumerate(values):
            index = len(operations)
            operations.append((target, bits, lane, ordinal))
            per_target[target].append(index)
            chain.append(index)
        per_thread.append(chain)
    with np.load(folder / 'outputs.npz', allow_pickle=False) as data:
        before = data['before'].copy()
    values = np.asarray([row[1] for row in operations], dtype='<u4').view('<f4')
    targets = np.asarray([row[0] for row in operations], dtype='<u4')
    for name in ('captured', 'original-runtime', 'original-ptx', 'source-ptx'):
        proposals = report['witnesses'][name]
        if not all(row['exact_float32_witness'] for row in proposals):
            rows.append({'packet': str(folder), 'target': name, 'all_scalar_proposals_found': False})
            continue
        edges = [set() for _ in operations]
        for chain in per_thread:
            for a, b in zip(chain, chain[1:]):
                edges[a].add(b)
        for scalar, proposal in enumerate(proposals):
            assert scalar == proposal['scalar']
            sequence = [per_target[scalar][i] for i in proposal['order']
                        if operations[per_target[scalar][i]][1] & 0x7fffffff]
            for a, b in zip(sequence, sequence[1:]):
                edges[a].add(b)
        degree = [0] * len(operations)
        for successors in edges:
            for b in successors:
                degree[b] += 1
        ready = [i for i, n in enumerate(degree) if not n]
        heapq.heapify(ready)
        order = []
        while ready:
            index = heapq.heappop(ready)
            order.append(index)
            for nxt in edges[index]:
                degree[nxt] -= 1
                if not degree[nxt]:
                    heapq.heappush(ready, nxt)
        row = {'packet': str(folder), 'target': name, 'all_scalar_proposals_found': True,
               'topological_nodes': len(order), 'total_nodes': len(operations),
               'remaining_cycle_and_downstream_nodes': len(operations) - len(order), 'GPU_verified': False}
        if len(order) == len(operations):
            result = before.copy()
            np.add.at(result, targets[order], values[order])
            wanted = np.asarray([p['target_bits'] for p in proposals], dtype='<u4')
            row['CPU_complete_vector_matches'] = result.tobytes() == wanted.tobytes()
            if row['CPU_complete_vector_matches']:
                path = BASE / ('joint-proposal-' + str(len(rows)) + '.npz')
                np.savez_compressed(path, operations=np.asarray(operations, dtype='<u4'),
                                    order=np.asarray(order, dtype='<u4'), before=before, target=wanted)
                row['proposal'] = str(path)
        rows.append(row)
(BASE / 'existing-joint-order-probe.json').write_text(json.dumps({'rows': rows,
    'GPU_used': False, 'whole_solver_complete': False}, indent=2) + '\n')
print('Existing proposals:', sum(row.get('CPU_complete_vector_matches', False) for row in rows), '/', len(rows),
      'complete CPU vectors;remaining topology counts', [row.get('topological_nodes') for row in rows])
