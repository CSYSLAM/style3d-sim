"""Audit actual graphs, copy descriptors, complete packets, aliases and vector producer/consumer links."""
from collections import Counter
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_nl2_linear import rendered_transport
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.graph_definition_dump import Copy3D

plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
status = json.loads((BASE / 'run.status.json').read_text())
assert status['complete'] and status['running'] is None
assert [r['label'] for r in status['completed']] == ['sdk0', 'rebuilt0']
assert all(r['actual_exit'] == 0 for r in status['completed'])
transport = rendered_transport()
assert transport == (BASE / 'transport-template.py').read_text()
namespace = {'__name__': 'reconstruction.csrc.nl2_linear_cpu_audit',
             '__package__': 'reconstruction.csrc', '__file__': str(BASE / 'transport-template.py')}
exec(compile(transport, namespace['__file__'], 'exec'), namespace)
data, hashes, counts = {}, {}, Counter()
control_base, config_base, model_base = None, None, None
with np.load(plan['input_checkpoint'], allow_pickle=False) as saved:
    checkpoint = {k: saved[k][30].tobytes() for k in ('body_q', 'body_qd', 'particle_q', 'particle_qd')}
for run in plan['runs']:
    folder = BASE / run['label']
    runtime = json.loads((folder / 'worker/runtime.json').read_text())
    assert runtime['exit'] == 0 and runtime['public_core_abi'] and runtime['real_graph_observed']
    assert not runtime['ab_bridge_used'] and runtime['reference_solver_mapped'] == (run['backend'] == 'original')
    expected = ('64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
                if run['backend'] == 'original' else '7eb6e847ad6f100b51f2bc89db0a88744f93878077c318c91288d2f595116b53')
    assert runtime['image_sha256'] == expected
    injection = json.loads((folder / 'injection.json').read_text())
    assert injection['graph_counts_before'] == injection['graph_counts_after'] == [17467, 17466]
    if config_base is None:
        config_base = injection['config']
    assert config_base == injection['config']
    with np.load(folder / 'before.npz', allow_pickle=False) as before:
        for state in ('state0', 'state1'):
            assert all(before[state + '-' + k].tobytes() == v for k, v in checkpoint.items())
        assert not before['feedback-angle-flags'].any()
    with np.load(folder / 'control-before.npz', allow_pickle=False) as control:
        raw = {k: (control[k].dtype.str, control[k].shape, control[k].tobytes()) for k in control.files}
        if control_base is None:
            control_base = raw
        assert raw == control_base
    trace = folder / 'trace'
    assert (folder / 'transport-as-run.py').read_text() == transport
    graph = json.loads((trace / 'definition-before/graph.json').read_text())
    nodes = linear_order(graph)[0]
    stages = namespace['select_stages'](nodes, 44, 49)
    layout = json.loads((trace / 'snapshot-layout.json').read_text())
    assert layout['stages'] == json.loads(json.dumps(stages))
    assert len(layout['snapshots']) == plan['diagnostic_snapshots_per_worker']
    model_path = trace / 'model-body-indices.bin'
    model = np.frombuffer(model_path.read_bytes(), dtype='<i4')
    assert model.shape == (176,) and np.array_equal(np.sort(model), np.arange(176))
    assert layout['model_map_source'] == namespace['integer'](nodes[8750], 1)
    if model_base is None:
        model_base = model.copy()
    assert np.array_equal(model_base, model)
    hashes[str(model_path)] = hashlib.sha256(model_path.read_bytes()).hexdigest()
    topology = json.loads((trace / 'graph-after-topology.json').read_text())
    positions = {n['handle']: i for i, n in enumerate(linear_order(topology)[0])}
    assert len(positions) == 17467 + len(layout['snapshots'])
    assert len(topology['edges']) == 17466 + len(layout['snapshots']) + 2 * len(stages)
    assert set(map(tuple, graph['edges'])) <= set(map(tuple, topology['edges']))
    offset, seen = 0, set()
    for copy in layout['snapshots']:
        stage = next(s for s in stages if s['key'] == copy['stage'])
        i, rank = copy['argument'], stage['rank']
        assert copy['source'] == namespace['integer'](stage['node'], i)
        assert copy['offset'] == offset and copy['bytes'] == stage['sizes'][i]
        identity = (stage['key'], copy['phase'], i)
        assert identity not in seen
        seen.add(identity)
        descriptor = bytes.fromhex(copy['actual_copy_parameters_hex'])
        assert len(descriptor) == ct.sizeof(Copy3D) == 200
        actual = Copy3D.from_buffer_copy(descriptor)
        assert actual.srcMemoryType == actual.dstMemoryType == 2
        assert actual.srcDevice == copy['source'] and actual.dstDevice == layout['device_base'] + offset
        assert (actual.WidthInBytes, actual.Height, actual.Depth) == (copy['bytes'], 1, 1)
        assert all(getattr(actual, side + field) == 0 for side in ('src', 'dst')
                   for field in ('XInBytes', 'Y', 'Z', 'LOD'))
        if copy['phase'] == 'before':
            assert positions[nodes[rank - 1]['handle']] < positions[copy['node']] < positions[stage['node']['handle']]
        else:
            assert copy['phase'] == 'after' and i in stage['outputs']
            target_position, next_position = positions[stage['node']['handle']], positions[nodes[rank + 1]['handle']]
            assert target_position < positions[copy['node']] < next_position
        offset += copy['bytes']
        counts['actual_copy_descriptor_bytes'] += len(descriptor)
    expected_seen = {(s['key'], prefix, i) for s in stages for prefix, indices in
                     [('before', s['sizes']), ('after', s['outputs'])] for i in indices}
    assert seen == expected_seen and offset == layout['total_snapshot_bytes'] == plan['snapshot_bytes_per_worker']
    counts['snapshot_bytes'] += offset
    packets, selected = {}, {s['key']: s for s in stages}
    for stage in stages:
        path = trace / (stage['key'] + '-packets/frame-00.npz')
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        with np.load(path, allow_pickle=False) as saved:
            packet = {k: saved[k].copy() for k in saved.files}
        fields = {'parameter-' + str(i) for i in range(len(stage['node']['parameter_hex']))}
        for i, raw in enumerate(stage['node']['parameter_hex']):
            assert packet['parameter-' + str(i)].tobytes().hex() == raw
        for prefix, indices in [('before', stage['sizes']), ('after', stage['outputs'])]:
            for i in indices:
                key = prefix + '-arg-' + str(i)
                fields.add(key)
                assert packet[key].dtype == np.dtype('u1') and packet[key].shape == (stage['sizes'][i],)
        assert fields == set(packet)
        packets[stage['key']] = packet

    def link(producer, output, consumer, argument):
        assert namespace['integer'](selected[producer]['node'], output) == \
            namespace['integer'](selected[consumer]['node'], argument)
        assert packets[producer]['after-arg-' + str(output)].tobytes() == \
            packets[consumer]['before-arg-' + str(argument)].tobytes(), (producer, output, consumer, argument)
        counts['actual_pointer_and_complete_payload_links'] += 1

    assert packets['inverse']['before-arg-0'].tobytes() == packets['inverse']['before-arg-3'].tobytes()
    assert selected['inverse']['output_overlaps'] == [{'arguments': [3, 0], 'overlap_bytes': 6336}]
    link('inverse', 3, 'precondition_first', 0)
    link('inverse', 3, 'precondition_last', 0)
    for suffix in ('first', 'last'):
        link('precondition_' + suffix, 2, 'direction_' + suffix, 1)
        link('precondition_' + suffix, 6, 'direction_' + suffix, 4)
        link('precondition_' + suffix, 6, 'update_' + suffix, 2)
        link('direction_' + suffix, 6, 'matrix_' + suffix, 4)
        link('matrix_' + suffix, 6, 'update_' + suffix, 5)
        link('matrix_' + suffix, 9, 'update_' + suffix, 3)
    data[run['label']] = packets
differences = {}
for stage in stages:
    key = stage['key']
    left, right = data['sdk0'][key], data['rebuilt0'][key]
    differences[key] = {}
    for prefix, indices in [('before', stage['sizes']), ('after', stage['outputs'])]:
        values = {}
        for i in indices:
            field = prefix + '-arg-' + str(i)
            a, b = left[field], right[field]
            assert a.shape == b.shape
            words = np.flatnonzero(a.view('<u4') != b.view('<u4'))
            values[str(i)] = {'different_words': len(words), 'total_words': len(a) // 4,
                              'first_indices': words[:32].tolist()}
            if prefix == 'after':
                aa, bb = a.view('<f4').astype('f8'), b.view('<f4').astype('f8')
                values[str(i)]['all_finite'] = bool(np.isfinite(aa).all() and np.isfinite(bb).all())
                values[str(i)]['max_abs_error'] = float(np.abs(aa - bb).max())
        differences[key][prefix] = values
    bound = {int(i) for i in stage['sizes']}
    differences[key]['scalar_parameters_equal'] = all(left['parameter-' + str(i)].tobytes() ==
                                                     right['parameter-' + str(i)].tobytes()
                                                     for i in range(len(stage['node']['parameter_hex'])) if i not in bound)
    assert differences[key]['scalar_parameters_equal']
body12 = model_base[48:52].astype(int)
assert body12.tolist() == [48, 49, 50, 51]
descriptive = {}
for label, packets in data.items():
    delta = packets['update_last']['after-arg-6'].view('<f4').reshape(176, 3)
    descriptive[label] = {'body12_final_NL2_delta_max_abs': float(np.abs(delta[body12]).max())}
result = {'counts': dict(counts), 'stage_cross_endpoint_differences': differences,
          'body12_proxy_indices': body12.tolist(), 'descriptive_only': descriptive, 'input_sha256': hashes,
          'actual_inplace_inverse_alias_preserved': True, 'RHS_initial_output_not_assumed_final_CG_residual': True,
          'original_velocity_helper_bug_retained': True, 'new_numeric_C_cohort_created': False,
          'old_C8_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
output = BASE / 'independent-cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps({'counts': dict(counts), 'descriptive_only': descriptive}, indent=2))
