"""Re-read complete three-backend replay artifacts and independently reconstruct guarded allocation contents."""
import argparse
import hashlib
import json
from pathlib import Path

import numpy as np

from .audit_cudahook import parameter_types


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def audit(phase):
    folder = phase / 'complete-input-replays'
    target = folder / 'independent-cpu.json'
    assert not target.exists()
    plan_path, report_path = folder / 'plan.json', folder / 'report.json'
    plan, report = [json.loads(path.read_text()) for path in (plan_path, report_path)]
    assert report['execution_complete'] and report['error'] is None and report['actual_calls'] == 3564
    assert len(plan['packets']) == len(report['packets']) == 1188
    hashes = {**plan['input_sha256'], **report['original_PTX_input_sha256']}
    for path in (Path(__file__), plan_path, report_path):
        hashes[str(path.resolve())] = sha(path)
    types = {name: parameter_types(name) for name in plan['kernel_names']}
    count = {'packets': 0, 'calls': 0, 'strict_packets': 0, 'strict_calls': 0, 'output_buffers': 0,
             'readonly_and_guard_bytes': 0, 'actual_parameter_bytes': 0, 'complete_pointer_fields': 0}
    packets = []
    for number, (packet, row) in enumerate(zip(plan['packets'], report['packets'])):
        assert row['number'] == number
        assert [row[k] for k in ('worker', 'key', 'call')] == [packet[k] for k in ('worker', 'key', 'call')]
        path = Path(row['output'])
        assert sha(path) == row['output_sha256']
        hashes[str(path.resolve())] = row['output_sha256']
        before = {b['label']: Path(b['input']).read_bytes() for b in packet['bindings']}
        expected = {label: Path(name).read_bytes() for label, name in packet['expected'].items()}
        addresses = {b['label']: b['address'] for b in packet['bindings']}
        binding_by_argument = {b['argument']: b for b in packet['bindings']}
        actual_pointers = {i for i, typ in enumerate(types[packet['node']['name']])
                           if '*' in typ and int.from_bytes(bytes.fromhex(packet['node']['parameter_hex'][i]), 'little')}
        assert actual_pointers == set(binding_by_argument)
        assert sorted(label for group in row['groups'] for label in group['labels']) == sorted(before)
        checks = {check['backend']: check for check in row['checks']}
        assert set(checks) == set(plan['backends'])
        equal = {backend: {} for backend in plan['backends']}
        group_for_label = {}
        with np.load(path, allow_pickle=False) as arrays:
            for argument, original in enumerate(packet['node']['parameter_hex']):
                wanted = bytes.fromhex(original)
                if argument in binding_by_argument:
                    label = binding_by_argument[argument]['label']
                    wanted = int(row['pointers'][label]).to_bytes(8, 'little')
                assert arrays['actual-parameter-' + str(argument)].tobytes() == wanted
                count['actual_parameter_bytes'] += len(wanted)
            for index, group in enumerate(row['groups']):
                start = min(addresses[label] for label in group['labels'])
                end = max(addresses[label] + len(before[label]) for label in group['labels'])
                assert start == group['start'] and end - start == group['bytes']
                prefix, base = group['prefix'], group['device_base']
                assert prefix == 256 + start % 256 and base % 256 == 0
                initial = bytearray([211]) * (prefix + end - start + 256)
                covered = np.zeros(len(initial), dtype=bool)
                writable = np.zeros(len(initial), dtype=bool)
                for label in group['labels']:
                    offset = prefix + addresses[label] - start
                    pointer = int(row['pointers'][label])
                    assert pointer == base + offset and pointer % 256 == addresses[label] % 256
                    count['complete_pointer_fields'] += 1
                    data = before[label]
                    for displacement, value in enumerate(data):
                        position = offset + displacement
                        if covered[position]:
                            assert initial[position] == value
                        initial[position] = value
                        covered[position] = True
                    if label in expected:
                        writable[offset:offset + len(data)] = True
                    group_for_label[label] = index, offset
                assert covered[prefix:prefix + end - start].all()
                initial = np.frombuffer(initial, dtype='u1')
                for backend in plan['backends']:
                    actual = arrays[backend + '-group-' + str(index)]
                    assert actual.dtype == np.dtype('u1') and actual.shape == initial.shape
                    assert actual[~writable].tobytes() == initial[~writable].tobytes()
                    count['readonly_and_guard_bytes'] += int((~writable).sum())
            for backend in plan['backends']:
                for label, wanted in expected.items():
                    actual = arrays[backend + '-output-' + label].tobytes()
                    group_index, offset = group_for_label[label]
                    group = arrays[backend + '-group-' + str(group_index)]
                    assert actual == group[offset:offset + len(wanted)].tobytes()
                    equal[backend][label] = actual == wanted
                    count['output_buffers'] += 1
                assert equal[backend] == checks[backend]['complete_outputs_equal_to_capture']
                strict = all(equal[backend].values())
                assert strict == checks[backend]['all_complete_outputs_strict']
                assert checks[backend]['readonly_and_guards_unchanged']
                count['calls'] += 1
                count['strict_calls'] += int(strict)
        strict_packet = all(all(values.values()) for values in equal.values())
        count['packets'] += 1
        count['strict_packets'] += int(strict_packet)
        packets.append({'number': number, 'all_complete_outputs_strict': strict_packet,
                        'complete_output_checks': equal, 'readonly_and_guards_unchanged': True})
    assert count['packets'] == 1188 and count['calls'] == 3564
    assert count['strict_packets'] == report['strict_packets']
    for name, expected_hash in hashes.items():
        assert sha(Path(name)) == expected_hash, name
    result = {'metrics': count, 'packets': packets, 'GPU_used': False,
              'raw_contact_records_not_sorted': True, 'fixed_failures_reclassified': False,
              'candidate_promoted': False, 'whole_solver_complete': False, 'input_sha256': hashes}
    target.write_text(json.dumps(result, indent=2) + '\n')
    print('Independent replay CPU audit:', count, flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    args = parser.parse_args()
    audit(args.phase.resolve(strict=True))


if __name__ == '__main__':
    main()
