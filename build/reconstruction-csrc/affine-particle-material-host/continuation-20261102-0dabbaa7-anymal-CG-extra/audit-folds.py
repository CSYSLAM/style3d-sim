"""Independently reproduce all recorded GPU scalar fold histories and guard bytes on CPU."""
import ast
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'capture/scalar-folds-v2'
OUTPUT = PHASE / 'independent-cpu.json'
assert not OUTPUT.exists()
plan = json.loads((PHASE / 'plan.json').read_text())
report = json.loads((PHASE / 'GPU-report.json').read_text())
assert report['complete'] and report['error'] is None
assert report['actual_GPU_calls'] == len(plan['requests']) == plan['planned_GPU_calls']
hashes = {**plan['input_sha256'], **report['input_sha256']}
protected, history_words, parameter_bytes = 0, 0, 0
replays = json.loads((PHASE.parent / 'full-input-replays/plan.json').read_text())
trace_descriptors = json.loads((PHASE.parent / 'atomic-operands/report.json').read_text())['rows']
traces = {}
for descriptor in trace_descriptors:
    path = Path(descriptor['record_json'])
    assert hashlib.sha256(path.read_bytes()).hexdigest() == descriptor['record_sha256']
    row = json.loads(path.read_text())
    assert row['packet_index'] == descriptor['packet_index']
    traces[row['packet_index']] = row
replay_report_path = PHASE.parent / 'full-input-replays/report.json'
replay_report = json.loads(replay_report_path.read_text())
expected_targets = {}
for packet_index, (packet, replay_row) in enumerate(zip(replays['packets'], replay_report['packets'])):
    with np.load(packet['input'], allow_pickle=False) as captured:
        with np.load(replay_row['output'], allow_pickle=False) as actual:
            for label in packet['stage']['outputs']:
                original = captured[packet['stage']['key'] + '/after/' + label].view('<u4')
                targets = [original] + [actual[side + '-output-' + label].view('<u4') for side in replays['backends']]
                different = np.any(np.asarray(targets) != original, axis=0)
                for index in np.flatnonzero(different):
                    expected_targets[packet_index, label, int(index)] = {int(values[index]) for values in targets}
    for path in (Path(packet['input']), Path(replay_row['output'])):
        hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
observed_targets = {}
for request in plan['requests']:
    key = request['packet_index'], request['output_label'], request['global_word_index']
    observed = observed_targets.setdefault(key, set())
    assert request['target_bits'] not in observed
    observed.add(request['target_bits'])
assert observed_targets == expected_targets and len(expected_targets) == plan['differing_words']
assert sum(map(len, expected_targets.values())) == len(plan['requests'])
hashes[str(replay_report_path.resolve())] = hashlib.sha256(replay_report_path.read_bytes()).hexdigest()
tiny = np.finfo('f4').tiny


def ftz(value):
    return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value


with np.load(PHASE / 'inputs.npz', allow_pickle=False) as inputs, np.load(PHASE / 'GPU-raw.npz') as raw:
    for request, row in zip(plan['requests'], report['rows']):
        number = request['number']
        assert number == row['number'] and request['target_bits'] == row['target_bits']
        values = inputs[f'{number}/values']
        order = inputs[f'{number}/order']
        expected_history = inputs[f'{number}/expected-history']
        packet = replays['packets'][request['packet_index']]
        stage, index, label = packet['stage'], request['global_word_index'], request['output_label']
        actual = []
        for lane, operations in enumerate(traces[request['packet_index']]['thread_operands']['original']):
            for ordinal, (target_label, target_index, bits) in enumerate(operations):
                if target_label == label and target_index == index:
                    actual.append([lane, ordinal, bits])
        assert actual == request['recorded_operands']
        assert values.view('<u4').tolist() == [record[2] for record in actual]
        with np.load(packet['input'], allow_pickle=False) as captured:
            initial_bits = int(captured[stage['key'] + '/before/' + label].view('<u4')[index])
        assert initial_bits == request['initial_bits']
        previous = {}
        for item in order:
            lane, ordinal, _ = actual[int(item)]
            assert ordinal > previous.get(lane, -1)
            previous[lane] = ordinal
        assert np.array_equal(np.sort(order), np.arange(len(values), dtype='<u4'))
        history, total = [], np.asarray([request['initial_bits']], dtype='<u4').view('<f4')[0]
        for index in order:
            history.append(total)
            total = ftz(np.float32(ftz(total) + ftz(values[index])))
        assert np.asarray(history, dtype='<f4').tobytes() == expected_history.tobytes()
        assert int(total.view('<u4')) == request['target_bits']
        for index in range(4):
            actual = raw[f'{number}/raw-{index}']
            assert np.all(actual[:256] == 211) and np.all(actual[-256:] == 211)
            protected += 512
            expected = [values.view('u1'), order.view('u1'),
                        np.asarray([request['target_bits']], dtype='<u4').view('u1'), expected_history.view('u1')][index]
            assert actual[256:-256].tobytes() == expected.tobytes()
            if index < 2:
                protected += len(expected)
            parameter = raw[f'{number}/parameter-{index}']
            assert parameter.shape == (8,) and int.from_bytes(parameter.tobytes(), 'little') % 256 == 0
            parameter_bytes += 8
        count = raw[f'{number}/parameter-4']
        assert count.shape == (4,) and int.from_bytes(count.tobytes(), 'little') == len(values)
        parameter_bytes += 4
        history_words += len(values)
for path in (Path(__file__), PHASE / 'GPU-raw.npz', PHASE / 'GPU-report.json', PHASE / 'serial-atomic.ptx'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
result = {'actual_GPU_scalar_calls': len(plan['requests']), 'differing_extra_chain_replay_words_covered': len(expected_targets),
          'history_words_checked': history_words, 'protected_bytes_checked': protected,
          'actual_parameter_bytes_checked': parameter_bytes, 'input_sha256': hashes,
          'GPU_used_for_this_audit': False, 'production_global_order_inferred': False,
          'whole_trajectory_failure_reclassified': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('Independent GPU fold CPU:', len(plan['requests']), 'exact targets;', len(expected_targets),
      'differing words;', history_words, 'history words')
