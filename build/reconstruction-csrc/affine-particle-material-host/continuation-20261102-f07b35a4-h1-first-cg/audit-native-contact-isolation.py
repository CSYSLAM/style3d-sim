"""Reconstruct every actual complete output and certify its F32 history using an independent integer-only adder."""
import argparse
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--folder', required=True, choices=('soft-force-native-isolation', 'soft-matrix-native-isolation',
                                                     'soft-matrix-source-native-isolation'))
args = parser.parse_args()
statuses = {'soft-force-native-isolation': 'soft-force-isolation.status.json',
            'soft-matrix-native-isolation': 'soft-matrix-isolation.status.json',
            'soft-matrix-source-native-isolation': 'soft-matrix-source-isolation.status.json'}
folder = BASE / args.folder
terminal = json.loads((BASE / statuses[args.folder]).read_text())
assert terminal['complete'] and terminal['running'] is None
assert [row['actual_exit'] for row in terminal['completed']] == [0]
report = json.loads((folder / 'report.json').read_text())
assert report['complete'] and report['contacts'] == 8891 and report['actual_calls'] == 26673
packet_path = Path(report['packet'])
assert hashlib.sha256(packet_path.read_bytes()).hexdigest() == report['packet_sha256']
source = json.loads((BASE / 'producer-operands-report.json').read_text())
case = next(row for row in source['rows'] if row['packet'] == str(packet_path))
output_indices = sorted(map(int, case['outputs']))
with np.load(packet_path, allow_pickle=False) as packet:
    seeds = {i: packet[f'before-arg-{i}'].view('u4').copy() for i in output_indices}
with np.load(case['probes'][0]['file'], allow_pickle=False) as packet:
    raw_trace, original_counts = packet['raw-trace'], packet['counts'][:8891]
    expected_targets, expected_values = [], []
    for record in raw_trace[np.arange(128)[None, :] < packet['counts'][:len(raw_trace), None]]:
        address = int.from_bytes(record[:8].tobytes(), 'little')
        matches = [(int(i), (address - span['address']) // 4) for i, span in case['outputs'].items()
                   if span['address'] <= address < span['address'] + span['bytes']]
        assert len(matches) == 1
        i, offset = matches[0]
        expected_targets.append((i << 32) | offset)
        expected_values.append(int.from_bytes(record[8:12].tobytes(), 'little'))


def integer_atomic_add(left, right):
    def units(word):
        exponent, fraction = (word >> 23) & 255, word & 0x7fffff
        assert exponent != 255
        magnitude = 0 if exponent == 0 else (0x800000 | fraction) << (exponent - 1)
        return -magnitude if word & 0x80000000 else magnitude

    total = units(left) + units(right)
    if total == 0:
        return left & right & 0x80000000
    sign = 0x80000000 if total < 0 else 0
    magnitude = abs(total)
    if magnitude < 1 << 23:
        return sign
    shift = max(0, magnitude.bit_length() - 24)
    significand = magnitude >> shift
    if shift:
        remainder, halfway = magnitude & ((1 << shift) - 1), 1 << (shift - 1)
        if remainder > halfway or (remainder == halfway and significand & 1):
            significand += 1
    if significand == 1 << 24:
        significand >>= 1
        shift += 1
    exponent = shift + 1
    return sign | 0x7f800000 if exponent >= 255 else sign | (exponent << 23) | (significand & 0x7fffff)


counts = {'contacts': 0, 'actual_native_PTX_source_calls': 0, 'integer_F32_steps': 0, 'complete_output_words': 0}
with np.load(folder / 'lossless-complete-outputs.npz', allow_pickle=False) as archive:
    data = {key: archive[key] for key in archive.files}
    assert np.array_equal(data['contact_counts'], original_counts)
    assert np.array_equal(data['record_targets'], np.asarray(expected_targets, dtype='u8'))
    assert np.array_equal(data['record_values'], np.asarray(expected_values, dtype='u4'))
    offsets = data['delta_offsets']
    assert len(offsets) == 8892 and offsets[0] == 0 and np.all(offsets[1:] >= offsets[:-1])
    assert offsets[-1] == len(data['delta_targets']) == len(data['delta_values'])
    starts = np.concatenate(([0], np.cumsum(original_counts, dtype='i8')))
    rows = [json.loads(line) for line in (folder / 'contacts.jsonl').read_text().splitlines()]
    assert len(rows) == 8891
    for index, row in enumerate(rows):
        assert row['contact'] == index and row['atomic_records'] == int(original_counts[index])
        assert row['all_complete_outputs_strict']
        actual = {i: seed.copy() for i, seed in seeds.items()}
        expected = {i: seed.copy() for i, seed in seeds.items()}
        left, right = int(offsets[index]), int(offsets[index + 1])
        targets, bits = data['delta_targets'][left:right], data['delta_values'][left:right]
        assert len(np.unique(targets)) == len(targets)
        for target, word in zip(targets, bits, strict=True):
            i, offset = int(target) >> 32, int(target) & 0xffffffff
            assert i in seeds and offset < len(seeds[i])
            actual[i][offset] = word
        for pos in range(int(starts[index]), int(starts[index + 1])):
            target = int(data['record_targets'][pos])
            i, offset = target >> 32, target & 0xffffffff
            before = int(expected[i][offset])
            after = integer_atomic_add(before, int(data['record_values'][pos]))
            assert before == int(data['record_before'][pos]) and after == int(data['record_after'][pos])
            expected[i][offset] = after
            counts['integer_F32_steps'] += 1
        assert all(np.array_equal(actual[i], expected[i]) for i in seeds)
        digest = hashlib.sha256()
        for i in output_indices:
            digest.update(actual[i].tobytes())
        fingerprints = row['actual_complete_output_sha256']
        assert set(fingerprints) == {'original-runtime', 'original-ptx', 'source-ptx'}
        assert all(sha == digest.hexdigest() for sha in fingerprints.values())
        counts['contacts'] += 1
        counts['actual_native_PTX_source_calls'] += 3
        counts['complete_output_words'] += 3 * sum(len(seed) for seed in seeds.values())
hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in
          (packet_path, folder / 'report.json', folder / 'contacts.jsonl', folder / 'lossless-complete-outputs.npz',
           Path(case['probes'][0]['file']), Path(__file__))}
target = BASE / (args.folder + '-independent-cpu.json')
assert not target.exists()
target.write_text(json.dumps({'counts': counts, 'input_sha256': hashes,
    'all_complete_actual_outputs_losslessly_reconstructed': True, 'all_three_backends_strict': True,
    'F32_RNE_FTZ_histories_reproduced_with_integer_arithmetic': True, 'original_launch_geometry_preserved': True,
    'full_aggregate_or_joint_global_schedule_proven': False, 'fixed_C8_changed': False,
    'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('Independent native contact isolation audit:', args.folder, counts)
