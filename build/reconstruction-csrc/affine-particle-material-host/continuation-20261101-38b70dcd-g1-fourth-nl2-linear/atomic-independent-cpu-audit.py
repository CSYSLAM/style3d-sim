"""Independently reconstruct real probe ABI, guarded SDK isolation, and every GPU F32 certificate history."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.pcg_alias_replay import span_groups

plan = json.loads((BASE / 'atomic-plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
report = json.loads((BASE / 'atomic/report.json').read_text())
assert report['complete'] and len(report['rows']) == len(plan['cases']) == 8
source = ROOT / 'reconstruction/csrc/g1_nl2_atomic.py'
assert report['runner_sha256'] == hashlib.sha256(source.read_bytes()).hexdigest()
counts, hashes = Counter(), {}


def flush(value):
    value = np.float32(value)
    word = int(value.view('<u4'))
    if 0 < word & 0x7fffffff < 0x00800000:
        return np.asarray([word & 0x80000000], dtype='<u4').view('<f4')[0]
    return value


def add(left, right):
    return flush(np.float32(flush(left) + flush(right)))


for case, row in zip(plan['cases'], report['rows'], strict=True):
    label, key = case['label'], case['stage']
    assert (row['label'], row['stage']) == (label, key)
    counter, world, pointwise = (6, 4, 2) if key.startswith('precondition') else (9, 7, 6)
    stage = case['layout']
    with np.load(case['packet'], allow_pickle=False) as captured:
        raw = [captured['parameter-' + str(i)].tobytes() for i in range(len(stage['node']['parameter_hex']))]
        bindings = {int(i): captured['before-arg-' + str(i)].tobytes() for i in stage['sizes']}
        wanted_vector = captured['after-arg-' + str(pointwise)].tobytes()
        captured_target = int.from_bytes(captured['after-arg-' + str(counter)].tobytes(), 'little')
    values = [int.from_bytes(v, 'little') for v in raw]
    groups = span_groups(values, bindings)
    assert len(groups) == len(row['groups'])
    path = BASE / 'atomic' / (label + '-' + key + '.npz')
    assert row['output_sha256'] == hashlib.sha256(path.read_bytes()).hexdigest()
    hashes[str(path)] = row['output_sha256']
    with np.load(path, allow_pickle=False) as packet:
        pointers, originals = {}, []
        for group, saved in zip(groups, row['groups'], strict=True):
            assert {k: group[k] for k in ('indices', 'start', 'end')} == {
                k: saved[k] for k in ('indices', 'start', 'end')}
            padding = 256 + group['start'] % 256
            assert padding == saved['padding'] and saved['device_base'] % 256 == 0
            initial = np.full(padding + len(group['initial']) + 256, 211, dtype='u1')
            initial[padding:padding + len(group['initial'])] = group['initial']
            originals.append(initial)
            for i in group['indices']:
                pointers[i] = saved['device_base'] + padding + values[i] - group['start']
                assert pointers[i] % 256 == values[i] % 256

        def check_abi(prefix, isolated):
            actual = [packet[prefix + '-parameter-' + str(i)].tobytes() for i in range(len(raw))]
            for i, value in enumerate(raw):
                assert len(actual[i]) == len(value)
                if isolated and i in (world, counter):
                    assert len(value) == 8 and int.from_bytes(actual[i], 'little') != 0
                elif i in pointers:
                    assert int.from_bytes(actual[i], 'little') == pointers[i]
                else:
                    assert actual[i] == value
                counts['actual_ABI_bytes'] += len(actual[i])
            return actual

        def check_groups(prefix, isolated):
            for i, (group, saved, initial) in enumerate(zip(groups, row['groups'], originals, strict=True)):
                actual = packet[prefix + '-group-' + str(i)]
                assert actual.dtype == np.dtype('u1') and actual.shape == initial.shape
                mask = np.ones(len(initial), dtype=bool)
                for argument in group['indices']:
                    offset = saved['padding'] + values[argument] - group['start']
                    if argument == pointwise or (argument == counter and not isolated):
                        mask[offset:offset + len(bindings[argument])] = False
                    if argument == pointwise:
                        assert actual[offset:offset + len(wanted_vector)].tobytes() == wanted_vector
                        counts['complete_pointwise_output_words'] += len(wanted_vector) // 4
                    if argument == counter and not isolated:
                        assert actual[offset:offset + 4].tobytes() == packet[prefix + '-counter'].tobytes()
                assert np.array_equal(actual[mask], initial[mask])
                counts['full_after_bytes'] += len(actual)
                counts['readonly_and_guard_bytes'] += int(mask.sum())

        observed = []
        targets = set(case['target_bits'])
        assert captured_target in targets
        for side in ('original', 'source'):
            actual = check_abi(side, False)
            for i in (len(raw), len(raw) + 1):
                value = packet[side + '-parameter-' + str(i)].tobytes()
                assert len(value) == 8 and int.from_bytes(value, 'little') != 0
                counts['actual_ABI_bytes'] += 8
            check_groups(side, False)
            trace, sizes = packet[side + '-raw-trace'], packet[side + '-counts']
            assert trace.dtype == np.dtype('u1') and trace.shape == (256, 128, 16)
            assert sizes.dtype == np.dtype('<u4') and sizes.shape == (256,)
            assert np.all(sizes[:176] == 1) and not sizes[176:].any()
            assert not trace[176:].any() and not trace[:, 1:].any() and not trace[:, :, 12:].any()
            addresses = trace[:176, 0, :8].copy().view('<u8').reshape(-1)
            assert np.all(addresses == pointers[counter])
            observed.append(trace[:176, 0, 8:12].copy().view('<f4').reshape(-1))
            assert np.isfinite(observed[-1]).all()
            counts['literal_GPU_atomic_records'] += 176
            targets.add(int(packet[side + '-counter'][0]))
        assert observed[0].tobytes() == observed[1].tobytes() == packet['operands'].tobytes()
        operands = observed[0]
        assert row['negative_operands'] == int(np.count_nonzero(operands < 0))
        assert row['subnormal_operands'] == int(np.count_nonzero((np.abs(operands) > 0) &
                                                               (np.abs(operands) < np.finfo('f4').tiny)))
        assert np.array_equal(packet['isolated-world-map'], np.arange(176, dtype='<i4'))
        expected_prefixes = [backend + '-isolated-' + str(zero) for zero in (0, 0x80000000)
                             for backend in ('original-runtime', 'original-ptx', 'source-ptx')]
        assert row['isolation_prefixes'] == expected_prefixes
        shared_world_pointer = None
        for prefix in expected_prefixes:
            actual = check_abi(prefix, True)
            world_pointer = int.from_bytes(actual[world], 'little')
            if shared_world_pointer is None:
                shared_world_pointer = world_pointer
            assert world_pointer == shared_world_pointer
            check_groups(prefix, True)
            assert packet[prefix + '-world-map-after'].tobytes() == packet['isolated-world-map'].tobytes()
            after = packet[prefix + '-counters']
            assert after.dtype == np.dtype('<u4') and after.shape == (304,)
            assert np.all(after[:64] == 211) and np.all(after[240:] == 211)
            zero = int(prefix.rsplit('-', 1)[-1])
            seed = np.asarray([zero], dtype='<u4').view('<f4')[0]
            predicted = np.asarray([add(seed, value) for value in operands], dtype='f4')
            assert after[64:240].tobytes() == predicted.tobytes()
            counts['isolated_SDK_PTX_source_contributors'] += 176
        assert row['targets'] == sorted(targets)
        assert {c['target_bits'] for c in row['certificates']} == targets
        initial_word = int.from_bytes(bindings[counter], 'little')
        assert initial_word == row['initial_bits'] == case['initial_bits'] == 0
        for certificate in row['certificates']:
            word = certificate['target_bits']
            assert certificate['passed']
            order, history = packet[str(word) + '-order'], packet[str(word) + '-history']
            assert order.dtype == np.dtype('<u4') and order.shape == (176,)
            assert np.array_equal(np.sort(order), np.arange(176))
            assert history.dtype == np.dtype('<f4') and history.shape == (176,)
            total = np.asarray([initial_word], dtype='<u4').view('<f4')[0]
            expected_history = []
            for lane in order:
                expected_history.append(total)
                total = add(total, operands[lane])
            assert history.tobytes() == np.asarray(expected_history, dtype='f4').tobytes()
            assert int(total.view('<u4')) == int(packet[str(word) + '-total'][0]) == word
            for i, width in enumerate((8, 8, 8, 8, 4)):
                raw_parameter = packet['certificate-' + str(word) + '-parameter-' + str(i)].tobytes()
                assert len(raw_parameter) == width
                if i == 4:
                    assert int.from_bytes(raw_parameter, 'little') == 176
                counts['actual_ABI_bytes'] += width
            counts['hardware_certificates'] += 1
            counts['hardware_F32_before_values'] += len(history)
    assert not row['unexplained_bits']
assert report['actual_calls'] == {'probe': 16, 'SDK_isolation': 48, 'certificate': counts['hardware_certificates']}
assert report['all_certificates_passed'] and not report['actual_production_order_inferred']
strict = json.loads((BASE / 'replay-independent-cpu-audit.json').read_text())
assert sum(strict['strict'].values()) == 81 and strict['counts']['complete_output_arrays'] == 96
output = BASE / 'atomic-independent-cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps({'counts': dict(counts), 'input_sha256': hashes, 'all_passed': True,
                              'actual_initial_bits_and_complete_after_checked': True,
                              'fifteen_strict_scalar_failures_retained': True, 'production_changed': False,
                              'whole_solver_complete': False}, indent=2) + '\n')
print(json.dumps({'counts': dict(counts), 'all_passed': True}, indent=2))
