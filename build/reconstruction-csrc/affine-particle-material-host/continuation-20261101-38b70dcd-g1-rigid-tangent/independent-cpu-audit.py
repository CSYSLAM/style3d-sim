"""Recompute all strict rigid-tangent outputs, complete after buffers and real atomic sequences from raw bytes."""
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
assert json.loads((base / 'replay.status.json').read_text()) == {
    'exit': 0, 'complete': True, 'whole_solver_complete': False}
replay = json.loads((base / 'replay/report.json').read_text())
assert len(replay['packets']) == 120
counts, strict, lane_counts = Counter(), Counter(), Counter()
full_sequence_differences = 0


def ordered(graph):
    handles = {node['handle'] for node in graph['nodes']}
    degree, following = dict.fromkeys(handles, 0), {handle: [] for handle in handles}
    for a, b in graph['edges']:
        assert a in handles and b in handles
        degree[b] += 1
        following[a].append(b)
    ready = [handle for handle in handles if not degree[handle]]
    result = []
    while ready:
        assert len(ready) == 1
        handle = ready.pop()
        result.append(handle)
        for target in following[handle]:
            degree[target] -= 1
            if not degree[target]:
                ready.append(target)
    assert len(result) == len(handles)
    return result


for side in ('original', 'source'):
    folder = base / side
    original = json.loads((folder / 'definition-before/graph.json').read_text())
    modified = json.loads((folder / 'graph-after-topology.json').read_text())
    layout = json.loads((folder / 'snapshot-layout.json').read_text())
    old_order, new_order = ordered(original), ordered(modified)
    assert len(old_order) == 17467 and len(new_order) == 17493
    assert len(original['edges']) == 17466 and len(modified['edges']) == 17494
    assert set(old_order) <= set(new_order)
    assert set(map(tuple, original['edges'])) <= set(map(tuple, modified['edges']))
    selected = layout['node']['handle']
    assert old_order.index(selected) == 17451
    following = old_order[17452]
    ranks = {handle: index for index, handle in enumerate(new_order)}
    intervals = []
    for row in layout['snapshots']:
        assert (row['predecessor'], row['node']) in set(map(tuple, modified['edges']))
        assert row['source'] == int.from_bytes(bytes.fromhex(layout['node']['parameter_hex'][row['argument']]), 'little')
        assert row['node'] in set(new_order) - set(old_order)
        assert (ranks[row['node']] < ranks[selected]) == (row['phase'] == 'before')
        if row['phase'] == 'after':
            assert row['argument'] == 30 and ranks[row['node']] < ranks[following]
        intervals.append((row['offset'], row['offset'] + row['bytes']))
    assert len(intervals) == 26 and min(intervals)[0] == 0
    assert all(left[1] == right[0] for left, right in zip(sorted(intervals), sorted(intervals)[1:]))
    assert max(intervals)[1] == layout['total_snapshot_bytes'] == 94692
    assert len(layout['sizes']) == 25
    assert (base / (side + '-capture-as-run.py')).read_bytes() == (base / 'capture-template.py').read_bytes()
assert (base / 'replay-replay-as-run.py').read_bytes() == (base / 'replay-template.py').read_bytes()

for row in replay['packets']:
    side, frame = row['side'], row['frame']
    path = base / side / 'packets' / f'frame-{frame:02d}.npz'
    assert hashlib.sha256(path.read_bytes()).hexdigest() == replay['input_sha256'][str(path)]
    layout = json.loads((base / side / 'snapshot-layout.json').read_text())
    with np.load(path) as packet, np.load(base / 'replay' / f'{side}-frame-{frame:02d}.npz') as outputs:
        raw = [packet['parameter-' + str(index)].tobytes() for index in range(35)]
        assert [item.hex() for item in raw] == layout['node']['parameter_hex']
        pointers = [int.from_bytes(item, 'little') for item in raw]
        assert pointers[1] == 1000 and pointers[20:23] == [105, 105, 1]
        assert pointers[26] == 44 and pointers[32:] == [176, 0, 0]
        bindings = {int(index): packet['before-arg-' + str(index)].tobytes() for index in layout['sizes']}
        reported = int.from_bytes(bindings[0], 'little', signed=True)
        active = min(max(reported, 0), 1000)
        assert active == row['active_contacts'] and reported == row['reported_contact_count']
        expected = packet['after-arg-30'].tobytes()
        changed = int(np.count_nonzero(np.frombuffer(expected, dtype='<u4') !=
                                      np.frombuffer(bindings[30], dtype='<u4')))
        assert changed == row['capture_effective_scalars']
        counts['effective_packet_calls'] += changed > 0
        counts['reported_active_contacts'] += active
        for check in row['checks']:
            backend = check['backend']
            value = outputs[backend + '-output']
            assert value.tobytes() == expected
            assert hashlib.sha256(value.tobytes()).hexdigest() == check['output_sha256']
            assert check['captured_output_equal'] and check['unwritten_bytes_unchanged']
            strict[backend] += 1
            for index, span in enumerate(row['spans']):
                start = min(pointers[arg] for arg in span['indices'])
                padding = start % 256
                before = np.zeros(padding + span['bytes'], dtype='u1')
                covered = np.zeros(len(before), dtype=bool)
                keep = np.ones(len(before), dtype=bool)
                for argument in span['indices']:
                    offset = padding + pointers[argument] - start
                    data = np.frombuffer(bindings[argument], dtype='u1')
                    old = before[offset:offset + len(data)]
                    seen = covered[offset:offset + len(data)]
                    assert np.array_equal(old[seen], data[seen])
                    old[:] = data
                    covered[offset:offset + len(data)] = True
                    if argument == 30:
                        keep[offset:offset + len(data)] = False
                assert covered[padding:].all()
                after = outputs[backend + '-group-' + str(index)]
                assert np.array_equal(after[keep], before[keep])
                counts['full_unwritten_bytes_rechecked'] += int(np.count_nonzero(keep))
            counts['strict_output_vectors_rechecked'] += 1
        operands, sequences = {}, {}
        for backend in ('original', 'source'):
            sizes, records = outputs[backend + '-counts'], outputs[backend + '-records']
            assert sizes.shape == (1024,) and not sizes[active:].any() and sizes.max() <= 128
            assert records.shape == (int(sizes.sum()), 16)
            grouped, ordered_records, cursor = [], [], 0
            for lane, size in enumerate(sizes):
                target_values, sequence = defaultdict(list), []
                for record in records[cursor:cursor + int(size)]:
                    address = int.from_bytes(record[:8].tobytes(), 'little')
                    assert row['actual_output_replay_address'] <= address < row['actual_output_replay_address'] + 2112
                    assert (address - row['actual_output_replay_address']) % 4 == 0
                    scalar = (address - row['actual_output_replay_address']) // 4
                    bits = int.from_bytes(record[8:12].tobytes(), 'little')
                    assert np.isfinite(np.asarray(bits, dtype='<u4').view('<f4'))
                    target_values[scalar].append(bits)
                    sequence.append((scalar, bits))
                grouped.append(dict(target_values))
                ordered_records.append(sequence)
                cursor += int(size)
            assert cursor == len(records)
            operands[backend], sequences[backend] = grouped, ordered_records
            counts['real_atomic_operands_rechecked'] += len(records)
            if backend == 'original':
                lane_counts.update(map(int, sizes[:active]))
        assert operands['original'] == operands['source']
        full_sequence_differences += sum(a != b for a, b in zip(sequences['original'], sequences['source']))
        assert row['all_per_thread_per_target_operand_sequences_equal']
assert counts['strict_output_vectors_rechecked'] == 600
assert counts['reported_active_contacts'] == 2017 and counts['effective_packet_calls'] == 53
assert counts['real_atomic_operands_rechecked'] == 11904
for filename in ('isolation-plan.json', 'certification-plan.json'):
    superseded = json.loads((base / filename).read_text())
    assert superseded['GPU_execution_started'] is False and superseded['thresholds_changed'] is False
    assert not superseded['observed_failures_removed']

fixed = base.parent / 'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json'
assert hashlib.sha256(fixed.read_bytes()).hexdigest() == json.loads(
    (base / 'status.json').read_text())['fixed_C8_report_sha256']
diagnostics = json.loads((base / 'diagnostic-trajectories.json').read_text())
old_paths = json.loads(fixed.read_text())['input_npz_paths']
with ExitStack() as stack:
    old = [stack.enter_context(np.load(old_paths['original' + str(index)])) for index in range(8)]
    for side in ('original', 'source'):
        folder = base / side
        runtime = json.loads((folder / 'worker/runtime.json').read_text())
        assert runtime['exit'] == 0 and runtime['real_graph_observed'] and runtime['public_core_abi']
        assert not runtime['ab_bridge_used'] and runtime['reference_solver_mapped'] == (side == 'original')
        actual = stack.enter_context(np.load(folder / 'worker/states.npz'))
        for key in actual.files:
            values = np.stack([item[key].astype(np.float64) for item in old])
            candidate = actual[key].astype(np.float64)
            assert len(candidate) == 60 and np.isfinite(candidate).all()
            total, axes = values.sum(0), tuple(range(1, candidate.ndim))
            spread = np.maximum.reduce([
                np.abs(values[index] - (total - values[index]) / 7).max(axis=axes) for index in range(8)])
            error = np.abs(candidate - total / 8).max(axis=axes)
            saved = diagnostics[side]['statistics'][key]
            assert int(np.count_nonzero(error <= spread)) == saved['substeps_within_spread']
            assert float(error.max()) == saved['reconstruction_error_max']
result = {'counts': dict(counts), 'strict_vectors_of120': dict(strict), 'active_lane_atomic_counts': dict(lane_counts),
          'cross_target_thread_order_differences': full_sequence_differences,
          'all600_complete_outputs_strict': True, 'all_per_thread_per_target_operands_equal': True,
          'full_after_bytes_independently_rechecked': True, 'authentic_pre_call_initial_used': True,
          'optional_extra_probes_not_executed_after_strict_gate_passed': True,
          'fixed_C8_failure_reclassified': False, 'whole_solver_complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'independent-cpu-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
