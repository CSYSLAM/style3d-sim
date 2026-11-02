"""Independently reconstruct all native triangle outputs, integer F32 steps and complete-word diagnostic controls."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
output = BASE / 'membrane-native-isolation'
terminal = json.loads((BASE / 'membrane-native-isolation.status.json').read_text())
assert terminal['complete'] and terminal['running'] is None
assert [row['actual_exit'] for row in terminal['completed']] == [0]
report = json.loads((output / 'report.json').read_text())
assert report['complete'] and report['triangles'] == 66930 and report['actual_calls'] == 200790
plan = json.loads((BASE / 'membrane-native-isolation-plan.json').read_text())
hashes = dict(plan['input_sha256'])
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
prepared = json.loads((BASE / 'membrane-isolation-inputs/plan.json').read_text())
operands = json.loads((BASE / 'producer-operands-report.json').read_text())
case = next(row for row in operands['rows'] if row['label'] == 'sdk0' and row['stage'] == 'membrane')
with np.load(case['probes'][0]['file'], allow_pickle=False) as packet:
    trace = packet['raw-trace'][:66930, :81].copy()
    assert np.all(packet['counts'][:66930] == 81) and not packet['counts'][66930:].any()
addresses = trace.view('<u8').reshape(66930, 81, 2)[:, :, 0]
raw_operands = trace.view('<u4').reshape(66930, 81, 4)[:, :, 2]
raw_targets = np.zeros(addresses.shape, dtype='u8')
matched = np.zeros(addresses.shape, dtype=bool)
with np.load(prepared['SDK_packet'], allow_pickle=False) as packet:
    seeds = {i: packet[f'before-arg-{i}'].view('u4').copy() for i in (5, 7)}
    captured_addresses = {i: int.from_bytes(packet[f'parameter-{i}'].tobytes(), 'little') for i in (5, 7)}
    padded_seeds = []
    padding = {}
    for i in (5, 7):
        padding[i] = 256 + captured_addresses[i] % 256
        padded = np.full(padding[i] // 4 + len(seeds[i]) + 64, 0xd3d3d3d3, dtype='u4')
        padded[padding[i] // 4:padding[i] // 4 + len(seeds[i])] = seeds[i]
        padded_seeds.append(padded)
        span = case['outputs'][str(i)]
        mask = (addresses >= span['address']) & (addresses < span['address'] + span['bytes'])
        raw_targets[mask] = (np.uint64(i) << np.uint64(32)) | ((addresses[mask] - span['address']) // 4)
        matched |= mask
assert matched.all() and np.all(np.diff(np.sort(raw_targets, axis=1), axis=1) != 0)
n0, n1 = map(len, padded_seeds)
assert report['full_output_and_guard_words_checked_per_backend_call'] == n0 + n1
controls = json.loads((output / 'helper-controls.json').read_text())
assert controls['complete'] and controls['all_word_counts_including_guards'] == [n0, n1]
points = sorted(set([0, padding[5] // 4, n0 // 2, n0 - 1, n0,
                     n0 + padding[7] // 4, n0 + n1 // 2, n0 + n1 - 1]))
assert [row['mutated_word_indices'] for row in controls['controls']] == [[], *[[i] for i in points], points]
for control in controls['controls']:
    expected = [seed.copy() for seed in padded_seeds]
    selected = control['mutated_word_indices']
    for point in selected:
        side, offset = (0, point) if point < n0 else (1, point - n0)
        expected[side][offset] ^= np.uint32(1)
    assert control['GPU_status'] == [len(selected), min(selected) if selected else 0xffffffff]
    assert control['complete_CPU_readback_verified']
    assert control['actual_complete_sha256'] == [hashlib.sha256(a.tobytes()).hexdigest() for a in expected]


def integer_add(left, right):
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


counts = {'triangles': 0, 'integer_F32_steps': 0, 'actual_native_PTX_source_calls': 0,
          'gathered_actual_words': 0, 'full_output_and_guard_words_GPU_compared': 0}
assert len(report['chunks']) == len(prepared['chunks']) == 17
for original, actual in zip(prepared['chunks'], report['chunks'], strict=True):
    assert (original['start'], original['stop']) == (actual['start'], actual['stop'])
    for row in (original, actual):
        path = Path(row['file'])
        assert hashlib.sha256(path.read_bytes()).hexdigest() == row['sha256']
        hashes[str(path)] = row['sha256']
    with np.load(original['file'], allow_pickle=False) as archive:
        data = {key: archive[key] for key in archive.files}
    left, right = original['start'], original['stop']
    assert np.array_equal(data['targets'], raw_targets[left:right])
    assert np.array_equal(data['operands'], raw_operands[left:right])
    expected_before = np.zeros(data['before'].shape, dtype='u4')
    for i in (5, 7):
        mask = data['targets'] >> np.uint64(32) == i
        words = (data['targets'][mask] & np.uint64(0xffffffff)).astype('u4')
        expected_before[mask] = seeds[i][words]
    assert np.array_equal(expected_before, data['before'])
    # This adder uses exact integers and rounding; it shares no floating-point calculation with the GPU worker.
    recomputed = np.fromiter((integer_add(int(a), int(b)) for a, b in
                             zip(data['before'].ravel(), data['operands'].ravel(), strict=True)), dtype='u4')
    assert np.array_equal(recomputed.reshape(data['after'].shape), data['after'])
    with np.load(actual['file'], allow_pickle=False) as archive:
        words, statuses = archive['actual_words'], archive['complete_comparison_status']
        assert words.shape == (right - left, 3, 81) and statuses.shape == (right - left, 3, 2)
        assert not statuses[:, :, 0].any() and np.all(statuses[:, :, 1] == 0xffffffff)
        assert np.array_equal(words, np.broadcast_to(data['after'][:, None, :], words.shape))
    counts['triangles'] += right - left
    counts['integer_F32_steps'] += (right - left) * 81
    counts['actual_native_PTX_source_calls'] += (right - left) * 3
    counts['gathered_actual_words'] += words.size
    counts['full_output_and_guard_words_GPU_compared'] += (right - left) * 3 * (n0 + n1)
    print('Independent native triangle CPU audit:', right, '/66930', flush=True)
assert counts['integer_F32_steps'] == 5421330 and counts['actual_native_PTX_source_calls'] == 200790
for path in (Path(__file__), output / 'helper-controls.json', output / 'report.json',
             BASE / 'membrane-native-isolation.status.json'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
target = BASE / 'membrane-native-isolation-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'counts': counts, 'input_sha256': hashes,
    'all_native_SDK_original_PTX_source_complete_outputs_strict': True,
    'actual_sparse_words_plus_complete_GPU_bitwise_check_losslessly_determine_all_output_words': True,
    'GPU_comparator_negative_controls_independently_reconstructed_with_complete_CPU_readback_SHA': True,
    'all_actual_F32_steps_independently_recomputed_using_integer_RNE_FTZ': True,
    'all_75_cross_endpoint_diagonal_seed_differences_outside_all_triangle_targets': True,
    'complete_aggregate_or_joint_global_schedule_proven': False, 'fixed_C8_changed': False,
    'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('All native triangle checks independently audited:', counts)
