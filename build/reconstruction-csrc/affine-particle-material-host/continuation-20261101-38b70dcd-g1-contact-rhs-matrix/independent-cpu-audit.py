"""Independently recheck contact graph placement, both complete outputs and all real atomic records."""
from collections import Counter, defaultdict
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.demo_ab import spread_report

base = Path(__file__).resolve().parent
plan = json.loads((base / 'plan.json').read_text())
for name, digest in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
assert json.loads((base / 'status.json').read_text())['complete']
assert json.loads((base / 'replay.status.json').read_text()) == {
    'exit': 0, 'complete': True, 'whole_solver_complete': False}
replay = json.loads((base / 'replay/report.json').read_text())
assert len(replay['packets']) == 240
counts, strict, lanes = defaultdict(Counter), defaultdict(Counter), defaultdict(Counter)


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


def expected_sizes(key):
    sizes = {0: 4, 2: 4000, 3: 4000, 9: 4000, 10: 4000, 11: 420, 12: 420, 13: 2940,
             14: 1260, 23: 176, 24: 704, 25: 528}
    sizes.update({i: 12000 for i in (4, 5, 6, 7, 8)})
    sizes.update({i: 420 for i in (15, 16, 17, 18)})
    if key == 'force':
        sizes.update({i: 2112 for i in (28, 29, 30, 32)})
        sizes[33] = 704
    else:
        sizes.update({27: 2112, 28: 2112, 33: 6336, 34: 6336})
    return sizes


layouts = {}
for side in ('original', 'source'):
    folder = base / side
    original = json.loads((folder / 'definition-before/graph.json').read_text())
    modified = json.loads((folder / 'graph-after-topology.json').read_text())
    layout = json.loads((folder / 'snapshot-layout.json').read_text())
    old_order, new_order = ordered(original), ordered(modified)
    assert len(old_order) == 17467 and len(new_order) == 17522
    assert len(original['edges']) == 17466 and len(modified['edges']) == 17525
    assert set(old_order) <= set(new_order)
    edge_set = set(map(tuple, modified['edges']))
    assert set(map(tuple, original['edges'])) <= edge_set
    ranks = {handle: i for i, handle in enumerate(new_order)}
    original_nodes = {node['handle']: node for node in original['nodes']}
    assert len(layout['stages']) == 2 and len(layout['snapshots']) == 55
    seen, intervals = set(), []
    for stage in layout['stages']:
        key = stage['key']
        layouts[side, key] = stage
        target = stage['node']['handle']
        assert stage['node'] == original_nodes[target]
        assert stage['rank'] == old_order.index(target) == {'force': 14576, 'matrix': 14587}[key]
        assert stage['node']['name'] == plan['kernels'][key]
        assert stage['node']['geometry'] == [4, 1, 1, 256, 1, 1, 0]
        assert stage['outputs'] == ([32, 33] if key == 'force' else [33, 34])
        assert {int(i): size for i, size in stage['sizes'].items()} == expected_sizes(key)
        previous, following = (old_order[stage['rank'] + delta] for delta in (-1, 1))
        selected = [row for row in layout['snapshots'] if row['stage'] == key]
        assert {(row['phase'], row['argument']) for row in selected} == {
            *(('before', i) for i in expected_sizes(key)), *(('after', i) for i in stage['outputs'])}
        for row in selected:
            assert (row['predecessor'], row['node']) in edge_set
            assert row['source'] == int.from_bytes(bytes.fromhex(stage['node']['parameter_hex'][row['argument']]),
                                                  'little')
            assert row['node'] in set(new_order) - set(old_order) and row['node'] not in seen
            seen.add(row['node'])
            assert row['bytes'] == expected_sizes(key)[row['argument']]
            if row['phase'] == 'before':
                assert ranks[previous] < ranks[row['node']] < ranks[target]
            else:
                assert ranks[target] < ranks[row['node']] < ranks[following]
            intervals.append((row['offset'], row['offset'] + row['bytes']))
    assert len(seen) == 55 and min(intervals)[0] == 0
    assert all(a[1] == b[0] for a, b in zip(sorted(intervals), sorted(intervals)[1:]))
    assert max(intervals)[1] == layout['total_snapshot_bytes'] == 209800

keys_seen = set()
for row in replay['packets']:
    key, side, frame = row['stage'], row['side'], row['frame']
    assert (key, side, frame) not in keys_seen
    keys_seen.add((key, side, frame))
    stage = layouts[side, key]
    path = base / side / (key + '-packets') / f'frame-{frame:02d}.npz'
    assert hashlib.sha256(path.read_bytes()).hexdigest() == replay['input_sha256'][str(path)]
    with np.load(path) as packet, np.load(base / 'replay' / f'{key}-{side}-frame-{frame:02d}.npz') as outputs:
        raw = [packet['parameter-' + str(i)].tobytes() for i in range(34 if key == 'force' else 35)]
        assert [item.hex() for item in raw] == stage['node']['parameter_hex']
        pointers = [int.from_bytes(item, 'little') for item in raw]
        assert pointers[1] == 1000 and pointers[20:23] == [105, 105, 1] and pointers[26] == 44
        assert pointers[27 if key == 'force' else 32] == 176
        assert key != 'matrix' or pointers[29] == pointers[30] == 0
        bindings = {i: packet['before-arg-' + str(i)].tobytes() for i in expected_sizes(key)}
        assert {i: len(value) for i, value in bindings.items()} == expected_sizes(key)
        afters = {i: packet['after-arg-' + str(i)].tobytes() for i in stage['outputs']}
        reported = int.from_bytes(bindings[0], 'little', signed=True)
        active = min(max(reported, 0), 1000)
        assert active == row['active_contacts'] and reported == row['reported_contact_count']
        counts[key]['active_contacts'] += active
        for i, value in afters.items():
            changed = int(np.count_nonzero(np.frombuffer(value, dtype='<u4') != np.frombuffer(bindings[i], dtype='<u4')))
            assert changed == row['capture_effective_scalars'][str(i)]
            counts[key]['effective_output_' + str(i)] += changed > 0
        all_indices = [i for span in row['spans'] for i in span['indices']]
        assert len(all_indices) == len(set(all_indices)) and set(all_indices) == set(bindings)
        for check in row['checks']:
            backend = check['backend']
            all_equal = True
            for i, value in afters.items():
                equal = outputs[backend + '-output-' + str(i)].tobytes() == value
                assert check['captured_output_equal'][str(i)] == equal
                strict[key][backend + '-output-' + str(i)] += equal
                all_equal &= equal
                counts[key]['complete_outputs_rechecked'] += 1
            assert check['all_outputs_equal'] == all_equal
            strict[key][backend + '-both'] += all_equal
            for index, span in enumerate(row['spans']):
                start = min(pointers[i] for i in span['indices'])
                end = max(pointers[i] + len(bindings[i]) for i in span['indices'])
                assert span['bytes'] == end - start
                padding = start % 256
                assert padding == span['original_start_mod256']
                before = np.zeros(padding + span['bytes'], dtype='u1')
                covered, keep = np.zeros(len(before), dtype=bool), np.ones(len(before), dtype=bool)
                for i in span['indices']:
                    assert span['offsets'][str(i)] == pointers[i] - start
                    offset = padding + pointers[i] - start
                    data = np.frombuffer(bindings[i], dtype='u1')
                    old, seen = before[offset:offset + len(data)], covered[offset:offset + len(data)]
                    assert np.array_equal(old[seen], data[seen])
                    old[:] = data
                    covered[offset:offset + len(data)] = True
                    if i in afters:
                        keep[offset:offset + len(data)] = False
                assert covered[padding:].all()
                after = outputs[backend + '-group-' + str(index)]
                assert np.array_equal(after[keep], before[keep]) and check['unwritten_bytes_unchanged']
                counts[key]['full_unwritten_bytes_rechecked'] += int(keep.sum())
        operands, sequences = {}, {}
        for backend in ('original', 'source'):
            sizes, records = outputs[backend + '-counts'], outputs[backend + '-records']
            assert sizes.shape == (1024,) and not sizes[active:].any()
            assert sizes.max() <= (64 if key == 'force' else 144)
            assert records.shape == (int(sizes.sum()), 16)
            grouped, full, cursor = [], [], 0
            addresses = {int(i): value for i, value in row['actual_output_replay_addresses'].items()}
            assert set(addresses) == set(afters)
            for i, address in addresses.items():
                assert address % 256 == pointers[i] % 256
            for size in sizes:
                values, sequence = defaultdict(list), []
                for record in records[cursor:cursor + int(size)]:
                    address = int.from_bytes(record[:8].tobytes(), 'little')
                    aliases = [(i, (address - start) // 4) for i, start in addresses.items()
                               if start <= address < start + len(afters[i])]
                    assert aliases and all((address - addresses[i]) % 4 == 0 for i, _ in aliases)
                    target = min(aliases)
                    bits = int.from_bytes(record[8:12].tobytes(), 'little')
                    assert np.isfinite(np.asarray(bits, dtype='<u4').view('<f4'))
                    values[target].append(bits)
                    sequence.append((target, bits))
                grouped.append(dict(values))
                full.append(sequence)
                cursor += int(size)
            operands[backend], sequences[backend] = grouped, full
            assert cursor == row['atomic_operands'][backend] == len(records)
            counts[key]['real_atomic_operands_rechecked'] += len(records)
            if backend == 'original':
                lanes[key].update(map(int, sizes[:active]))
        different = [i for i, (a, b) in enumerate(zip(operands['original'], operands['source'])) if a != b]
        sequence_different = [i for i, (a, b) in enumerate(zip(sequences['original'], sequences['source'])) if a != b]
        assert different == row['operand_differing_lanes']
        assert sequence_different == row['complete_sequence_differing_lanes']
        assert row['all_per_thread_per_target_operand_sequences_equal'] == (not different)
        assert row['all_complete_thread_sequences_equal'] == (not sequence_different)
        counts[key]['packets'] += 1
        counts[key]['per_thread_per_target_sequence_differences'] += len(different)
        counts[key]['full_thread_sequence_differences'] += len(sequence_different)
expected_packets = {(key, side, frame) for key in ('force', 'matrix')
                    for side in ('original', 'source') for frame in range(60)}
assert keys_seen == expected_packets

fixed = base.parent / 'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json'
assert hashlib.sha256(fixed.read_bytes()).hexdigest() == json.loads(
    (base / 'status.json').read_text())['fixed_C8_report_sha256']
old_paths = json.loads(fixed.read_text())['input_npz_paths']
diagnostics = {}
with ExitStack() as stack:
    old = [stack.enter_context(np.load(old_paths['original' + str(i)])) for i in range(8)]
    for side in ('original', 'source'):
        folder = base / side
        runtime = json.loads((folder / 'worker/runtime.json').read_text())
        assert runtime['exit'] == 0 and runtime['real_graph_observed'] and runtime['public_core_abi']
        assert not runtime['ab_bridge_used'] and runtime['reference_solver_mapped'] == (side == 'original')
        path = folder / 'worker/states.npz'
        actual = stack.enter_context(np.load(path))
        statistics = spread_report(old, [actual])
        details = {}
        for key in actual.files:
            values = np.stack([item[key].astype(np.float64) for item in old])
            candidate = actual[key].astype(np.float64)
            assert len(candidate) == 60 and np.isfinite(candidate).all()
            total, axes = values.sum(0), tuple(range(1, candidate.ndim))
            spread = np.maximum.reduce([
                np.abs(values[i] - (total - values[i]) / 7).max(axis=axes) for i in range(8)])
            error = np.abs(candidate - total / 8).max(axis=axes)
            assert int(np.count_nonzero(error <= spread)) == statistics[key]['substeps_within_spread']
            assert float(error.max()) == statistics[key]['reconstruction_error_max']
            details[key] = {'outside_frames': np.flatnonzero(error > spread).tolist(),
                            'max_error': float(error.max()), 'max_error_frame': int(np.argmax(error))}
        exact = {}
        for label, filename in old_paths.items():
            with np.load(filename) as frozen:
                exact[label] = all(actual[key].tobytes() == frozen[key].tobytes() for key in actual.files)
        diagnostics[side] = {'statistics': statistics, 'outside': details, 'exact_frozen_matches': exact,
                             'states_sha256': hashlib.sha256(path.read_bytes()).hexdigest()}
(base / 'diagnostic-trajectories.json').write_text(json.dumps(diagnostics, indent=2) + '\n')
result = {'counts': {k: dict(v) for k, v in counts.items()}, 'strict_outputs_of120': {k: dict(v) for k, v in strict.items()},
          'active_lane_atomic_counts': {k: dict(v) for k, v in lanes.items()},
          'full_after_bytes_independently_rechecked': True, 'authentic_pre_call_initial_used': True,
          'fixed_C8_failure_reclassified': False, 'whole_solver_complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'independent-cpu-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
