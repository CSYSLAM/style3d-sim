"""Recheck raw snapshot dependencies, complete buffers, SDK isolation and GPU scalar histories independently."""
from collections import Counter, defaultdict
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

root = Path.cwd()
base = Path(__file__).resolve().parent
plan = json.loads((base / 'plan.json').read_text())
for name, digest in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
for stage in ('replay', 'isolation', 'certificates'):
    assert json.loads((base / (stage + '.status.json')).read_text()) == {
        'exit': 0, 'complete': True, 'whole_solver_complete': False}
replay = json.loads((base / 'replay/report.json').read_text())
certificates = json.loads((base / 'certificates/report.json').read_text())
isolation = json.loads((base / 'isolation/report.json').read_text())
certificate_plan = json.loads((base / 'certification-plan.json').read_text())
assert isolation['calls'] == 30960 and certificates['certificates'] == 63370
assert len(replay['packets']) == len(certificates['packets']) == len(isolation['packets']) == 120
assert certificate_plan['replay_report_sha256'] == hashlib.sha256((base / 'replay/report.json').read_bytes()).hexdigest()
counts, strict = Counter(), Counter()
full_sequence_differences = 0
tiny = np.finfo('f4').tiny


def value(bits):
    return np.asarray(bits, dtype='<u4').view('<f4')[()]


def ftz(number):
    return np.copysign(np.float32(0), number) if 0 < abs(number) < tiny else number


for side in ('original', 'source'):
    folder = base / side
    original = json.loads((folder / 'definition-before/graph.json').read_text())
    modified = json.loads((folder / 'graph-after-topology.json').read_text())
    layout = json.loads((folder / 'snapshot-layout.json').read_text())
    assert len(original['nodes']) == 17467 and len(modified['nodes']) == 17486
    assert len(original['edges']) == 17466 and len(modified['edges']) == 17487
    old_nodes = {node['handle'] for node in original['nodes']}
    new_nodes = {node['handle'] for node in modified['nodes']}
    assert old_nodes <= new_nodes and set(map(tuple, original['edges'])) <= set(map(tuple, modified['edges']))
    degree, next_nodes = dict.fromkeys(new_nodes, 0), {handle: [] for handle in new_nodes}
    for a, b in modified['edges']:
        degree[b] += 1
        next_nodes[a].append(b)
    ready = [handle for handle in new_nodes if not degree[handle]]
    order = []
    while ready:
        assert len(ready) == 1
        handle = ready.pop()
        order.append(handle)
        for target in next_nodes[handle]:
            degree[target] -= 1
            if not degree[target]:
                ready.append(target)
    assert len(order) == len(new_nodes)
    rank = {handle: i for i, handle in enumerate(order)}
    selected = layout['node']['handle']
    intervals = []
    for snapshot in layout['snapshots']:
        assert (snapshot['predecessor'], snapshot['node']) in set(map(tuple, modified['edges']))
        assert snapshot['node'] in new_nodes - old_nodes
        assert snapshot['source'] == int.from_bytes(bytes.fromhex(
            layout['node']['parameter_hex'][snapshot['argument']]), 'little')
        assert (rank[snapshot['node']] < rank[selected]) == (snapshot['phase'] == 'before')
        intervals.append((snapshot['offset'], snapshot['offset'] + snapshot['bytes']))
    assert len(intervals) == 19 and sorted(intervals)[0][0] == 0
    assert all(a[1] == b[0] for a, b in zip(sorted(intervals), sorted(intervals)[1:]))
    assert sorted(intervals)[-1][1] == layout['total_snapshot_bytes'] == 15416

for row in replay['packets']:
    side, frame = row['side'], row['frame']
    packet_path = base / side / 'packets' / f'frame-{frame:02d}.npz'
    assert hashlib.sha256(packet_path.read_bytes()).hexdigest() == replay['input_sha256'][str(packet_path)]
    with np.load(packet_path) as packet, np.load(base / 'replay' / f'{side}-frame-{frame:02d}.npz') as outputs:
        layout = json.loads((base / side / 'snapshot-layout.json').read_text())
        raw = [packet['parameter-' + str(index)].tobytes() for index in range(22)]
        assert [value.hex() for value in raw] == layout['node']['parameter_hex']
        pointers = [int.from_bytes(value, 'little') for value in raw]
        bindings = {int(index): packet['before-arg-' + str(index)].tobytes() for index in layout['sizes']}
        captured = packet['after-arg-18'].view('<u4')
        initial_bits = np.frombuffer(bindings[18], dtype='<u4')
        assert len(captured) == len(initial_bits) == 528
        assert int(np.count_nonzero(captured != initial_bits)) == row['capture_effective_scalars'] > 0
        targets = [set([int(word)]) for word in captured]
        for check in row['checks']:
            backend = check['backend']
            result = outputs[backend + '-output']
            equal = result.tobytes() == captured.tobytes()
            assert equal == check['captured_output_equal']
            strict[backend] += equal
            assert hashlib.sha256(result.tobytes()).hexdigest() == check['output_sha256']
            assert check['unwritten_bytes_unchanged']
            for scalar, word in enumerate(result.view('<u4')):
                targets[scalar].add(int(word))
            for group_index, span in enumerate(row['spans']):
                start = min(pointers[index] for index in span['indices'])
                padding = start % 256
                expected = np.zeros(padding + span['bytes'], dtype='u1')
                covered = np.zeros(len(expected), dtype=bool)
                keep = np.ones(len(expected), dtype=bool)
                for index in span['indices']:
                    offset = padding + pointers[index] - start
                    incoming = np.frombuffer(bindings[index], dtype='u1')
                    actual = expected[offset:offset + len(incoming)]
                    seen = covered[offset:offset + len(incoming)]
                    assert np.array_equal(actual[seen], incoming[seen])
                    actual[:] = incoming
                    covered[offset:offset + len(incoming)] = True
                    if index == 18:
                        keep[offset:offset + len(incoming)] = False
                assert covered[padding:].all()
                after = outputs[backend + '-group-' + str(group_index)]
                assert np.array_equal(after[keep], expected[keep])
                counts['saved_unwritten_bytes_rechecked'] += int(np.count_nonzero(keep))
            counts['full_replay_and_probe_output_vectors'] += 1
        operands, sequences = {}, {}
        for backend in ('original', 'source'):
            sizes, records = outputs[backend + '-counts'], outputs[backend + '-records']
            assert np.all(sizes[:43] == 24) and not sizes[43:].any()
            assert records.shape == (1032, 16)
            cursor, grouped, ordered = 0, [], []
            for lane, size in enumerate(sizes):
                by_target, raw_sequence = defaultdict(list), []
                for record in records[cursor:cursor + int(size)]:
                    address = int.from_bytes(record[:8].tobytes(), 'little')
                    assert row['actual_output_replay_address'] <= address < row['actual_output_replay_address'] + 2112
                    scalar = (address - row['actual_output_replay_address']) // 4
                    bits = int.from_bytes(record[8:12].tobytes(), 'little')
                    assert np.isfinite(value(bits))
                    by_target[scalar].append(bits)
                    raw_sequence.append((scalar, bits))
                grouped.append(dict(by_target))
                ordered.append(raw_sequence)
                cursor += int(size)
            assert cursor == len(records)
            operands[backend], sequences[backend] = grouped, ordered
            counts['real_atomic_operands_rechecked'] += cursor
        assert operands['original'] == operands['source']
        full_sequence_differences += sum(a != b for a, b in zip(sequences['original'], sequences['source']))
        terms = [dict() for _ in initial_bits]
        for lane, by_target in enumerate(operands['original']):
            for scalar, words in by_target.items():
                assert len(words) == 1
                terms[scalar][lane] = words[0]
        with np.load(base / 'isolation' / f'{side}-frame-{frame:02d}.npz') as isolated:
            actual, expected = isolated['outputs'], isolated['expected_from_real_operands']
            assert actual.shape == (3, 2, 43, 528) and expected.shape == (2, 43, 528)
            predicted = np.empty_like(expected)
            for seed_index, seed in enumerate((0, 0x80000000)):
                predicted[seed_index].fill(seed)
                for scalar, by_lane in enumerate(terms):
                    for lane, word in by_lane.items():
                        predicted[seed_index, lane, scalar] = ftz(np.float32(value(seed) + ftz(value(word)))).view('u4')
            assert np.array_equal(expected, predicted)
            assert all(np.array_equal(vector, predicted) for vector in actual)
            counts['isolated_SDK_PTX_source_calls_rechecked'] += 258
            counts['isolated_output_scalar_words_rechecked'] += actual.size
        with np.load(base / 'certificates' / f'{side}-frame-{frame:02d}.npz') as proof:
            scalars, words, starts = proof['scalars'], proof['target_bits'], proof['initial_bits']
            offsets, lanes, values = proof['offsets'], proof['term_lanes'], proof['term_value_bits']
            hardware, history = proof['hardware_output_bits'], proof['hardware_history_bits']
            assert len(offsets) == len(scalars) + 1 and offsets[0] == 0
            assert offsets[-1] == len(lanes) == len(values) == len(history)
            seen = [set() for _ in initial_bits]
            for index, scalar in enumerate(scalars):
                scalar = int(scalar)
                assert starts[index] == initial_bits[scalar] and hardware[index] == words[index]
                begin, end = map(int, offsets[index:index + 2])
                assert len(set(map(int, lanes[begin:end]))) == len(terms[scalar]) == end - begin
                assert {int(lane): int(word) for lane, word in zip(lanes[begin:end], values[begin:end])} == terms[scalar]
                current = value(starts[index])
                for step in range(begin, end):
                    assert int(current.view('u4')) == history[step]
                    current = ftz(np.float32(ftz(current) + ftz(value(values[step]))))
                assert int(current.view('u4')) == words[index]
                seen[scalar].add(int(words[index]))
                counts['GPU_scalar_certificates_rechecked'] += 1
                counts['GPU_atomic_history_values_rechecked'] += end - begin
            assert seen == targets
assert counts['real_atomic_operands_rechecked'] == 247680
assert counts['isolated_SDK_PTX_source_calls_rechecked'] == 30960
assert counts['GPU_scalar_certificates_rechecked'] == 63370

fixed = base.parent / 'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json'
assert hashlib.sha256(fixed.read_bytes()).hexdigest() == json.loads((base / 'status.json').read_text())['fixed_C8_report_sha256']
diagnostics = json.loads((base / 'diagnostic-trajectories.json').read_text())
old_paths = json.loads(fixed.read_text())['input_npz_paths']
with ExitStack() as stack:
    old = [stack.enter_context(np.load(old_paths['original' + str(i)])) for i in range(8)]
    for side in ('original', 'source'):
        folder = base / side
        runtime = json.loads((folder / 'worker/runtime.json').read_text())
        assert runtime['exit'] == 0 and runtime['public_core_abi'] and runtime['real_graph_observed']
        assert not runtime['ab_bridge_used'] and runtime['reference_solver_mapped'] == (side == 'original')
        run = stack.enter_context(np.load(folder / 'worker/states.npz'))
        for key in run.files:
            actual = run[key].astype(np.float64)
            values = np.stack([item[key].astype(np.float64) for item in old])
            total, axes = values.sum(0), tuple(range(1, actual.ndim))
            spread = np.maximum.reduce([
                np.abs(values[i] - (total - values[i]) / 7).max(axis=axes) for i in range(8)])
            error = np.abs(actual - total / 8).max(axis=axes)
            saved = diagnostics[side]['statistics'][key]
            assert int(np.count_nonzero(error <= spread)) == saved['substeps_within_spread']
            assert float(error.max()) == saved['reconstruction_error_max']
result = {'counts': dict(counts), 'strict_vectors_of120': dict(strict),
          'cross_target_thread_order_differences': full_sequence_differences,
          'all_per_thread_per_target_operands_equal': True, 'full_unwritten_after_bytes_independently_rechecked': True,
          'actual_pre_call_initial_used': True, 'all63370_GPU_scalar_certificates_rechecked': True,
          'single_global_schedule_proven': False, 'actual_production_order_inferred': False,
          'fixed_C8_failure_reclassified': False, 'whole_solver_complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'independent-cpu-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
