"""Audit actual snapshot descriptors, backing bounds, full bytes and cross-endpoint first-NL differences on CPU."""
from collections import Counter
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.graph_definition_dump import Copy3D
from reconstruction.csrc.h1_self_assembly_layout import select_stages

plan = json.loads((BASE / 'plan.json').read_text())
status = json.loads((BASE / 'run.status.json').read_text())
assert status['complete'] and status['running'] is None
assert [row['actual_exit'] for row in status['completed']] == [0, 0]
hashes, layouts = {}, {}
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
counts = Counter()
for run in plan['runs']:
    label = run['label']
    folder = BASE / label / 'trace'
    layout = json.loads((folder / 'snapshot-layout.json').read_text())
    graph = json.loads((folder / 'definition-before/graph.json').read_text())
    topology = json.loads((folder / 'graph-after-topology.json').read_text())
    nodes = linear_order(graph)[0]
    assert layout['stages'] == json.loads(json.dumps(select_stages(nodes, 46, 51)))
    assert len(layout['stages']) == 4 and len(layout['snapshots']) == 50
    assert layout['total_snapshot_bytes'] == 105105340
    assert len(topology['nodes']) == 6120 + 50 and len(topology['edges']) == 6119 + 50 + 2 * 4
    assert set(map(tuple, graph['edges'])) <= set(map(tuple, topology['edges']))
    linear_order(topology)
    ranges = {(row['address'], row['captured_bytes']): row for row in layout['backing_ranges']}
    for stage in layout['stages']:
        for index, size in stage['sizes'].items():
            address = int.from_bytes(bytes.fromhex(stage['node']['parameter_hex'][int(index)]), 'little')
            backing = ranges[address, size]
            assert backing['base'] <= address and address + size <= backing['base'] + backing['bytes']
    expected_offset = 0
    for snapshot in layout['snapshots']:
        assert snapshot['offset'] == expected_offset
        params = Copy3D.from_buffer_copy(bytes.fromhex(snapshot['actual_copy_parameters_hex']))
        assert params.srcMemoryType == params.dstMemoryType == 2
        assert params.srcDevice == snapshot['source'] and params.dstDevice == layout['device_base'] + expected_offset
        assert (params.WidthInBytes, params.Height, params.Depth) == (snapshot['bytes'], 1, 1)
        expected_offset += snapshot['bytes']
        counts['actual_copy_descriptors'] += 1
        counts['complete_snapshot_bytes'] += snapshot['bytes']
    assert expected_offset == 105105340
    runtime = json.loads((BASE / label / 'worker/runtime.json').read_text())
    assert runtime['exit'] == 0 and runtime['public_core_abi'] and not runtime['ab_bridge_used']
    assert runtime['reference_solver_mapped'] == (run['backend'] == 'original')
    layouts[label] = layout
    for path in [folder / 'snapshot-layout.json', folder / 'graph-after-topology.json',
                 folder / 'definition-before/graph.json', BASE / label / 'worker/runtime.json']:
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
rows = []
for left, right in zip(layouts['sdk0']['stages'], layouts['rebuilt0']['stages'], strict=True):
    assert (left['key'], left['rank'], left['sizes'], left['outputs']) == (
        right['key'], right['rank'], right['sizes'], right['outputs'])
    pair = [BASE / label / 'trace' / (left['key'] + '-packets/frame-00.npz') for label in ('sdk0', 'rebuilt0')]
    differences = []
    with np.load(pair[0], allow_pickle=False) as a, np.load(pair[1], allow_pickle=False) as b:
        expected = {f'parameter-{i}' for i in range(len(left['node']['parameter_hex']))}
        expected |= {f'before-arg-{i}' for i in left['sizes']} | {f'after-arg-{i}' for i in left['outputs']}
        assert set(a.files) == set(b.files) == expected
        for data, stage in [(a, left), (b, right)]:
            for i, raw in enumerate(stage['node']['parameter_hex']):
                assert data[f'parameter-{i}'].tobytes().hex() == raw
            for i, size in stage['sizes'].items():
                assert data[f'before-arg-{i}'].dtype == np.uint8 and data[f'before-arg-{i}'].nbytes == size
            for i in stage['outputs']:
                assert data[f'after-arg-{i}'].nbytes == stage['sizes'][str(i)]
            span = stage['dynamic_contact_span']
            contact, counter = span['argument'], span['counter_argument']
            before = int.from_bytes(data[f'before-arg-{counter}'].tobytes(), 'little')
            after = int.from_bytes(data.get(f'after-arg-{counter}', data[f'before-arg-{counter}']).tobytes(), 'little')
            assert 0 <= before <= after <= 131072
            if contact in stage['outputs']:
                first, last = data[f'before-arg-{contact}'], data[f'after-arg-{contact}']
                assert first[:before * 60].tobytes() == last[:before * 60].tobytes()
                assert first[after * 60:].tobytes() == last[after * 60:].tobytes()
            if stage['key'] == 'inverse':
                assert data['before-arg-0'].tobytes() == data['before-arg-3'].tobytes()
        for name in sorted(expected - {key for key in expected if key.startswith('parameter-')}):
            equal = a[name].tobytes() == b[name].tobytes()
            counts['cross_endpoint_payloads'] += 1
            counts['cross_endpoint_equal_payloads'] += equal
            if not equal:
                words = np.flatnonzero(a[name].view(np.uint32) != b[name].view(np.uint32))
                differences.append({'field': name, 'different_words': len(words), 'first_word': int(words[0])})
    for path in pair:
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    rows.append({'stage': left['key'], 'rank': left['rank'], 'different_payloads': differences})
target = BASE / 'captures-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'counts': dict(counts), 'stages': rows, 'input_sha256': hashes,
    'all_selected_spans_have_actual_backing_bounds': True, 'original_nodes_and_edges_preserved': True,
    'first_C8_samples_replaced': False, 'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('Full capture audit:', dict(counts))
print('First cross-endpoint captured payload differences:', next((row for row in rows if row['different_payloads']), None))
