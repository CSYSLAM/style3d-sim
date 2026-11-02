"""Match complete active external contact records and their actual atomic contributions across the two captured runs."""
from collections import Counter, defaultdict, deque
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'native-contact'
OUTPUT = PHASE / 'contact-row-map-independent-cpu.json'
assert not OUTPUT.exists()
plan_path = PHASE / 'full-input-replays/plan.json'
trace_path = PHASE / 'atomic-operands/report.json'
plan = json.loads(plan_path.read_text())
trace = json.loads(trace_path.read_text())
fields = [2, 3, 4, 5, 6, 7, 8, 9, 10]
rows, arrays, hashes = [], {}, {}


def records(archive, packet):
    prefix = packet['stage']['key'] + '/before/arg-'
    count = int(archive[prefix + '0'].view('<i4')[0])
    result = []
    for j in range(count):
        result.append(b''.join(archive[prefix + str(field)].reshape(-1, 4 if field in (2, 3, 9, 10) else 12)[j].tobytes()
                               for field in fields))
    return result


for index in (0, 1):
    left, right = plan['packets'][index], plan['packets'][index + 2]
    stage = left['stage']
    with np.load(left['input'], allow_pickle=False) as a, np.load(right['input'], allow_pickle=False) as b:
        first, second = records(a, left), records(b, right)
        assert len(first) == len(second) == 160 and Counter(first) == Counter(second)
        indices = defaultdict(deque)
        for j, value in enumerate(second):
            indices[value].append(j)
        mapping = [indices[value].popleft() for value in first]
        assert sorted(mapping) == list(range(160))
        unchanged = []
        for binding in stage['bindings']:
            label = binding['label']
            if binding['argument'] in fields or label in stage['outputs']:
                continue
            assert a[stage['key'] + '/before/' + label].tobytes() == b[right['stage']['key'] + '/before/' + label].tobytes()
            unchanged.append(label)
        if index == 0:
            for label in stage['outputs']:
                assert a[stage['key'] + '/before/' + label].tobytes() == b[right['stage']['key'] + '/before/' + label].tobytes()
    total = 0
    for backend in ('original', 'source'):
        first_ops = trace['rows'][index]['thread_operands'][backend]
        second_ops = trace['rows'][index + 2]['thread_operands'][backend]
        assert all(first_ops[j] == second_ops[k] for j, k in enumerate(mapping))
        assert not any(first_ops[160:]) and not any(second_ops[160:])
        total = sum(len(first_ops[j]) for j in range(160))
    arrays[str(index) + '/original_to_source_row'] = np.asarray(mapping, dtype='i4')
    rows.append({'kernel': stage['kind'], 'complete_active_records_equal_as_multiset': 160,
                 'record_bytes_per_row': len(first[0]), 'moved_rows': sum(j != k for j, k in enumerate(mapping)),
                 'actual_atomic_operands_equal_after_row_map': total,
                 'all_noncontact_readonly_before_fields_bitwise_equal': unchanged,
                 'first_force_accumulator_initial_values_equal': index == 0,
                 'production_global_thread_order_inferred': False})
    for packet in (left, right):
        path = Path(packet['input'])
        hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
np.savez_compressed(PHASE / 'contact-row-map.npz', **arrays)
for path in (Path(__file__), plan_path, trace_path, PHASE / 'atomic-operands/independent-cpu.json',
             PHASE / 'contact-row-map.npz'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
OUTPUT.write_text(json.dumps({'rows': rows, 'input_sha256': hashes, 'GPU_used': False,
    'complete_trajectory_equivalence_claimed': False, 'old_failures_reclassified': False}, indent=2) + '\n')
print('CPU verified160 complete contact records permuted;16640 actual force/tangent operands match across runs')
