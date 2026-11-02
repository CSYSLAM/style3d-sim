"""Independently rebuild raw atomic traces, parameter bytes and guards from the saved complete cloth packets."""
from collections import Counter
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'particles-deformed-common-inputs/GPU-results'
OUTPUT = PHASE / 'independent-cpu.json'
assert not OUTPUT.exists()
report = json.loads((PHASE / 'report.json').read_text())
hashes = dict(report['input_sha256'])
checked, protected, parameter_bytes = [], 0, 0
assert report['actual_instrumented_GPU_calls'] == 36 and report['actual_unmodified_GPU_calls'] == 54
assert len(report['rows']) == 18 and report['GPU_waits'][-1]['free_memory_MiB'] >= 4096
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
        for backend in ('SDK-runtime', 'original', 'source'):
            for index, group in enumerate(row['groups']):
                initial = np.full(group['prefix'] + group['bytes'] + 256, 211, dtype='u1')
                mask = np.ones(len(initial), dtype=bool)
                for label in group['labels']:
                    start = group['prefix'] + bindings[label]['address'] - group['start']
                    value = before[label]
                    initial[start:start + len(value)] = value
                    if label in stage['outputs']:
                        mask[start:start + len(value)] = False
                after = data[backend + '-unmodified-group-' + str(index)]
                assert after.shape == initial.shape and after[mask].tobytes() == initial[mask].tobytes()
                protected += int(mask.sum())
                for label in set(group['labels']) & set(stage['outputs']):
                    start = group['prefix'] + bindings[label]['address'] - group['start']
                    output = data[backend + '-unmodified-output-' + label]
                    assert after[start:start + len(output)].tobytes() == output.tobytes()
                    assert np.isfinite(output.view('<f4')).all()
            if backend != 'SDK-runtime':
                for label in stage['outputs']:
                    a = data['SDK-runtime-unmodified-output-' + label]
                    b = data[backend + '-unmodified-output-' + label]
                    actual = {'bitwise': a.tobytes() == b.tobytes(),
                              'max_abs': float(np.max(np.abs(a.view('<f4').astype('f8') - b.view('<f4').astype('f8'))))}
                    assert actual == row['unmodified_outputs_vs_SDK'][backend][label]
    count = sum(len(values) for values in original_threads)
    assert count == row['atomic_operations']
    checked.append({'kind': row['kind'], 'actual_original_and_source_atomic_operands_equal': count,
                    'within_thread_target_and_value_sequence_equal': True})
for path in (Path(__file__), PHASE / 'report.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
result = {'unmodified_GPU_calls_checked': 54, 'instrumented_GPU_calls_checked': 36,
          'rows': checked, 'atomic_operands_equal': sum(row['actual_original_and_source_atomic_operands_equal']
                                                      for row in checked),
          'protected_bytes_checked': protected, 'actual_original_parameter_bytes_checked': parameter_bytes,
          'input_sha256': hashes, 'GPU_used_for_this_audit': False,
          'production_global_thread_order_inferred': False, 'aggregate_scalar_folds_certified': False,
          'whole_trajectory_failure_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('Independent actual operand CPU:', result['atomic_operands_equal'],
      'original/source targets and F32 values identical;guards and ABI verified', flush=True)
