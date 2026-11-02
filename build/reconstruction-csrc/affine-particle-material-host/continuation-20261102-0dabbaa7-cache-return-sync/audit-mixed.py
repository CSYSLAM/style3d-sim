"""Reconstruct fixed mixed input groups and check all actual replay bytes independently on CPU."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import schemas

output = BASE / 'mixed-fenced'
report_path = output / 'report.json'
report = json.loads(report_path.read_text())
plan = json.loads((BASE / 'mixed-replay-plan.json').read_text())
pair = Path(plan['fixed_pair'])
build = json.loads((pair / 'solver-build.json').read_text())
schema = schemas()[0]
expected_source = '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
assert report['source_sha256'] == build['extension_sha256'] == expected_source
assert report['reference_sha256'] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
assert report['upload_completion_fenced'] and report['all_pointwise_equal']
assert not report['out_of_allocation_guards_checked'] and not report['fixed_source_replaced']
for path, expected in report['input_sha256'].items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
assert hashlib.sha256((BASE / 'mixed-replay.py').read_bytes()).hexdigest() == report['runner_sha256']
assert report['trials_per_backend'] == 2
calls = parameter_bytes = output_bytes = readonly_bytes = counter_words = extra_bytes = alias_packets = 0
side_counts, raw_hashes = {}, {}
for row in report['packets']:
    side, packet = row['capture'], row['packet']
    side_counts[side] = side_counts.get(side, 0) + 1
    folder = pair / side / 'native'
    if (folder / 'actual').exists():
        folder /= 'actual'
    prefix = packet[:-4]
    meta = json.loads((folder / packet).read_text())
    name = meta['name']
    widths = build['kernels'][name]['parameters']
    original = [(folder / (prefix + f'before.param_{index}.bin')).read_bytes() for index in range(len(widths))]
    assert list(map(len, original)) == widths
    assert row['raw']['original_parameter_hex'] == [value.hex() for value in original]
    addresses = [int.from_bytes(value, 'little') for value in original]
    if '15initialize_stepE' in name:
        bindings = {1: 'gravity', 3: 'world', 4: 'v', 5: 'x', 6: 'host_diagonal', 17: 'mass', 18: 'flags',
                    19: 'particle_kind', **{7 + 2 * slot: f'diagonal_template{slot}' for slot in range(5)}}
        outputs, extra, atomic = {5: 'x', 20: 'previous', 21: 'target', 22: 'diagonal'}, {}, None
    elif '14initialize_rhsE' in name:
        bindings = {1: 'x', 2: 'target', 3: 'mass', 4: 'row_count', 5: 'entries', 7: 'external', 8: 'flags'}
        outputs, extra, atomic = {9: 'rhs'}, {}, None
    elif '27invert_block_preconditionerE' in name:
        bindings = {0: 'blocks', 1: 'mass', 2: 'flags'}
        outputs, extra, atomic = {3: 'inverse'}, {}, None
    elif '25initialize_block_diagonalE' in name:
        bindings, outputs = {0: 'diagonal'}, {1: 'blocks'}
        if addresses[2]:
            outputs[2] = 'precond'
        extra, atomic = {}, None
    elif '23precondition_and_reduceIN3glm' in name:
        bindings = {0: 'inverse', 1: 'r', 4: 'world', 6: 'numerator'}
        outputs, extra, atomic = {2: 'z', 6: 'numerator'}, {}, 6
        assert addresses[3] == 0
    elif '26multiply_matrix_and_reduceINS_17BlockNonZeroEntry' in name:
        bindings = {0: 'row_count', 1: 'entries', 3: 'blocks', 4: 'p', 5: 'extra', 7: 'world', 9: 'denominator'}
        outputs, extra, atomic = {6: 'ap', 9: 'denominator'}, {}, 9
        assert addresses[2] == 2
    elif '19update_cg_directionE' in name:
        bindings = {1: 'z', 2: 'world', 4: 'numerator', 5: 'previous_numerator'}
        if addresses[0]:
            bindings[6] = 'p'
        outputs, extra, atomic = {6: 'p'}, {}, None
    elif '28update_solution_and_residualEP' in name:
        bindings = {0: 'world', 2: 'numerator', 3: 'denominator', 4: 'p', 5: 'ap', 6: 'x', 7: 'r'}
        outputs, extra, atomic = {6: 'x', 7: 'r'}, {}, None
    elif '20apply_nonlinear_stepE' in name:
        bindings, outputs, extra, atomic = {0: 'q', 2: 'dx'}, {1: 'q', 2: 'dx'}, {2: 387 * 12}, None
    else:
        assert '15update_velocityE' in name, name
        bindings, outputs, extra, atomic = {1: 'previous', 2: 'q'}, {3: 'v'}, {}, None
    assert row['raw']['output_arguments'] == {str(index): label for index, label in outputs.items()}
    source_inputs = {index: (folder / (prefix + 'before.' + label + '.bin')).read_bytes()
                     for index, label in bindings.items() if addresses[index]}
    captured = {index: (folder / (prefix + 'after.' + label + '.bin')).read_bytes()
                for index, label in outputs.items() if index not in extra}
    expected_groups = {}
    for index, kind in enumerate(schema[name]):
        if kind != 'pointer' or not addresses[index]:
            continue
        assert index in source_inputs or index in outputs, (name, index)
        size = max(len(source_inputs.get(index, b'')), len(captured.get(index, b'')), extra.get(index, 0))
        group = expected_groups.setdefault(addresses[index], {'size': 0, 'inputs': []})
        group['size'] = max(group['size'], size)
        if index in source_inputs:
            group['inputs'].append(source_inputs[index])
    ranges = sorted((address, address + group['size']) for address, group in expected_groups.items())
    assert all(left[1] <= right[0] for left, right in zip(ranges, ranges[1:])), 'Unexpected partial overlap'
    pointer_indices = [index for index, kind in enumerate(schema[name]) if kind == 'pointer' and addresses[index]]
    alias_packets += int(len(pointer_indices) > len(expected_groups))
    groups = row['raw']['groups']
    assert [group['address'] for group in groups] == list(expected_groups)
    raw_path = Path(row['raw']['path'])
    raw_hashes[str(raw_path)] = hashlib.sha256(raw_path.read_bytes()).hexdigest()
    assert raw_hashes[str(raw_path)] == row['raw']['sha256']
    with np.load(raw_path, allow_pickle=False) as arrays:
        keys = set()
        for group_number, group in enumerate(groups):
            expected = expected_groups[group['address']]
            assert group['size'] == expected['size']
            initial = bytearray([0xa5] * group['size'])
            for data in expected['inputs']:
                for other in expected['inputs']:
                    assert data[:min(len(data), len(other))] == other[:min(len(data), len(other))]
                initial[:len(data)] = data
            key = f'group-{group_number}/initial'
            keys.add(key)
            assert arrays[key].tobytes() == initial
        for index, (raw, kind) in enumerate(zip(original, schema[name])):
            key = f'actual-parameter-{index}'
            keys.add(key)
            actual = arrays[key].tobytes()
            if kind == 'pointer' and addresses[index]:
                group = next(group for group in groups if group['address'] == addresses[index])
                assert actual == group['device_address'].to_bytes(8, 'little')
            else:
                assert actual == raw
            assert len(actual) == len(raw)
            parameter_bytes += 6 * len(actual)
        expected_outputs = dict(captured)
        for index in extra:
            expected_outputs[index] = arrays[f'original-runtime/0/output-{index}'].tobytes()
            assert len(expected_outputs[index]) == extra[index]
        assert {(check['backend'], check['trial']) for check in row['checks']} == {
            (backend, trial) for backend in ('original-runtime', 'original-ptx', 'source-ptx') for trial in range(2)}
        for check in row['checks']:
            backend, trial = check['backend'], check['trial']
            protected_count = 0
            for index, expected in expected_outputs.items():
                key = f'{backend}/{trial}/output-{index}'
                keys.update((key, f'expected-{index}'))
                assert arrays[key].tobytes() == arrays[f'expected-{index}'].tobytes() == expected
                group_number = next(i for i, group in enumerate(groups) if group['address'] == addresses[index])
                group_key = f'{backend}/{trial}/group-{group_number}'
                assert arrays[group_key][:len(expected)].tobytes() == expected
                output_bytes += len(expected)
                extra_bytes += len(expected) if index in extra else 0
            for group_number, group in enumerate(groups):
                key = f'{backend}/{trial}/group-{group_number}'
                keys.add(key)
                initial, after = arrays[f'group-{group_number}/initial'], arrays[key]
                assert initial.dtype == after.dtype == np.dtype('u1')
                assert initial.shape == after.shape == (group['size'],)
                protected = np.ones(group['size'], dtype=bool)
                for index, expected in expected_outputs.items():
                    if addresses[index] == group['address']:
                        protected[:len(expected)] = False
                assert after[protected].tobytes() == initial[protected].tobytes()
                protected_count += int(protected.sum())
            assert protected_count == check['readonly_bytes_checked']
            readonly_bytes += protected_count
            calls += 1
            if atomic is not None:
                assert len(expected_outputs[atomic]) == 129 * 4
                assert check['atomic_counter_count'] == 129 and check['all_atomic_counter_words_equal']
                counter_words += 129
        assert keys == set(arrays.files)
assert side_counts == {'legacy': 366, 'source': 366} and calls == 4392
status = json.loads((BASE / 'mixed-worker-status.json').read_text())
assert status['actual_exit'] == 0 and status['external_apps_allowed'] and status['GPU_workers_serial']
inputs = {str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest()
          for p in (Path(__file__), report_path, BASE / 'mixed-replay.py', BASE / 'mixed-worker-status.json')}
result = {'packets': 732, 'actual_calls': calls, 'parameter_bytes_CPU_checked': parameter_bytes,
          'complete_output_bytes_CPU_checked': output_bytes, 'in_allocation_readonly_bytes_CPU_checked': readonly_bytes,
          'counter_words_CPU_checked': counter_words, 'SDK_derived_extra_output_bytes': extra_bytes,
          'packets_with_same_start_aliases': alias_packets, 'all_partial_overlaps_absent': True,
          'minimum_sampled_free_MiB': min(row['free_MiB'] for row in status['memory_samples']),
          'external_apps_allowed': True, 'input_sha256': inputs, 'raw_sha256': raw_hashes,
          'out_of_allocation_guards_proved': False, 'full_three_dimensional_geometry_captured': False,
          'fixed_failed_cohort_replaced': False, 'production_modified': False, 'whole_solver_complete': False}
(BASE / 'mixed-independent-cpu.json').write_text(json.dumps(result, indent=2) + '\n')
print('CPU verified732 fixed packets,4392 calls;', output_bytes, 'output bytes and', readonly_bytes, 'readonly bytes')
