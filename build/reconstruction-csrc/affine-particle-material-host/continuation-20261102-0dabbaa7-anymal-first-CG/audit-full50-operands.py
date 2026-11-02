"""Independently rebuild raw atomic traces, parameter bytes and guards from the saved complete cloth packets."""
from collections import Counter
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'full50/atomic-operands'
OUTPUT = PHASE / 'independent-cpu.json'
assert not OUTPUT.exists()
report = json.loads((PHASE / 'report.json').read_text())
hashes = dict(report['input_sha256'])
checked, protected, parameter_bytes = [], 0, 0
for number, row in enumerate(report['rows']):
    stage = row['stage']
    path = Path(row['captured_input'])
    with np.load(path, allow_pickle=False) as data:
        before = {b['label']: data[stage['key'] + '/before/' + b['label']].copy() for b in stage['bindings']}
    bindings = {b['label']: b for b in stage['bindings']}
    raw = [bytearray.fromhex(value) for value in stage['node']['parameter_hex']]
    for binding in stage['bindings']:
        i = binding['argument']
        pointer = row['pointers'][binding['label']]
        assert pointer % 256 == binding['address'] % 256
        raw[i] = bytearray(pointer.to_bytes(8, 'little'))
    path = Path(row['raw_output'])
    digest = hashlib.sha256(path.read_bytes()).hexdigest()
    assert digest == row['raw_output_sha256']
    hashes[str(path)] = digest
    original_threads = None
    with np.load(path, allow_pickle=False) as data:
        for i, value in enumerate(raw):
            assert data['actual-parameter-' + str(i)].tobytes() == bytes(value)
            parameter_bytes += len(value)
        assert all(data['actual-parameter-' + str(i)].shape == (8,) for i in (len(raw), len(raw) + 1))
        for side in ('original', 'source'):
            trace, count = data[side + '-raw-trace'], data[side + '-raw-counts']
            for value in (trace, count):
                assert np.all(value[:256] == 211) and np.all(value[-256:] == 211)
                protected += 512
            counts = count[256:-256].copy().view('<u4')
            records = trace[256:-256].reshape(len(counts), 128, 16)
            assert counts.tolist() == row['counts'][side] and counts.max() <= 128
            extracted = []
            for lane, size in enumerate(counts):
                assert not records[lane, int(size):].any()
                values = []
                for ordinal in range(int(size)):
                    value = records[lane, ordinal]
                    assert not value[12:].any()
                    address = int.from_bytes(value[:8].tobytes(), 'little')
                    bits = int.from_bytes(value[8:12].tobytes(), 'little')
                    assert np.isfinite(np.frombuffer(value[8:12].copy(), dtype='<f4')[0])
                    matches = [(label, (address - row['pointers'][label]) // 4) for label in stage['outputs']
                               if 0 <= address - row['pointers'][label] < len(before[label])
                               and (address - row['pointers'][label]) % 4 == 0]
                    assert len(matches) == 1
                    values.append([*matches[0], bits])
                extracted.append(values)
            if row['kind'] in ('23precondition_and_reduce', '26multiply_matrix_and_reduce'):
                label = 'arg-6' if row['kind'] == '23precondition_and_reduce' else 'arg-9'
                assert len(extracted) == 768
                for lane, operations in enumerate(extracted):
                    if lane < 544:
                        assert len(operations) == 1 and operations[0][:2] == [label, lane // 68]
                    else:
                        assert not operations
            assert extracted == row['thread_operands'][side]
            if side == 'original':
                original_threads = extracted
            else:
                assert extracted == original_threads
                assert all(Counter(map(tuple, a)) == Counter(map(tuple, b))
                           for a, b in zip(original_threads, extracted))
            for index, group in enumerate(row['groups']):
                initial = np.full(group['prefix'] + group['bytes'] + 256, 211, dtype='u1')
                mask = np.ones(len(initial), dtype=bool)
                seen = np.zeros(group['bytes'], dtype=bool)
                for label in group['labels']:
                    offset = bindings[label]['address'] - group['start']
                    value = before[label]
                    target = initial[group['prefix'] + offset:group['prefix'] + offset + len(value)]
                    overlap = seen[offset:offset + len(value)]
                    assert target[overlap].tobytes() == value[overlap].tobytes()
                    target[:] = value
                    seen[offset:offset + len(value)] = True
                    assert row['pointers'][label] == group['device_base'] + group['prefix'] + offset
                    if label in stage['outputs']:
                        mask[group['prefix'] + offset:group['prefix'] + offset + len(value)] = False
                assert seen.all()
                after = data[side + '-raw-group-' + str(index)]
                assert after.shape == initial.shape and after[mask].tobytes() == initial[mask].tobytes()
                protected += int(mask.sum())
        label = 'arg-2' if row['kind'] == '23precondition_and_reduce' else 'arg-6'
        with np.load(row['captured_input'], allow_pickle=False) as captured:
            target = captured[stage['key'] + '/after/' + label]
        group_index = next(i for i, group in enumerate(row['groups']) if label in group['labels'])
        group = row['groups'][group_index]
        offset = group['prefix'] + bindings[label]['address'] - group['start']
        for side in ('original', 'source'):
            actual = data[side + '-raw-group-' + str(group_index)][offset:offset + len(target)]
            assert actual.tobytes() == target.tobytes()
    count = sum(len(values) for values in original_threads)
    assert count == row['atomic_operations']
    checked.append({'kind': row['kind'], 'actual_original_and_source_atomic_operands_equal': count,
                    'within_thread_target_and_value_sequence_equal': True})
for path in (Path(__file__), PHASE / 'report.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
result = {'rows': checked, 'atomic_operands_equal': sum(row['actual_original_and_source_atomic_operands_equal']
                                                      for row in checked),
          'protected_bytes_checked': protected, 'actual_original_parameter_bytes_checked': parameter_bytes,
          'input_sha256': hashes, 'GPU_used_for_this_audit': False,
          'production_global_thread_order_inferred': False, 'aggregate_scalar_folds_certified': False,
          'whole_trajectory_failure_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('Independent actual operand CPU:', result['atomic_operands_equal'],
      'original/source targets and F32 values identical;guards and ABI verified', flush=True)
