"""Independently audit authentic RHS graphs, full replay bytes, actual ABI and real atomic records."""
from collections import Counter, defaultdict
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

sys.path.insert(0, str(Path.cwd()))
from reconstruction.demo_ab import spread_report

BASE = Path(__file__).resolve().parent
SIZES = {
    'rhs': {1: 2112, 2: 2112, 3: 704, 4: 704, 5: 26752, 7: 2112, 8: 704, 9: 2112},
    'joint': {0: 2112, 1: 704, 2: 688, 3: 1032, 4: 1032, 5: 1376, 6: 1376, 7: 344, 8: 1032, 10: 2112},
    'so3': {0: 2112, 1: 704, 2: 176, 3: 1584, 4: 1584, 6: 2112},
}
OUTPUT = {'rhs': 9, 'joint': 10, 'so3': 6}
RANKS = {'rhs': 14575, 'joint': 14580, 'so3': 14583}
WIDTHS = {'rhs': [4] + [8] * 11, 'joint': [8] * 9 + [4] + [8] * 5, 'so3': [8] * 5 + [4] + [8] * 4}
STATIC = {'rhs': (3, 4, 5, 8), 'joint': tuple(range(1, 8)), 'so3': (1, 2)}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def order(graph):
    nodes = {node['handle'] for node in graph['nodes']}
    following = {node: [] for node in nodes}
    degree = dict.fromkeys(nodes, 0)
    for a, b in graph['edges']:
        assert a in nodes and b in nodes
        following[a].append(b)
        degree[b] += 1
    ready = [node for node in nodes if degree[node] == 0]
    result = []
    while ready:
        assert len(ready) == 1
        node = ready.pop()
        result.append(node)
        for target in following[node]:
            degree[target] -= 1
            if degree[target] == 0:
                ready.append(target)
    assert len(result) == len(nodes)
    return result


plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert digest(Path(name)) == expected, name
status = json.loads((BASE / 'status.json').read_text())
assert status['complete'] and status['running'] is None
assert status['completed'] == [{'backend': side, 'exit': 0} for side in ('original', 'source')]
assert json.loads((BASE / 'replay.status.json').read_text()) == {
    'exit': 0, 'complete': True, 'whole_solver_complete': False,
}
replay = json.loads((BASE / 'replay/report.json').read_text())
assert len(replay['packets']) == 360
layouts = {}
for side in ('original', 'source'):
    folder = BASE / side
    graph = json.loads((folder / 'definition-before/graph.json').read_text())
    changed = json.loads((folder / 'graph-after-topology.json').read_text())
    layout = json.loads((folder / 'snapshot-layout.json').read_text())
    before, after = order(graph), order(changed)
    assert len(before) == 17467 and len(graph['edges']) == 17466
    assert len(after) == 17494 and len(changed['edges']) == 17499
    edges = set(map(tuple, changed['edges']))
    assert set(map(tuple, graph['edges'])) <= edges and set(before) <= set(after)
    assert len(layout['stages']) == 3 and len(layout['snapshots']) == 27
    positions = {handle: i for i, handle in enumerate(after)}
    originals = {node['handle']: node for node in graph['nodes']}
    seen, intervals = set(), []
    for stage in layout['stages']:
        key, node = stage['key'], stage['node']
        layouts[side, key] = stage
        assert node == originals[node['handle']] and node['name'] == plan['kernels'][key]
        assert node['geometry'] == [1, 1, 1, 256, 1, 1, 0] and node['parameter_widths'] == WIDTHS[key]
        assert stage['rank'] == before.index(node['handle']) == RANKS[key]
        assert {int(i): size for i, size in stage['sizes'].items()} == SIZES[key]
        assert stage['outputs'] == [OUTPUT[key]] and not stage['output_overlaps']
        raw = [bytes.fromhex(value) for value in node['parameter_hex']]
        rows = [row for row in layout['snapshots'] if row['stage'] == key]
        assert {(r['phase'], r['argument']) for r in rows} == {
            *(('before', i) for i in SIZES[key]), ('after', OUTPUT[key]),
        }
        previous, following = (before[stage['rank'] + d] for d in (-1, 1))
        for row in rows:
            i = row['argument']
            assert row['node'] not in seen and row['node'] not in originals
            seen.add(row['node'])
            assert row['source'] == int.from_bytes(raw[i], 'little') and row['bytes'] == SIZES[key][i]
            assert (row['predecessor'], row['node']) in edges
            assert (positions[previous] < positions[row['node']] < positions[node['handle']] if row['phase'] == 'before'
                    else positions[node['handle']] < positions[row['node']] < positions[following])
            intervals.append((row['offset'], row['offset'] + row['bytes']))
    assert seen == set(after) - set(before)
    assert min(intervals)[0] == 0 and max(intervals)[1] == layout['total_snapshot_bytes'] == 63728
    assert all(a[1] == b[0] for a, b in zip(sorted(intervals), sorted(intervals)[1:]))
    assert (BASE / (side + '-capture-as-run.py')).read_bytes() == (BASE / 'capture-template.py').read_bytes()
assert (BASE / 'replay-replay-as-run.py').read_bytes() == (BASE / 'replay-template.py').read_bytes()
counts, strict = defaultdict(Counter), defaultdict(Counter)
static = defaultdict(list)
inputs, seen = {}, set()
for row in replay['packets']:
    key, side, frame = row['stage'], row['side'], row['frame']
    identity = key, side, frame
    assert identity not in seen
    seen.add(identity)
    path = BASE / side / (key + '-packets') / ('frame-' + str(frame).zfill(2) + '.npz')
    result = BASE / 'replay' / (key + '-' + side + '-frame-' + str(frame).zfill(2) + '.npz')
    inputs[str(path)], inputs[str(result)] = digest(path), digest(result)
    with np.load(path, allow_pickle=False) as packet, np.load(result, allow_pickle=False) as actual:
        node = layouts[side, key]['node']
        raw = [packet['parameter-' + str(i)].tobytes() for i in range(len(WIDTHS[key]))]
        assert [value.hex() for value in raw] == node['parameter_hex']
        assert list(map(len, raw)) == WIDTHS[key]
        values = [int.from_bytes(value, 'little') for value in raw]
        bindings = {i: packet['before-arg-' + str(i)].tobytes() for i in SIZES[key]}
        assert {i: len(data) for i, data in bindings.items()} == SIZES[key]
        out = OUTPUT[key]
        expected = packet['after-arg-' + str(out)].tobytes()
        assert len(expected) == 2112
        effective = int(np.count_nonzero(np.frombuffer(expected, '<u4') != np.frombuffer(bindings[out], '<u4')))
        assert row['capture_effective_scalars'] == {str(out): effective}
        counts[key]['effective_calls'] += int(effective != 0)
        for i in STATIC[key]:
            static[key, i, side].append(bindings[i])
        # Reconstruct intersecting groups independently; adjacency alone must not merge allocations.
        groups = []
        for start, end, i in sorted((values[i], values[i] + len(data), i) for i, data in bindings.items()):
            if not groups or start >= groups[-1]['end']:
                groups.append({'start': start, 'end': end, 'indices': [i]})
            else:
                groups[-1]['end'] = max(groups[-1]['end'], end)
                groups[-1]['indices'].append(i)
        assert len(groups) == len(row['spans'])
        pointers, initial_groups, masks = {}, [], []
        for group, observed in zip(groups, row['spans']):
            start, end, indices = group['start'], group['end'], group['indices']
            pad = start % 256
            assert observed['indices'] == indices and observed['bytes'] == end - start
            assert observed['original_start_mod256'] == pad
            assert observed['offsets'] == {str(i): values[i] - start for i in indices}
            base = observed['allocated_device_base']
            assert base and base % 256 == 0
            initial = np.zeros(pad + end - start, dtype='u1')
            covered = np.zeros(len(initial), dtype=bool)
            covered[:pad] = True
            mask = np.ones(len(initial), dtype=bool)
            for i in indices:
                offset = pad + values[i] - start
                incoming = np.frombuffer(bindings[i], dtype='u1')
                target = initial[offset:offset + len(incoming)]
                used = covered[offset:offset + len(incoming)]
                assert np.array_equal(target[used], incoming[used])
                target[:] = incoming
                used[:] = True
                pointers[i] = base + offset
                assert pointers[i] % 256 == values[i] % 256
                if i == out:
                    mask[offset:offset + len(incoming)] = False
            assert covered.all()
            initial_groups.append(initial)
            masks.append(mask)
        assert row['actual_output_replay_addresses'] == {str(out): pointers[out]}
        for i, original in enumerate(raw):
            relocated = actual['actual-parameter-' + str(i)].tobytes()
            assert relocated == (pointers[i].to_bytes(8, 'little') if i in pointers else original)
            counts[key]['actual_ABI_bytes_rechecked'] += len(relocated)
            counts[key]['pointer_fields_rechecked' if i in pointers else 'scalar_bytes_rechecked'] += (
                1 if i in pointers else len(original))
        backends = {'original-runtime', 'original-ptx', 'source-ptx'}
        if key != 'rhs':
            backends |= {'original-probe', 'source-probe'}
        assert len(row['checks']) == len(backends) and {c['backend'] for c in row['checks']} == backends
        for check in row['checks']:
            backend = check['backend']
            output_bytes = actual[backend + '-output-' + str(out)].tobytes()
            equal = output_bytes == expected
            assert check['captured_output_equal'] == {str(out): equal} and check['all_outputs_equal'] == equal
            strict[key][backend] += int(equal)
            for i, (group, initial, mask) in enumerate(zip(groups, initial_groups, masks)):
                after = actual[backend + '-group-' + str(i)]
                assert after.shape == initial.shape and np.array_equal(after[mask], initial[mask])
                counts[key]['unwritten_after_bytes_rechecked'] += int(mask.sum())
                if out in group['indices']:
                    offset = group['start'] % 256 + values[out] - group['start']
                    assert after[offset:offset + 2112].tobytes() == output_bytes
            assert check['unwritten_bytes_unchanged']
            counts[key]['complete_vectors_rechecked'] += 1
        active = {'rhs': 176, 'joint': 86, 'so3': 44}[key]
        assert row['actual_lane_count'] == row['active_lanes'] == active
        assert row['atomic_probes_executed'] == (key != 'rhs')
        if key == 'rhs':
            assert not row['atomic_operands']
        else:
            full, grouped = {}, {}
            for backend in ('original', 'source'):
                sizes = actual[backend + '-counts']
                records = actual[backend + '-records']
                assert sizes.shape == (1024,) and not sizes[active:].any()
                if key == 'joint':
                    pairs = np.frombuffer(bindings[2], '<i4').reshape(86, 2)
                    assert ((pairs >= -1) & (pairs < 44)).all()
                    expected_sizes = 12 * np.count_nonzero(pairs >= 0, axis=1)
                else:
                    expected_sizes = np.full(44, 12)
                assert np.array_equal(sizes[:active], expected_sizes)
                assert records.shape == (int(sizes.sum()), 16)
                assert len(records) == row['atomic_operands'][backend]
                full[backend], grouped[backend] = [], []
                offset = 0
                for size in sizes:
                    sequence, targets = [], defaultdict(list)
                    for record in records[offset:offset + size]:
                        address = int.from_bytes(record[:8].tobytes(), 'little')
                        assert pointers[out] <= address < pointers[out] + 2112 and (address - pointers[out]) % 4 == 0
                        target = (out, (address - pointers[out]) // 4)
                        bits = int.from_bytes(record[8:12].tobytes(), 'little')
                        sequence.append((target, bits))
                        targets[target].append(bits)
                    full[backend].append(sequence)
                    grouped[backend].append(dict(targets))
                    offset += int(size)
                counts[key]['real_atomic_operands_rechecked'] += len(records)
            differing = [i for i, (a, b) in enumerate(zip(grouped['original'], grouped['source'])) if a != b]
            full_differing = [i for i, (a, b) in enumerate(zip(full['original'], full['source'])) if a != b]
            assert differing == row['operand_differing_lanes'] and full_differing == row['complete_sequence_differing_lanes']
            counts[key]['per_target_sequence_differing_lanes'] += len(differing)
            counts[key]['full_thread_sequence_differing_lanes'] += len(full_differing)
        counts[key]['packets'] += 1
assert seen == {(key, side, i) for key in SIZES for side in ('original', 'source') for i in range(60)}
cache = {}
for key, indices in STATIC.items():
    for i in indices:
        values = {side: static[key, i, side] for side in ('original', 'source')}
        hashes = {side: sorted({hashlib.sha256(value).hexdigest() for value in data}) for side, data in values.items()}
        cache[key + '-arg-' + str(i)] = {
            'bytes': len(values['original'][0]), 'unique_sha256': hashes,
            'constant_over60_both': all(len(row) == 1 for row in hashes.values()),
            'all120_byte_equal': len(set(hashes['original'] + hashes['source'])) == 1,
        }
(BASE / 'cross-backend-constructor-cache-fields.json').write_text(json.dumps({
    'fields': cache, 'all_recorded_fields_constant_and_equal': all(v['all120_byte_equal'] for v in cache.values()),
    'entire_constructor_not_proven': True, 'whole_solver_complete': False,
}, indent=2) + '\n')
fixed = BASE.parent / 'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json'
assert digest(fixed) == status['fixed_C8_report_sha256']
old_paths = json.loads(fixed.read_text())['input_npz_paths']
diagnostics = {}
with ExitStack() as stack:
    originals = [stack.enter_context(np.load(old_paths['original' + str(i)])) for i in range(8)]
    for side in ('original', 'source'):
        runtime = json.loads((BASE / side / 'worker/runtime.json').read_text())
        assert runtime['exit'] == 0 and runtime['real_graph_observed'] and runtime['public_core_abi']
        assert not runtime['ab_bridge_used'] and runtime['reference_solver_mapped'] == (side == 'original')
        actual = stack.enter_context(np.load(BASE / side / 'worker/states.npz'))
        stats = spread_report(originals, [actual])
        for key in actual.files:
            values = np.stack([item[key].astype(np.float64) for item in originals])
            candidate = actual[key].astype(np.float64)
            assert len(candidate) == 60 and np.isfinite(candidate).all()
            total, axes = values.sum(0), tuple(range(1, candidate.ndim))
            spread = np.maximum.reduce([np.abs(values[i] - (total - values[i]) / 7).max(axis=axes) for i in range(8)])
            error = np.abs(candidate - total / 8).max(axis=axes)
            assert int(np.count_nonzero(error <= spread)) == stats[key]['substeps_within_spread']
            assert float(error.max()) == stats[key]['reconstruction_error_max']
        diagnostics[side] = stats
(BASE / 'diagnostic-trajectories.json').write_text(json.dumps(diagnostics, indent=2) + '\n')
report = {
    'counts': {key: dict(value) for key, value in counts.items()},
    'strict_vectors_of120': {key: dict(value) for key, value in strict.items()},
    'input_sha256': inputs, 'runner_sha256': digest(Path(__file__)),
    'all_complete_outputs_strict': all(value == 120 for fields in strict.values() for value in fields.values()),
    'full_unwritten_after_independently_rechecked': True, 'actual_ABI_bytes_independently_rechecked': True,
    'frozen_failure_reclassified': False, 'whole_solver_complete': False,
}
(BASE / 'independent-cpu-audit.json').write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({key: value for key, value in report.items() if key != 'input_sha256'}, indent=2), flush=True)
